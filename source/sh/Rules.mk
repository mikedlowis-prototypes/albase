MKSH_SUBDIR = source/sh
MKSH_BIN    = sh
MKSH_CCCMD  = $(CC) $(CFLAGS) -I$(MKSH_SUBDIR) $(MKSH_DEFINES) -c -o $@ $^
MKSH_LDCMD  = $(CC) -o $@ $^

MKSH_OBJS =                  \
    $(MKSH_SUBDIR)/lalloc.o  \
    $(MKSH_SUBDIR)/eval.o    \
    $(MKSH_SUBDIR)/exec.o    \
    $(MKSH_SUBDIR)/expr.o    \
    $(MKSH_SUBDIR)/funcs.o   \
    $(MKSH_SUBDIR)/histrap.o \
    $(MKSH_SUBDIR)/jobs.o    \
    $(MKSH_SUBDIR)/lex.o     \
    $(MKSH_SUBDIR)/main.o    \
    $(MKSH_SUBDIR)/misc.o    \
    $(MKSH_SUBDIR)/shf.o     \
    $(MKSH_SUBDIR)/syn.o     \
    $(MKSH_SUBDIR)/tree.o    \
    $(MKSH_SUBDIR)/var.o     \
    $(MKSH_SUBDIR)/edit.o

MKSH_DEFINES =                  \
    -DMKSH_BUILD_R=523          \
    -DMKSH_BUILDSH              \
    -DHAVE_ATTRIBUTE_BOUNDED=1  \
    -DHAVE_ATTRIBUTE_FORMAT=1   \
    -DHAVE_ATTRIBUTE_NORETURN=1 \
    -DHAVE_ATTRIBUTE_PURE=1     \
    -DHAVE_ATTRIBUTE_UNUSED=1   \
    -DHAVE_ATTRIBUTE_USED=1     \
    -DHAVE_SYS_TIME_H=1         \
    -DHAVE_TIME_H=1             \
    -DHAVE_BOTH_TIME_H=1        \
    -DHAVE_SYS_BSDTYPES_H=0     \
    -DHAVE_SYS_FILE_H=1         \
    -DHAVE_SYS_MKDEV_H=0        \
    -DHAVE_SYS_MMAN_H=1         \
    -DHAVE_SYS_PARAM_H=1        \
    -DHAVE_SYS_RESOURCE_H=1     \
    -DHAVE_SYS_SELECT_H=1       \
    -DHAVE_SYS_SYSMACROS_H=0    \
    -DHAVE_BSTRING_H=0          \
    -DHAVE_GRP_H=1              \
    -DHAVE_IO_H=0               \
    -DHAVE_LIBGEN_H=1           \
    -DHAVE_LIBUTIL_H=0          \
    -DHAVE_PATHS_H=1            \
    -DHAVE_STDINT_H=1           \
    -DHAVE_STRINGS_H=1          \
    -DHAVE_TERMIOS_H=1          \
    -DHAVE_ULIMIT_H=1           \
    -DHAVE_VALUES_H=0           \
    -DHAVE_CAN_INTTYPES=1       \
    -DHAVE_CAN_UCBINTS=1        \
    -DHAVE_CAN_INT8TYPE=1       \
    -DHAVE_CAN_UCBINT8=1        \
    -DHAVE_RLIM_T=1             \
    -DHAVE_SIG_T=1              \
    -DHAVE_SYS_ERRLIST=1        \
    -DHAVE_SYS_SIGNAME=1        \
    -DHAVE_SYS_SIGLIST=1        \
    -DHAVE_FLOCK=1              \
    -DHAVE_LOCK_FCNTL=1         \
    -DHAVE_GETRUSAGE=1          \
    -DHAVE_GETSID=1             \
    -DHAVE_GETTIMEOFDAY=1       \
    -DHAVE_KILLPG=1             \
    -DHAVE_MEMMOVE=1            \
    -DHAVE_MKNOD=0              \
    -DHAVE_MMAP=1               \
    -DHAVE_NICE=1               \
    -DHAVE_REVOKE=1             \
    -DHAVE_SETLOCALE_CTYPE=1    \
    -DHAVE_LANGINFO_CODESET=1   \
    -DHAVE_SELECT=1             \
    -DHAVE_SETRESUGID=0         \
    -DHAVE_SETGROUPS=0          \
    -DHAVE_STRERROR=0           \
    -DHAVE_STRSIGNAL=0          \
    -DHAVE_STRLCPY=1            \
    -DHAVE_FLOCK_DECL=1         \
    -DHAVE_REVOKE_DECL=1        \
    -DHAVE_SYS_ERRLIST_DECL=1   \
    -DHAVE_SYS_SIGLIST_DECL=1   \
    -DHAVE_PERSISTENT_HISTORY=1

$(MKSH_BIN): $(MKSH_OBJS)
	$(MKSH_LDCMD)

$(MKSH_SUBDIR)/lalloc.o: $(MKSH_SUBDIR)/lalloc.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/eval.o: $(MKSH_SUBDIR)/eval.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/exec.o: $(MKSH_SUBDIR)/exec.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/expr.o: $(MKSH_SUBDIR)/expr.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/funcs.o: $(MKSH_SUBDIR)/funcs.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/histrap.o: $(MKSH_SUBDIR)/histrap.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/jobs.o: $(MKSH_SUBDIR)/jobs.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/lex.o: $(MKSH_SUBDIR)/lex.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/main.o: $(MKSH_SUBDIR)/main.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/misc.o: $(MKSH_SUBDIR)/misc.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/shf.o: $(MKSH_SUBDIR)/shf.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/syn.o: $(MKSH_SUBDIR)/syn.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/tree.o: $(MKSH_SUBDIR)/tree.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/var.o: $(MKSH_SUBDIR)/var.c
	$(MKSH_CCCMD)

$(MKSH_SUBDIR)/edit.o: $(MKSH_SUBDIR)/edit.c
	$(MKSH_CCCMD)
