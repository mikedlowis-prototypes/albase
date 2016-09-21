#!/bin/sh
export ROOT=$PWD/build/
export ISO_FS=$PWD/iso9660/
export ISO_IMAGE=$PWD/albase.iso

# Copy the kernel to the ISO folder
cp $ROOT/boot/vmlinuz $ISO_FS/isolinux/vmlinuz
# Copy the base files into an initrd.img
find $ROOT | grep -v '^build/obj' | cpio --owner root:root --quiet -o -H newc | gzip -9 > $ISO_FS/isolinux/initrd.img
# Delete the old image if it exists
rm -f $ISO_IMAGE
# Build the new image
mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -l -input-charset default -V albase -A "albase" -o $ISO_IMAGE $ISO_FS
