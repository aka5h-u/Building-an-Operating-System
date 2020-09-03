C_SRC = $(wildcard kernel/*.c drivers/*.c)
C_HDRS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SRC:.c=.o}

os-image.bin: boot/boot_sect.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

run: os-image.bin	
	qemu-system-i386 -fda $^

%.o: %.c ${C_HDRS}
	gcc -ffreestanding -c $< -o $@

%.bin: %.asm
	nasm -f bin $< -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin boot/*.o drivers/*.o