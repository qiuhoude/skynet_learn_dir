section  .text
   global _start
_start:
   mov rcx, 10
   mov rax, 0
addLoop:
   add qword [tot], rax
   add rax, 1
   dec rcx
   cmp rcx, 0
   jne addLoop    ; jump if RCX is not 0
   ; Add with loop
   mov eax, 0    ; EAX is tot
   mov ecx, 10    ; ECX is counter
myloop:
   add eax, ecx    ; EAX = EAX + ECX
   loop myloop    ; if ECX > 0 goto myloop
   ; Terminate Linux program
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   tot dq 0