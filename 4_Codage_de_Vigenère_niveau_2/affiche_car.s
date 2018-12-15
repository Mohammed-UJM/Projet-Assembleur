	.data			
case:				# le module qui affiche sur la sortie  
	.quad 0			# standard le  caractère dont le code
	.text			# ASCII est mis  dans le registre RAX
	.global affiche_car	
affiche_car:
	xor %rbx, %rbx		# RBX = 0
	mov $case, %rsi		# RSI = &case (etiquette)
	mov %rax, (%rsi,%rbx,8)	# RSI[RBX] = RAX
fin:
	mov $1, %rax		# RAX = 1
	mov $1, %rdi		# RDI = 1
	mov $1, %rdx		# RDX = 1
	syscall			# appel systeme (affichage de l'étiquette case)
	ret $0			# retour vers programme principal
