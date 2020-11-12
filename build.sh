nasm -f bin bootloader/boot.asm -o ./bootloader/boot.bin
nasm -f bin kernel/kernel.asm -o ./kernel/kernel.bin
dd if=bootloader/boot.bin of=boot.img bs=512 count=1 conv=notrunc
dd if=kernel/kernel.bin of=boot.img bs=512 count=5 seek=1 conv=notrunc
