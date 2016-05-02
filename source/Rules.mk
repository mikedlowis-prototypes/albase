SRC_SUBDIR  = source
SRC_BINS    = init getty login dmesg mount
BINS       += $(SRC_BINS)
ECLEAN     += $(addprefix $(BINDIR)/, $(SRC_BINS))

init: $(BINDIR)/init
$(BINDIR)/init: $(SRC_SUBDIR)/init.c
	$(BUILD)

getty: $(BINDIR)/getty
$(BINDIR)/getty: $(SRC_SUBDIR)/getty.c
	$(BUILD)

login: $(BINDIR)/login
$(BINDIR)/login: $(SRC_SUBDIR)/login.c
	$(BUILD) -lcrypt

dmesg: $(BINDIR)/dmesg
$(BINDIR)/dmesg: $(SRC_SUBDIR)/dmesg.c
	$(BUILD)

mount: $(BINDIR)/mount
$(BINDIR)/mount: $(SRC_SUBDIR)/mount.c
	$(BUILD)

