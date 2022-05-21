processor 16f877
include <p16f877.inc>

valor1 equ 0x21
valor2 equ 0x22
valor3 equ 0x23
cte1 equ 0x80
cte2 equ 0X50
cte3 equ 0X80
AUX equ 0x24
	ORG 0 
	GOTO INICIO
	ORG 5
INICIO:
	BSF STATUS, RP0
	BCF STATUS, RP1
	CLRF TRISB
	BCF STATUS, RP0	
	CLRF PORTB
LOOP_INI:
	CALL retardo
	MOVLW 0X80
	MOVWF AUX	
LOOP:
	RRF AUX, 1
	BTFSS AUX, 7
	MOVF AUX, 0
	MOVWF PORTB
	CALL retardo
	GOTO LOOP
	GOTO LOOP_INI
retardo:
 	MOVLW cte1
 	MOVWF valor1
tres: 	
	MOVLW cte2
	MOVWF valor2
dos: 	
	MOVLW cte3
	MOVWF valor3
uno:
 	DECFSZ valor3
	GOTO uno
	DECFSZ valor2
	GOTO dos
	DECFSZ valor1
	GOTO tres
	RETURN
	END