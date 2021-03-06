#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# architecture
ARCH = x86_64

# tools
CC     = cc
LD     = $(CC)
AR     = ar

# flags
LIBS     =
INCS     = -Iinclude
DEFS     = -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L
CPPFLAGS = $(INCS) $(DEFS)
CFLAGS   = --static -O2 --std=gnu99
LDFLAGS  = --static $(LIBS)
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
DIRS   = $(BUILDDIR) $(BINDIR) $(LIBDIR) $(OBJDIR) \
         $(BUILDDIR)/boot      \
         $(BUILDDIR)/dev       \
         $(BUILDDIR)/etc       \
         $(BUILDDIR)/home/root \
         $(BUILDDIR)/proc      \
         $(BUILDDIR)/sys       \
         $(BUILDDIR)/tmp       \
         $(BUILDDIR)/var

# optionally override settings
-include config.mk

#------------------------------------------------------------------------------
# Build Rules
#------------------------------------------------------------------------------
# TODO: Determine if this is needed anymore now that we have a musl-based cross compiler
#include source/musl/Rules.mk
#
# TODO: Fix an issue where libcurl.a is refusing to build for some reason
#include source/curl/Rules.mk

include source/Rules.mk
include source/ubase/Rules.mk
include source/sbase/Rules.mk
include source/sh/Rules.mk
include source/shadow/Rules.mk
include source/smdev/Rules.mk
include source/sdhcp/Rules.mk
#include source/iproute2/Rules.mk
include source/kernel/Rules.mk
include etc/Rules.mk

.PHONY: all $(PHONY)

all: $(PHONY)

stage1: $(PHONY)
	cd $(BUILDDIR) && tar -cJf ../stage1.tar.xz . --exclude obj --exclude dummy

clean: kernel-clean
	@echo cleaning
	@$(RM) $(BUILDDIR)/dummy $(ECLEAN)
	@$(RM) -r $(BUILDDIR)/include
	@$(RM) albase.iso stage1.tar.xz iso9660/isolinux/vmlinuz iso9660/isolinux/initrd.img
	@$(RM) $(BUILDDIR)/boot/* $(BUILDDIR)/bin/* $(BUILDDIR)/init

dist-clean:
	@$(RM) -r $(BUILDDIR) musl-cross-make/stage1 musl-cross-make/stage2 config.mk

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
