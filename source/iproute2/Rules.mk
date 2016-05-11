PHONY  += iproute2
ECLEAN += $(IPROUTE2_LIBMISC) \
          $(IPROUTE2_LIB) \
          $(IPROUTE2_BINS) \
          $(IPROUTE2_LIBMISC_OBJS) \
          $(IPROUTE2_LIB_OBJS)
DIRS   += $(IPROUTE2_OBJDIR) \
          $(IPROUTE2_OBJDIR)/ip \
          $(IPROUTE2_OBJDIR)/lib

# Subdir settings
IPROUTE2_SUBDIR = source/iproute2
IPROUTE2_OBJDIR = $(OBJDIR)/iproute2
IPROUTE2_FLAGS  = -O2 -DRESOLVE_HOSTNAMES -DLIBDIR=\"/usr/lib\" -DCONFDIR=\"/etc/iproute2\" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -DHAVE_SETNS -D_LINUX_IN6_H
IPROUTE2_INCS   = -I$(IPROUTE2_SUBDIR)/include

# libutil
IPROUTE2_LIBIPROUTE2      = $(IPROUTE2_OBJDIR)/libiproute2.a
IPROUTE2_LIBIPROUTE2_SRCS = $(wildcard $(IPROUTE2_SUBDIR)/lib/*.c)
IPROUTE2_LIBIPROUTE2_OBJS = $(patsubst $(IPROUTE2_SUBDIR)/%,$(IPROUTE2_OBJDIR)/%.o,$(basename $(IPROUTE2_LIBIPROUTE2_SRCS)))

# ip command
IPROUTE2_IP       = $(BINDIR)/ip
IPROUTE2_DEL_SRCS = $(IPROUTE2_SUBDIR)/ip/rtmon.c $(IPROUTE2_SUBDIR)/ip/static-syms.c
IPROUTE2_IP_SRCS  = $(filter-out $(IPROUTE2_DEL_SRCS),$(wildcard $(IPROUTE2_SUBDIR)/ip/*.c))
IPROUTE2_IP_OBJS  = $(patsubst $(IPROUTE2_SUBDIR)/%,$(IPROUTE2_OBJDIR)/%.o,$(basename $(IPROUTE2_IP_SRCS)))

iproute2: $(IPROUTE2_LIBIPROUTE2) $(BINDIR)/rtmon $(BINDIR)/ip

$(IPROUTE2_LIBIPROUTE2): $(IPROUTE2_LIBIPROUTE2_OBJS)

$(BINDIR)/rtmon: $(IPROUTE2_SUBDIR)/ip/rtmon.c $(IPROUTE2_LIBIPROUTE2)

$(BINDIR)/ip: $(IPROUTE2_IP_OBJS) $(IPROUTE2_LIBIPROUTE2)

$(BINDIR)/%:
	$(CC) $(IPROUTE2_FLAGS) $(IPROUTE2_INCS) -o $@ $^

$(IPROUTE2_OBJDIR)/%.a:
	$(AR) $(ARFLAGS) $@ $^

$(IPROUTE2_OBJDIR)/%.o: $(IPROUTE2_SUBDIR)/%.c $(CC)
	$(CC) $(IPROUTE2_FLAGS) $(IPROUTE2_INCS) -c -o $@ $<
