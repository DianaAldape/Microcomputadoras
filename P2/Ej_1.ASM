
PROCESSOR 16f877
INCLUDE <p16f877.inc>

ORG0
GOTO INICIO
ORG5

INICIO: bcf STATUS,RP1	;Coloca en 0 al bit RP1 de STATUS, RP1 = 0
		bsf STATUS,RP0	;Coloca en 1 al bit RP0 de STATUS
		movlw 0x20		;Carga un 0x20 al registro W
		movwf FSR		;Mueve el contenido de W al registro FSR
LOOP: 	movlw 0x5F		;Carga un 0x5F al registro W
		movwf INDF		;Mueve el contenido de W a la dirección apuntada
						;por el registro FSR 
		incf FSR		;Incrementa FSR
		btfss FSR,6		;IF (FSR == 40) Si es 1, salta. 
		GOTO LOOP 		;Regresa a etiqueta LOOP
		GOTO $
		END				;Fin del programa