PROCESSOR 16F877
INCLUDE <p16F877.inc>

valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ h'01'
cte2 equ h'50'
cte3 equ h'60'
c0 equ h'04'
c1 equ h'02'
c2 equ h'01'
c3 equ h'03'
cont equ 0x20
cont2 equ 0x24
regini equ 0x028
regini2 equ 0x029
reg1 equ 0x25
reg2 equ 0x26
nvuelta equ 0x27
org 0
goto INICIO
org 5
INICIO:
	BCF STATUS, RP0
	BCF STATUS, RP1
	clrf PORTA
	clrf PORTC
	BSF STATUS, RP0
	BCF STATUS, RP1
	movlw 0x07
	movwf ADCON1
	movlw 0x3f
	movwf TRISA
	clrf TRISC
	BCF STATUS, RP0
	clrf PORTC
LOOPMAIN:
	BTFSC PORTA, 2
	goto izquierda
	BTFSC PORTA, 1
	goto centro
	BTFSC PORTA, 0
	goto derecha
	goto LOOPMAIN
izquierda:
	MOVLW 0x01
	MOVWF PORTC
	; retardo 1ms
	movlw 0x03
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	;call RETARDO
	clrf PORTC
	; retardo 20 ms
	movlw 0x82
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	goto LOOPMAIN
centro:
	MOVLW 0x01
	MOVWF PORTC
	; retardo 1ms
	movlw 0x09
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	;call RETARDO
	clrf PORTC
	; retardo 20 ms
	movlw 0x82
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	goto LOOPMAIN

derecha:
	MOVLW 0x01
	MOVWF PORTC
	; retardo 1ms
	movlw 0x10
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	;call RETARDO
	clrf PORTC
	; retardo 20 ms
	movlw 0x82
	movwf regini
	movlw 0xFF
	movwf regini2
	call RETARDO
	goto LOOPMAIN

RETARDO:
	movf regini, w
	movwf reg1
LOOPRET1:
	MOVF regini2, w
	MOVWF reg2
LOOPRET2:
	DECFSZ reg2
	goto LOOPRET1
	DECFSZ reg1
	goto LOOPRET2
return 


end