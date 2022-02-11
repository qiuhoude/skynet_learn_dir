section  .text
   global _start
_start:
   ; Read input
   mov rax, GETUSERINPUT
   mov rdi, STDIN
   mov rsi, buffer
   mov rdx, bufferSize
   syscall
   ; Write user input back
   mov rdx, rax
   mov rax, WRITEUSERINPUT
   mov rdi, STDOUT
   mov rsi, buffer
   syscall
   ; Terminate program  
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   GETUSERINPUT equ 0
   WRITEUSERINPUT equ 1
   STDIN equ 0
   STDOUT equ 1
section .bss
   bufferSize equ 32
   buffer resb bufferSize