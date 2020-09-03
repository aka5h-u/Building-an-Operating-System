[org 0x7c00]
KERNEL_OFFSET equ 0x1000 

    mov [BOOT_DRIVE], dl 
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE 
    call print

    call load_kernel 
    call switch_to_pm 
    jmp $ 

%include "boot_print.asm"
%include "32bit_print.asm"
%include "32bit_gdt.asm"
%include "32bit_switch.asm"
%include "disk_read.asm"


[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print

    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 15  ; read 15 sectors
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; Give control to the kernel
    jmp $ 


BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0


times 510 - ($-$$) db 0
dw 0xaa55