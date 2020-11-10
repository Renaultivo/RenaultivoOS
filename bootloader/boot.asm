[bits 16]
[org 0x7c00]

loadKernel:
  mov ah, 0x02   ; Read disk sectors function
  mov dl, 0x80   ; read boot drive (current drive)
  mov al, 1      ; Number of sectors to read
  mov ch, 0      ; Cylinder 
  mov cl, 2      ; Sector 2, the bootloader is in sector 1 (first sector)
  mov dh, 0      ; Head
  mov bx, 0x0800 ; ----| Define buffer address ES:BX
  mov es, bx     ; ----|
  mov bx, 0x0000 ; ----|
  int 0x13       ; run function
  
jmp 0x0800:0x0000 ; jump to kernel

times 510-($-$$) db 0
dw 0xAA55
