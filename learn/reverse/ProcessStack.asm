section  .text
   global _start
_start:
   ; On DDD prompt: x/6d $rbx
   mov rbx, vals
   mov r15, 0        ; A flag
   mov rcx, 3        ; How many items in the stack?
doPush:
   ; On DDD prompt: x/d $rsp
   push  qword [rbx + r15 * 8]
   inc r15
   loop doPush
   mov rbx, vals
   mov r15, 0  
   mov rcx, 3
doPop:
   ; On DDD prompt: p $rax
   pop rax
   ; On DDD prompt: x/6d $rbx
   mov qword [rbx + r15 * 8], rax
   inc r15
   loop doPop
   ; Terminate Linux program
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   vals dq 1000, 1001, 1002