PHONY  += libc
ECLEAN += $(MUSL_OBJS) $(MUSL_LIBS) $(MUSL_CRT_OBJS)
DIRS   += $(MUSL_OBJDIRS) \
          $(MUSL_OBJDIR)/include/bits/ \
          $(BUILDDIR)/include/

WRAPCC_GCC     = $(REALCC)
MUSL_SUBDIR    = source/musl
MUSL_OBJDIR    = $(OBJDIR)/musl
MUSL_SRCDIRS   = $(addprefix $(MUSL_SUBDIR)/,src/* src/$(ARCH)/* src/*/$(ARCH)/* crt ldso)
MUSL_BASE_SRCS = $(sort $(wildcard $(addsuffix /*.c,$(MUSL_SRCDIRS))))
MUSL_ARCH_SRCS = $(sort $(wildcard $(addsuffix /$(ARCH)/*.[csS],$(MUSL_SRCDIRS))))
MUSL_SRCS      = $(MUSL_BASE_SRCS) $(MUSL_ARCH_SRCS)
MUSL_OBJS      = $(patsubst $(MUSL_SUBDIR)/%,$(MUSL_OBJDIR)/%.o,$(basename $(MUSL_SRCS)))
MUSL_OBJDIRS   = $(patsubst $(MUSL_SUBDIR)/%,$(MUSL_OBJDIR)/%,$(wildcard $(MUSL_SRCDIRS)))

MUSL_INCS =                       \
    -I$(MUSL_SUBDIR)/arch/$(ARCH) \
    -I$(MUSL_SUBDIR)/arch/generic \
    -I$(MUSL_SUBDIR)/src/internal \
    -I$(MUSL_SUBDIR)/include      \
    -I$(MUSL_OBJDIR)

MUSL_LIBS = \
    $(LIBDIR)/libc.a \
    $(LIBDIR)/libcrypt.a \
    $(LIBDIR)/libdl.a \
    $(LIBDIR)/libm.a \
    $(LIBDIR)/libpthread.a \
    $(LIBDIR)/libresolv.a \
    $(LIBDIR)/librt.a \
    $(LIBDIR)/libutil.a \
    $(LIBDIR)/libxnet.a

MUSL_CRT_OBJS =       \
    $(LIBDIR)/Scrt1.o \
    $(LIBDIR)/crt1.o  \
    $(LIBDIR)/rcrt1.o \
    $(LIBDIR)/crti.o  \
    $(LIBDIR)/crtn.o

MUSL_EXTRAS =          \
    $(BINDIR)/musl-gcc \
    $(LIBDIR)/musl-gcc.specs

MUSL_FONE   = -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack
MUSL_FTWO   = -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections
MUSL_CFLAGS = -std=c99 -nostdinc $(MUSL_FONE) -D_XOPEN_SOURCE=700 -Os -pipe $(MUSL_FTWO) -include vis.h
MUSL_CC_CMD = $(REALCC) $(MUSL_CFLAGS) $(MUSL_INCS) $(MUSL_CPPFLAGS) -c -o $@ $<

libc: $(MUSL_LIBS) $(MUSL_CRT_OBJS) $(MUSL_EXTRAS) libc-headers

libc-headers:
	cp -R $(MUSL_SUBDIR)/include/ $(BUILDDIR)/
	cp -R $(MUSL_SUBDIR)/arch/$(ARCH)/bits/ $(BUILDDIR)/include/
	cp -R $(MUSL_SUBDIR)/arch/generic/bits/ $(BUILDDIR)/include/

$(LIBDIR)/libc.a: $(filter $(MUSL_OBJDIR)/src/%,$(MUSL_OBJS))

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.s
	$(MUSL_CC_CMD)

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.S
	$(MUSL_CC_CMD)

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.c
	$(MUSL_CC_CMD)

$(LIBDIR)/%.a:
	@echo $(AR) $(ARFLAGS) $@
	@$(ARCHIVE)

# CRT Objects
$(LIBDIR)/Scrt1.o: $(MUSL_SUBDIR)/crt/Scrt1.c
	$(MUSL_CC_CMD) -fPIC -fno-stack-protector -DCRT
$(LIBDIR)/crt1.o: $(MUSL_SUBDIR)/crt/crt1.c
	$(MUSL_CC_CMD) -fno-stack-protector -DCRT
$(LIBDIR)/rcrt1.o: $(MUSL_SUBDIR)/crt/rcrt1.c
	$(MUSL_CC_CMD) -fPIC -fno-stack-protector -DCRT
$(LIBDIR)/crti.o: $(MUSL_SUBDIR)/crt/x86_64/crti.s
	$(MUSL_CC_CMD) -DCRT
$(LIBDIR)/crtn.o: $(MUSL_SUBDIR)/crt/x86_64/crtn.s
	$(MUSL_CC_CMD) -DCRT

$(BINDIR)/musl-gcc: $(LIBDIR)/libc.a $(LIBDIR)/musl-gcc.specs
	printf '#!/bin/sh\nexec "$${REALGCC:-$(WRAPCC_GCC)}" "$$@" -specs "%s/musl-gcc.specs"\n' "$(LIBDIR)" > $@
	chmod +x $@

$(LIBDIR)/musl-gcc.specs: $(MUSL_SUBDIR)/tools/musl-gcc.specs.sh
	sh $< "$(BUILDDIR)/include" "$(LIBDIR)" "$(LDSO_PATHNAME)" > $@
