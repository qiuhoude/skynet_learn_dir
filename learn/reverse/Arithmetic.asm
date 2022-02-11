section  .text
   global _start
_start:
   ; Standard methodology 常规用法
   mov ecx, 1313h
   mov ebx, 2121h
   mov eax, 2  
   mul ebx
   add ecx, eax     ; ecx = 0x5555

   ; Arithmetic with LEA 
   mov ecx, 1313h
   mov ebx, 2121h  
   lea ecx, [ebx * 2 + ecx]     ; ecx = 0x5555

   ; Terminate program in Linux 程序退出
   mov rax, 60
   mov rdi, 0
   syscall