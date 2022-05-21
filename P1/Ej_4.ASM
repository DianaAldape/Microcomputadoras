
		PROCESSOR 16f877
		INCLUDE <p16f877.inc>

SEC 	equ H'20'		;Define la posición de SEC
		ORG0
		GOTO INICIO
		ORG5

INICIO: movlw 0x01		;Mueve 0x01 a W, W => 0x01
		movwf SEC		;Mueve W a SEC, SEC => 1
SERIE:	rlf SEC,1		;Rota SEC a la izquierda
		btfss SEC,7		;IF (SEC == 0x80) Salta
		GOTO SERIE		;Regresa a SERIE
		GOTO INICIO		;Regresa a INICIO
		END  			;Fin del programa

