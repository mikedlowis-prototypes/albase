#!/bin/sh
export ROOT=$PWD/build/
export ISO_FS=$PWD/iso9660/
export ISO_IMAGE=$PWD/albase.iso
export INITRD=$ISO_FS/isolinux/initrd.img

# Move the init daemon to root so kernel can find it
mv "$ROOT/bin/init" "$ROOT"

echo "Generating $INITRD..."
(
    cd $ROOT && find . -print0 |  
    cpio --null -ov --format=newc | 
    gzip -9 > $INITRD
)

# Copy the kernel to the ISO folder
cp -v $ROOT/boot/vmlinuz $ISO_FS/isolinux/vmlinuz
# Build the new image
mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -l -input-charset default -V albase -A "albase" -o $ISO_IMAGE $ISO_FS

