[BITS 16]
[ORG 0X7E00]

call jumpLine
mov bp, msg
mov cx, msgLen
call printMessage

main:
  hlt
  jmp $

%include "libs/bios/printMessage.asm"

msg db 'Kernel loaded'
msgLen equ $-msg
