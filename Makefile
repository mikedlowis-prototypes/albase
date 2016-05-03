#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# tools
CC = cc
LD = $(CC)
AR = ar

# flags
LIBS     =
INCS     = -Iinclude
DEFS     = -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CPPFLAGS = $(INCS) $(DEFS)
CFLAGS   = -O2 --std=gnu99
LDFLAGS  = $(LIBS)
ARFLAGS  = rcs

# commands
BUILD   = $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
ARCHIVE = $(AR) $(ARFLAGS) $@ $^

# dirs
BUILDDIR = build
BINDIR   = $(BUILDDIR)/bin
OBJDIR   = $(BUILDDIR)/obj

# collections
BINS   =
ECLEAN =
DIRS   = $(BUILDDIR) $(BINDIR) $(OBJDIR)

#------------------------------------------------------------------------------
# Build Rules
#------------------------------------------------------------------------------
include source/Rules.mk
include source/sh/Rules.mk
include source/ubase/Rules.mk
#include source/sbase/Rules.mk

.PHONY: all $(BINS)

all: $(BINS)

clean:
	$(RM) $(ECLEAN)

# load dependency files if they exist
-include $(DEPS)

# load user-specific settings if they exist
-include config.mk

#------------------------------------------------------------------------------
# Ensure The Build Dir Exists
#------------------------------------------------------------------------------
$(BUILDDIR)/dummy:
	mkdir -p $(DIRS)
	touch $@
-include $(BUILDDIR)/dummy

