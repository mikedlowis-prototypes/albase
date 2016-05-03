BINS   += $(SBASE_BINS)
DIRS   += $(SBASE_OBJDIR)
ECLEAN += $(SBASE_LIBUTIL) \
          $(SBASE_LIBUTF) \
          $(SBASE_LIBUTIL_OBJS) \
          $(SBASE_LIBUTF_OBJS) \
          $(addprefix $(BINDIR)/,$(SBASE_BINS))

SBASE_SUBDIR  = source/sbase
SBASE_OBJDIR  = $(OBJDIR)/sbase
SBASE_LIBUTIL = $(SBASE_OBJDIR)/libutil.a
SBASE_LIBUTF  = $(SBASE_OBJDIR)/libutf.a
SBASE_DEFS    = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_FILE_OFFSET_BITS=64
SBASE_COMPILE = $(CC) $(SBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(SBASE_SUBDIR) -c -o $@ $<
SBASE_BUILD   = $(CC) $(SBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(SBASE_SUBDIR) -o $@ $^
SBASE_ARCHIVE = $(AR) $(ARFLAGS) $@ $^

SBASE_LIBUTIL_OBJS = \
    $(SBASE_OBJDIR)/concat.o \
    $(SBASE_OBJDIR)/cp.o \
    $(SBASE_OBJDIR)/crypt.o \
    $(SBASE_OBJDIR)/ealloc.o \
    $(SBASE_OBJDIR)/enmasse.o \
    $(SBASE_OBJDIR)/eprintf.o \
    $(SBASE_OBJDIR)/eregcomp.o \
    $(SBASE_OBJDIR)/estrtod.o \
    $(SBASE_OBJDIR)/fnck.o \
    $(SBASE_OBJDIR)/fshut.o \
    $(SBASE_OBJDIR)/getlines.o \
    $(SBASE_OBJDIR)/human.o \
    $(SBASE_OBJDIR)/linecmp.o \
    $(SBASE_OBJDIR)/md5.o \
    $(SBASE_OBJDIR)/memmem.o \
    $(SBASE_OBJDIR)/mkdirp.o \
    $(SBASE_OBJDIR)/mode.o \
    $(SBASE_OBJDIR)/parseoffset.o \
    $(SBASE_OBJDIR)/putword.o \
    $(SBASE_OBJDIR)/reallocarray.o \
    $(SBASE_OBJDIR)/recurse.o \
    $(SBASE_OBJDIR)/rm.o \
    $(SBASE_OBJDIR)/sha1.o \
    $(SBASE_OBJDIR)/sha224.o \
    $(SBASE_OBJDIR)/sha256.o \
    $(SBASE_OBJDIR)/sha384.o \
    $(SBASE_OBJDIR)/sha512-224.o \
    $(SBASE_OBJDIR)/sha512-256.o \
    $(SBASE_OBJDIR)/sha512.o \
    $(SBASE_OBJDIR)/strcasestr.o \
    $(SBASE_OBJDIR)/strlcat.o \
    $(SBASE_OBJDIR)/strlcpy.o \
    $(SBASE_OBJDIR)/strsep.o \
    $(SBASE_OBJDIR)/strtonum.o \
    $(SBASE_OBJDIR)/unescape.o

SBASE_LIBUTF_OBJS = \
    $(SBASE_OBJDIR)/fgetrune.o \
    $(SBASE_OBJDIR)/fputrune.o \
    $(SBASE_OBJDIR)/isalnumrune.o \
    $(SBASE_OBJDIR)/isalpharune.o \
    $(SBASE_OBJDIR)/isblankrune.o \
    $(SBASE_OBJDIR)/iscntrlrune.o \
    $(SBASE_OBJDIR)/isdigitrune.o \
    $(SBASE_OBJDIR)/isgraphrune.o \
    $(SBASE_OBJDIR)/isprintrune.o \
    $(SBASE_OBJDIR)/ispunctrune.o \
    $(SBASE_OBJDIR)/isspacerune.o \
    $(SBASE_OBJDIR)/istitlerune.o \
    $(SBASE_OBJDIR)/isxdigitrune.o \
    $(SBASE_OBJDIR)/lowerrune.o \
    $(SBASE_OBJDIR)/rune.o \
    $(SBASE_OBJDIR)/runetype.o \
    $(SBASE_OBJDIR)/upperrune.o \
    $(SBASE_OBJDIR)/utf.o \
    $(SBASE_OBJDIR)/utftorunestr.o

SBASE_BINS =\
    basename\
    cal\
    cat\
    chgrp\
    chmod\
    chown\
    chroot\
    cksum\
    cmp\
    cols\
    comm\
    cp\
    cron\
    cut\
    date\
    dirname\
    du\
    echo\
    ed\
    env\
    expand\
    expr\
    false\
    find\
    flock\
    fold\
    getconf\
    grep\
    head\
    join\
    hostname\
    kill\
    link\
    ln\
    logger\
    logname\
    ls\
    md5sum\
    mkdir\
    mkfifo\
    mktemp\
    mv\
    nice\
    nl\
    nohup\
    od\
    pathchk\
    paste\
    printenv\
    printf\
    pwd\
    readlink\
    renice\
    rm\
    rmdir\
    sed\
    seq\
    setsid\
    sha1sum\
    sha224sum\
    sha256sum\
    sha384sum\
    sha512sum\
    sha512-224sum\
    sha512-256sum\
    sleep\
    sort\
    split\
    sponge\
    strings\
    sync\
    tail\
    tar\
    tee\
    test\
    tftp\
    time\
    touch\
    tr\
    true\
    tsort\
    tty\
    uname\
    unexpand\
    uniq\
    unlink\
    uudecode\
    uuencode\
    wc\
    which\
    whoami\
    xargs\
    xinstall\
    yes

$(SBASE_LIBUTIL): $(SBASE_LIBUTIL_OBJS)
	$(SBASE_ARCHIVE)
$(SBASE_OBJDIR)/concat.o: $(SBASE_SUBDIR)/libutil/concat.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/cp.o: $(SBASE_SUBDIR)/libutil/cp.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/crypt.o: $(SBASE_SUBDIR)/libutil/crypt.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/ealloc.o: $(SBASE_SUBDIR)/libutil/ealloc.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/enmasse.o: $(SBASE_SUBDIR)/libutil/enmasse.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/eprintf.o: $(SBASE_SUBDIR)/libutil/eprintf.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/eregcomp.o: $(SBASE_SUBDIR)/libutil/eregcomp.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/estrtod.o: $(SBASE_SUBDIR)/libutil/estrtod.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/fnck.o: $(SBASE_SUBDIR)/libutil/fnck.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/fshut.o: $(SBASE_SUBDIR)/libutil/fshut.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/getlines.o: $(SBASE_SUBDIR)/libutil/getlines.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/human.o: $(SBASE_SUBDIR)/libutil/human.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/linecmp.o: $(SBASE_SUBDIR)/libutil/linecmp.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/md5.o: $(SBASE_SUBDIR)/libutil/md5.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/memmem.o: $(SBASE_SUBDIR)/libutil/memmem.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/mkdirp.o: $(SBASE_SUBDIR)/libutil/mkdirp.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/mode.o: $(SBASE_SUBDIR)/libutil/mode.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/parseoffset.o: $(SBASE_SUBDIR)/libutil/parseoffset.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/putword.o: $(SBASE_SUBDIR)/libutil/putword.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/reallocarray.o: $(SBASE_SUBDIR)/libutil/reallocarray.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/recurse.o: $(SBASE_SUBDIR)/libutil/recurse.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/rm.o: $(SBASE_SUBDIR)/libutil/rm.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha1.o: $(SBASE_SUBDIR)/libutil/sha1.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha224.o: $(SBASE_SUBDIR)/libutil/sha224.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha256.o: $(SBASE_SUBDIR)/libutil/sha256.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha384.o: $(SBASE_SUBDIR)/libutil/sha384.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha512-224.o: $(SBASE_SUBDIR)/libutil/sha512-224.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha512-256.o: $(SBASE_SUBDIR)/libutil/sha512-256.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/sha512.o: $(SBASE_SUBDIR)/libutil/sha512.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/strcasestr.o: $(SBASE_SUBDIR)/libutil/strcasestr.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/strlcat.o: $(SBASE_SUBDIR)/libutil/strlcat.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/strlcpy.o: $(SBASE_SUBDIR)/libutil/strlcpy.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/strsep.o: $(SBASE_SUBDIR)/libutil/strsep.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/strtonum.o: $(SBASE_SUBDIR)/libutil/strtonum.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/unescape.o: $(SBASE_SUBDIR)/libutil/unescape.c
	$(SBASE_COMPILE)


$(SBASE_LIBUTF): $(SBASE_LIBUTF_OBJS)
	$(SBASE_ARCHIVE)
$(SBASE_OBJDIR)/fgetrune.o: $(SBASE_SUBDIR)/libutf/fgetrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/fputrune.o: $(SBASE_SUBDIR)/libutf/fputrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isalnumrune.o: $(SBASE_SUBDIR)/libutf/isalnumrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isalpharune.o: $(SBASE_SUBDIR)/libutf/isalpharune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isblankrune.o: $(SBASE_SUBDIR)/libutf/isblankrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/iscntrlrune.o: $(SBASE_SUBDIR)/libutf/iscntrlrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isdigitrune.o: $(SBASE_SUBDIR)/libutf/isdigitrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isgraphrune.o: $(SBASE_SUBDIR)/libutf/isgraphrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isprintrune.o: $(SBASE_SUBDIR)/libutf/isprintrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/ispunctrune.o: $(SBASE_SUBDIR)/libutf/ispunctrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isspacerune.o: $(SBASE_SUBDIR)/libutf/isspacerune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/istitlerune.o: $(SBASE_SUBDIR)/libutf/istitlerune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/isxdigitrune.o: $(SBASE_SUBDIR)/libutf/isxdigitrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/lowerrune.o: $(SBASE_SUBDIR)/libutf/lowerrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/rune.o: $(SBASE_SUBDIR)/libutf/rune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/runetype.o: $(SBASE_SUBDIR)/libutf/runetype.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/upperrune.o: $(SBASE_SUBDIR)/libutf/upperrune.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/utf.o: $(SBASE_SUBDIR)/libutf/utf.c
	$(SBASE_COMPILE)
$(SBASE_OBJDIR)/utftorunestr.o: $(SBASE_SUBDIR)/libutf/utftorunestr.c
	$(SBASE_COMPILE)

basename: $(BINDIR)/basename
$(BINDIR)/basename: $(SBASE_SUBDIR)/basename.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cal: $(BINDIR)/cal
$(BINDIR)/cal: $(SBASE_SUBDIR)/cal.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cat: $(BINDIR)/cat
$(BINDIR)/cat: $(SBASE_SUBDIR)/cat.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

chgrp: $(BINDIR)/chgrp
$(BINDIR)/chgrp: $(SBASE_SUBDIR)/chgrp.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

chmod: $(BINDIR)/chmod
$(BINDIR)/chmod: $(SBASE_SUBDIR)/chmod.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

chown: $(BINDIR)/chown
$(BINDIR)/chown: $(SBASE_SUBDIR)/chown.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

chroot: $(BINDIR)/chroot
$(BINDIR)/chroot: $(SBASE_SUBDIR)/chroot.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cksum: $(BINDIR)/cksum
$(BINDIR)/cksum: $(SBASE_SUBDIR)/cksum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cmp: $(BINDIR)/cmp
$(BINDIR)/cmp: $(SBASE_SUBDIR)/cmp.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cols: $(BINDIR)/cols
$(BINDIR)/cols: $(SBASE_SUBDIR)/cols.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

comm: $(BINDIR)/comm
$(BINDIR)/comm: $(SBASE_SUBDIR)/comm.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cp: $(BINDIR)/cp
$(BINDIR)/cp: $(SBASE_SUBDIR)/cp.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cron: $(BINDIR)/cron
$(BINDIR)/cron: $(SBASE_SUBDIR)/cron.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

cut: $(BINDIR)/cut
$(BINDIR)/cut: $(SBASE_SUBDIR)/cut.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

date: $(BINDIR)/date
$(BINDIR)/date: $(SBASE_SUBDIR)/date.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

dirname: $(BINDIR)/dirname
$(BINDIR)/dirname: $(SBASE_SUBDIR)/dirname.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

du: $(BINDIR)/du
$(BINDIR)/du: $(SBASE_SUBDIR)/du.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

echo: $(BINDIR)/echo
$(BINDIR)/echo: $(SBASE_SUBDIR)/echo.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

ed: $(BINDIR)/ed
$(BINDIR)/ed: $(SBASE_SUBDIR)/ed.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

env: $(BINDIR)/env
$(BINDIR)/env: $(SBASE_SUBDIR)/env.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

expand: $(BINDIR)/expand
$(BINDIR)/expand: $(SBASE_SUBDIR)/expand.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

expr: $(BINDIR)/expr
$(BINDIR)/expr: $(SBASE_SUBDIR)/expr.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

false: $(BINDIR)/false
$(BINDIR)/false: $(SBASE_SUBDIR)/false.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

find: $(BINDIR)/find
$(BINDIR)/find: $(SBASE_SUBDIR)/find.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

flock: $(BINDIR)/flock
$(BINDIR)/flock: $(SBASE_SUBDIR)/flock.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

fold: $(BINDIR)/fold
$(BINDIR)/fold: $(SBASE_SUBDIR)/fold.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

getconf: $(BINDIR)/getconf
$(BINDIR)/getconf: $(SBASE_SUBDIR)/getconf.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

grep: $(BINDIR)/grep
$(BINDIR)/grep: $(SBASE_SUBDIR)/grep.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

head: $(BINDIR)/head
$(BINDIR)/head: $(SBASE_SUBDIR)/head.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

join: $(BINDIR)/join
$(BINDIR)/join: $(SBASE_SUBDIR)/join.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

hostname: $(BINDIR)/hostname
$(BINDIR)/hostname: $(SBASE_SUBDIR)/hostname.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

kill: $(BINDIR)/kill
$(BINDIR)/kill: $(SBASE_SUBDIR)/kill.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

link: $(BINDIR)/link
$(BINDIR)/link: $(SBASE_SUBDIR)/link.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

ln: $(BINDIR)/ln
$(BINDIR)/ln: $(SBASE_SUBDIR)/ln.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

logger: $(BINDIR)/logger
$(BINDIR)/logger: $(SBASE_SUBDIR)/logger.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

logname: $(BINDIR)/logname
$(BINDIR)/logname: $(SBASE_SUBDIR)/logname.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

ls: $(BINDIR)/ls
$(BINDIR)/ls: $(SBASE_SUBDIR)/ls.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

md5sum: $(BINDIR)/md5sum
$(BINDIR)/md5sum: $(SBASE_SUBDIR)/md5sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

mkdir: $(BINDIR)/mkdir
$(BINDIR)/mkdir: $(SBASE_SUBDIR)/mkdir.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

mkfifo: $(BINDIR)/mkfifo
$(BINDIR)/mkfifo: $(SBASE_SUBDIR)/mkfifo.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

mktemp: $(BINDIR)/mktemp
$(BINDIR)/mktemp: $(SBASE_SUBDIR)/mktemp.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

mv: $(BINDIR)/mv
$(BINDIR)/mv: $(SBASE_SUBDIR)/mv.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

nice: $(BINDIR)/nice
$(BINDIR)/nice: $(SBASE_SUBDIR)/nice.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

nl: $(BINDIR)/nl
$(BINDIR)/nl: $(SBASE_SUBDIR)/nl.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

nohup: $(BINDIR)/nohup
$(BINDIR)/nohup: $(SBASE_SUBDIR)/nohup.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

od: $(BINDIR)/od
$(BINDIR)/od: $(SBASE_SUBDIR)/od.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

pathchk: $(BINDIR)/pathchk
$(BINDIR)/pathchk: $(SBASE_SUBDIR)/pathchk.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

paste: $(BINDIR)/paste
$(BINDIR)/paste: $(SBASE_SUBDIR)/paste.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

printenv: $(BINDIR)/printenv
$(BINDIR)/printenv: $(SBASE_SUBDIR)/printenv.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

printf: $(BINDIR)/printf
$(BINDIR)/printf: $(SBASE_SUBDIR)/printf.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

pwd: $(BINDIR)/pwd
$(BINDIR)/pwd: $(SBASE_SUBDIR)/pwd.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

readlink: $(BINDIR)/readlink
$(BINDIR)/readlink: $(SBASE_SUBDIR)/readlink.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

renice: $(BINDIR)/renice
$(BINDIR)/renice: $(SBASE_SUBDIR)/renice.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

rm: $(BINDIR)/rm
$(BINDIR)/rm: $(SBASE_SUBDIR)/rm.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

rmdir: $(BINDIR)/rmdir
$(BINDIR)/rmdir: $(SBASE_SUBDIR)/rmdir.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sed: $(BINDIR)/sed
$(BINDIR)/sed: $(SBASE_SUBDIR)/sed.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

seq: $(BINDIR)/seq
$(BINDIR)/seq: $(SBASE_SUBDIR)/seq.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

setsid: $(BINDIR)/setsid
$(BINDIR)/setsid: $(SBASE_SUBDIR)/setsid.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha1sum: $(BINDIR)/sha1sum
$(BINDIR)/sha1sum: $(SBASE_SUBDIR)/sha1sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha224sum: $(BINDIR)/sha224sum
$(BINDIR)/sha224sum: $(SBASE_SUBDIR)/sha224sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha256sum: $(BINDIR)/sha256sum
$(BINDIR)/sha256sum: $(SBASE_SUBDIR)/sha256sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha384sum: $(BINDIR)/sha384sum
$(BINDIR)/sha384sum: $(SBASE_SUBDIR)/sha384sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha512sum: $(BINDIR)/sha512sum
$(BINDIR)/sha512sum: $(SBASE_SUBDIR)/sha512sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha512-224sum: $(BINDIR)/sha512-224sum
$(BINDIR)/sha512-224sum: $(SBASE_SUBDIR)/sha512-224sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sha512-256sum: $(BINDIR)/sha512-256sum
$(BINDIR)/sha512-256sum: $(SBASE_SUBDIR)/sha512-256sum.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sleep: $(BINDIR)/sleep
$(BINDIR)/sleep: $(SBASE_SUBDIR)/sleep.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sort: $(BINDIR)/sort
$(BINDIR)/sort: $(SBASE_SUBDIR)/sort.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

split: $(BINDIR)/split
$(BINDIR)/split: $(SBASE_SUBDIR)/split.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sponge: $(BINDIR)/sponge
$(BINDIR)/sponge: $(SBASE_SUBDIR)/sponge.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

strings: $(BINDIR)/strings
$(BINDIR)/strings: $(SBASE_SUBDIR)/strings.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

sync: $(BINDIR)/sync
$(BINDIR)/sync: $(SBASE_SUBDIR)/sync.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tail: $(BINDIR)/tail
$(BINDIR)/tail: $(SBASE_SUBDIR)/tail.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tar: $(BINDIR)/tar
$(BINDIR)/tar: $(SBASE_SUBDIR)/tar.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tee: $(BINDIR)/tee
$(BINDIR)/tee: $(SBASE_SUBDIR)/tee.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

test: $(BINDIR)/test
$(BINDIR)/test: $(SBASE_SUBDIR)/test.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tftp: $(BINDIR)/tftp
$(BINDIR)/tftp: $(SBASE_SUBDIR)/tftp.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

time: $(BINDIR)/time
$(BINDIR)/time: $(SBASE_SUBDIR)/time.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

touch: $(BINDIR)/touch
$(BINDIR)/touch: $(SBASE_SUBDIR)/touch.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tr: $(BINDIR)/tr
$(BINDIR)/tr: $(SBASE_SUBDIR)/tr.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

true: $(BINDIR)/true
$(BINDIR)/true: $(SBASE_SUBDIR)/true.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tsort: $(BINDIR)/tsort
$(BINDIR)/tsort: $(SBASE_SUBDIR)/tsort.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

tty: $(BINDIR)/tty
$(BINDIR)/tty: $(SBASE_SUBDIR)/tty.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

uname: $(BINDIR)/uname
$(BINDIR)/uname: $(SBASE_SUBDIR)/uname.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

unexpand: $(BINDIR)/unexpand
$(BINDIR)/unexpand: $(SBASE_SUBDIR)/unexpand.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

uniq: $(BINDIR)/uniq
$(BINDIR)/uniq: $(SBASE_SUBDIR)/uniq.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

unlink: $(BINDIR)/unlink
$(BINDIR)/unlink: $(SBASE_SUBDIR)/unlink.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

uudecode: $(BINDIR)/uudecode
$(BINDIR)/uudecode: $(SBASE_SUBDIR)/uudecode.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

uuencode: $(BINDIR)/uuencode
$(BINDIR)/uuencode: $(SBASE_SUBDIR)/uuencode.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

wc: $(BINDIR)/wc
$(BINDIR)/wc: $(SBASE_SUBDIR)/wc.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

which: $(BINDIR)/which
$(BINDIR)/which: $(SBASE_SUBDIR)/which.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

whoami: $(BINDIR)/whoami
$(BINDIR)/whoami: $(SBASE_SUBDIR)/whoami.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

xargs: $(BINDIR)/xargs
$(BINDIR)/xargs: $(SBASE_SUBDIR)/xargs.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

xinstall: $(BINDIR)/xinstall
$(BINDIR)/xinstall: $(SBASE_SUBDIR)/xinstall.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

yes: $(BINDIR)/yes
$(BINDIR)/yes: $(SBASE_SUBDIR)/yes.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)

