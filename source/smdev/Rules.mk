PHONY  += smdev
ECLEAN += $(BINDIR)/smdev $(SMDEV_OBJS)
DIRS   += $(SMDEV_OBJDIR)/util

SMDEV_SUBDIR = source/smdev
SMDEV_OBJDIR = $(OBJDIR)/smdev
SMDEV_SRCS   = $(wildcard $(SMDEV_SUBDIR)/*.c $(SMDEV_SUBDIR)/util/*.c)
SMDEV_OBJS   = $(patsubst $(SMDEV_SUBDIR)/%,$(SMDEV_OBJDIR)/%.o,$(basename $(SMDEV_SRCS)))

SMDEV_INCS   = -I$(BUILDDIR)/include
SMDEV_DEFS   =

smdev: $(BINDIR)/smdev

$(BINDIR)/smdev: $(SMDEV_OBJS)
	$(CC) -o $@ $^

$(SMDEV_OBJDIR)/%.o: $(SMDEV_SUBDIR)/%.c
	$(CC) $(SMDEV_INCS) $(SMDEV_DEFS) -c -o $@ $<

