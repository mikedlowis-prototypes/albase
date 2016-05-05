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
MUSL_BASE_OBJS = $(patsubst $(MUSL_SUBDIR)/%,$(MUSL_OBJDIR)/%.o,$(basename $(MUSL_BASE_SRCS)))
MUSL_ARCH_OBJS = $(patsubst $(MUSL_SUBDIR)/%,$(MUSL_OBJDIR)/%.o,$(basename $(MUSL_ARCH_SRCS)))
MUSL_DEL_OBJS  = $(sort $(subst /$(ARCH)/,/,$(MUSL_ARCH_OBJS)))
MUSL_OBJS      = $(filter-out $(MUSL_DEL_OBJS), $(sort $(MUSL_BASE_OBJS) $(MUSL_ARCH_OBJS)))
MUSL_OBJDIRS   = $(patsubst $(MUSL_SUBDIR)/%,$(MUSL_OBJDIR)/%,$(wildcard $(MUSL_SRCDIRS)))

# Optimize some of the sources
MUSL_OPGLOBS = internal/*.c malloc/*.c string/*.c
MUSL_OPSRCS  = $(wildcard $(MUSL_OPGLOBS:%=$(MUSL_SUBDIR)/src/%))
$(MUSL_OPSRCS:$(MUSL_SUBDIR)/%.c=$(MUSL_OBJDIR)/%.o): MUSL_FLAGS += -O3

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

DEFS =
MUSL_FONE   = -std=c99 -nostdinc -ffreestanding -fexcess-precision=standard -frounding-math -Wa,--noexecstack -D_XOPEN_SOURCE=700
MUSL_FTWO   = -Os -pipe -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -Werror=implicit-function-declaration -Werror=implicit-int -Werror=pointer-sign -Werror=pointer-arith -include vis.h
MUSL_FLAGS  = $(MUSL_FONE) $(MUSL_INCS) $(MUSL_FTWO)
MUSL_CC_CMD = $(REALCC) $(MUSL_FLAGS)

libc: $(MUSL_LIBS) $(MUSL_CRT_OBJS) $(MUSL_EXTRAS) libc-headers

libc-headers:
	cp -R $(MUSL_SUBDIR)/include/ $(BUILDDIR)/
	cp -R $(MUSL_SUBDIR)/arch/$(ARCH)/bits/ $(BUILDDIR)/include/
	cp -R $(MUSL_SUBDIR)/arch/generic/bits/ $(BUILDDIR)/include/

$(LIBDIR)/libc.a: $(filter $(MUSL_OBJDIR)/src/%,$(MUSL_OBJS))

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.s
	$(MUSL_CC_CMD) -c -o $@ $<

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.S
	$(MUSL_CC_CMD) -c -o $@ $<

$(MUSL_OBJDIR)/%.o: $(MUSL_SUBDIR)/%.c
	$(MUSL_CC_CMD) -c -o $@ $<

$(LIBDIR)/%.a:
	@echo $(AR) $(ARFLAGS) $@
	@$(ARCHIVE)

# CRT Objects
$(LIBDIR)/Scrt1.o: $(MUSL_SUBDIR)/crt/Scrt1.c
	$(MUSL_CC_CMD) -fPIC -fno-stack-protector -DCRT -c -o $@ $<

$(LIBDIR)/crt1.o: $(MUSL_SUBDIR)/crt/crt1.c
	$(MUSL_CC_CMD) -fno-stack-protector -DCRT -c -o $@ $<

$(LIBDIR)/rcrt1.o: $(MUSL_SUBDIR)/crt/rcrt1.c
	$(MUSL_CC_CMD) -fPIC -fno-stack-protector -DCRT -c -o $@ $<

$(LIBDIR)/crti.o: $(MUSL_SUBDIR)/crt/x86_64/crti.s
	$(MUSL_CC_CMD) -DCRT -c -o $@ $<

$(LIBDIR)/crtn.o: $(MUSL_SUBDIR)/crt/x86_64/crtn.s
	$(MUSL_CC_CMD) -DCRT -c -o $@ $<

$(BINDIR)/musl-gcc: $(LIBDIR)/libc.a $(LIBDIR)/musl-gcc.specs
	printf '#!/bin/sh\nexec "$${REALGCC:-$(WRAPCC_GCC)}" "$$@" -specs "%s/musl-gcc.specs"\n' "$(LIBDIR)" > $@
	chmod +x $@

$(LIBDIR)/musl-gcc.specs: $(MUSL_SUBDIR)/tools/musl-gcc.specs.sh
	sh $< "$(BUILDDIR)/include" "$(LIBDIR)" "$(LDSO_PATHNAME)" > $@

# Objects with stack protector disabled
$(MUSL_OBJDIR)/src/env/__init_tls.o: $(MUSL_SUBDIR)/src/env/__init_tls.c
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<
$(MUSL_OBJDIR)/src/env/__libc_start_main.o: $(MUSL_SUBDIR)/src/env/__libc_start_main.c
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<
$(MUSL_OBJDIR)/src/env/__stack_chk_fail.o: $(MUSL_SUBDIR)/src/env/__stack_chk_fail.c
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<
$(MUSL_OBJDIR)/src/string/x86_64/memcpy.o: $(MUSL_SUBDIR)/src/string/x86_64/memcpy.s
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<
$(MUSL_OBJDIR)/src/string/x86_64/memset.o: $(MUSL_SUBDIR)/src/string/x86_64/memset.s
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<
$(MUSL_OBJDIR)/src/thread/x86_64/__set_thread_area.o: $(MUSL_SUBDIR)/src/thread/x86_64/__set_thread_area.s
	$(MUSL_CC_CMD) -fno-stack-protector -c -o $@ $<

$(MUSL_OBJDIR)/src/string/memcmp.o: $(MUSL_SUBDIR)/src/string/memcmp.c
	$(MUSL_CC_CMD) -fno-tree-loop-distribute-patterns -c -o $@ $<
