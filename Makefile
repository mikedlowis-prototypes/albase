#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# tools
CC = cc

# flags
LIBS     =
INCS     = -Iinclude
CPPFLAGS = $(INCS) -D_XOPEN_SOURCE
CFLAGS   = -O2 $(CPPFLAGS)
LDFLAGS  = $(LIBS)
BUILD    = $(CC) $(CFLAGS) -o $@ $<

#------------------------------------------------------------------------------
# Build-Specific Macros
#------------------------------------------------------------------------------
BINS = init getty login

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

clean:
	$(RM) $(BINS)

# load dependency files
-include $(DEPS)

