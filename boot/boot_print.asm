[bits 16]

print:
    pusha
    mov ah, 0x0e ;tty mode to output stuff on screen ,BIOS routine
    loop:
        mov al, [bx]
        int 0x10      ;interrupt after each character
        inc bx
        cmp al ,0
        jne loop

mov al ,0x0a  ;new line
int 0x10 
mov al ,0x0d  ;carriage return
int 0x10

