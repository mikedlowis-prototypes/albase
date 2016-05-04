PHONY  += sbase
DIRS   += $(SBASE_OBJDIR)
ECLEAN += $(SBASE_LIBUTIL) \
          $(SBASE_LIBUTF) \
          $(SBASE_LIBUTIL_OBJS) \
          $(SBASE_LIBUTF_OBJS) \
          $(SBASE_BINS)

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
    $(BINDIR)/basename\
    $(BINDIR)/cal\
    $(BINDIR)/cat\
    $(BINDIR)/chgrp\
    $(BINDIR)/chmod\
    $(BINDIR)/chown\
    $(BINDIR)/chroot\
    $(BINDIR)/cksum\
    $(BINDIR)/cmp\
    $(BINDIR)/cols\
    $(BINDIR)/comm\
    $(BINDIR)/cp\
    $(BINDIR)/cron\
    $(BINDIR)/cut\
    $(BINDIR)/date\
    $(BINDIR)/dirname\
    $(BINDIR)/du\
    $(BINDIR)/echo\
    $(BINDIR)/ed\
    $(BINDIR)/env\
    $(BINDIR)/expand\
    $(BINDIR)/expr\
    $(BINDIR)/false\
    $(BINDIR)/find\
    $(BINDIR)/flock\
    $(BINDIR)/fold\
    $(BINDIR)/getconf\
    $(BINDIR)/grep\
    $(BINDIR)/head\
    $(BINDIR)/join\
    $(BINDIR)/hostname\
    $(BINDIR)/kill\
    $(BINDIR)/link\
    $(BINDIR)/ln\
    $(BINDIR)/logger\
    $(BINDIR)/logname\
    $(BINDIR)/ls\
    $(BINDIR)/md5sum\
    $(BINDIR)/mkdir\
    $(BINDIR)/mkfifo\
    $(BINDIR)/mktemp\
    $(BINDIR)/mv\
    $(BINDIR)/nice\
    $(BINDIR)/nl\
    $(BINDIR)/nohup\
    $(BINDIR)/od\
    $(BINDIR)/pathchk\
    $(BINDIR)/paste\
    $(BINDIR)/printenv\
    $(BINDIR)/printf\
    $(BINDIR)/pwd\
    $(BINDIR)/readlink\
    $(BINDIR)/renice\
    $(BINDIR)/rm\
    $(BINDIR)/rmdir\
    $(BINDIR)/sed\
    $(BINDIR)/seq\
    $(BINDIR)/setsid\
    $(BINDIR)/sha1sum\
    $(BINDIR)/sha224sum\
    $(BINDIR)/sha256sum\
    $(BINDIR)/sha384sum\
    $(BINDIR)/sha512sum\
    $(BINDIR)/sha512-224sum\
    $(BINDIR)/sha512-256sum\
    $(BINDIR)/sleep\
    $(BINDIR)/sort\
    $(BINDIR)/split\
    $(BINDIR)/sponge\
    $(BINDIR)/strings\
    $(BINDIR)/sync\
    $(BINDIR)/tail\
    $(BINDIR)/tar\
    $(BINDIR)/tee\
    $(BINDIR)/test\
    $(BINDIR)/tftp\
    $(BINDIR)/time\
    $(BINDIR)/touch\
    $(BINDIR)/tr\
    $(BINDIR)/true\
    $(BINDIR)/tsort\
    $(BINDIR)/tty\
    $(BINDIR)/uname\
    $(BINDIR)/unexpand\
    $(BINDIR)/uniq\
    $(BINDIR)/unlink\
    $(BINDIR)/uudecode\
    $(BINDIR)/uuencode\
    $(BINDIR)/wc\
    $(BINDIR)/which\
    $(BINDIR)/whoami\
    $(BINDIR)/xargs\
    $(BINDIR)/xinstall\
    $(BINDIR)/yes

sbase: $(SBASE_BINS)

$(SBASE_LIBUTIL): $(SBASE_LIBUTIL_OBJS)
	$(SBASE_ARCHIVE)

$(SBASE_OBJDIR)/%.o: $(SBASE_SUBDIR)/libutil/%.c
	$(SBASE_COMPILE)

$(SBASE_LIBUTF): $(SBASE_LIBUTF_OBJS)
	$(SBASE_ARCHIVE)

$(SBASE_OBJDIR)/%.o: $(SBASE_SUBDIR)/libutf/%.c
	$(SBASE_COMPILE)

$(BINDIR)/%: $(SBASE_SUBDIR)/%.c $(SBASE_LIBUTIL) $(SBASE_LIBUTF)
	$(SBASE_BUILD)
