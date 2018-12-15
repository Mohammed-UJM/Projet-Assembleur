	.data
erreur:
	.string "Il faut 2 arguments !!"
nb_lettres:
	.quad 26
decalage:	mov (%r9,%r13,1), %bl
	.quad 0
saut:
	.string "\n"
	.text
	.global _start
_start:
	pop %r8
	cmp $3, %r8
	jne affiche_erreur
	pop %r9
	pop %r9
	pop %r10
	xor %r12, %r12
	xor %r13, %r13
	jmp tant_que
	
affiche_erreur:
	mov $1, %rax
	mov $1, %rdi
	mov $erreur, %rsi
	mov $22, %rdx
	syscall
	jmp fin
	
tant_que:
	xor %rdx, %rdx
	mov (%r10,%r12,1), %al
	test %al, %al
	jz fin
	mov (%r9,%r13,1), %bl
	test %bl, %bl
	jz reinitialise_cle
	
continue:
	sub $97, %rbx
	sub $97, %rax
	add %rbx, %rax
	divq nb_lettres
	mov %rdx, %rax
	add $97, %rax
	call affiche_car
	inc %r12
	inc %r13
	jmp tant_que
	
reinitialise_cle:
	xor %r13, %r13
	mov (%r9,%r13,1), %bl
	jmp continue
	
fin:
	mov $1, %rax
	mov $1, %rdi
	mov $saut, %rsi
	mov $1, %rdx
	syscall
	
	mov $60, %rax
	xor %rdi, %rdi
	syscall
	ret
	
