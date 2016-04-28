/**
  @brief
  @author Michael D. Lowis
  @license BSD 2-clause License
*/
#include "util.h"
#include <sys/klog.h>

#define SYSLOG_ACTION_READ_ALL       3
#define SYSLOG_ACTION_CLEAR          5
#define SYSLOG_ACTION_CONSOLE_LEVEL  8
#define SYSLOG_ACTION_SIZE_BUFFER   10

char* ARGV0;

static void usage(void) {
    fprintf(stderr, "Usage: %s [-Cc] [-n level]\n", ARGV0);
    exit(1);
}

int eklogctl(int type, char *bufp, int len) {
    int nbytes = klogctl(type, bufp, len);
    if (nbytes < 0)
        die("klogctl failed: %s", errnostr());
    return nbytes;
}

int main(int argc, char** argv) {
    long level = -1;
    bool read  = true;
    bool clear_before = false;
    bool clear_after = false;
    /* Parse command line options */
    OPTBEGIN {
        case 'C': clear_before = true; read = false;     break;
        case 'c': clear_after = true;  read = true;      break;
        case 'n': level = estrtol(EOPTARG(usage()), 10); break;
        default:
            usage();
    } OPTEND;
    /* clear the before before  doing anything else */
    if (clear_before)
        eklogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
    /* Set the log level */
    if (level >= 0)
        eklogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, level);
    /* Read the raw log data and print it out */
    if (read) {
        int nbytes = eklogctl(SYSLOG_ACTION_SIZE_BUFFER, NULL, 0);
        char* buf  = (char*)emalloc(nbytes);
        eklogctl(SYSLOG_ACTION_READ_ALL, buf, nbytes);
        nbytes = efwrite(buf, 1, nbytes, stdout);
        if (buf[nbytes - 1] != '\n')
            fputc('\n', stdout);
        free(buf);
    }
    /* Clear the log after we've read it out */
    if (clear_after)
        eklogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
    return 0;
}
