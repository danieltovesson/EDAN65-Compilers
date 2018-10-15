.global _start
.data
buf: .skip 1024

.text
_start:

call main
movq $0, %rdi
movq $60, %rax
syscall

main:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $0, %rsp
	 movq $1, -8(%rbp)
	 movq $2, -16(%rbp)
	 pushq -16(%rbp)
	 pushq -8(%rbp)
	 call f
	 addq $16, %rsp
	 movq $1, %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

f:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $8, %rsp
	 movq $3, -40(%rbp)
	 movq -40(%rbp), %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

