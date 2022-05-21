	processor 16f877a
	include	<p16f877a.inc>	
AUX EQU H'25'		
	ORG 0
	GOTO INICIO
	ORG 5  
INICIO:
	BSF STATUS,RP0		;Cambio al banco 1
	BCF STATUS,RP1		
	BSF TXSTA,BRGH		;BRGH = 1
	MOVLW D'129'		
	MOVWF SPBRG			;Se configura una tasa de 9600 buds
	BCF TXSTA,SYNC		;Comunicación de tipo asíncrona 
	BSF TXSTA,TXEN		;Se habilita el transmisor 
	MOVWF TRISB    	 	;Se configura el puerto B como salida
	CLRF PORTB      	;Se limpia el puerto B
	BCF STATUS,RP0		;Cambio al banco 0
	BSF RCSTA,SPEN		;Se habilita el puerto Serie
	BSF RCSTA,CREN		;Se habilita a recepción continua 	
RECIBE
	BTFSS PIR1,RCIF		;If (RCIF = 1) {salta}
	GOTO RECIBE		 	;else {RECIBE} 
	MOVF RCREG,W		;W = RCREG
	MOVWF AUX			
	MOVWF TXREG			;Vemos en la terminal lo que se tecleo
	BSF STATUS,RP0		;Cambio al banco 1
TRANSMITE:
	BTFSS TXSTA,TRMT	;if (TRMT = 1) {Salta}
	GOTO TRANSMITE		;else {TRANSMITE}
	BCF STATUS,RP0		;Cambio a banco 0		
	MOVLW	A'1'		;W <- 1
	XORWF	AUX,W		;W XOR AUX
	BTFSC	STATUS,Z	;if (Z = 0) {salta}	
	GOTO	CASO_1		;else {CASO_1}
	MOVLW	A'0'		;W <- 1	
	XORWF	AUX,W		;W XOR AUX	
	BTFSC	STATUS,Z	;if (Z = 0) {salta}
	GOTO	CASO_0		;else {CASO_1}
	GOTO RECIBE			;Repite
CASO_0
	BCF		PORTB,0		;Mandamos 0 al puerto B
	GOTO	RECIBE		;Regresa a RECIBE
CASO_1					
	BSF		PORTB,0		;Mandamos 1 al puerto B
	GOTO	RECIBE		;Regresa a RECIBE

	END	
	