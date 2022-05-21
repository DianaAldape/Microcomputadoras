	processor 16f877a
	include	<p16f877a.inc>
	
	var EQU H'31'	
	ORG 0
	GOTO INICIO
	ORG 5  
INICIO:
	BSF STATUS,RP0			;Cambio al banco 01
	BCF STATUS,RP1
	BSF TXSTA,BRGH			;Ponemos en 1 la bandera BRGH, tasa de tranferencia alta
	MOVLW D'129'		
	MOVWF SPBRG				;Configuramos a una tasa de 9600 buds
	MOVLW h'0'
	MOVWF TRISB     		;Configura el puerto B como salida
	CLRF PORTB      		;Limpia los bits del PUERTO B
	BCF TXSTA,SYNC			;Comunicación de tipo asíncrona 
	BSF TXSTA,TXEN			;habilita el transmisor 
	BCF STATUS,RP0			;Cambio al banco 0
	BSF RCSTA,SPEN			;Habilita el puerto Serie
	BSF RCSTA,CREN			;Habilita a recepción continua 
	CLRF PORTB
RECIBIR:
	BTFSS PIR1,RCIF			
	GOTO RECIBIR			
	MOVF RCREG,W			
	MOVWF var			
	MOVWF TXREG				
	BSF STATUS,RP0			;Cambio banco 1
TRASMITIR:
	BTFSS TXSTA,TRMT		;Revisar si se transmite informacion	
	GOTO TRASMITIR			
	BCF STATUS,RP0			;Cambio a banco 0
	MOVLW	A'S'			
	XORWF	var,W			;Comparar Si es 'S'
	BTFSC	STATUS,Z		
	GOTO	PARO_PARO		;Si es igual ve a ESTADO_1
	MOVLW	A'A'			
	XORWF	var,W			;Comparar Si es 'A'
	BTFSC	STATUS,Z		
	GOTO	DERECH_DERECH	;Si es igual ve a ESTADO_2
	MOVLW	A'T'			
	XORWF	var,W			;Comparar Si es 'T'
	BTFSC	STATUS,Z		
	GOTO	IZQ_IZQ			;Si es igual ve a ESTADO_3
	MOVLW	A'D'			
	XORWF	var,W			;Comparar Si es 'D'
	BTFSC	STATUS,Z		
	GOTO	DER_IZQ			;Si es igual ve a ESTADO_4
	MOVLW	A'I'			
	XORWF	var,W			;Comparar Si es 'I'
	BTFSC	STATUS,Z		
	GOTO	IZQ_DER			;Si es igual ve a ESTADO_5
	GOTO RECIBIR
PARO_PARO:					;PARO PARO
	MOVLW 0X00
	MOVWF PORTB
	GOTO RECIBIR
DERECH_DERECH:				;DERECHA DERECHA
	MOVLW 0X05
	MOVWF PORTB
	GOTO RECIBIR
IZQ_IZQ:					;IZQUIERDA IZQUIERDA
	MOVLW 0X0A
	MOVWF PORTB
	GOTO RECIBIR
DER_IZQ:					;DERECHA IZQUIERDA
	MOVLW 0X09
	MOVWF PORTB
	GOTO RECIBIR
IZQ_DER:					;IZQUIERDA DERECHA
	MOVLW 0X06
	MOVWF PORTB
	GOTO RECIBIR
END