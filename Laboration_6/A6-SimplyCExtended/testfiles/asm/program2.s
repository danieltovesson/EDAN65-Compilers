.global _start
.data
buf: .skip 1024

.text
_start:

call main
movq $0, %rdi
movq $60, %rax
syscall

f:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $0, %rsp
	 movq $2, %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

main:
	 pushq %rbp
	 movq %rsp, %rbp
	 subq $0, %rsp
	 call f
	 addq $0, %rsp
	 movq $1, %rax
	 movq %rbp, %rsp
	 popq %rbp
	 ret

