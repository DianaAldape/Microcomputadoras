		processor 16f877
		include <p16f877.inc>
		
valor1 equ H'20' 
;valor2 equ H'21'
;valor3 equ H'22'

cteA equ 100h
;cteB equ 50h
;cteC equ 60h


		
		ORG 0 
		GOTO INICIO 
		
		ORG 5
		
INICIO: CLRF PORTA
		CLRF PORTE
		BSF STATUS, RP0 
		BCF STATUS, RP1
		MOVLW 00H 
		MOVWF ADCON1
		MOVLW 00h
		MOVWF TRISD
		BCF STATUS, RP0
		
		MOVLW B'11101001'
		MOVWF ADCON0 
		
OTRO: 	BSF ADCON0, 2
		CALL RETARDO_20 ;  o micro
		
ESPERA:	BTFSC ADCON0, 2
		GOTO ESPERA
		MOVF ADRESH, W
		MOVWF PORTD ; D  
		GOTO OTRO 
		
RETARDO_20: MOVLW cteA   
			MOVWF valor1
uno:		DECFSZ valor1
			GOTO uno
			RETURN 
			END









;MOVLW H'3F'
		;MOVWF TRISE
		;MOVLW 00h 
		;MOVWF TRISD


;tres: 		MOVLW cteB
;			MOVWF valor2 
;dos: 		MOVLW cteC  
;			MOVWF valor3
;uno: 		DECFSZ valor3
;			GOTO uno
;			DECFSZ valor2 
;			GOTO dos
;			DECFSZ valor1
;			GOTO tres
;			RETURN 
;			END