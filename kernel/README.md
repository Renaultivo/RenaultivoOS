# DevOS - Kernel documentation

### Content
- What the code do
- ASM functions used and what they do
- References and recommendations

## start

```ASM
start:
  mov [bootDrive], dl
```

<details>
  <summary>What does it do?</summary>
  <br>
    When the BIOS start, it saves the <strong>boot drive ID</strong> in <strong>DL register</strong>.
  <br>
    It's a important info for us, so we copy it to the memory.
</details>

<br>

```ASM
start:
  [...]
  call jumpLine
  mov bp, kernelLoadedMessage
  mov cx, kernelLoaderMessageLen
  call printMessage
```

<details>
  <summary>What does it do?</summary>
  <br>
  Jump the first line to do not overwrite the bootloader message.
  <br>
  Print a message to let the user know that the kernel was successfully loaded.
</details>

## checkCPU

```ASM
checkCPU:
  mov eax, 0x80000000
  cpuid
  cmp eax, 0x80000001
  jb notSupported
```

<details>
  <summary>What does it do?</summary>
  <br>
  Call <strong>CPUID</strong> function and verify if it returned the value "0x80000001".
  <br>
  If this function do not return "0x80000001" it means that this function is not supported.
</details>

<br>

```ASM
checkCPU:
  [...]
  mov eax, 0x80000001
  cpuid
  test eax, (1<<29)
  jz notSupported
```

<details>
  <summary>What does it do?</summary>
  <br>
  Get the value returned from CPUID and verify if the bit of eax (eax<<29) is set.
  <br>
  The 29th bit of eax (eax<<29) indicates if the <strong>Long Mode (64 bits)</strong> is available.
</details>

<br>

```ASM
checkCPU:
  [...]
  test eax, (1<<26)
  jz notSupported
```

<details>
  <summary>What does it do?</summary>
  <br>
  Get the value returned from CPUID and verify if the bit of eax (eax<<26) is set.
  <br>
  The 26th bit of eax (eax<<26) indicates if the processor supports 1 Gibibyte pages.
</details>

## main

```ASM
main:
  hlt
  jmp $
```

<details>
  <summary>What does it do?</summary>
  <br>
  Infinite loop
</details>

## notSupported

```ASM
notSupported:
  mov bp, notSupportedMessage
  mov cx, notSupportedMessageLen
  call printMessage
  jmp main
```

<details>
  <summary>What does it do?</summary>
  <br>
  Print not supported message and jump to main
</details>
