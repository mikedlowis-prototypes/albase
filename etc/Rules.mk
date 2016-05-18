PHONY  += etc
DIRS   += $(BUILDDIR)/etc
ECLEAN += $(BUILDDIR)/etc/*

ETC_SUBDIR = etc
ETC_FILES  = $(filter-out $(ETC_SUBDIR)/Rules.mk,$(wildcard $(ETC_SUBDIR)/*))

etc:
	cp $(ETC_FILES) $(BUILDDIR)/etc
