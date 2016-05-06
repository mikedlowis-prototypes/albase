PHONY  += shadow
ECLEAN += $(SHADOW_LIBMISC) \
          $(SHADOW_LIB) \
          $(SHADOW_BINS) \
          $(SHADOW_LIBMISC_OBJS) \
          $(SHADOW_LIB_OBJS)
DIRS   += $(SHADOW_OBJDIR) \
          $(SHADOW_OBJDIR)/lib \
          $(SHADOW_OBJDIR)/libmisc

# Subdir settings
SHADOW_SUBDIR       = source/shadow
SHADOW_OBJDIR       = $(OBJDIR)/shadow

# libshadow.a
SHADOW_LIB      = $(LIBDIR)/libshadow.a
SHADOW_LIB_SRCS = $(wildcard $(SHADOW_SUBDIR)/lib/*.c)
SHADOW_LIB_OBJS = $(patsubst $(SHADOW_SUBDIR)/%,$(SHADOW_OBJDIR)/%.o,$(basename $(SHADOW_LIB_SRCS)))

# libmisc.a
SHADOW_LIBMISC      = $(SHADOW_OBJDIR)/libmisc.a
SHADOW_LIBMISC_SRCS = $(wildcard $(SHADOW_SUBDIR)/libmisc/*.c)
SHADOW_LIBMISC_OBJS = $(patsubst $(SHADOW_SUBDIR)/%,$(SHADOW_OBJDIR)/%.o,$(basename $(SHADOW_LIBMISC_SRCS)))

# The actual command sources
SHADOW_SRCS = $(wildcard $(SHADOW_SUBDIR)/src/*.c)
SHADOW_BINS = $(patsubst $(SHADOW_SUBDIR)/src/%,$(BINDIR)/%,$(basename $(SHADOW_SRCS)))

shadow: $(SHADOW_LIBMISC) $(SHADOW_LIB) $(SHADOW_BINS)

$(SHADOW_LIB): $(SHADOW_LIB_OBJS)

$(SHADOW_LIBMISC): $(SHADOW_LIBMISC_OBJS)

$(BINDIR)/%: $(SHADOW_SUBDIR)/src/%.c $(SHADOW_LIBMISC) $(SHADOW_LIB)
	$(CC) -I$(SHADOW_SUBDIR) -I$(SHADOW_SUBDIR)/libmisc -I$(SHADOW_SUBDIR)/lib -DHAVE_CONFIG_H -O2 -o $@ $^

$(SHADOW_LIBMISC): $(SHADOW_LIBMISC_OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(SHADOW_OBJDIR)/%.o: $(SHADOW_SUBDIR)/%.c $(CC)
	$(CC) -I$(SHADOW_SUBDIR) -I$(SHADOW_SUBDIR)/libmisc -I$(SHADOW_SUBDIR)/lib -DHAVE_CONFIG_H -O2 -c -o $@ $<
