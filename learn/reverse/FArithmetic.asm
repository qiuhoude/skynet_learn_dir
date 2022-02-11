section  .text
   global _start
; In DDD console: info all-registers
; In DDD console: register MXCSR
_start:
   movss xmm0, dword [sPVar1]
   movss dword [sPVar2], xmm0
   movss xmm1, dword [sPVar2]
   movsd xmm2, qword [dPVar1]
   movsd qword [dPVar2], xmm2
   movsd xmm3, qword [dPVar2]  
   mov eax, dword [sPVarInt]
   cvtsi2ss xmm0, eax         ; Int -> F-P
   ; Two memory locations, two operations! 
   movss xmm0, dword [sPVar3]
   addss xmm0, dword [sPVar4]
   movss dword [sPTot], xmm0
   ; This will not work!!!
   ; addss dword [sPVar3], dword [sPVar4]  
   ; MXCSR register will change now!
   movss xmm0, dword [sPVar1]
   divss xmm0, dword [sPDiv]
   ; Terminate program in Linux
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   sPVar1 dd 1.41
   sPVar2 dd 0.0
   dPVar1 dq 2.82
   dPVar2 dq 0.0
   sPVarInt dd 10
   sPVar3 dd 55.21
   sPVar4 dd 11.15
   sPTot dd 0.0
   sPDiv dd 0.0