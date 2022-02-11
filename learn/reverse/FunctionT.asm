section   .text
   global _start
_start:
   ; Parameters section starts - 8th
   ; These parameters are passed using the stack
   push avg
   push sum
   ; These parameters are passed using registers
   mov r9, last
   mov r8, md2
   mov rcx, md1
   mov rdx, first
   mov esi, dword [numElems]
   mov rdi, numbers
   ; Parameters section ends - 1st
   call numExtractor
   ; Clear 2 results onto stack 8 bytes each
   add rsp, 16
   
   ; Terminate Linux program
   mov rax, 60
   mov rdi, 0
   syscall

   global numExtractor
numExtractor:
   mov rax, 0              ; Total
   mov r10, 0              ; Flag
   ; RBP is top of the stack
   push rbp
   ; RBP points at itself
   mov rbp, rsp
   ; In DDD console: print *(int *) ($rsp)
   push r10
sumLoop:
   ; sum = sum + num[i]
   add eax, dword [rdi + r10 * 4]
   inc r10
   cmp r10, rsi
   jl sumLoop
   ; Call by reference requires two steps!!!
   ; 1. Retrieve address of sum
   mov r10, qword [rbp + 16] 
   ; 2. Return address of sum
   mov dword [r10], eax                     
                                                                                            
   ; Get numElems
   mov r10, rsi                                       
   ; Set numElems - 1
   dec r10
   ; Get last            
   mov eax, dword [rdi + r10 * 4]
   ; In DDD console: print *(int *) ($r9)
   mov dword [r9], eax
   
   ; Get first
   mov eax, dword [rdi]
   ; In DDD console: print *(int *) ($rdx)
   mov dword [rdx], eax
   ; Add code to get average and median(s)
   pop r10
   ; Pop stack into RBP to prepare next instruction
   pop rbp
   ret
section .data
   avg dd 0
   sum dd 0
   md1 dd 0
   md2 dd 0
   last dd 0
   first dd 0
   numElems dd 5
   numbers dd 2, 4, 6, 8, 10