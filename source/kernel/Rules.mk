PHONY  += kernel
KERNEL_SUBDIR = source/kernel

kernel:
	make -C $(KERNEL_SUBDIR) -j4
	cp -v $(KERNEL_SUBDIR)/arch/x86/boot/bzImage $(BUILDDIR)/boot/vmlinuz
	cp -v $(KERNEL_SUBDIR)/System.map $(BUILDDIR)/boot/System.map
	cp -v $(KERNEL_SUBDIR)/.config $(BUILDDIR)/boot/config

kernel-config:
	make -C $(KERNEL_SUBDIR) menuconfig

kernel-clean:
	make -C $(KERNEL_SUBDIR) clean

