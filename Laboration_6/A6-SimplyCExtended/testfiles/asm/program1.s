.global _start
.data
buf: .skip 1024

.text
_start:
	main:
		pushq %rbp
		movq %rsp, %rbp
		subq $4, %rsp
		 movq $1, -4(%rbp)
		 movq -4(%rbp), %rax
		movq %rbp, %rsp
		popq %rbp
		ret
	movq $0, %rdi
	movq $60, %rax
	syscall
