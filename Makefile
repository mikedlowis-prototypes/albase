#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# architecture
ARCH = x86_64

# tools
REALCC = gcc
CC     = $(BINDIR)/musl-gcc
LD     = $(CC)
AR     = ar

# flags
LIBS     =
INCS     = -Iinclude
DEFS     = -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CPPFLAGS = $(INCS) $(DEFS)
CFLAGS   = -O2 --std=gnu99
LDFLAGS  = $(LIBS)
ARFLAGS  = rcs

# commands
BUILD   = $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $<
ARCHIVE = $(AR) $(ARFLAGS) $@ $^

# dirs
BUILDDIR = build
BINDIR   = $(BUILDDIR)/bin
LIBDIR   = $(BUILDDIR)/lib
OBJDIR   = $(BUILDDIR)/obj

# collections
PHONY  =
BINS   =
ECLEAN =
DIRS   = $(BUILDDIR) $(BINDIR) $(LIBDIR) $(OBJDIR)

#------------------------------------------------------------------------------
# Build Rules
#------------------------------------------------------------------------------
include source/musl/Rules.mk
include source/Rules.mk
include source/ubase/Rules.mk
include source/sbase/Rules.mk
include source/sh/Rules.mk
#include source/shadow/Rules.mk

.PHONY: all $(PHONY)

all: $(PHONY)

clean:
	@echo cleaning
	@$(RM) $(BUILDDIR)/dummy $(ECLEAN)
	@$(RM) -r $(BUILDDIR)/include

# load dependency files if they exist
-include $(DEPS)

# load user-specific settings if they exist
-include config.mk

#------------------------------------------------------------------------------
# Ensure The Build Dir Exists
#------------------------------------------------------------------------------
$(BUILDDIR)/dummy:
	@echo creating build dirs
	@mkdir -p $(DIRS)
	@touch $@
-include $(BUILDDIR)/dummy
