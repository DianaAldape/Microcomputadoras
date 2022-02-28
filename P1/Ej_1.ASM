	
PROCESSOR 16f877
INCLUDE <p16f877.inc>

K equ H'26'	;Se define la posición de K (operando)
L equ H'27'	;Se define la posición de L (resultado)

ORG0 
GOTO INICIO
ORG5

INICIO:	movlw H'05'	;Guarda 05 en W, 05 => W
		addwf K,0	;Suma el contenido de W con el de K y lo guarda en W, W+K => W
		movwf L		;Mueve el contenido de W a L, W => L
		GOTO INICIO	;Regresa al INICIO
		END			;Fin del programa

