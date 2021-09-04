[BITS 16]
[ORG 0x7C00]

main:
  mov ds, ax
  mov es, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7C00 
  mov ah, 0x41
  mov bx, 0xAA55
