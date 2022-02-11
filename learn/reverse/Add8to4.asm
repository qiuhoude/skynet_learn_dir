section  .text
   global _start
_start:
   mov eax, dword [v1]
   mov edx, dword [v1 + 4]
   ; Add first part
   add eax, dword [v2]
   ; Add second part and carry bit  
   adc edx, dword [v2 + 4]
   mov dword [vSum], eax
   mov dword [vSum + 4], edx
  
   ; Terminate program in Linux
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   ; Labels are 8 bytes while registers only 4
   v1 dq 0x1ABC000000000000
   v2 dq 0x2DEF000000000000
   vSum dq 0