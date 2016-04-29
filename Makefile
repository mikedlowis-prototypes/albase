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
BUILD    = $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $<

#------------------------------------------------------------------------------
# Build-Specific Macros
#------------------------------------------------------------------------------
BINS = init getty login dmesg sh

# load user-specific settings
-include config.mk

#------------------------------------------------------------------------------
# Phony Targets
#------------------------------------------------------------------------------
.PHONY: all

all: $(BINS)

init: source/init.c
	$(BUILD)

getty: source/getty.c
	$(BUILD)

login: source/login.c
	$(BUILD) -lcrypt

dmesg: source/dmesg.c
	$(BUILD)

include source/sh/Rules.mk

clean:
	$(RM) $(BINS) $(MKSH_OBJS)

# load dependency files
-include $(DEPS)

