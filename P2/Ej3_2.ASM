		PROCESSOR 16f877
		INCLUDE <p16f877.inc>
CONT 	equ H'41'
AUX 	equ H'42'

		ORG 0
		GOTO INICIO 
		ORG 5		
INICIO: 
		CLRF AUX		;Limpia AUX
		INCF CONT		;Incrementa CONT
		MOVLW 19 		;W = 10
		XORWF CONT, W 	;W XOR CONT
		BTFSC STATUS, Z ;Si (Z==0): Salta
		GOTO FIN		;else : Termina el programa
		MOVLW 0x20 		;Carga 0x20 al registro W
		MOVWF FSR 		;Mueve el contenido de W al registro FSR (FSR = 0x20)
		MOVF 0x20, 0	;Mueve el contenido de 0x20 a W
COMPARAR: 
		BTFSC FSR,4 	;if (FCR=!0x30)	Salta
		GOTO INICIO		;Regresa a inicio
		INCF FSR		;FSR++
		MOVWF AUX		;AUX = W 
		SUBWF INDF, 0	; W= FSR-W
		BTFSS STATUS, C ; If (C==1) Mantener
		GOTO INTERCAMBIAR
		GOTO MANTENER	
MANTENER:
		MOVFW INDF		;Mueve el contenido de la dirección apuntada por FSR a W
		GOTO COMPARAR	;Regresa a comparar
INTERCAMBIAR:
		MOVF INDF, W	;W = el contenido de la dirreción a la que apunta FSR
		DECF FSR		;FCR--
		MOVWF INDF 		;Copia lo que hay en W a la dirección que apunta FCR
		MOVFW AUX		;W=AUX
		INCF FSR 		;FSR++
		MOVWF INDF		;Copia W a la dirección a la que apunt FCR
		GOTO COMPARAR	;Regresa a comparar
FIN: 	
		END

		
		
		
		
		  
		