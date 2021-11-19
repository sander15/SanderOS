org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

; prints a string to the screen

puts:
    ; save register of the mod
    push si
    push ax

.loop:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0e    ;call bios interrupt
    mov bh,0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret


main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax
    ; setup stack
    mov ss, ax
    mov sp, 0x7C00
    ; prints the message
    mov si, msg_hello
    call puts

    hit

.halt:
    jmp .halt


msg_hello: db 'Hello Sander', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
