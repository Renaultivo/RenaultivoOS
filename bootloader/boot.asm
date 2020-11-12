[BITS 16]
[ORG 0x7C00]

main:
  mov [bootDrive], dl
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7C00
  
checkDisk:
  mov ah, 0x41
  mov bx, 0x55AA
  int 0x13
  jc diskError
  cmp bx, 0xAA55
  jne diskError 
 
  mov bp, loadingKernelMessage
  mov cx, loadingKernelMessageLen
  call printMessage

loadKernel:
  mov si, readPacket
  mov word[si], 0x10
  mov word[si+2], 5
  mov word[si+4], 0x7E00
  mov word[si+6], 0
  mov dword[si+8], 1
  mov dword[si+0xC], 0
  mov dl, [bootDrive]
  mov ah, 0x42
  int 0x13
  jc loadError
  mov dl, [bootDrive]
  jmp 0x7E00

main_loop:
  hlt
  jmp $

diskError:
  mov bp, diskErrorMessage
  mov cx, diskErrorMessageLen
  call printMessage
  jmp main_loop

loadError:
  mov bp, loadErrorMessage
  mov cx, loadErrorMessageLen
  call printMessage
  jmp main_loop

%include "libs/bios/printMessage.asm"
  
bootDrive db 0
diskErrorMessage db 'Failed to verify disk'
diskErrorMessageLen equ $-diskErrorMessage
loadingKernelMessage db 'Loading kernel...'
loadingKernelMessageLen equ $-loadingKernelMessage
loadErrorMessage db 'A error occurred while loading kernel'
loadErrorMessageLen equ $-loadErrorMessage
readPacket times 16 db 0

times 510-($-$$) db 0
dw 0xAA55
