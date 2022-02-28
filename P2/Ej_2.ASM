		processor 16f877
		include <p16f877.inc>
I:		equ 0x20; dirección de inicio
J:		equ 0x40; dirección de fin
min:	equ 0x41; dirección que contiene al número menor
aux:	equ 0x42; dirección auxiliar
		org 0
		goto inicio
		org 5
inicio:	movlw I; pone en W la dirección I
		movwf FSR; guarda el contenido de W en FSR
		movlw 0x7f; pone un 0x7f en W. El mayor número positivo posible con 8 bits signados
		movwf min; pone el mayor número posible en min
ciclo:	call minimo; llama a la subrutina minimo
		incf FSR; incrementa el contenido de FSR
		movlw J; pone en W la dirección J		
		xorwf FSR,0; W <- INDF xor W
		btfss STATUS,Z; revisa si fue cero la operación anterior
		goto ciclo; si no ha sido cero, sige incrementando
		goto inicio; si ya fue cero, regresa al inicio
minimo: movf INDF,0; W <- ((FSR))
		subwf min,0; W <- min - w
		movwf aux; almacena el resultado de la operación en un registro auxiliar
		btfsc aux,7; revisa si la operación anterior dio como resultado un número positivo
		return; termina la subrutina, pues min es menor que lo que hay en W
		movf INDF,0; dio como resultado positivo, es decir, min>w, por lo tanto hace W <- ((FSR))
		movwf min; coloca el contenido de W en min
		return; termina la subrutina, pues ya se actualizó el contenido  de min
		end	