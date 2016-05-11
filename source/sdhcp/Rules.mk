PHONY  += sdhcp
ECLEAN += $(BINDIR)/sdhcp $(SDHCP_OBJS)
DIRS   += $(SDHCP_OBJDIR)/util

SDHCP_SUBDIR = source/sdhcp
SDHCP_OBJDIR = $(OBJDIR)/sdhcp
SDHCP_SRCS   = $(wildcard $(SDHCP_SUBDIR)/*.c $(SDHCP_SUBDIR)/util/*.c)
SDHCP_OBJS   = $(patsubst $(SDHCP_SUBDIR)/%,$(SDHCP_OBJDIR)/%.o,$(basename $(SDHCP_SRCS)))

SDHCP_INCS   = -I$(BUILDDIR)/include
SDHCP_DEFS   =

sdhcp: headers $(BINDIR)/sdhcp

$(BINDIR)/sdhcp: $(SDHCP_OBJS)
	$(CC) -o $@ $^

$(SDHCP_OBJDIR)/%.o: $(SDHCP_SUBDIR)/%.c $(CC)
	$(CC) $(SDHCP_INCS) $(SDHCP_DEFS) -c -o $@ $<

