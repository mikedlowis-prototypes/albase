/**
  @brief
  @author Michael D. Lowis
  @license BSD 2-clause License
*/
#include "util.h"
#include <unistd.h>
#include <pwd.h>
#include <shadow.h>
#include <sys/ioctl.h>

#define ENV_PATH "/bin"

char* ARGV0;
static char* Hostname = NULL;
static char* Username = NULL;
static char* Password = NULL;
static bool  PreserveEnv = false;

static char* get_host(void) {
    static char hostname[256] = { 0 };
    if (Hostname == NULL) {
        gethostname(hostname, sizeof(hostname)-1);
        return hostname;
    } else {
        return Hostname;
    }
}

static char* get_user(void) {
    static char username[256] = { 0 };
    if (Username == NULL) {
        printf("login: ");
        fflush(stdout);
        if (fgets(username, sizeof(username)-1, stdin))
            username[strlen(username)-1] = '\0';
        return username;
    } else {
        return Username;
    }
}

static char* get_pass(void) {
    /* flush input buffer */
    ioctl(0, TCFLSH, (void *)0);
    return getpass("password: ");
}

static struct passwd* check_pass(const char* user, char* pass) {
    struct spwd* spw;
    /* get the passwd entry */
    struct passwd* pwentry = getpwnam(user);
    if (!pwentry || errno)
        die("Could not find entry for user: %s", user);
    /* Handle disabled accounts */
    if (pwentry->pw_passwd[0] == '!' || pwentry->pw_passwd[0] == '*') {
        warn("access denied");
        return NULL;
    }
    /* Handle blank pass or blank pass entry */
    if ((pwentry->pw_passwd[0] == '\0') || (pass[0] == '\0')) {
        warn("incorrect password\n");
        return NULL;
    }
    /* Get the shadow entry */
    if (pwentry->pw_passwd[0] == 'x' && pwentry->pw_passwd[1] == '\0') {
        errno = 0;
        spw = getspnam(pwentry->pw_name);
        if (!spw || errno)
            die("could not retrieve shadow entry for %s", user);

        if (spw->sp_pwdp[0] == '!' || spw->sp_pwdp[0] == '*') {
            warn("access denied\n");
            return NULL;
        }
    }
    /* Check the password */
    char* cryptpass = crypt(pass, spw->sp_pwdp);
    if (strcmp(cryptpass, spw->sp_pwdp) != 0) {
        warn("incorrect password");
        return NULL;
    }
    return pwentry;
}

int main(int argc, char** argv) {
    /* Parse command line options */
    OPTBEGIN {
        case 'p':
            PreserveEnv = true;
            break;
        case 'h':
            Hostname = EOPTARG(die("no hostname provided"));
            break;
        case 'u':
            Username = EOPTARG(die("no username provided"));
            break;
        default:
            fprintf(stderr,"Usage: %s [-p] [-h host] [-u user]", ARGV0);
            exit(EXIT_FAILURE);
    } OPTEND;
    /* Print the hostname to the tty */
    if (isatty(0) == 0 || isatty(1) == 0 || isatty(2) == 0)
        die("no tty");
    printf("This is %s\n\n", get_host());
    /* Get the credentials and authenticate */
    char* user  = get_user();
    char* pass  = get_pass();
    struct passwd* pwentry = check_pass(user, pass);
    while (*pass) { *(pass++) = '\0'; }
    if (pwentry != NULL) {
        initgroups(user, pwentry->pw_gid);
        check(setgid(pwentry->pw_gid), "setgid failed");
        check(setuid(pwentry->pw_uid), "setuid failed");
        char *shell = (pwentry->pw_shell[0] ? pwentry->pw_shell : "/bin/sh");
        if (!PreserveEnv)
            clearenv();
        setenv("HOME",    pwentry->pw_dir,  1);
        setenv("SHELL",   shell,            1);
        setenv("USER",    pwentry->pw_name, 1);
        setenv("LOGNAME", pwentry->pw_name, 1);
        setenv("PATH",    ENV_PATH,         1);
        check(chdir(pwentry->pw_dir), "chdir failed");
        execlp(shell, shell, "-l", NULL);
    }

    /* Handle any unexpected errors that occurred */
error:
    return (errno == ENOENT) ? 127 : 126;
}
