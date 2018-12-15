	.data			# 4  Codage de Vigenère, niveau 2
erreur:				# l'etiquette qui contient le message d'erreur
	.string "Il faut 2 arguments !!"
nb_lettres:			# l'etiquette qui contient 26 (nb alphabet)
	.quad 26
saut:				# l'etiquette qui contient un saut de ligne "\n"
	.string "\n"
	
	.text
	.global _start
_start:
	pop %r8			# R8 = argc
	cmp $3, %r8		# R8 != 3 ?
	jne affiche_erreur	# si oui alors affiche erreur
	pop %r9			# sinon R9 = argv[0]
	pop %r9			# R9 = argv[1] (la clé)
	pop %r10		# R10 = argv[2] (chaine à coder)
	xor %r12, %r12		# R12 = 0
	xor %r13, %r13		# R13 = 0
	xor %r14, %r14		# R14 = 0
	
tant_que:
	xor %rdx, %rdx		# RDX = 0
	mov (%r10, %r12), %al	# AL = R10[R12]
	test %al, %al		# AL = 0 ?
	jz fin			# si oui alors c'est fini
	mov (%r9, %r13), %bl	# BL = R9[R13]
	test %bl, %bl		# BL = 0 ?
	jz reinitialise_cle	# si oui alors repeter la clé

continu:
	call verification	# verifie si le caractere est min, maj (R14=0) ou non lettre (R14=1) 
	test %r14, %r14		# R14 != 0 ?
	jnz tant_que		# si oui c a dire que le caractere est non lettre sauter vers tant que (boucle)
	sub $97, %rbx		# sinon RBX -= 97 calcul decalage ('a'=0, 'b'=1, ...)
	sub $97, %rax		# RAX -= 97
	add %rbx, %rax		# RAX += RBX
	divq nb_lettres		# RAX /= nb_lettres et RDX %= nb_lettres
	mov %rdx, %rax		# RAX = RDX
	add $97, %rax		# RAX += 97
	call affiche_car	# affiche RAX sur la sortie standard
	inc %r12		# R12 ++
	inc %r13		# R13 ++
	jmp tant_que		# saut vers tant_que ( boucle )
	
reinitialise_cle:		# reinitialise la clé pour pouvoir la repeter
	xor %r13, %r13		# R13 = 0
	mov (%r9, %r13), %bl	# BL = R9[R13]
	jmp continu		# saut vers continu

affiche_erreur:			# affiche le message d'erreur dans le cas != 2 arguments
	mov $1, %rax		# RAX = 1
	mov $1, %rdi		# RDI = 1
	mov $erreur, %rsi	# RSI = &erreur (etiquette)
	mov $22, %rdx		# RDX = 22 nb de caracteres dans le message
	syscall			# appel systeme (affichage)
	
fin:				# affichage d'un saut de ligne et fin
	mov $1, %rax		# RAX = 1
	mov $1, %rdi		# RDI = 1
	mov $saut, %rsi		# RSI = &saut (etiquette)
	mov $1, %rdx		# RDX = 1
	syscall			# appel systeme (affichage)
	
	mov $60, %rax		# RAX = 60
	xor %rdi, %rdi		# RDI = 0
	syscall			# appel systeme (fin du programme)
	ret			# fin du programme
