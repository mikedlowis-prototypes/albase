PHONY  += $(MKSH_BIN)
DIRS   += $(MKSH_OBJDIR)
ECLEAN += $(BINDIR)/$(MKSH_BIN) $(MKSH_OBJS)

MKSH_BIN     = sh
MKSH_SUBDIR  = source/sh
MKSH_OBJDIR  = $(OBJDIR)/sh

MKSH_OBJS =                  \
    $(MKSH_OBJDIR)/lalloc.o  \
    $(MKSH_OBJDIR)/eval.o    \
    $(MKSH_OBJDIR)/exec.o    \
    $(MKSH_OBJDIR)/expr.o    \
    $(MKSH_OBJDIR)/funcs.o   \
    $(MKSH_OBJDIR)/histrap.o \
    $(MKSH_OBJDIR)/jobs.o    \
    $(MKSH_OBJDIR)/lex.o     \
    $(MKSH_OBJDIR)/main.o    \
    $(MKSH_OBJDIR)/misc.o    \
    $(MKSH_OBJDIR)/shf.o     \
    $(MKSH_OBJDIR)/syn.o     \
    $(MKSH_OBJDIR)/tree.o    \
    $(MKSH_OBJDIR)/var.o     \
    $(MKSH_OBJDIR)/edit.o    \
    $(MKSH_OBJDIR)/strlcpy.o

MKSH_DEFINES =                    \
    -DMKSH_BUILD_R=523            \
    -DMKSH_BUILDSH                \
    -D_GNU_SOURCE                 \
    -DSETUID_CAN_FAIL_WITH_EAGAIN \
    -DHAVE_ATTRIBUTE_BOUNDED=0    \
    -DHAVE_ATTRIBUTE_FORMAT=1     \
    -DHAVE_ATTRIBUTE_NORETURN=1   \
    -DHAVE_ATTRIBUTE_PURE=1       \
    -DHAVE_ATTRIBUTE_UNUSED=1     \
    -DHAVE_ATTRIBUTE_USED=1       \
    -DHAVE_SYS_TIME_H=1           \
    -DHAVE_TIME_H=1               \
    -DHAVE_BOTH_TIME_H=1          \
    -DHAVE_SYS_BSDTYPES_H=0       \
    -DHAVE_SYS_FILE_H=1           \
    -DHAVE_SYS_MKDEV_H=0          \
    -DHAVE_SYS_MMAN_H=1           \
    -DHAVE_SYS_PARAM_H=1          \
    -DHAVE_SYS_RESOURCE_H=1       \
    -DHAVE_SYS_SELECT_H=1         \
    -DHAVE_SYS_SYSMACROS_H=1      \
    -DHAVE_BSTRING_H=0            \
    -DHAVE_GRP_H=1                \
    -DHAVE_IO_H=0                 \
    -DHAVE_LIBGEN_H=1             \
    -DHAVE_LIBUTIL_H=0            \
    -DHAVE_PATHS_H=1              \
    -DHAVE_STDINT_H=1             \
    -DHAVE_STRINGS_H=1            \
    -DHAVE_TERMIOS_H=1            \
    -DHAVE_ULIMIT_H=1             \
    -DHAVE_VALUES_H=1             \
    -DHAVE_CAN_INTTYPES=1         \
    -DHAVE_CAN_UCBINTS=1          \
    -DHAVE_CAN_INT8TYPE=1         \
    -DHAVE_CAN_UCBINT8=1          \
    -DHAVE_RLIM_T=1               \
    -DHAVE_SIG_T=1                \
    -DHAVE_SYS_ERRLIST=0          \
    -DHAVE_SYS_SIGNAME=0          \
    -DHAVE_SYS_SIGLIST=0          \
    -DHAVE_FLOCK=1                \
    -DHAVE_LOCK_FCNTL=1           \
    -DHAVE_GETRUSAGE=1            \
    -DHAVE_GETSID=1               \
    -DHAVE_GETTIMEOFDAY=1         \
    -DHAVE_KILLPG=1               \
    -DHAVE_MEMMOVE=1              \
    -DHAVE_MKNOD=0                \
    -DHAVE_MMAP=1                 \
    -DHAVE_NICE=1                 \
    -DHAVE_REVOKE=0               \
    -DHAVE_SETLOCALE_CTYPE=1      \
    -DHAVE_LANGINFO_CODESET=1     \
    -DHAVE_SELECT=1               \
    -DHAVE_SETRESUGID=1           \
    -DHAVE_SETGROUPS=1            \
    -DHAVE_STRERROR=1             \
    -DHAVE_STRSIGNAL=1            \
    -DHAVE_STRLCPY=1              \
    -DHAVE_FLOCK_DECL=1           \
    -DHAVE_REVOKE_DECL=1          \
    -DHAVE_SYS_ERRLIST_DECL=0     \
    -DHAVE_SYS_SIGLIST_DECL=0     \
    -DHAVE_PERSISTENT_HISTORY=1

$(MKSH_BIN): $(BINDIR)/$(MKSH_BIN)

$(BINDIR)/$(MKSH_BIN): $(MKSH_OBJS)
	$(LD) -o $@ $(MKSH_OBJS) $(LDFLAGS)

$(MKSH_OBJDIR)/%.o: $(MKSH_SUBDIR)/%.c
	$(CC) $(CFLAGS) -I$(MKSH_SUBDIR) $(MKSH_DEFINES) -c -o $@ $^
