#------------------------------------------------------------------------------
# Build Configuration
#------------------------------------------------------------------------------
# tools
CC = cc

# flags
LIBS     =
INCS     = -Iinclude
CPPFLAGS =
CFLAGS   = -O2 ${INCS} ${CPPFLAGS}
LDFLAGS  = ${LIBS}
ECLEAN   =

#------------------------------------------------------------------------------
# Build-Specific Macros
#------------------------------------------------------------------------------
# Simple Single-file Binary Template
define make-bin =
$1: source/$1.c
	$(CC) ${CFLAGS} -o $$@ $$<
ECLEAN += $1
endef

BINS = init getty

# load user-specific settings
-include config.mk

#------------------------------------------------------------------------------
# Phony Targets
#------------------------------------------------------------------------------
.PHONY: all

all: $(BINS)

$(eval $(call make-bin,init))
$(eval $(call make-bin,getty))

clean:
	$(RM) $(ECLEAN)

# load dependency files
-include ${DEPS}

