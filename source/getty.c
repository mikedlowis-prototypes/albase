/**
  @brief
  @author Michael D. Lowis
  @license BSD 2-clause License
*/
#include "util.h"
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>

char* ARGV0;
static char* TTY  = "/dev/tty1";
static char* TERM = "linux";

static void sigignore(int signal, int ignore) {
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
        fprintf(stderr, "Warning: TIOCSCTTY: could not set controlling tty\n");
    vhangup();
    close(fd);
    /* Now open it for real */
    if ((fd = open(TTY, O_RDWR)) < 0)
        die("Failed to open %s\n", TTY);
    return fd;
}

static int dologin(void) {
    //if (gethostname(hostname, sizeof(hostname)) == 0)
    //    printf("%s ", hostname);
    //printf("login: ");
    //fflush(stdout);

    ///* Flush pending input */
    //ioctl(0, TCFLSH, (void *)0);
    //memset(logname, 0, sizeof(logname));
    //while (1) {
    //    n = read(0, &c, 1);
    //    if (n < 0)
    //        eprintf("read:");
    //    if (n == 0)
    //        return 1;
    //    if (i >= sizeof(logname) - 1)
    //        eprintf("login name too long\n");
    //    if (c == '\n' || c == '\r')
    //        break;
    //    logname[i++] = c;
    //}
    //if (logname[0] == '-')
    //    eprintf("login name cannot start with '-'\n");
    //if (logname[0] == '\0')
    //    return 1;
    //return execlp("/bin/login", "login", "-p", logname, NULL);
    return 0;
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
    sigignore(SIGHUP, 1); // ignore SIGHUP
    setenv("TERM", TERM, 1);
    setsid();
    /* Open the TTY for normal usage */
    int fd = opentty();
    dup2(fd, 0); // Make stdin  the TTY
    dup2(fd, 1); // Make stdout the TTY
    dup2(fd, 2); // Make stderr the TTY
    if (fchown(fd, 0, 0) < 0)
        fprintf(stderr, "fchown %s:", TTY);
    if (fchmod(fd, 0600) < 0)
        fprintf(stderr, "fchmod %s:", TTY);
    if (fd > 2)
        close(fd);
    sigignore(SIGHUP, 0); // stop ignoring SIGHUP
    /* clear all utmp entries for this TTY */
//    /* Clear all utmp entries for this tty */
//    fp = fopen(UTMP_PATH, "r+");
//    if (fp) {
//        do {
//            pos = ftell(fp);
//            if (fread(&usr, sizeof(usr), 1, fp) != 1)
//                break;
//            if (usr.ut_line[0] == '\0')
//                continue;
//            if (strcmp(usr.ut_line, tty) != 0)
//                continue;
//            memset(&usr, 0, sizeof(usr));
//            fseek(fp, pos, SEEK_SET);
//            if (fwrite(&usr, sizeof(usr), 1, fp) != 1)
//                break;
//        } while (1);
//        if (ferror(fp))
//            weprintf("%s: I/O error:", UTMP_PATH);
//        fclose(fp);
//    }
    /* Start the command or login prompt */
    if (argc > 2)
        return execvp(argv[2], &(argv[2]));
    else
        return dologin();
}
