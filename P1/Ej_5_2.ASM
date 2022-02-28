		processor 16f877
		include <p16f877.inc>

J		equ H'20'
		org 0
		goto INICIO
		org 5

INICIO:	movlw 00h		;W=0
		movwf J			;Mueve el contendio de W a J
CICLO:	
		incf J,1		;Incrementa a J, y el resultado lo guarda en J
		movf J,0		;Copia el contenido de J en W
		sublw 09h		;W <- W - 09h
		btfsc STATUS,Z	;Revisa si el resultado de la resta fue cero
		goto NUEVE		;El resultado fue cero
		goto NO_NUEVE	;El resultado no fue cero
NUEVE:	
		movlw 10h		;Coloca un 10 en W
		movwf J			;Copia el contenido de W en J
		goto CICLO		;Regresa a CICLO
NO_NUEVE: 
		movf J,0		;Copia el contenido de J a W
		sublw 19h		;W <- W - 19h
		btfss STATUS,Z	;Revisa si el resultado de la resta fue cero
		goto CICLO		;El resultado no fue cero
		movlw 20h		;El resultado fue cero, entonces coloca un 20 en W
		movwf J			;Copia el contenido de W en J
		goto INICIO		;Regresa a INCIO
		end				;Fin del programa