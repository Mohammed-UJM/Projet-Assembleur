	.data
rax:
	.quad 0
	.text
	.global affiche_car
affiche_car:
	xor %rbx, %rbx
	mov $rax, %rsi	
	mov %rax, (%rsi,%rbx,8)
fin:
	push %rcx
	mov $1, %rax
	mov $1, %rdi
	mov $1, %rdx
	syscall
	pop %rcx
	ret $0
	
