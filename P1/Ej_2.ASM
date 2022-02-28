
PROCESSOR 16f877
INCLUDE <p16f877.inc>

K equ H'26' ;Se define la posición de K (Operando 1)
L equ H'27'	;Se define la posición de L (Operando 2)
M equ H'28'	;Se define la posición de M (Resultado)

ORG0
GOTO INICIO
ORG5

INICIO: MOVF K,W	;Se mueve lo que hay en K a W, W => K
		ADDWF L,0	;Se suma lo que hay en W + L => W
		MOVWF M		;Se mueve el resultado a M, W => M
		GOTO INICIO	;Regresa a INICIO
		END			;Fin del programa