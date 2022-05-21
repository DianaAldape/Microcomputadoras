		
		processor 16f877
		include <p16f877.inc>
J		equ H'25'
K	 	equ H'26'
C1		equ H'27'
R1		equ H'28'
		org 0
		goto INICIO
		org 5
INICIO:	
		movf J,0		;Mueve de J al registro W
		addwf K,0		;W <- W+K
		movwf R1		;Mueve el resultado de la operación de W a R1
		btfss STATUS,C	;Si el carry es 1, salta una instrucción
		goto NO_ACARREO	;Entra si no hubo acarreo
		goto ACARREO	;Entra si hubo acarreo
NO_ACARREO: 
		movlw H'00'	;Coloca un h'00' en W
		movwf C1		;Mueve el contenido de W a C1
		goto INICIO		;Salta a inicio
ACARREO: 
		movlw H'01'	;Coloca un h'01' en W
		movwf C1		;Mueve el contenido de W a C1
		goto INICIO		;Regresa a INCIO
		end				;Fin del programa