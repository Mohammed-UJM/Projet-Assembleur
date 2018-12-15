	.data			# 2  Codage Jules César, niveau 2
erreur:				# l'etiquette qui contient le message d'erreur
	.string "Il faut 2 arguments !!"
nb_lettres:			# l'etiquette qui contient 26 (nb alphabet)
	.quad 26
decalage:			# l'etiquette qui recoit la valeur du decalage
	.quad 0
saut:				# l'etiquette qui contient un saut de ligne "\n"
	.string "\n"

	.text
	.global _start
_start:
	pop %r9			# R9 = argc
	cmp $3, %r9		# R9 != 3 ?
	jne affiche_erreur	# si oui alors affiche erreur
	pop %rcx		# sinon RCX = argv[0]
	pop %rcx		# RCX = argv[1] (la clé)
	call atoi		# RAX = atoi ( argv[1] )
	mov %rax, decalage	# decalage (etiquette) = RAX
	pop %rcx		# RCX = argv[2] (chaine à coder)
	xor %r12, %r12		# R12 = 0		

tant_que:
	xor %rdx, %rdx		# RDX = 0
        xor %rax, %rax          # RAX = 0
	mov (%rcx,%r12,1), %al	# AL = RCX[R12]
	test %al, %al		# AL = 0 ?
	jz fin			# si oui alors c'est fini
	sub $97, %rax		# sinon RAX -= 97 ( RAX = 'a' + (RAX - 'a' + decalage ) % 26 )
	add decalage, %rax	# RAX += decalage (etiquette)
	divq nb_lettres		# RAX /= nb_lettres et RDX %= nb_lettres
	mov %rdx, %rax		# RAX = RDX
	add $97, %rax		# RAX += 97
	call affiche_car	# affiche RAX sur la sortie standard
	inc %r12		# R12 ++
	jmp tant_que		# saut vers tant_que ( boucle )

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
