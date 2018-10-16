.global _start
.data
buf: .skip 1024

.text
_start:

call main
movq $0, %rdi
movq $60, %rax
syscall

gcd1:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $24, %rsp
	 movq 16(%rbp), %rax
	 movq %rax, -16(%rbp)
	 movq 24(%rbp), %rax
	 movq %rax, -24(%rbp)
whilegcd10_:
	 movq -16(%rbp), %rax
	 pushq %rax
	 movq -24(%rbp), %rax
	 movq %rax, %rbx
	 popq %rax
	 cmpq %rbx, %rax
	 je end_whilegcd10_
	 movq -16(%rbp), %rax
	 pushq %rax
	 movq -24(%rbp), %rax
	 movq %rax, %rbx
	 popq %rax
	 cmpq %rbx, %rax
	 jle ifgcd10_0_
	 movq -16(%rbp), %rax
	 pushq %rax
	 movq -24(%rbp), %rax
	 movq %rax, %rbx
	 popq %rax
	 subq %rbx, %rax
	 movq %rax, -16(%rbp)
	 jmp figcd10_0_
ifgcd10_0_:
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq -16(%rbp), %rax
	 movq %rax, %rbx
	 popq %rax
	 subq %rbx, %rax
	 movq %rax, -24(%rbp)
figcd10_0_:
	 jmp whilegcd10_
end_whilegcd10_:
	 movq -16(%rbp), %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

gcd2:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $24, %rsp
	 movq 16(%rbp), %rax
	 movq %rax, -16(%rbp)
	 movq 24(%rbp), %rax
	 movq %rax, -24(%rbp)
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq $0, %rax
	 movq %rax, %rbx
	 popq %rax
	 cmpq %rbx, %rax
	 jne ifgcd20_
	 movq -16(%rbp), %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

	 jmp figcd20_
ifgcd20_:
figcd20_:
	 movq -16(%rbp), %rax
	 pushq %rax
	 movq -24(%rbp), %rax
	 movq %rax, %rbx
	 popq %rax
	 movq $0, %rdx
	 idivq %rbx, %rax
	 movq %rdx, %rax
	 pushq %rax
	 movq -24(%rbp), %rax
	 pushq %rax
	 call gcd2
	 addq $16, %rsp
	 movq %rbp, %rsp
	 popq %rbp
	 ret

main:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $32, %rsp
	 movq $0, -16(%rbp)
	 movq $0, -24(%rbp)
	 movq $20, %rax
	 movq %rax, -16(%rbp)
	 movq $24, %rax
	 movq %rax, -24(%rbp)
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq -16(%rbp), %rax
	 pushq %rax
	 call gcd1
	 addq $16, %rsp
	 pushq %rax
	 call print
	 addq $8, %rsp
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq -16(%rbp), %rax
	 pushq %rax
	 call gcd2
	 addq $16, %rsp
	 pushq %rax
	 call print
	 addq $8, %rsp
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq -16(%rbp), %rax
	 pushq %rax
	 call gcd1
	 addq $16, %rsp
	 pushq %rax
	 movq -24(%rbp), %rax
	 pushq %rax
	 movq -16(%rbp), %rax
	 pushq %rax
	 call gcd2
	 addq $16, %rsp
	 movq %rax, %rbx
	 popq %rax
	 subq %rbx, %rax
	 movq %rax, -32(%rbp)
	 movq -32(%rbp), %rax
	 pushq %rax
	 call print
	 addq $8, %rsp
	 movq $0, %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

# Procedure to read number from stdin.
# C signature: long int read(void)
read:
        pushq %rbp
        movq %rsp, %rbp
        movq $0, %rdi
        movq $buf, %rsi
        movq $1024, %rdx
        movq $0, %rax
        syscall                 # sys_read(0, buf, 1024)
        ### Convert string to integer (atoi).
        ### RAX = string length (nchar)
        ### RSI = string pointer
        movq $0, %rdx           # sum <- 0
        cmpq $0, %rax           # if (nchar > 0)
        jle atoi_done           # nchar <= 0
        movq %rsi, %rdi         # copy RSI to RDI for sign check later
        movb (%rsi), %ch        # look at first char
        cmp $0x2D, %ch
        jne atoi_loop
        incq %rsi               # skip sign char
atoi_loop:
        cmpq $0, %rax           # while (nchar > 0)
        jle atoi_done           # leave loop if nchar <= 0
        movzbq (%rsi), %rcx     # move byte, zero extend to quad-word
        cmpq $0x30, %rcx        # test if < '0'
        jl atoi_done            # character is not numeric
        cmpq $0x39, %rcx        # test if > '9'
        jg atoi_done            # character is not numeric
        imulq $10, %rdx         # multiply sum by 10
        subq $0x30, %rcx        # value of character
        addq %rcx, %rdx         # add to sum
        incq %rsi               # step to next char
        decq %rax               # nchar--
        jmp atoi_loop           # loop back
atoi_done:
        movq %rdx, %rax         # put result value in RAX
        movb (%rdi), %ch        # check sign char
        cmp $0x2D, %ch
        jne read_end
        negq %rax               # negate result due to sign char
read_end:
        popq %rbp
        ret

# Procedure to print number to stdout.
# C signature: void print(long int)
print:
        pushq %rbp
        movq %rsp, %rbp
        ### Convert integer to string (itoa).
        movq 16(%rbp), %rax
        movq $(buf+1023), %rsi  # RSI = write pointer (starts at end of buffer)
        movb $0x0A, (%rsi)      # insert newline
        movq $1, %rcx           # RCX = string length
        cmpq $0, %rax
        jge itoa_loop
        negq %rax               # negate to make RAX positive
itoa_loop:                      # do.. while (at least one iteration)
        movq $10, %rdi
        movq $0, %rdx
        idivq %rdi              # divide RDX:RAX by 10
        addb $0x30, %dl         # remainder + '0'
        decq %rsi               # move string pointer
        movb %dl, (%rsi)
        incq %rcx               # increment string length
        cmpq $0, %rax
        jg itoa_loop            # produce more digits
itoa_done:
        movq 16(%rbp), %rax
        cmpq $0, %rax
        jge print_end
        decq %rsi
        incq %rcx
        movb $0x2D, (%rsi)
print_end:
        movq $1, %rdi
        movq %rcx, %rdx
        movq $1, %rax
        syscall
        popq %rbp
        ret

print_string:
        pushq %rbp
        movq %rsp, %rbp
        movq $1, %rdi
        movq 16(%rbp), %rsi
        movq 24(%rbp), %rdx
        movq $1, %rax
        syscall
        popq %rbp
        ret
