processor 16f877a
include <p16f877a.inc>

val equ h'20'
M2 equ 0x21    

		ORG 0	;comienzo, vector de reseteo
		GOTO INICIO	;salto incondicional a INICIO
		ORG 5	;PCL en 5, define origen del programa
INICIO:	
		CLRF PORTA ; Limpia PORTA
		BSF STATUS,RP0	;Coloca en 1 la bandera RP0 del registro STATUS para ir al banco 01
		BCF STATUS,RP1	;Coloca en 0 la bandera RP1 del registro STATUS
		MOVLW 0x00		;Se le da valor de 00 hexadecimal al registro W 
		MOVWF ADCON1	;El valor contenido en W se asigna en el registro ADCON1
						;Para definir como analógico
		MOVLW 0x00		;Se le da valor de 0 hexadecimal al registro W
		MOVWF TRISB		;El valor contenido en W se asigna en el registro TRISB
						;Al asignar el 0 se vuelve una salida
		MOVLW 0x00		;Se le da valor de 0 hexadecimal al registro W
		MOVWF TRISD		;El valor contenido en W se asigna en el registro TRISD
						;Al asignar el 0 se vuelve una salida
		BCF STATUS,RP0	;Configura un 0 en el bit 5 del registro STATUS (RP0)
						;Regresa al banco 0
		MOVLW B'00101001'	;Se le da valor de B'11101001' al registro W 
		MOVWF ADCON0	;El valor contenido en W se asigna en el registro ADCON0
		CLRF PORTB		;Se limpia el puerto

LOOP:
	BSF ADCON0,2		;Se comienza la conversion
	CALL retardo		;Esperamos a que termine de "leer" la informacion

LOOP2:
	BTFSC ADCON0,2		;se verifica si ya termino de "leer" la informacion
	GOTO LOOP2			;No
	MOVF ADRESH,w		;Si y lo pasamos a w
	MOVWF M2			;Almacenamiento temporal

	XORLW b'00000000'	;0,0
	BTFSC STATUS,Z
	CALL n0
	MOVF M2,w

	XORLW b'00110010'	;0,0.99
	BTFSC STATUS,Z
	CALL n0
	MOVF M2,w

	XORLW b'00110011'	;1,1
	BTFSC STATUS,Z
	CALL n1
	MOVF M2,w

	XORLW b'01001100'	;1,1.99
	BTFSC STATUS,Z
	CALL n1
	MOVF M2,w

	XORLW b'01100110'	;2,2
	BTFSC STATUS,Z
	CALL n2
	MOVF M2,w

	XORLW b'01111111'	;2,2.99
	BTFSC STATUS,Z
	CALL n2
	MOVF M2,w

	XORLW b'10011000'	;3,3
	BTFSC STATUS,Z
	CALL n3
	MOVF M2,w

	XORLW b'10110011'	;3,3.99
	BTFSC STATUS,Z
	CALL n3
	MOVF M2,w

	XORLW b'11001100'	;4,4
	BTFSC STATUS,Z
	CALL n4
	MOVF M2,w

	XORLW b'11100110'	;4,4.80
	BTFSC STATUS,Z
	CALL n4
	MOVF M2,w

	XORLW b'11100111'	;5,4.80
	BTFSC STATUS,Z
	CALL n5
	MOVF M2,w

	XORLW b'11111111'	;5,5
	BTFSC STATUS,Z
	CALL n5
	MOVF M2,w
	GOTO LOOP

retardo:
	MOVLW h'30'
	MOVWF val
	LOOP3 DECFSZ val
	GOTO LOOP3
	return
	
	n0:
	MOVLW 0X00
	MOVWF PORTD
	return

	n1:
	MOVLW 0X01
	MOVWF PORTD
	return

	n2:
	MOVLW 0X02
	MOVWF PORTD
	return

	n3:
	MOVLW 0X03
	MOVWF PORTD
	return

	n4:
	MOVLW 0X04
	MOVWF PORTD
	return

	n5:
	MOVLW 0X05
	MOVWF PORTD
	return

	end