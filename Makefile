#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# tools
CC = cc

# flags
LIBS     =
INCS     = -Iinclude
CPPFLAGS =
CFLAGS   = -O2 $(INCS) $(CPPFLAGS)
LDFLAGS  = $(LIBS)
BUILD    = $(CC) $(CFLAGS) -o $@ $<

#------------------------------------------------------------------------------
# Build-Specific Macros
#------------------------------------------------------------------------------
BINS = init getty

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

clean:
	$(RM) $(BINS)

# load dependency files
-include $(DEPS)

