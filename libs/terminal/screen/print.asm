print:
  pusha
print_loop:
  mov al, [bx]
  cmp al, 0
  je print_finished
  int 0x10
  inc bl
  jmp print_loop
print_finished:
  popa
  ret
