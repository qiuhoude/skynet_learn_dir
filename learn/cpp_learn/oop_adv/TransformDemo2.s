	.file	"TransformDemo2.cc"
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.text._ZNKSt9type_info4nameEv,"axG",@progbits,_ZNKSt9type_info4nameEv,comdat
	.align 2
	.weak	_ZNKSt9type_info4nameEv
	.type	_ZNKSt9type_info4nameEv, @function
_ZNKSt9type_info4nameEv:
.LFB976:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$42, %al
	jne	.L2
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$1, %rax
	jmp	.L3
.L2:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
.L3:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE976:
	.size	_ZNKSt9type_info4nameEv, .-_ZNKSt9type_info4nameEv
	.section	.rodata
.LC0:
	.string	"Class A"
	.section	.text._ZNK1A4funcEv,"axG",@progbits,_ZNK1A4funcEv,comdat
	.align 2
	.weak	_ZNK1A4funcEv
	.type	_ZNK1A4funcEv, @function
_ZNK1A4funcEv:
.LFB989:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$.LC0, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE989:
	.size	_ZNK1A4funcEv, .-_ZNK1A4funcEv
	.section	.rodata
.LC1:
	.string	"Class B"
	.section	.text._ZNK1B4funcEv,"axG",@progbits,_ZNK1B4funcEv,comdat
	.align 2
	.weak	_ZNK1B4funcEv
	.type	_ZNK1B4funcEv, @function
_ZNK1B4funcEv:
.LFB990:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$.LC1, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE990:
	.size	_ZNK1B4funcEv, .-_ZNK1B4funcEv
	.section	.rodata
.LC2:
	.string	"Class C"
	.section	.text._ZNK1C4funcEv,"axG",@progbits,_ZNK1C4funcEv,comdat
	.align 2
	.weak	_ZNK1C4funcEv
	.type	_ZNK1C4funcEv, @function
_ZNK1C4funcEv:
.LFB991:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$.LC2, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE991:
	.size	_ZNK1C4funcEv, .-_ZNK1C4funcEv
	.section	.rodata
.LC3:
	.string	"Class D"
	.section	.text._ZNK1D4funcEv,"axG",@progbits,_ZNK1D4funcEv,comdat
	.align 2
	.weak	_ZNK1D4funcEv
	.type	_ZNK1D4funcEv, @function
_ZNK1D4funcEv:
.LFB992:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$.LC3, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE992:
	.size	_ZNK1D4funcEv, .-_ZNK1D4funcEv
	.section	.text._ZN1AC2Ev,"axG",@progbits,_ZN1AC5Ev,comdat
	.align 2
	.weak	_ZN1AC2Ev
	.type	_ZN1AC2Ev, @function
_ZN1AC2Ev:
.LFB995:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$_ZTV1A+16, (%rax)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE995:
	.size	_ZN1AC2Ev, .-_ZN1AC2Ev
	.weak	_ZN1AC1Ev
	.set	_ZN1AC1Ev,_ZN1AC2Ev
	.section	.text._ZN1BC2Ev,"axG",@progbits,_ZN1BC5Ev,comdat
	.align 2
	.weak	_ZN1BC2Ev
	.type	_ZN1BC2Ev, @function
_ZN1BC2Ev:
.LFB1000:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN1AC2Ev
	movq	-8(%rbp), %rax
	movq	$_ZTV1B+16, (%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1000:
	.size	_ZN1BC2Ev, .-_ZN1BC2Ev
	.weak	_ZN1BC1Ev
	.set	_ZN1BC1Ev,_ZN1BC2Ev
	.section	.text._ZN1CC2Ev,"axG",@progbits,_ZN1CC5Ev,comdat
	.align 2
	.weak	_ZN1CC2Ev
	.type	_ZN1CC2Ev, @function
_ZN1CC2Ev:
.LFB1002:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN1BC2Ev
	movq	-8(%rbp), %rax
	movq	$_ZTV1C+16, (%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1002:
	.size	_ZN1CC2Ev, .-_ZN1CC2Ev
	.weak	_ZN1CC1Ev
	.set	_ZN1CC1Ev,_ZN1CC2Ev
	.section	.text._ZN1DC2Ev,"axG",@progbits,_ZN1DC5Ev,comdat
	.align 2
	.weak	_ZN1DC2Ev
	.type	_ZN1DC2Ev, @function
_ZN1DC2Ev:
.LFB1004:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN1CC2Ev
	movq	-8(%rbp), %rax
	movq	$_ZTV1D+16, (%rax)
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1004:
	.size	_ZN1DC2Ev, .-_ZN1DC2Ev
	.weak	_ZN1DC1Ev
	.set	_ZN1DC1Ev,_ZN1DC2Ev
	.section	.rodata
.LC4:
	.string	"Downcasting failed: A* to B*"
	.align 8
.LC5:
	.string	"Downcasting successfully: A* to B*"
.LC6:
	.string	"Downcasting failed: A* to C*"
	.align 8
.LC7:
	.string	"Downcasting successfully: A* to C*"
.LC8:
	.string	"-------------------------"
	.text
	.globl	main
	.type	main, @function
main:
.LFB993:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movl	$16, %edi
	call	_Znwm
	movq	%rax, %rbx
	movq	$0, (%rbx)
	movl	$0, 8(%rbx)
	movq	%rbx, %rdi
	call	_ZN1AC1Ev
	movq	%rbx, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L14
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rax), %rax
	movq	%rax, %rdi
	call	_ZNKSt9type_info4nameEv
	movq	%rax, %rsi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-24(%rbp), %rax
	testq	%rax, %rax
	jne	.L16
	jmp	.L33
.L14:
	call	__cxa_bad_typeid
.L33:
	movl	$0, %eax
	jmp	.L17
.L16:
	movl	$0, %ecx
	movl	$_ZTI1B, %edx
	movl	$_ZTI1A, %esi
	movq	%rax, %rdi
	call	__dynamic_cast
.L17:
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L18
	movl	$.LC4, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	jmp	.L19
.L18:
	movl	$.LC5, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
.L19:
	movq	-24(%rbp), %rax
	testq	%rax, %rax
	jne	.L20
	movl	$0, %eax
	jmp	.L21
.L20:
	movl	$0, %ecx
	movl	$_ZTI1C, %edx
	movl	$_ZTI1A, %esi
	movq	%rax, %rdi
	call	__dynamic_cast
.L21:
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L22
	movl	$.LC6, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	jmp	.L23
.L22:
	movl	$.LC7, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
.L23:
	movl	$.LC8, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movl	$24, %edi
	call	_Znwm
	movq	%rax, %rbx
	movq	$0, (%rbx)
	movl	$0, 8(%rbx)
	movl	$0, 12(%rbx)
	movl	$0, 16(%rbx)
	movl	$0, 20(%rbx)
	movq	%rbx, %rdi
	call	_ZN1DC1Ev
	movq	%rbx, -24(%rbp)
	movq	-24(%rbp), %rax
	testq	%rax, %rax
	jne	.L24
	movl	$0, %eax
	jmp	.L25
.L24:
	movl	$0, %ecx
	movl	$_ZTI1B, %edx
	movl	$_ZTI1A, %esi
	movq	%rax, %rdi
	call	__dynamic_cast
.L25:
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L26
	movl	$.LC4, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	jmp	.L27
.L26:
	movl	$.LC5, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
.L27:
	movq	-24(%rbp), %rax
	testq	%rax, %rax
	jne	.L28
	movl	$0, %eax
	jmp	.L29
.L28:
	movl	$0, %ecx
	movl	$_ZTI1C, %edx
	movl	$_ZTI1A, %esi
	movq	%rax, %rdi
	call	__dynamic_cast
.L29:
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L30
	movl	$.LC6, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	jmp	.L31
.L30:
	movl	$.LC7, %esi
	movl	$_ZSt4cout, %edi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %esi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
.L31:
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE993:
	.size	main, .-main
	.weak	_ZTV1D
	.section	.rodata._ZTV1D,"aG",@progbits,_ZTV1D,comdat
	.align 16
	.type	_ZTV1D, @object
	.size	_ZTV1D, 24
_ZTV1D:
	.quad	0
	.quad	_ZTI1D
	.quad	_ZNK1D4funcEv
	.weak	_ZTV1C
	.section	.rodata._ZTV1C,"aG",@progbits,_ZTV1C,comdat
	.align 16
	.type	_ZTV1C, @object
	.size	_ZTV1C, 24
_ZTV1C:
	.quad	0
	.quad	_ZTI1C
	.quad	_ZNK1C4funcEv
	.weak	_ZTV1B
	.section	.rodata._ZTV1B,"aG",@progbits,_ZTV1B,comdat
	.align 16
	.type	_ZTV1B, @object
	.size	_ZTV1B, 24
_ZTV1B:
	.quad	0
	.quad	_ZTI1B
	.quad	_ZNK1B4funcEv
	.weak	_ZTV1A
	.section	.rodata._ZTV1A,"aG",@progbits,_ZTV1A,comdat
	.align 16
	.type	_ZTV1A, @object
	.size	_ZTV1A, 24
_ZTV1A:
	.quad	0
	.quad	_ZTI1A
	.quad	_ZNK1A4funcEv
	.weak	_ZTS1D
	.section	.rodata._ZTS1D,"aG",@progbits,_ZTS1D,comdat
	.type	_ZTS1D, @object
	.size	_ZTS1D, 3
_ZTS1D:
	.string	"1D"
	.weak	_ZTI1D
	.section	.rodata._ZTI1D,"aG",@progbits,_ZTI1D,comdat
	.align 16
	.type	_ZTI1D, @object
	.size	_ZTI1D, 24
_ZTI1D:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTS1D
	.quad	_ZTI1C
	.weak	_ZTS1C
	.section	.rodata._ZTS1C,"aG",@progbits,_ZTS1C,comdat
	.type	_ZTS1C, @object
	.size	_ZTS1C, 3
_ZTS1C:
	.string	"1C"
	.weak	_ZTI1C
	.section	.rodata._ZTI1C,"aG",@progbits,_ZTI1C,comdat
	.align 16
	.type	_ZTI1C, @object
	.size	_ZTI1C, 24
_ZTI1C:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTS1C
	.quad	_ZTI1B
	.weak	_ZTS1B
	.section	.rodata._ZTS1B,"aG",@progbits,_ZTS1B,comdat
	.type	_ZTS1B, @object
	.size	_ZTS1B, 3
_ZTS1B:
	.string	"1B"
	.weak	_ZTI1B
	.section	.rodata._ZTI1B,"aG",@progbits,_ZTI1B,comdat
	.align 16
	.type	_ZTI1B, @object
	.size	_ZTI1B, 24
_ZTI1B:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTS1B
	.quad	_ZTI1A
	.weak	_ZTS1A
	.section	.rodata._ZTS1A,"aG",@progbits,_ZTS1A,comdat
	.type	_ZTS1A, @object
	.size	_ZTS1A, 3
_ZTS1A:
	.string	"1A"
	.weak	_ZTI1A
	.section	.rodata._ZTI1A,"aG",@progbits,_ZTI1A,comdat
	.align 16
	.type	_ZTI1A, @object
	.size	_ZTI1A, 16
_ZTI1A:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTS1A
	.text
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB1014:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$1, -4(%rbp)
	jne	.L34
	cmpl	$65535, -8(%rbp)
	jne	.L34
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	call	__cxa_atexit
.L34:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1014:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB1015:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1015:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-39)"
	.section	.note.GNU-stack,"",@progbits
