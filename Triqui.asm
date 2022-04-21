.data
tablero: .byte  ' ', ' ', ' '
	.byte ' ', ' ', ' '
	.byte ' ', ' ', ' '  
#size: .word 3
#.eqv DATA_SIZE 9

end_g: .word 0 # Va a hacer la funcion de un boolean. // Cuando es 0 es que es false y 1 true
possible_win: .word 0 # Possibly win, tambien boolean
prevent_win: .word 0 # Prevent win, tambien boolean
xavi: .byte 'X'
person: .byte 'O'
char_space: .byte ' '
char_a: .byte 65 # A
cahr_b: .byte 66 # 'B'
char_c: .byte 67 # 'C'
InputColumn: .space 1
str_welcome: .asciiz "Bienvendio al triqui donde no podras ganar jeje (nivel Dios)\n\n"
str_introduction: .asciiz "Te presentamos a la maquina con la que jugaras, \n\tSu nombre es Xavi"
str_columnas: .asciiz "\n     A      B      C  \n"
fila1: .word 1
fila2: .word 2
fila3: .word 3
str_before: .asciiz "  [ "
str_after: .asciiz " ]"
str_turn_Xavi: .asciiz "\n\n\t------- TURNO DE XAVI -------\n"
str_turn_player: .asciiz "\n\n\t------- AHORA ES SU TURNO -------\n"
str_fila: .asciiz "\nDigite la fila en la que que desea colocarlo (1 - 3): "
str_columna: .asciiz "\nDigite la columna en la que que desea colocarlo (A - C): "
str_endTurnPlayer: .asciiz "\nSu turno ha sido llevado a cabo con exito,\n\n"
str_endTurnXavi: "\n\n Ya se ha llevado a cabo el turno de Xavi (PC). \n\n"
str_endTurnBoard: "Ahora el tablero de juego esta asi: \n\n"
str_opVerBoard: .asciiz "\n\nDesea observar como quedo finalmente el tablero?"
str_yes: .asciiz "\n\t1. Si"
str_no: .asciiz "\n\t2. No"
str_chooseOp: .asciiz "\nDigita tu opcion: "
str_op1: .asciiz  "\nFinalmente el tablero quedo asi: \n\n"
str_op2: .asciiz "\nVale, ningun problema :D"
str_invalidOp: .asciiz "\nDigito incorrecto, vuelva a intentarlo a continuacion.\n"
str_busy: .asciiz "\nLo sentimos, esta casilla ya est� ocupada, intentelo de nuevo a continuaci�n: \n"
str_last_message: .asciiz "\n\n\t---\tGRACIAS POR JUGAR. --- :D\n\t---\tMAS SUERTE LA PROXIMA VEZ! --- :D\n\n\n"
str_borde: .asciiz "\n**************************************************\n"
str_XaviWins: .asciiz "\n LA XAVINETA LO HA VUELTO A HACER, HA GANADO XAVI!\n"
str_tie: .asciiz  "\n\t    SE HA PRESENTADO UN EMPATE.\n"
str_line: .asciiz "\n"

.text

main: 
	li $v0, 4
	la $a0, str_welcome
	syscall	
	
	li $v0, 4
	la $a0, str_introduction
	syscall
	
	addi $s0, $zero, 9 # Los turnos empiezan desde 9 descendentemente
	lb $s1, xavi   # Contiene la ficha de pc
	lb $s2, person # Contiene la ficha de persona
	lb $s3, char_space # Contiene una casilla vacia
	addi $s4, $zero, 0 # Bool que va a hacer que pare el juego # End_game
	while1:
		beq $s4, 1, exit1 # Cuando End_game sea 1 (true), terminara
		jal turno_xavi
		jal print_board
		jal evaluate_winner
		beq $s4, 0, turn_per
		j while1
		turn_per:
			jal turno_person
			jal print_board
			j while1
	
	exit1:
		li $v0, 4
		la $a0, str_opVerBoard
		syscall		
		
		li $v0, 4
		la $a0, str_yes
		syscall	
			
		li $v0, 4
		la $a0, str_no
		syscall
			
		li $v0, 4
		la $a0, str_chooseOp
		syscall
		
		li $v0, 5
		syscall
		move $t7, $v0
		
		beq $t7, 1, print_board
		
		li $v0, 4
		la $a0, str_last_message
		syscall
	
	
	li $v0, 10
	syscall
	
	
print_board:
	la $t0, tablero
	
	li $v0, 4
	la $a0, str_columnas
	syscall
	
	li $v0, 1
	lw $a0, fila1
	syscall
	
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 0($t0)
	li $v0, 11
	move $a0, $t1
	syscall 
	
	li $v0, 4
	la $a0, str_after
	syscall	
	
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 1($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
		
	li $v0, 4
	la $a0, str_before
	syscall

	lb $t1, 2($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
	
	li $v0, 4
	la $a0, str_line
	syscall
	
	li $v0, 1
	lw $a0, fila2
	syscall
		
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 3($t0)
	li $v0, 11
	move $a0, $t1
	syscall 
	
	li $v0, 4
	la $a0, str_after
	syscall	
	
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 4($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
		
	li $v0, 4
	la $a0, str_before
	syscall

	lb $t1, 5($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
	
	li $v0, 4
	la $a0, str_line
	syscall
	
	li $v0, 1
	lw $a0, fila3
	syscall
		
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 6($t0)
	li $v0, 11
	move $a0, $t1
	syscall 
	
	li $v0, 4
	la $a0, str_after
	syscall	
	
	li $v0, 4
	la $a0, str_before
	syscall
	
	lb $t1, 7($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
		
	li $v0, 4
	la $a0, str_before
	syscall

	lb $t1, 8($t0)
	li $v0, 11
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, str_after
	syscall
	
	li $v0, 4
	la $a0, str_line
	syscall
	
	jr $ra
	
	

turno_xavi:
	
	li $v0, 4
	la $a0, str_turn_Xavi
	syscall
	
	addi $t8, $zero, 0
	
	j possibly_win
	
	#beq $t8, 0, look4prevent # Si es false entonces mire si se puede prevenir que el otro jugador gane
	#j last_notice
	
	look4prevent:
		j prevent_p_win
		
	#check_prevent:
	#	beq $t9, 0, confirm_def # Si tambien es false, no tuvo que hacer uso de ninguna, por lo cual tiene que hacer el proceso de acuerdo al turno
	#	j last_notice
		
	#confirming: # Se confirma que ambas hayan sido false
	#	beq $t8, $t9, confirm_def
	
	confirm_def:  # Se confirma que no tuvo que hacer uso ni del prevent, ni del posible win
		beq $s0, 9, turno1
		beq $s0, 7, turno2
		beq $s0, 5, turno3
		
		turno1:
			addi $t2, $zero, 6
			sb $s1, tablero($t2)
			j last_notice
		
		turno2:
			addi $t7, $zero, 0
			lb $t2, tablero($t7)
			beq $t2, $s2, op1_turn2
			
			addi $t7, $zero, 4
			lb $t2, tablero($t7)
			beq $t2, $s2, op1_turn2
			
			addi $t7, $zero, 8
			lb $t2, tablero($t7)
			beq $t2, $s2, op1_turn2
			
			addi $t7, $zero, 3
			lb $t2, tablero($t7)
			beq $t2, $s2, op2_turn2
			
			j op3_turn2
			
			op1_turn2:
				addi $t2, $zero, 2
				sb $s1, tablero($t2)
				j last_notice
			op2_turn2:
				addi $t2, $zero, 8
				sb $s1, tablero($t2)
				j last_notice
			op3_turn2:
				addi $t2, $zero, 0
				sb $s1, tablero($t2)
				j last_notice
				
		turno3:
			addi $t2, $zero, 3
			lb $t7, tablero($t2)
			beq $t7, $s2, valid_1
			
			addi $t2, $zero, 7
			lb $t7, tablero($t2)
			beq $t7, $s2, valid_2
			
			#addi $t2, $zero, 3
			#lb $t7, tablero($t2)
			#beq $t7, $s2, valid_3
			
			j else
			
			valid_1:
				addi $t2, $zero, 7
				lb $t7, tablero($t2)
				beq $t7, $s3, valid1.2
				j valid_3  # Porque el primer condicional es igual
				
				valid1.2:
					addi $t2, $zero, 8
					lb $t7, tablero($t2)
					beq $t7, $s3, valid_move1
					
					valid_move1:
						addi $t2, $zero, 8
						sb $s1, tablero($t2)
						j last_notice
			
			valid_2:
				addi $t2, $zero, 2
				lb $t7, tablero($t2)
				beq $t7, $s3, valid_move2
					
				valid_move2:
					addi $t2, $zero, 2
					sb $s1, tablero($t2)
					j last_notice
			
			valid_3:
				addi $t2, $zero, 7
				lb $t7, tablero($t2)
				beq $t7, $s2, valid_move3
					
				valid_move3:
					addi $t2, $zero, 2
					sb $s1, tablero($t2)
					j last_notice
			
			else: # En caso de que no se cumpla ninguno de los anteriores casos
				addi $t2, $zero, 0 # Se inicializa en 0 el "contador" que recorrera al mismo tiempo cada casilla del arreglo 
				addi $t7, $zero, 0 # Bool que se encargara de saber si ya se pudo hacer el movement
				while_else:
					lb $t6, tablero($t2) # Se carga en t6 la posicion del tablero en la que va el contador xd
					beq $t6, $s3, move_done # Si la posicion en la que estamos esta vacia, se lleva a la funcion move_done ya que se coloca en cualquiera que se encuentre vacia
					addi $t2, $t2, 1
					j while_else
					
				move_done:
					sb $s1, tablero($t6)
					addi $t7, $t7, 1 # Se convierte en true
					j last_notice
					
			
	last_notice:
		li $v0, 4
		la $a0, str_endTurnXavi
		syscall
		
		li $v0, 4
		la $a0, str_endTurnBoard
		syscall
	
		subi $s0, $s0, 1

		jr $ra


turno_person:
	subi $s0, $s0, 1 # Contador de turnos -1
	
	li $v0, 4
	la $a0, str_turn_player
	syscall
	
	addi $t2, $zero, 0  # El estado inicial de t2 es falso, esta va a ser la encargada de saber si si es valida una casilla
	addi $t3, $zero, 0  # El estado inicial de t3 es falso
	
	while:
		beq $t3, 1, exit # while( t3 (move done) == false) # Mientras sea falso, es decir, mientras aun no se haya hecho el movimiento, volver a repetir las input de los valores
		
		li $v0, 4
		la $a0, str_fila
		syscall
		
		li $v0, 5
		syscall
		move $t4, $v0
		
		bgt $t4, 0, check1
		ble $t4, 0, incorrect1
		check1: 
			ble $t4, 3, ask_column
			bgt $t4, 3, incorrect1
		
		ask_column:
			li $v0, 4
			la $a0, str_columna
			syscall
		
			#li $v0, 8
			#la $a0, InputColumn
			#li $a1, 1
			#syscall
			li $v0, 12
			syscall
			move $t5, $v0
			#lb $t5, InputColumn
			andi $t5,$t5,0x0F # where $t5 contains the ascii digit .
			
			bgt $t5, 0, check2
			ble $t5, 0, incorrect1
		
		check2:
			ble $t5, 3, valid1
			bgt $t5, 3, incorrect1
			
			beq $t5, 'B', valid1
			
		valid1: 
			subi $t4, $t4, 1 # Se le resta 1 a la fila que digito el usuario porque el usuario digita de 1 a 3 y recordar que en prog se inicia a contar desde 0 :D
			subi $t5, $t5, 1 # Se le resta 17 ya que en el codigo Ascii para pasar de la A, al 0 se requiere bajar 17 "numeros" # Actualizacion: El codigo ascii en mips es diferente, esta todo raro, la idea es que para lograr pasar de las letras a los numeros tenemos es que restar 11
			
			addi $t6, $zero, 3 # 3 porque es el numero de filas y columnas :)
			mul $t2, $t4, $t6
			add $t2, $t2, $t5 # Se aplica la formula para saber el numero que le corresponde en la matriz xd
			
			lb $t6, char_space
			lb $s3, tablero($t2)  # BOBOOOOOOOOOO HPTAAAAAAAAAAAA, t2 is a fucking number, the same fucking thing that u r askiinnnggg, asshole
			beq $t6, $s3, valid2 
			bne $s3, $t6, incorrect2 #Esta casilla ya esta ocupada
		
		valid2:
			sb $s2, tablero($t2)
			addi $t3, $t3, 1  # t3 se convierte en verdadero ya que si fue posible el movimiento
			j exit
		
		incorrect1:  # Cuando digita una casilla inexistente
			li $v0, 4
			la $a0, str_invalidOp
			syscall
			j while
			
		incorrect2: # Cuando digita una casilla que ya esta ocupada
			li $v0, 4
			la $a0, str_busy
			syscall
			j while
		
		
	exit:
		li $v0, 4
		la $a0, str_endTurnPlayer
		syscall
		
		li $v0, 4
		la $a0, str_endTurnBoard
		syscall
		
		#jal print_board
		
		jr $ra

prevent_p_win:

	# PRIMERA FILA
	First_one:
		addi $t2, $zero, 0
		lb $t1, tablero($t2)
		beq $t1, $s2, fila1.1
	
	# addi $t2, $zero, 0
	# lb $t1, tablero($t2)
	# beq $t1, $s2, fila1.2
	
	Second_one:
		addi $t2, $zero, 1
		lb $t1, tablero($t2)
		beq $t1, $s2, fila1.3
	
	
	
	# SEGUNDA FILA
	Third_one:
		addi $t2, $zero, 3
		lb $t1, tablero($t2)
		beq $t1, $s2, fila2.1
	
	# addi $t2, $zero, 3
	# lb $t1, tablero($t2)
	# beq $t1, $s2, fila2.2
	
	Fourth_one:
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s2, fila2.3
	
	
	
	# SEGUNDA COLUMNA
	# addi $t2, $zero, 1
	# lb $t1, tablero($t2)
	# beq $t1, $s2, columna2.1
	
	# addi $t2, $zero, 1
	# lb $t1, tablero($t2)
	# beq $t1, $s2, columna2.2
	
	# addi $t2, $zero, 4
	# lb $t1, tablero($t2)
	# beq $t1, $s2, columna2.3
	
	
		
	# TERCERA COLUMNA
	Fifth_one:
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s2, columna3.1
	
	# addi $t2, $zero, 2
	# lb $t1, tablero($t2)
	# beq $t1, $s2, columna3.2
	
	Sixth_one:
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s2, columna3.3
	
	# DIAGONAL SUP-INF
	# addi $t2, $zero, 0
	# lb $t1, tablero($t2)
	# beq $t1, $s2, diag_si1
	
	# addi $t2, $zero, 0
	# lb $t1, tablero($t2)
	# beq $t1, $s2, diag_si2
	
	# addi $t2, $zero, 4
	# lb $t1, tablero($t2)
	# beq $t1, $s2, diag_si3
	
	j confirm_def
	
	fila1.1: # Primera posibilidad de la primera fila
		addi $t2, $zero, 1
		lb $t1, tablero($t2)
		beq $t1, $s2, fila1.1.2
		j fila1.2 # Ya que tienen en comun la primera posibilidad, entonces tambien debe comparar la segunda
		fila1.1.2: # Segunda posibilidad desprendida de la primera posibilidad de la primera fila
			addi $t2, $zero, 2
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done2 # Casilla en la que se realizo el movimiento para detener al rival
			#j confirm_def
	
	fila1.2: # Segunda posibilidad de la primera fila
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s2, fila1.2.2
		j diag_si1
		fila1.2.2:
			addi $t2, $zero, 1
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done1
			#j confirm_def
	
	fila1.3: # Tercera posibilidad de la primera fila
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s2, fila1.3.2
		j columna2.1
		fila1.3.2:
			addi $t2, $zero, 0
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done0
			#j confirm_def
	
	
	
	fila2.1: # Primera posibilidad de la segunda fila
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s2, fila2.1.2
		j fila2.2
		fila2.1.2:
			addi $t2, $zero, 5
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done5
			#j confirm_def
	
	fila2.2: # Segunda posibilidad de la segunda fila
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s2, fila2.2.2
		j Fourth_one
		fila2.2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done4
			#j confirm_def
	
	fila2.3: # Tercer posibilidad de la segunda fila
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s2, fila2.3.2
		j columna2.3
		fila2.3.2:
			addi $t2, $zero, 3
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done3
			#j confirm_def
	
	columna2.1: # Primera posibilidad de la segunda columna
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s2, columna2.1.2
		j columna2.2
		columna2.1.2:
			addi $t2, $zero, 7
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done7
			#j confirm_def
	
	columna2.2: # Segunda posibilidad de la segunda columna
		addi $t2, $zero, 7
		lb $t1, tablero($t2)
		beq $t1, $s2, columna2.2.2
		j Third_one
		columna2.2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done4
			#j confirm_def
	
	columna2.3: # Tercera posibilidad de la segunda columna
		addi $t2, $zero, 7
		lb $t1, tablero($t2)
		beq $t1, $s2, columna2.3.2
		j diag_si3
		columna2.3.2:
			addi $t2, $zero, 1
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done1
			#j confirm_def

	
	columna3.1: # Primera posibilidad de la tercera columna
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s2, columna3.1.2
		j columna3.2
		columna3.1.2:
			addi $t2, $zero, 8
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done8
			#j confirm_def
	
	columna3.2: # Segunda posibilidad de la tercera columna
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s2, columna3.1.2
		j Sixth_one
		columna3.2.2:
			addi $t2, $zero, 5
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done5
			#j confirm_def
	
	columna3.3: # Tercera posibilidad de la tercera columna
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s2, columna3.1.2
		j confirm_def
		columna3.3.2:
			addi $t2, $zero, 2
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done2
			#j confirm_def
	
	diag_si1: # Primera posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s2, diag_si1.2
		j diag_si2
		diag_si1.2:
			addi $t2, $zero, 8
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done8
			#j confirm_def
	
	diag_si2: # Segunda posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s2, diag_si2.2
		j Second_one
		diag_si2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done4
			#j confirm_def
		
	diag_si3: # Tercera posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s2, diag_si3.2
		j Fifth_one
		diag_si3.2:
			addi $t2, $zero, 0
			lb $t1, tablero($t2)
			beq $t1, $s3, prevented_done0
			#j confirm_def

	prevented_done0:
		addi $t2, $zero, 0
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
		
	prevented_done1:
		addi $t2, $zero, 1
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done2:
		addi $t2, $zero, 2
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done3:
		addi $t2, $zero, 3
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done4:
		addi $t2, $zero, 4
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done5:
		addi $t2, $zero, 5
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done6:
		addi $t2, $zero, 6
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	
	prevented_done7:
		addi $t2, $zero, 7
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice

	prevented_done8:
		addi $t2, $zero, 8
		sb $s1, tablero($t2)
		add $t9, $zero, 1
		j last_notice
	

possibly_win:
	FirstOne:
		addi $t2, $zero, 0
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila1.1
	
	SecondOne:
		addi $t2, $zero, 1
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila1.3
	
	ThirdOne:
		addi $t2, $zero, 3
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila2.1
	
	FourthOne:
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila2.3
		
	FifthOne:
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna3.1
	
	SixthOne:
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna3.3
		
	SeventhOne:
		addi $t2, $zero, 6
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila3.1
	
	j look4prevent
	
	
	pwfila1.1: # Primera posibilidad de la primera fila
		addi $t2, $zero, 1
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila1.1.2
		j pwfila1.2 # Ya que tienen en comun la primera posibilidad, entonces tambien debe comparar la segunda
		pwfila1.1.2: # Segunda posibilidad desprendida de la primera posibilidad de la primera fila
			addi $t2, $zero, 2
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done2 # Casilla en la que se realizo el movimiento para detener al rival
			j pwfila1.2
	
	pwfila1.2: # Segunda posibilidad de la primera fila
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila1.2.2
		j pwdiag_si1
		pwfila1.2.2:
			addi $t2, $zero, 1
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done1
			j pwdiag_si1
	
	pwfila1.3: # Tercera posibilidad de la primera fila
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila1.3.2
		j pwcolumna2.1
		pwfila1.3.2:
			addi $t2, $zero, 0
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done0
			j pwcolumna2.1
	
	
	
	pwfila2.1: # Primera posibilidad de la segunda fila
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila2.1.2
		j pwfila2.2
		pwfila2.1.2:
			addi $t2, $zero, 5
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done5
			j pwfila2.2
	
	pwfila2.2: # Segunda posibilidad de la segunda fila
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila2.2.2
		j pwcolumna1.1
		pwfila2.2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done4
			j pwcolumna1.1
	
	pwfila2.3: # Tercer posibilidad de la segunda fila
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila2.3.2
		j pwcolumna2.3
		pwfila2.3.2:
			addi $t2, $zero, 3
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done3
			j pwcolumna2.3
	
	pwcolumna2.1: # Primera posibilidad de la segunda columna
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna2.1.2
		j pwcolumna2.2
		pwcolumna2.1.2:
			addi $t2, $zero, 7
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done7
			j pwcolumna2.2
	
	pwcolumna2.2: # Segunda posibilidad de la segunda columna
		addi $t2, $zero, 7
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna2.2.2
		j ThirdOne
		pwcolumna2.2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done4
			j ThirdOne
	
	pwcolumna2.3: # Tercera posibilidad de la segunda columna
		addi $t2, $zero, 7
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna2.3.2
		j pwdiag_si3
		pwcolumna2.3.2:
			addi $t2, $zero, 1
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done1
			j pwdiag_si3

	
	pwcolumna3.1: # Primera posibilidad de la tercera columna
		addi $t2, $zero, 5
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna3.1.2
		j pwcolumna3.2
		pwcolumna3.1.2:
			addi $t2, $zero, 8
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done8
			j pwcolumna3.2
	
	pwcolumna3.2: # Segunda posibilidad de la tercera columna
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna3.2.2
		j SixthOne
		pwcolumna3.2.2:
			addi $t2, $zero, 5
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done5
			j SixthOne
	
	pwcolumna3.3: # Tercera posibilidad de la tercera columna
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna3.3.2
		j SeventhOne
		pwcolumna3.3.2:
			addi $t2, $zero, 2
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done2
			j SeventhOne
	
	pwdiag_si1: # Primera posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s1, pwdiag_si1.2
		j pwdiag_si2
		pwdiag_si1.2:
			addi $t2, $zero, 8
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done8
			j pwdiag_si2
	
	pwdiag_si2: # Segunda posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s1, pwdiag_si2.2
		j pwcolumna1.2
		pwdiag_si2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done4
			j pwcolumna1.2
		
	pwdiag_si3: # Tercera posibilidad de la diagnoal sup-inf
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s1, pwdiag_si3.2
		j FifthOne
		pwdiag_si3.2:
			addi $t2, $zero, 0
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done0
			j FifthOne
			
	###########################################################

	pwcolumna1.1:
		addi $t2, $zero, 6
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna1.1.2
		j FourthOne
		pwcolumna1.1.2:
			addi $t2, $zero, 0
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done0
			j FourthOne
	
	pwcolumna1.2:
		addi $t2, $zero, 6
		lb $t1, tablero($t2)
		beq $t1, $s1, pwcolumna1.2.2
		j SecondOne
		pwcolumna1.2.2:
			addi $t2, $zero, 3
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done3
			j SecondOne
	
	pwfila3.1:
		addi $t2, $zero, 7
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila3.1.2
		j pwfila3.2
		pwfila3.1.2:
			addi $t2, $zero, 8
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done8
			j pwfila3.2
	
	pwfila3.2:
		addi $t2, $zero, 8
		lb $t1, tablero($t2)
		beq $t1, $s1, pwfila3.2.2
		j pwdiag_is1
		pwfila3.2.2:
			addi $t2, $zero, 7
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done7
			j pwdiag_is1
	
	pwdiag_is1:
		addi $t2, $zero, 4
		lb $t1, tablero($t2)
		beq $t1, $s1, pwdiag_is1.2
		j pwdiag_is2
		pwdiag_is1.2:
			addi $t2, $zero, 2
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done2
			j pwdiag_is2
	
	pwdiag_is2:
		addi $t2, $zero, 2
		lb $t1, tablero($t2)
		beq $t1, $s1, pwdiag_is2.2
		j look4prevent
		pwdiag_is2.2:
			addi $t2, $zero, 4
			lb $t1, tablero($t2)
			beq $t1, $s3, moveToWin_Done4
			j look4prevent
	

	moveToWin_Done0:
		addi $t2, $zero, 0
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
		
	moveToWin_Done1:
		addi $t2, $zero, 1
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done2:
		addi $t2, $zero, 2
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done3:
		addi $t2, $zero, 3
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done4:
		addi $t2, $zero, 4
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done5:
		addi $t2, $zero, 5
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done6:
		addi $t2, $zero, 6
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice
	
	moveToWin_Done7:
		addi $t2, $zero, 7
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice

	moveToWin_Done8:
		addi $t2, $zero, 8
		sb $s1, tablero($t2)
		addi $t8, $zero, 1
		j last_notice


evaluate_winner:
	j row1
	# VERIFICACION XAVI WINNER
	verifying_xaviW:
		row1:
			addi $t2, $zero, 0
			lb $t6, tablero($t2)
			beq $t6, $s1, row1.1
			j row2
			row1.1:
				addi $t2, $zero, 1
				lb $t6, tablero($t2)
				beq $t6, $s1, row1.2
				j row2
				row1.2:
					addi $t2, $zero, 2
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		row2:
			addi $t2, $zero, 3
			lb $t6, tablero($t2)
			beq $t6, $s1, row2.1
			j row3
			row2.1:
				addi $t2, $zero, 4
				lb $t6, tablero($t2)
				beq $t6, $s1, row2.2
				j row3
				row2.2:
					addi $t2, $zero, 5
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		row3:
			addi $t2, $zero, 6
			lb $t6, tablero($t2)
			beq $t6, $s1, row3.1
			j column1
			row3.1:
				addi $t2, $zero, 7
				lb $t6, tablero($t2)
				beq $t6, $s1, row3.2
				j column1
				row3.2:
					addi $t2, $zero, 8
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		column1: 
			addi $t2, $zero, 0
			lb $t6, tablero($t2)
			beq $t6, $s1, column1.1
			j column2
			column1.1:
				addi $t2, $zero, 3
				lb $t6, tablero($t2)
				beq $t6, $s1, column1.2
				j column2
				column1.2:
					addi $t2, $zero, 6
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		column2:
			addi $t2, $zero, 1
			lb $t6, tablero($t2)
			beq $t6, $s1, column2.1
			j column3
			column2.1:
				addi $t2, $zero, 4
				lb $t6, tablero($t2)
				beq $t6, $s1, column2.2
				j column3
				column2.2:
					addi $t2, $zero, 7
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		column3:
			addi $t2, $zero, 2
			lb $t6, tablero($t2)
			beq $t6, $s1, column3.1
			j diag_SI
			column3.1:
				addi $t2, $zero, 5
				lb $t6, tablero($t2)
				beq $t6, $s1, column3.2
				j diag_SI
				column3.2:
					addi $t2, $zero, 8
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		diag_SI: # Diagonal Superior - Inferior
			addi $t2, $zero, 0
			lb $t6, tablero($t2)
			beq $t6, $s1, diag_SI.1
			j diag_IS
			diag_SI.1:
				addi $t2, $zero, 4
				lb $t6, tablero($t2)
				beq $t6, $s1, diag_SI.2
				j diag_IS
				diag_SI.2:
					addi $t2, $zero, 8
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
		diag_IS: # Diagonal Inferior -> Superior
			addi $t2, $zero, 6
			lb $t6, tablero($t2)
			beq $t6, $s1, diag_IS.1
			j verifying_tie
			diag_IS.1:
				addi $t2, $zero, 4
				lb $t6, tablero($t2)
				beq $t6, $s1, diag_IS.2
				j verifying_tie
				diag_IS.2:
					addi $t2, $zero, 2
					lb $t6, tablero($t2)
					beq $t6, $s1, win_true
					j verifying_tie
		
	
		win_true:
			addi $s4, $zero, 1
			
			li $v0, 4
			la $a0, str_borde
			syscall
		
			li $v0, 4
			la $a0, str_XaviWins
			syscall
		
			li $v0, 4
			la $a0, str_borde
			syscall
			jr $ra
	
	# VERIFICACION EMPATE
	verifying_tie:
		addi $t2, $zero, 0
		addi $t6, $zero, 9
	
		for_tie:
			subi $t6, $t6, 1
			beq $t6, 0, exit_for
			
			lb $t1, tablero($t6)	
			bne $t1, $s3, increase_cont
			j for_tie
		
			increase_cont:
				addi $t2, $t2, 1
				j for_tie
		
		exit_for:
			beq $t2, 8, tie_true
			jr $ra
		
		tie_true:
			addi $s4, $zero, 1
		
			li $v0, 4
			la $a0, str_borde
			syscall
		
			li $v0, 4
			la $a0, str_tie
			syscall
		
			li $v0, 4
			la $a0, str_borde
			syscall
		
			jr $ra
