PHONY  += albase
ECLEAN += $(addprefix $(BINDIR)/, $(SRC_BINS))

SRC_SUBDIR  = source
SRC_BINS    = init getty login dmesg mount

albase: $(SRC_BINS)

init:  $(BINDIR)/init
getty: $(BINDIR)/getty
login: $(BINDIR)/login
dmesg: $(BINDIR)/dmesg
mount: $(BINDIR)/mount

$(BINDIR)/%: $(SRC_SUBDIR)/%.c
	$(BUILD) -lcrypt
