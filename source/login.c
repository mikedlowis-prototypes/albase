/**
  @brief
  @author Michael D. Lowis
  @license BSD 2-clause License
*/
#include "util.h"
#include <unistd.h>
#include <pwd.h>
#include <shadow.h>

//#include <sys/ioctl.h>
//#include <sys/types.h>
//#include <errno.h>
//#include <grp.h>
//#include <pwd.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <time.h>
//#include <unistd.h>
//#include <utmp.h>

//#include "config.h"
//#include "passwd.h"
//#include "util.h"

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
        fgets(username, sizeof(username)-1, stdin);
        username[strlen(username)-1] = '\0';
        return username;
    } else {
        return Username;
    }
}

static char* get_pass(void) {
    return getpass("password: ");
}

static bool check_pass(const char* user, char* pass) {
    struct spwd* spw;
    struct passwd* pwentry = getpwnam(user);
    if (!pwentry || errno)
        die("Could not find entry for user: %s", user);
    /* Handle disabled accounts */
    if (pwentry->pw_passwd[0] == '!' || pwentry->pw_passwd[0] == '*') {
        warn("access denied");
        return false;
    }
    /* Handle blank pass or blank pass entry */
    if ((pwentry->pw_passwd[0] == '\0') || (pass[0] == '\0')) {
        warn("incorrect password\n");
        return false;
    }
    /* Handle shadow passwd entries */
    if (pwentry->pw_passwd[0] == 'x' && pwentry->pw_passwd[1] == '\0') {
        errno = 0;
        spw = getspnam(pwentry->pw_name);
        if (!spw || errno)
            die("could not retrieve shadow entry for %s", user);

        if (spw->sp_pwdp[0] == '!' || spw->sp_pwdp[0] == '*') {
            warn("access denied\n");
            return false;
        }
    }
    /* Check the password */
    char* cryptpass = crypt(pass, spw->sp_pwdp);
    if (strcmp(cryptpass, spw->sp_pwdp) != 0) {
        warn("incorrect password");
        return false;
    }
    return true;
}

int pw_check(const struct passwd *pw, const char *pass)
{
    char *cryptpass, *p;
    struct spwd *spw;

    p = pw->pw_passwd;
    if (p[0] == '!' || p[0] == '*') {
    weprintf("denied\n");
    return -1;
    }

    if (pw->pw_passwd[0] == '\0') {
        if (pass[0] == '\0')
            return 1;
        weprintf("incorrect password\n");
        return 0;
    }

    if (pw->pw_passwd[0] == 'x' && pw->pw_passwd[1] == '\0') {
        errno = 0;
        spw = getspnam(pw->pw_name);
        if (!spw) {
            if (errno)
                weprintf("getspnam: %s:", pw->pw_name);
            else
                weprintf("who are you?\n");
            return -1;
        }
        p = spw->sp_pwdp;
        if (p[0] == '!' || p[0] == '*') {
            weprintf("denied\n");
            return -1;
        }
    }

    cryptpass = crypt(pass, p);
    if (!cryptpass) {
    weprintf("crypt:");
    return -1;
    }
    if (strcmp(cryptpass, p) != 0) {
    weprintf("incorrect password\n");
    return 0;
    }
    return 1;
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
            die("Usage: %s [-p] [-h host] [-u user]", ARGV0);
    } OPTEND;
    /*  */
    if (isatty(0) == 0 || isatty(1) == 0 || isatty(2) == 0)
        die("no tty");
    printf("%s\n", get_host());

    char* user = get_user();
    char* pass = get_pass();
    if (check_pass(user, pass)) {

    } else {
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}

//* See LICENSE file for copyright and license details. */
//#include <sys/ioctl.h>
//#include <sys/types.h>
//
//#include <errno.h>
//#include <grp.h>
//#include <pwd.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <time.h>
//#include <unistd.h>
//#include <utmp.h>
//
//#include "config.h"
//#include "passwd.h"
//#include "util.h"
//
///* Write utmp entry */
//static void
//writeutmp(const char *user, const char *tty)
//{
//    struct utmp usr;
//    FILE *fp;
//
//    memset(&usr, 0, sizeof(usr));
//
//    usr.ut_type = USER_PROCESS;
//    usr.ut_pid = getpid();
//    strlcpy(usr.ut_user, user, sizeof(usr.ut_user));
//    strlcpy(usr.ut_line, tty, sizeof(usr.ut_line));
//    usr.ut_tv.tv_sec = time(NULL);
//
//    fp = fopen(UTMP_PATH, "a");
//    if (fp) {
//        if (fwrite(&usr, sizeof(usr), 1, fp) != 1)
//            if (ferror(fp))
//                weprintf("%s: write error:", UTMP_PATH);
//        fclose(fp);
//    } else {
//        weprintf("fopen %s:", UTMP_PATH);
//    }
//}
//
//static int
//dologin(struct passwd *pw, int preserve)
//{
//    char *shell = pw->pw_shell[0] == '\0' ? "/bin/sh" : pw->pw_shell;
//
//    if (preserve == 0)
//        clearenv();
//    setenv("HOME", pw->pw_dir, 1);
//    setenv("SHELL", shell, 1);
//    setenv("USER", pw->pw_name, 1);
//    setenv("LOGNAME", pw->pw_name, 1);
//    setenv("PATH", ENV_PATH, 1);
//    if (chdir(pw->pw_dir) < 0)
//        eprintf("chdir %s:", pw->pw_dir);
//    execlp(shell, shell, "-l", NULL);
//    weprintf("execlp %s:", shell);
//    return (errno == ENOENT) ? 127 : 126;
//}
//
//static void
//usage(void)
//{
//    eprintf("usage: %s [-p] username\n", argv0);
//}
//
//int
//main(int argc, char *argv[])
//{
//    struct passwd *pw;
//    char *pass, *user;
//    char *tty;
//    uid_t uid;
//    gid_t gid;
//    int pflag = 0;
//
//    ARGBEGIN {
//    case 'p':
//        pflag = 1;
//        break;
//    default:
//        usage();
//    } ARGEND;
//
//    if (argc < 1)
//        usage();
//
//    if (isatty(0) == 0 || isatty(1) == 0 || isatty(2) == 0)
//        eprintf("no tty");
//
//    user = argv[0];
//    errno = 0;
//    pw = getpwnam(user);
//    if (!pw) {
//        if (errno)
//            eprintf("getpwnam %s:", user);
//        else
//            eprintf("who are you?\n");
//    }
//
//    uid = pw->pw_uid;
//    gid = pw->pw_gid;
//
//    /* Flush pending input */
//    ioctl(0, TCFLSH, (void *)0);
//
//    pass = getpass("Password: ");
//    if (!pass)
//        eprintf("getpass:");
//    if (pw_check(pw, pass) <= 0)
//        exit(1);
//
//    tty = ttyname(0);
//    if (!tty)
//        eprintf("ttyname:");
//
//    writeutmp(user, tty);
//
//    if (initgroups(user, gid) < 0)
//        eprintf("initgroups:");
//    if (setgid(gid) < 0)
//        eprintf("setgid:");
//    if (setuid(uid) < 0)
//        eprintf("setuid:");
//
//    return dologin(pw, pflag);
//}
