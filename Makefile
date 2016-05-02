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
BUILD    = $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^

# dirs
BUILDDIR = build
BINDIR   = $(BUILDDIR)/bin
OBJDIR   = $(BUILDDIR)/obj

# targets
BINS =
ECLEAN =

#------------------------------------------------------------------------------
# Ensure The Build Dir Exists
#------------------------------------------------------------------------------
$(BUILDDIR)/dummy:
	mkdir -p $(BUILDDIR) $(BINDIR) $(OBJDIR) $(MKSH_OBJDIR)
	touch $@
-include $(BUILDDIR)/dummy

#------------------------------------------------------------------------------
# Build Rules
#------------------------------------------------------------------------------
include source/Rules.mk
include source/sh/Rules.mk

.PHONY: all $(BINS)

all: $(BINS)

clean:
	$(RM) $(ECLEAN)

# load dependency files if they exist
-include $(DEPS)

# load user-specific settings if they exist
-include config.mk
