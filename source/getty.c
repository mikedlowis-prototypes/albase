/**
  @brief
  @author Michael D. Lowis
  @license BSD 2-clause License
*/
#include "util.h"
#include <unistd.h>
#include <fcntl.h>
#include <utmp.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/stat.h>

char* ARGV0;
static char* TTY  = "/dev/tty1";
static char* TERM = "linux";
static char* UTMP = "/var/run/utmp";
static char  Hostname[256] = {0};
static char  Username[256] = {0};

static void ignoresig(int signal, int ignore) {
    struct sigaction sigact;
    sigact.sa_handler = (ignore ? SIG_IGN : SIG_DFL);
    sigact.sa_flags = 0;
    sigemptyset(&sigact.sa_mask);
    sigaction(signal, &sigact, NULL);
}

static int opentty(void) {
    int fd;
    /* First reset the tty and take control if necessary */
    if ((fd = open(TTY, O_RDWR)) < 0)
        die("Failed to open %s\n", TTY);
    if (isatty(fd) == 0)
        die("%s is not a tty\n", TTY);
    if (ioctl(fd, TIOCSCTTY, (void *)1) != 0)
        warn("TIOCSCTTY: could not set controlling tty\n");
    vhangup();
    close(fd);
    /* Now open it for real */
    if ((fd = open(TTY, O_RDWR)) < 0)
        die("Failed to open %s\n", TTY);
    return fd;
}

static void clearutmp(void) {
    struct utmp usr;
    FILE* fp = efopen(UTMP, "r+");
    do {
        int pos = ftell(fp);
        efread(&usr, sizeof(usr), 1, fp);
        if ((usr.ut_line[0] == '\0') || (strcmp(usr.ut_line, TTY) != 0))
            continue;
        memset(&usr, 0, sizeof(usr));
        fseek(fp, pos, SEEK_SET);
        efwrite(&usr, sizeof(usr), 1, fp);
    } while (1);
    if (ferror(fp))
        warn("%s: I/O error:", UTMP);
    fclose(fp);
}

static int dologin(void) {
    int i = 0, c = 0;
    /* Print the hostname */
    if (gethostname(Hostname, sizeof(Hostname)) == 0)
        printf("%s ", Hostname);
    printf("login: ");
    fflush(stdout);
    /* Read in the username */
    ioctl(0, TCFLSH, (void *)0);
    while (1) {
        if (0 == efread(&c, 1, 1, stdin))
            return 1;
        if (i >= (sizeof(Username) - 1))
            die("login name too long\n");
        if (c == '\n' || c == '\r')
            break;
        Username[i++] = c;
    }
    /* Execute the login command */
    if ((Username[0] == '\0') || (Username[0] == '-'))
        return 1;
    else
        return execlp("/bin/login", "login", "-p", Username, NULL);
}

int main(int argc, char *argv[]) {
    /* Print usage and exit if we receive any flags */
    OPTBEGIN{
        default:
            die("Usage: %s [tty] [term] [cmd] [args]\n", ARGV0);
    } OPTEND;
    /* Read the arguments into variables */
    if (argc > 0) TTY  = argv[0];
    if (argc > 1) TERM = argv[1];
    /* setup the environment and session */
    ignoresig(SIGHUP, 1); // ignore SIGHUP
    setenv("TERM", TERM, 1);
    setsid();
    /* Open the TTY for normal usage */
    int fd = opentty();
    dup2(fd, 0); // Make stdin  the TTY
    dup2(fd, 1); // Make stdout the TTY
    dup2(fd, 2); // Make stderr the TTY
    if (fchown(fd, 0, 0) < 0)
        warn("fchown %s:", TTY);
    if (fchmod(fd, 0600) < 0)
        warn("fchmod %s:", TTY);
    ignoresig(SIGHUP, 0); // stop ignoring SIGHUP
    /* clear all utmp entries for this TTY */
    clearutmp();
    /* Start the command or login prompt */
    if (argc > 2)
        return execvp(argv[2], &(argv[2]));
    else
        return dologin();
}
