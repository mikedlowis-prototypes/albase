PHONY  += ubase
DIRS   += $(UBASE_OBJDIR)
ECLEAN += $(UBASE_LIBUTIL) \
          $(UBASE_LIBUTIL_OBJS) \
          $(UBASE_BINS)

UBASE_SUBDIR  = source/ubase
UBASE_OBJDIR  = $(OBJDIR)/ubase
UBASE_LIBUTIL = $(UBASE_OBJDIR)/libutil.a
UBASE_DEFS    = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
UBASE_COMPILE = $(CC) $(UBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(UBASE_SUBDIR) -o $@ -c $<
UBASE_BUILD   = $(CC) $(UBASE_DEFS) $(CFLAGS) $(CPPFLAGS) -I$(UBASE_SUBDIR) -o $@ $<
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

UBASE_BINS =              \
    $(BINDIR)/chvt        \
    $(BINDIR)/clear       \
    $(BINDIR)/ctrlaltdel  \
    $(BINDIR)/dd          \
    $(BINDIR)/df          \
    $(BINDIR)/eject       \
    $(BINDIR)/fallocate   \
    $(BINDIR)/free        \
    $(BINDIR)/freeramdisk \
    $(BINDIR)/fsfreeze    \
    $(BINDIR)/halt        \
    $(BINDIR)/hwclock     \
    $(BINDIR)/id          \
    $(BINDIR)/insmod      \
    $(BINDIR)/killall5    \
    $(BINDIR)/last        \
    $(BINDIR)/lastlog     \
    $(BINDIR)/lsmod       \
    $(BINDIR)/lsusb       \
    $(BINDIR)/mesg        \
    $(BINDIR)/mknod       \
    $(BINDIR)/mkswap      \
    $(BINDIR)/mount       \
    $(BINDIR)/mountpoint  \
    $(BINDIR)/nologin     \
    $(BINDIR)/pagesize    \
    $(BINDIR)/passwd      \
    $(BINDIR)/pidof       \
    $(BINDIR)/pivot_root  \
    $(BINDIR)/ps          \
    $(BINDIR)/readahead   \
    $(BINDIR)/respawn     \
    $(BINDIR)/rmmod       \
    $(BINDIR)/stat        \
    $(BINDIR)/su          \
    $(BINDIR)/swaplabel   \
    $(BINDIR)/swapoff     \
    $(BINDIR)/swapon      \
    $(BINDIR)/switch_root \
    $(BINDIR)/sysctl      \
    $(BINDIR)/truncate    \
    $(BINDIR)/umount      \
    $(BINDIR)/unshare     \
    $(BINDIR)/uptime      \
    $(BINDIR)/vtallow     \
    $(BINDIR)/watch       \
    $(BINDIR)/who

ubase: $(UBASE_BINS)

$(UBASE_LIBUTIL): $(UBASE_LIBUTIL_OBJS)
	$(UBASE_ARCHIVE)

$(UBASE_OBJDIR)/%.o: $(UBASE_SUBDIR)/libutil/%.c
	$(UBASE_COMPILE)

$(BINDIR)/%: $(UBASE_SUBDIR)/%.c $(UBASE_LIBUTIL)
	$(UBASE_BUILD) $(UBASE_LIBUTIL) -lcrypt
