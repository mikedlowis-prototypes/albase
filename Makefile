#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# architecture
ARCH = x86_64

# tools
REALCC = cc
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

# cc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h -c -o build/lib/Scrt1.o source/musl/crt/Scrt1.c -fPIC -fno-stack-protector -DCRT
#gcc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h  -fPIC -fno-stack-protector -DCRT -c -o obj/crt/Scrt1.o crt/Scrt1.c
#
# cc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h -c -o build/lib/crt1.o source/musl/crt/crt1.c -fno-stack-protector -DCRT
#gcc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h  -fno-stack-protector -DCRT -c -o obj/crt/crt1.o crt/crt1.c
#
# cc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h -c -o build/lib/rcrt1.o source/musl/crt/rcrt1.c -fPIC -fno-stack-protector -DCRT
#gcc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h  -fPIC -fno-stack-protector -DCRT -c -o obj/crt/rcrt1.o crt/rcrt1.c
#
# cc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h -c -o build/lib/crti.o source/musl/crt/x86_64/crti.s -DCRT
#gcc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h  -DCRT -c -o obj/crt/x86_64/crti.o crt/x86_64/crti.s
#
# cc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h -c -o build/lib/crtn.o source/musl/crt/x86_64/crtn.s -DCRT
#gcc -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700 -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -include vis.h  -DCRT -c -o obj/crt/x86_64/crtn.o crt/x86_64/crtn.s



#------------------------------------------------------------------------------
# Ensure The Build Dir Exists
#------------------------------------------------------------------------------
$(BUILDDIR)/dummy:
	@echo creating build dirs
	@mkdir -p $(DIRS)
	@touch $@
-include $(BUILDDIR)/dummy
