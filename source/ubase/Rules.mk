BINS   += $(UBASE_BINS)
DIRS   += $(UBASE_OBJDIR)
ECLEAN += $(UBASE_LIBUTIL) \
          $(UBASE_LIBUTIL_OBJS) \
          $(addprefix $(BINDIR)/,$(UBASE_BINS))

UBASE_SUBDIR  = source/ubase
UBASE_OBJDIR  = $(OBJDIR)/ubase
UBASE_LIBUTIL = $(UBASE_OBJDIR)/libutil.a
UBASE_DEFS    = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
UBASE_COMPILE = $(CC) $(UBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(UBASE_SUBDIR) -o $@ -c $<
UBASE_BUILD   = $(CC) $(UBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(UBASE_SUBDIR) -o $@ $^
UBASE_ARCHIVE = $(AR) $(ARFLAGS) $@ $^

UBASE_LIBUTIL_OBJS =                 \
    $(UBASE_OBJDIR)/agetcwd.o        \
    $(UBASE_OBJDIR)/agetline.o       \
    $(UBASE_OBJDIR)/apathmax.o       \
    $(UBASE_OBJDIR)/concat.o         \
    $(UBASE_OBJDIR)/ealloc.o         \
    $(UBASE_OBJDIR)/eprintf.o        \
    $(UBASE_OBJDIR)/estrtol.o        \
    $(UBASE_OBJDIR)/estrtoul.o       \
    $(UBASE_OBJDIR)/explicit_bzero.o \
    $(UBASE_OBJDIR)/passwd.o         \
    $(UBASE_OBJDIR)/proc.o           \
    $(UBASE_OBJDIR)/putword.o        \
    $(UBASE_OBJDIR)/recurse.o        \
    $(UBASE_OBJDIR)/strlcat.o        \
    $(UBASE_OBJDIR)/strlcpy.o        \
    $(UBASE_OBJDIR)/strtonum.o       \
    $(UBASE_OBJDIR)/tty.o

UBASE_BINS =    \
    chvt        \
    clear       \
    ctrlaltdel  \
    dd          \
    df          \
    eject       \
    fallocate   \
    free        \
    freeramdisk \
    fsfreeze    \
    halt        \
    hwclock     \
    id          \
    insmod      \
    killall5    \
    last        \
    lastlog     \
    lsmod       \
    lsusb       \
    mesg        \
    mknod       \
    mkswap      \
    mount       \
    mountpoint  \
    nologin     \
    pagesize    \
    passwd      \
    pidof       \
    pivot_root  \
    ps          \
    readahead   \
    respawn     \
    rmmod       \
    stat        \
    su          \
    swaplabel   \
    swapoff     \
    swapon      \
    switch_root \
    sysctl      \
    truncate    \
    umount      \
    unshare     \
    uptime      \
    vtallow     \
    watch       \
    who

$(UBASE_LIBUTIL): $(UBASE_LIBUTIL_OBJS)
	$(UBASE_ARCHIVE)
$(UBASE_OBJDIR)/agetcwd.o: $(UBASE_SUBDIR)/libutil/agetcwd.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/agetline.o: $(UBASE_SUBDIR)/libutil/agetline.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/apathmax.o: $(UBASE_SUBDIR)/libutil/apathmax.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/concat.o: $(UBASE_SUBDIR)/libutil/concat.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/ealloc.o: $(UBASE_SUBDIR)/libutil/ealloc.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/eprintf.o: $(UBASE_SUBDIR)/libutil/eprintf.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/estrtol.o: $(UBASE_SUBDIR)/libutil/estrtol.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/estrtoul.o: $(UBASE_SUBDIR)/libutil/estrtoul.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/explicit_bzero.o: $(UBASE_SUBDIR)/libutil/explicit_bzero.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/passwd.o:  $(UBASE_SUBDIR)/libutil/passwd.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/proc.o: $(UBASE_SUBDIR)/libutil/proc.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/putword.o: $(UBASE_SUBDIR)/libutil/putword.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/recurse.o: $(UBASE_SUBDIR)/libutil/recurse.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/strlcat.o: $(UBASE_SUBDIR)/libutil/strlcat.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/strlcpy.o: $(UBASE_SUBDIR)/libutil/strlcpy.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/strtonum.o: $(UBASE_SUBDIR)/libutil/strtonum.c
	$(UBASE_COMPILE)
$(UBASE_OBJDIR)/tty.o: $(UBASE_SUBDIR)/libutil/tty.c
	$(UBASE_COMPILE)

chvt: $(BINDIR)/chvt
$(BINDIR)/chvt: $(UBASE_SUBDIR)/chvt.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

clear: $(BINDIR)/clear
$(BINDIR)/clear: $(UBASE_SUBDIR)/clear.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

ctrlaltdel: $(BINDIR)/ctrlaltdel
$(BINDIR)/ctrlaltdel: $(UBASE_SUBDIR)/ctrlaltdel.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

dd: $(BINDIR)/dd
$(BINDIR)/dd: $(UBASE_SUBDIR)/dd.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

df: $(BINDIR)/df
$(BINDIR)/df: $(UBASE_SUBDIR)/df.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

eject: $(BINDIR)/eject
$(BINDIR)/eject: $(UBASE_SUBDIR)/eject.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

fallocate: $(BINDIR)/fallocate
$(BINDIR)/fallocate: $(UBASE_SUBDIR)/fallocate.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

free: $(BINDIR)/free
$(BINDIR)/free: $(UBASE_SUBDIR)/free.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

freeramdisk: $(BINDIR)/freeramdisk
$(BINDIR)/freeramdisk: $(UBASE_SUBDIR)/freeramdisk.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

fsfreeze: $(BINDIR)/fsfreeze
$(BINDIR)/fsfreeze: $(UBASE_SUBDIR)/fsfreeze.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

halt: $(BINDIR)/halt
$(BINDIR)/halt: $(UBASE_SUBDIR)/halt.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

hwclock: $(BINDIR)/hwclock
$(BINDIR)/hwclock: $(UBASE_SUBDIR)/hwclock.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

id: $(BINDIR)/id
$(BINDIR)/id: $(UBASE_SUBDIR)/id.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

insmod: $(BINDIR)/insmod
$(BINDIR)/insmod: $(UBASE_SUBDIR)/insmod.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

killall5: $(BINDIR)/killall5
$(BINDIR)/killall5: $(UBASE_SUBDIR)/killall5.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

last: $(BINDIR)/last
$(BINDIR)/last: $(UBASE_SUBDIR)/last.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

lastlog: $(BINDIR)/lastlog
$(BINDIR)/lastlog: $(UBASE_SUBDIR)/lastlog.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

lsmod: $(BINDIR)/lsmod
$(BINDIR)/lsmod: $(UBASE_SUBDIR)/lsmod.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

lsusb: $(BINDIR)/lsusb
$(BINDIR)/lsusb: $(UBASE_SUBDIR)/lsusb.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

mesg: $(BINDIR)/mesg
$(BINDIR)/mesg: $(UBASE_SUBDIR)/mesg.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

mknod: $(BINDIR)/mknod
$(BINDIR)/mknod: $(UBASE_SUBDIR)/mknod.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

mkswap: $(BINDIR)/mkswap
$(BINDIR)/mkswap: $(UBASE_SUBDIR)/mkswap.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

mountpoint: $(BINDIR)/mountpoint
$(BINDIR)/mountpoint: $(UBASE_SUBDIR)/mountpoint.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

nologin: $(BINDIR)/nologin
$(BINDIR)/nologin: $(UBASE_SUBDIR)/nologin.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

pagesize: $(BINDIR)/pagesize
$(BINDIR)/pagesize: $(UBASE_SUBDIR)/pagesize.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

passwd: $(BINDIR)/passwd
$(BINDIR)/passwd: $(UBASE_SUBDIR)/passwd.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD) -lcrypt

pidof: $(BINDIR)/pidof
$(BINDIR)/pidof: $(UBASE_SUBDIR)/pidof.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

pivot_root: $(BINDIR)/pivot_root
$(BINDIR)/pivot_root: $(UBASE_SUBDIR)/pivot_root.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

ps: $(BINDIR)/ps
$(BINDIR)/ps: $(UBASE_SUBDIR)/ps.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

readahead: $(BINDIR)/readahead
$(BINDIR)/readahead: $(UBASE_SUBDIR)/readahead.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

respawn: $(BINDIR)/respawn
$(BINDIR)/respawn: $(UBASE_SUBDIR)/respawn.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

rmmod: $(BINDIR)/rmmod
$(BINDIR)/rmmod: $(UBASE_SUBDIR)/rmmod.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

stat: $(BINDIR)/stat
$(BINDIR)/stat: $(UBASE_SUBDIR)/stat.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

su: $(BINDIR)/su
$(BINDIR)/su: $(UBASE_SUBDIR)/su.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD) -lcrypt

swaplabel: $(BINDIR)/swaplabel
$(BINDIR)/swaplabel: $(UBASE_SUBDIR)/swaplabel.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

swapoff: $(BINDIR)/swapoff
$(BINDIR)/swapoff: $(UBASE_SUBDIR)/swapoff.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

swapon: $(BINDIR)/swapon
$(BINDIR)/swapon: $(UBASE_SUBDIR)/swapon.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

switch_root: $(BINDIR)/switch_root
$(BINDIR)/switch_root: $(UBASE_SUBDIR)/switch_root.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

sysctl: $(BINDIR)/sysctl
$(BINDIR)/sysctl: $(UBASE_SUBDIR)/sysctl.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

truncate: $(BINDIR)/truncate
$(BINDIR)/truncate: $(UBASE_SUBDIR)/truncate.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

unmount: $(BINDIR)/unmount
$(BINDIR)/umount: $(UBASE_SUBDIR)/umount.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

unshare: $(BINDIR)/unshare
$(BINDIR)/unshare: $(UBASE_SUBDIR)/unshare.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

uptime: $(BINDIR)/uptime
$(BINDIR)/uptime: $(UBASE_SUBDIR)/uptime.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

vtallow: $(BINDIR)/vtallow
$(BINDIR)/vtallow: $(UBASE_SUBDIR)/vtallow.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

watch: $(BINDIR)/watch
$(BINDIR)/watch: $(UBASE_SUBDIR)/watch.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)

who: $(BINDIR)/who
$(BINDIR)/who: $(UBASE_SUBDIR)/who.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD)
