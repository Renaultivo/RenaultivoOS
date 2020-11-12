printMessage:
  pusha
  mov ah, 0x13
  mov al, 1
  mov bx, 0xA
  xor dl, dl
  mov dh, [row]
  int 0x10
  call jumpLine
  popa
  ret

jumpLine:
  mov dh, [row]
  inc dh
  mov [row], dh
  ret

row db 0
