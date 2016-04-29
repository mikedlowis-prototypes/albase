#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# tools
CC = cc

# flags
LIBS     =
INCS     = -Iinclude
DEFS     = -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CPPFLAGS = $(INCS) $(DEFS)
CFLAGS   = -O2
LDFLAGS  = $(LIBS)
BUILD    = $(CC) $(CPPFLAGS) $(CFLAGS) -o $(BINDIR)/$@ $^

# dirs
BUILDDIR = build
BINDIR   = $(BUILDDIR)/bin
OBJDIR   = $(BUILDDIR)/obj

#------------------------------------------------------------------------------
# Build-Specific Macros
#------------------------------------------------------------------------------
BINS =              \
    $(BINDIR)/init  \
    $(BINDIR)/getty \
    $(BINDIR)/login \
    $(BINDIR)/dmesg \
    $(BINDIR)/sh

# load user-specific settings
-include config.mk

#------------------------------------------------------------------------------
# Phony Targets
#------------------------------------------------------------------------------
.PHONY: all dirs

all: dirs $(BINS)

dirs:
	mkdir -p $(BINDIR) $(OBJDIR) $(MKSH_OBJDIR)

$(BINDIR)/init: source/init.c
	$(BUILD)

$(BINDIR)/getty: source/getty.c
	$(BUILD)

$(BINDIR)/login: source/login.c
	$(BUILD) -lcrypt

$(BINDIR)/dmesg: source/dmesg.c
	$(BUILD)

include source/sh/Rules.mk

clean:
	$(RM) $(BINS) $(MKSH_OBJS)

# load dependency files
-include $(DEPS)

