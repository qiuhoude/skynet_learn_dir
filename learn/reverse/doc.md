# Reverse Engineering For Beginners

#### 应用程序启动需要注意的点
##### windows 需要注意的注册表
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKLM\Software\Microsoft\Windows\CurrentVersion\Run HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx
HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices
HKLM\Software\Microsoft\Windows\N\RunServicesOnce
HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnceEx
HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices
HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Run
HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Load
HKLM\SYSTEM\ControlSet***\Control\SessionManager\BootExecuteHKLM\SOFTWARE\Wow6432Node\Windows\CurrentVersion\Run
```

##### Linux 应用需要注意的

- `cron` 配置
- `network` 和网络配置
- `usb` 端口
- ` X Server.`
- `/boot` 目录和任何启动相关的文件夹
- `environment variables` 环境变量 `$PATH`,`aliases` 和 `shell settings`.



#### 通用寄存器 (General-Purpos Registers GPR)
- AX is for storage in arithmetic operations.
- CX is the counter register used in shift, rotate and loop instructions.
- DX is mainly for arithmetic and I/O operations, but it is also used for general storage.
- BX is the base register and it is used to point to data.
- SP points to the top of the stack. When data is placed onto stack, SP decrements (or increments, in platforms such as Intel MCS-51) and as the data is retrieved from the stack, SP increments (or decrements, in platforms such as Intel MCS-51). This register should not be modified.
- BP points at the bottom of the stack.
- SI is used to point at sources in string or stream operations.
- DI is used to point to destinations in string or stream operations.

`AX` 指的是 16-bit;   
32-bit 前面加`E` 例如 `EAX`;  
64-bit 前面加 `R` 例如 `RAX`;

`EAX` 是full 32-bit  
`AX` 检索 lower 16-bits 
`AL` 检索 lower 8 bits  
`AH` 检索 8~15 bits  

#### 段寄存器 (segment registers)

- SS points to the stack.
- CS points to the code.
- DS points to the data.
- ES points to extra data.
- FS points to more extra data.
- GS points to still more extra data.

x84-64已经放弃对这个技术的支持,CS SS DS ES 都是置0  
FS和GS还是包含数据  
windows上存储thread相关的数据  
Linuxs上存储 per-Cpu 的信息

#### 指令指针 (Instruction Pointer (IP))
存储下一条要执行的汇编指令的地址

#### 标志寄存器(Flags Registers)


- CF is set if an addition or subtraction borrow a bit beyond the size of the register. Next instruction will check this value.
- PF is set if the number of set bits in the least significant byte is even. Used with jump instructions.
- AF is set if borrow generated out of four least significant bits.
- ZF is set if the result of an operation is zero.
- `SF is set if the result of an operation is negative.`
- `TF is set if step by step execution for debugging is needed.`
- `IF is set if interrupts are enabled.`
- DF is set if string operations read memory backwards.
- `OF is set if arithmetic overflow happens.`
- IOPL defines the I/O Privilege Level of the current process.
- NT is set if the current process is linked to the next one.
- `RF turns some debug exceptions off to allow debugging.`
- VM is set to allow real mode applications to run in protected mode (80386 behaving like a faster 8086).
- AC is set if alignment checking of memory references is done.
- `VIF is set with VIP to have the operating system servicing deferred interrupts.`
- `VIP is set if an interrupt is pending.`
- ID is set if the platform supports the CPUID instruction.

#### 汇编指令语法

```
语法包含下面4部分
Label Instruction Operand Comment

.data 包含初始化的变量和常量
.bss 定义为初始化数据
.text 代码段
```

```asm
section .text
     global _start
_start:
     mov ecx, myStr            ; Place a comment here
     mov edx, MYSTRLEN
     mov ebx, 1
     mov eax, 4
     int 0x80
     ; The program is about to terminate
     mov eax, 60
     mov edi, 0
     syscall  
section  .data
     myStr db 'Works!', 0xa
     MYSTRLEN equ $ - myStr
```

nasm 和 gdb 使用
```bash
# nasm 使用
nasm -g -f elf64 -F dwarf demo.asm
ld -o demo demo.asm

# gdb 调试可以
gdb -tui demo

# 进入gdb后查看代码 list
(gdb) list
layout regs # 打开寄存器 
layout split # ctrl-x ctrl-o 切换窗口

set disassemble-next-line on # 自动反汇编后面要执行的代码
file xx.exe # 选择文件
b 10    #下断点
info b  #查看断点
delete [breakpoints] [num] # 删除断点 
run args    # 运行,可以传入参数 
info registers # 查看寄存器
info var        # 变量

nexti       # 下一条指令
next        # 下一条语句
c           # 继续执行
print/x $rax # 16进制打印寄存器 rax的值
display expr # 显示表达式
display/fmt expr
```

```makefile
OBJS = Demo

all:	$(OBJS)

%:	%.asm
	nasm -g -f elf64 $@.asm
	ld -o $@ $@.o
 
clean:
	rm -f $(OBJS)  *.o
```

##### 汇编整数四则运算常用指令
```asm
; 常量定义,不用指定大小和类型
;<name>   equ    <value>
MYCONST   equ    10              ; Just a constant
MYSTRLEN  equ    $ - myStr       ; As seen before

; 变量定义  在.data section中
;<name>   <type>   <magnitude>
sqrTwo    dd       1.4142
age       db       10

; 未初始化变量 在.bss段
;<name>   <type>   <value>
array1    resb     5         ; 5 items byte array
array2    resd     20        ; 20 items double array

; mov 是在寄存器和内存之间进行移动数据
;mov   <dest>   <source>
mov    rax,     qword [var1]      ; Move value 
mov    rax,     var1              ; Move address

; 转换(Conversions) 转换可以 widening 或 narrowing,
；有符号和无符号有不同的规则，加宽(widening)时高阶必须保留符号位
; 缩小(narrowing)时不必有特殊的指令
mov   rbx, 10
; BL is used to access the lower 8-bits of RBX
mov   al, bl

; 加宽转换时,寄存器或内存高位会置0
mov al, 10        ; Move 10 into AL
mov rbx, 0        ; Initialise the whole RBX to 0
; Copy AL to BL leaving all upper zeroes in RBX
mov bl, al

; movzx 指令可以进行有符号转换,会根据原始数据在高阶位设置0或1
; 下的例子 -9 从 16-bit 加宽到 32-bit
+9               : 0000000000001001 (get positive)
0000000000001001 : 1111111111110110 (invert)
1111111111110110 : 1111111111110111 (add 1)
11111111111111111111111111110111    (pad with 1)
; MOVSX 将符号位的值扩展到 16或32位
; MOVSXD 将符号位的值扩展到 64位

; lea (load effective address)指令与mov基本一致, lea使用的是值而不是地址  

; add 两个整数相加,1.dest,source的size要一致,2.最终值存储到dest中,3.dest必须可以存储值,4.两个操纵数不能是内存
;add   <dest>   <source>
add    ecx,     eax          ; ecx = eax + ecx

; adc 带进位的加法(addition with carry),会将进位存储到 `RFLAG` 寄存器中
;adc   <dest>,   <src>
add    r1,       r2       ; might set carry bit
adc    r3,       r4       ; use carry bit

; inc 递增操作,用于内存操作数
;inc   <operand>
inc    byte [var1]       ; var1 = var1 + 1
inc    word [var2]       ; var2 = var2 + 1

; sub 减法; 规则基本和add一致, 加一条 dest 不能是一个数字
;sub   <dest>   <source>
sub    eax,     200        ; eax = eax - 200

; dec 递减; 用于内存操作
;dec   <operand>
dec    byte [var1]       ; var1 = var1 - 1
dec    word [var2]       ; var2 = var2 - 1

; mul 无符号乘法(unsigned multiplication) ( 10 * 5 : 10被乘数,5乘数) 
; 被乘数将放入特殊寄存器,会根据操作数大小来选择(AL,AX,EAX,RAX)
; 乘数可以是内存地址或寄存器
; 根据规则存储
; AL * 8-bit = AH (upper), AL (lower)
; AX * 16-bit = DX (upper), AX (lower)
; EAX * 32-bit = EDX (upper), EAX (lower)
; RAX * 64-bit = RDX (upper), RAX (lower)
mov   al,   2
mov   dl,   4
;mul   <source>
mul    dl

; imul 有符号乘法
;imul   <src>                
imul    al     ; same than mul
;imul   <dest>,   <source|immediate>
imul    ax,       10     ; dest = dest * src|imm
;imul   <dest>,   <source>,   <immediate>
imul    rbx,      rcx,        1024     ; dest = src * imm

; div 无符号除法, idiv 有符号除法, 规则和乘法基本一致, 被除数(dividend)会根据大小放到特定寄存器中
; 除数可以是内存地址或寄存器, 商(quotient)和余数(remainder) 会被放到指定寄存器中
; [AH][AL] / 8-bit = AL (quotient), AH (remainder)
; [DX][AX] / 16-bit = AX (quotient), DX (remainder)
; [EDX][EAX] / 32-bit = EAX (quotient), EDX (remainder)
; [RDX][RAX] / 64-bit = RAX (quotient), RDX (remainder)
```

四则运算的例子

```asm
section  .text
   global _start
_start:
   ; Standard methodology 常规用法
   mov ecx, 1313h
   mov ebx, 2121h
   mov eax, 2  
   mul ebx          ; eax = eax * ebx
   add ecx, eax     ; ecx = 0x5555

   ; Arithmetic with LEA 
   mov ecx, 1313h
   mov ebx, 2121h  
   lea ecx, [ebx * 2 + ecx]     ; ecx = 0x5555 过程:ecx = ebx * 2 + ecx

   ; Terminate program in Linux 程序退出
   mov rax, 60
   mov rdi, 0
   syscall
```

8字节变量加到4字节的寄存器中

```asm
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
```
##### 浮点数四则运算常用指令
浮点操作使用专用寄存器 
`XMM registers` 是SSE扩展创建; 共添加16个新128位寄存器命名为`XMM0`~`XMM15`   
随后，根据AVX扩展名，这些寄存器已重命名为YMM，并扩展为最多包含256位。 MXCSR寄存器包含XMM的控制和状态信息  

浮点计算必须将浮点移动到浮点寄存器中才能进行操作, 有 `MOVSS`32位长度的src 和 `MOVSD`64位; 规则如下
- 两个操作数必须有正确的size
- 两个操作数不能是内存值
- 两个操作数不能是立即数

```asm
; 移动
; MOVSS MOVSD

; 转换,使用之前必须转换
;cvtss2sd   <xmm>,   <src>
cvtss2sd    xmm3,    xmm3      ; 32b FP > 64b FP
;cvtsd2ss   <xmm>,   <src>     
cvtss2sd    xmm3,    xmm3      ; 64b FP > 32b FP
;cvtss2si   <xmm>,   <src>     
cvtss2sd    xmm3,    xmm3      ; 32b FP > 32b I
;cvtsd2si   <xmm>,   <src>
cvtss2sd    xmm3,    xmm3      ; 64b FP > 32b I

; addss(单精度) addsd(双精度) 加法, dest都是XMM寄存器
; subss subds 减法
; 规则 1.dest src 相同size; 2.不允许内存到内存操作; 3. src操作数可能不是立即数

; 乘法 规则都与 add 一样
;mulss   <xmm>,   <src>    
mulss    xmm2,    dword [var1]
;mulsd   <xmm>,   <src>    
mulsd    xmm0,    qword [var2]

; 除法 divss divds, 规则都与 add 一样
```

例子:
```asm
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
```

##### 控制指令

```asm
; 跳转指令
jmp end_program
; More code goes here
end_program:
   mov rax, 60
   mov rdi, 0
   syscall

; cmp 指令比较两个数,结果存储到 PFLAG 中,接受两个参数第一个不能是立即数
; ax等于10就跳转到 do_some
cmp ax, 10
je do_some
; More code here
do_some:
; More code here
```

匹配`cmp`结果进行跳转的指令
- JL is for signed data and jumps if p1 < p2.
- JLE is for signed data and jumps if p1 <= p2.
- JG is for signed data, jump if p1 > p2.
- JGE is for signed data, jumps if p1 >= p2.
- JE jumps if p1 = p2.
- JNE jumps if p1 ≠ p2.
- JB is for unsigned data, jumps if p1 < p2.
- JBE is for unsigned data, jumps if p1 <= p2.
- JA is for unsigned data, jumps if p1 > p2.
- JAE is for unsigned data, jumps if p1 >= p2.

注意:如跳转标签不在128字节内, 某些汇编程序会抛出 `jump out of range`的错误  

- 复杂的循环: 汇编没有提供对应的指令,但可以使用 cmp + `jmp,jl,je...`来实现  
- 简单的循环: 可以使用`loop`指令来实现 ,接受一个参数:要跳转的位置; 嵌套循环用loop会比较难实现
   - 计数存储在`rcx`寄存器中
   - 每次循环 `rcx` 递减
   - `rcx!=0` 就会继续循环

例子:
```asm
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
```

##### 栈操作指令

程序在内存的布局

```
stack    向下增长             
heap     向上增长             hight memory
bss      未初始化数据         low memory
data     初始化数据和常量
text     代码段
reserved 保留段

; operand 不是能立即数,可以是内存值或寄存器值, 64位平台是dq(quadword=8bit)
; [RSP] copied into "op", RSP = RSP + DQ
pop   <operand>
; RSP = RSP - DQ, "op" copied into [RSP]
push  <operand>

```

例子
```asm
section  .text
   global _start
_start:
   ; gdb x/6d $rbx
   mov rbx, vals
   mov r15, 0        ; A flag
   mov rcx, 3        ; How many items in the stack?
doPush:
   ; gdb x/d $rsp
   push  qword [rbx + r15 * 8]
   inc r15
   loop doPush
   mov rbx, vals
   mov r15, 0  
   mov rcx, 3
doPop:
   ; gdb p $rax
   pop rax
   ; gdb x/6d $rbx
   mov qword [rbx + r15 * 8], rax
   inc r15
   loop doPop
   ; Terminate Linux program
   mov rax, 60
   mov rdi, 0
   syscall
section .data
   vals dq 1000, 1001, 1002
```

##### 函数操作指令

链接处理中 会调用函数并从中返回。这一步是依赖堆栈，错误的值存储到该区域中会使程序崩溃

```asm
; 函数的定义
global <funcName>
<funcName>:
   ; Function body goes here
ret
```

- call 通过将指向下一条指令的RIP寄存器的内容压入堆栈来存储要返回的地址
- ret 将控制权转移到位于堆栈上的返回地址。程序员在运行此命令之前需要确保弹出并推送正确的值，否则程序将跳转到随机位置

函数参传递
- 将传递参数存储到寄存器中,参数的数量取决于寄存器的数量, 事实上只能是前6个值会在寄存器,7之后会存储在栈中,倒叙存储
- 可以放到全局变量中,但不建议这样做
- 可以存储到栈中,会比寄存器慢,但是可以管理更多的参数

整型 任意数量参数寄存器分配
```
64-bit	32-bit	16-bit	8-bit
1	RDI	EDI	DI	DIL
2	RSI	ESI	SI	SIL
3	RDX	EDX	DX	DL
4	RCX	ECX	CX	CL
5	R8	R8D	R8W	R8B
6	R9	R9D	R9W	R9B
7	Stack	Stack	Stack	Stack
N	Stack	Stack	Stack	Stack
```

浮点型 将寄存器替换成 xmm0~xmm7  

通常函数结束后是通过修改 RSP 寄存器对栈进行重置  
`RSP = RSP + [(number of args) * 8]`

每个根据8byte长度进行计算, 返回值会根据 size和type放到指定的寄存器中
```
Returning value	Register name
Byte	AL
Word	AX
Double-Word	EAX
Quad-Word	RAX
Floating-Point	XMM0
```

每个寄存器对应汇编函数
```
Register	Usage
RAX	Stores the return value
RBX	Callee saves this value onto stack, does required work and then restores it
RCX	4th Argument
RDX	3rd Argument
RSI	2nd Argument
RDI	1st Argument
RBP	Callee saves this value onto stack, does required work and then restores it
RSP	Stack pointer
R8	5th Argument
R9	6th Argument
R10	Temporary
R11	Temporary
R12	Callee saves this value onto stack, does required work and then restores it
R13	Callee saves this value onto stack, does required work and then restores it
R14	Callee saves this value onto stack, does required work and then restores it
R15	Callee saves this value onto stack, does required work and then restores it
```

下面例子 `numExtractor` 从数组 numbers 计算出 avg sum frist last median 
```asm
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
```
##### Stack Buffer Overflow(SBO)
栈缓冲区溢出可以导致程序崩溃,下面是c代码的栈内存移除, myArray是栈上分配的数组  
崩溃原因:stack包含了 返回地址,基于栈的参数,保留寄存器,这些会被重写 
栈溢出可能修改rip,这样就执行恶意代码
```c
int myArray[5] = { 0, 1, 2, 3, 4 };
int myVar = 0;
/* The following lines would cause a SBO
if myArray was stored onto stack */
myArray[6] = 5;
myVar = myArray[6];
myVar = 41756418731968713;

/*
指令结构如下
         RIP
         RBP
⇈ ⇈ ⇈ myArray[] ⇈ ⇈ ⇈
⇈ ⇈ ⇈ myVar ⇈ ⇈ ⇈
         RBX
         R12
         R13
```
如何防止SBO的攻击
- ASLR (Address Space Layout Randomization) liunx上设置 `/proc/sys/kernel/randomize_va_space` 1或2
- Canaries 是一个软件基础技术,可以通过随机插入`RIP`来检测`SBO`,这些值如果被修改或删除程序就会停止,对应GCC选项是`-fno-stack-protector`
- DEP(Data Execution Prevention) 是硬件和软件的基础技术,通过将内存标记可执行或不可执行区域.linux 不能紧张DEP,Windows可以使用 `bcdedit.exe`

##### 系统服务调用(system service call)
系统服务函数,参数限制6个以内,因为传递参数的寄存器只有6个  
```
Register	Use
RAX	System service to be called
RDI	1st Argument
RSI	2nd Argument
RDX	3rd Argument
RCX	4th Argument
R8	   5th Argument
R9	   6th Argument
```

每个系统服务调用对应固定数量的值(个人理解就是系统调用的编号),该值存在 `RXA` 中  
- linux中被定义在`unistd_32.h`和`unistd_64.h`的头文件中, 文件地址`/usr/include/asm/unistd_64.h`可以查看系统调用编号 
- windows 需要安装 `NTDLL` 才能进行分析

例子: 从stdIn读取数据, 输出stdOut
```asm
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
```
##### COFF和PF 文件格式

###### COFF (Common Object File Format)
- COFF是可执行文件，共享库和目标代码的格式。
- COFF原始设计受到限制，因为它没有长数据类型（至少64位）的标准表示形式，并且调试功能有限
- 有很多扩展来克服这些限制 `XCOFF`和 `ECOFF`
- 尽管COFF被ELF取代，但它仍在Windows和某些类似Unix的系统上使用。
- COFF文件提供用于调试信息的空间
- 程序员可以在编译时自定义格式

内部结构
```
FILE HEADER
OPTIONAL FILE HEADER
.TEXT SECTION HEADER
.DATA SECTION HEADER
.BSS SECTION HEADER

SAMPLE_SECTION HEADER
.TEXT SECTION RAW DATA
.DATA SECTION RAW DATA

SAMPLE_SECTION RAW DATA
.TEXT RELOCATION INFO
.DATA RELOCATION INFO

SAMPLE_SECTION RELOCATION INFO
SYMBOL TABLE
STRING TABLE
```
###### PE (Portable Executable)  
Microsoft 将COFF进行重新设计得到PE, 有 .exe, .dll, .ocx, .drv, .sys, .mui 等
在windows中 可执行文件称PE, 目标文件(Objects files)称COFF; `PE .NET`扩展可以调用CLR，而PE32+处理64位代码  
PE文件不包含与位置无关的代码。所有地址提前编译器/链接器确定。如果无法使用首选地址，则操作系统将重新计算所有使代码适配新值的绝对地址，这称为`rebasing`。


内部结构
```
DOS HEADER
PE/COFF HEADER
OPTIONAL HEADER
(Data directories arrays)

SECTION HEADERS ARRAY
.TEXT SECTION
.BSS SECTION
…
```
各个section的说明
- .text for the program body.
- .bss for uninitialized variables.
- .data for initialized variables.
- .rsrc for resource directories.
- .edata for export tables.
- .idata for import tables.
- .debug for debug information.
- .cormeta for object files that contain managed code.
- .drective for linker options.
- .pdata for exceptions information.
- .reloc for image relocations.

```sh
# 16进制查看器
xxd -c 16 [file_name] | more
# 查看pe
readpe [file_name] | more
```

###### ELF (Executable and Linkable Format) 
一般后缀是 .bin, .o, .ko, .so, .elf, .prx 的文件

基本结构
```
ELF HEADER
PROGRAM HEADER TABLE
.TEXT
…
.DATA
SECTION HEADER TABLE
```
ELF 头一般有 52byte长度(32-bit架构) ,64byte(64-bit架构)

```sh
xxd -l 64 [file_name]
# 查看符号信息
readelf -s [file_name] | more
# 查看头信息
readelf -h [file_name]
# 查看程序头 
readelf -l [file_name]
```
## 连接
-  <https://liberoscarcelli.net/courses/reverse-engineering/beginners/reverse-engineering-for-beginners>