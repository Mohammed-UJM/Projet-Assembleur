	.data			# le module qui verifie si le caractere est min, maj ou non lettre
point:				# l'etiquette qui contient un point "."
	.string "."

	.text
	.global verification
verification:
verifie_minuscule:
	cmp $97, %rax		# RAX < 97 ?
	jl verifie_majuscule	# si oui alors verifie si majuscule
	cmp $122, %rax		# sinon RAX > 122 ?
	jg verifie_non_lettre	# si oui alors verifie si non lettre
	xor %r14, %r14		# sinon R14 = 0 (R14 variable temoin)
	ret $0			# et retour vers programme principal (calculer et afficher la minuscule)

verifie_majuscule:
	cmp $65, %rax		# RAX < 65 ?
	jl verifie_non_lettre	# si oui alors verifie si non lettre
	cmp $90, %rax		# sinon RAX > 90 ?
	jg verifie_non_lettre	# si oui alors verifie si non lettre
	add $32, %rax		# sinon convertir vers minuscule RAX += 32
        xor %r14, %r14		# R14 = 0 (R14 variable temoin)
	ret $0			# et retourner vers programme principal (calculer et afficher la minuscule)

verifie_non_lettre:
	test %r14, %r14		# R14 = 0 ?
	jz affiche_point	# si oui alors afficher point "."
	inc %r12		# sinon R12 ++ sans afficher "." (deja afficher)
	mov $1, %r14		# R14 = 1 (R14 variable temoin)
	ret $0			# et retourner vers programme principal (et sauter vers tant_que (boucle))
	
affiche_point:			# affichage du point "."
	mov $1, %rax		# RAX = 1
	mov $1, %rdi		# RDI = 1
	mov $point, %rsi	# RSI = &point (etiquette)
	mov $1, %rdx		# RDX = 1
	syscall			# appel systeme (affichage)
	mov $1, %r14		# R14 = 1 (R14 variable temoin)
	inc %r12		# R12 ++
	ret $0			# et retourner vers programme principal (et sauter vers tant_que (boucle))
