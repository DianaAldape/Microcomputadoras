	processor 16f877a
	include	<p16f877a.inc>

	var1 EQU H'30'	
	var2 EQU H'31'
	var3 EQU H'32'
	var4 EQU H'33'
	cte1 equ 70h		
	cte2 equ 70h		
	cte3 equ 70h		
	
	ORG 0
	GOTO INICIO
	ORG 5  

RETARDO: 
	MOVLW cte1			
	MOVWF var2		
TRES
	MOVLW cte2		
	MOVWF var3	
DOS
	MOVLW cte3		
	MOVWF var4	
UNO
	DECFSZ var4			;Decementa var4
	GOTO UNO			;Si el resultado es diferente de 0 
	DECFSZ var3			;Decementa var3
	GOTO DOS			;Si el resultado es diferente de 0 
	DECFSZ var2			;Decementa var2
	GOTO TRES			;Si el resultado es diferente de 0 

	RETURN

INICIO:
	BSF STATUS,RP0
	BCF STATUS,RP1		;Cambiamos de banco
	BSF TXSTA,BRGH		;Ponemos en 1 la bandera BRGH, tasa de tranferencia alta
	MOVLW D'129'
	MOVWF SPBRG			;Configuramos a una tasa de 9600 buds

	BCF TXSTA,SYNC		;Comunicación de tipo asíncrona 
	BSF TXSTA,TXEN		;habilita el transmisor 

	MOVWF TRISB    	 	;Configura el puerto B como salida
	CLRF PORTB      	;Limpiamos el puerto B

	BCF STATUS,RP0		;Cambio al banco 0
	BSF RCSTA,SPEN		;Habilita el puerto Serie
	BSF RCSTA,CREN		;Habilita a recepción continua 
	
	
RECIBIR:
	BTFSS PIR1,RCIF		;Bucle para revisar si se están recibiendo datos
	GOTO RECIBIR		
	
	MOVF RCREG,W		;Cargamos en W RCREG
	MOVWF var1			;Variable para determinar comportamiento
	MOVWF TXREG			;Vemos en la terminal lo que se tecleo
	BSF STATUS,RP0		;Cambio banco 1

TRASMITIR:
	BTFSS TXSTA,TRMT	;Revisar la transmición de información 		
	GOTO TRASMITIR			
	BCF STATUS,RP0		;Cambio a banco 0

	MOVLW	A'D'			
	XORWF	var1,W		;Verificamos si el valor en la terminal es una 'D'
	BTFSC	STATUS,Z		
	GOTO	ACCION_D	;Si es igual a D, saltamos
	
	MOVLW	A'd'		
	XORWF	var1,W		;Verificamos si el valor en la terminal es una 'd'
	BTFSC	STATUS,Z		
	GOTO	ACCION_D	;Si es igual a d, saltamos
	
	MOVLW	A'I'		
	XORWF	var1,W		;Verificamos si el valor en la terminal es una 'I'	
	BTFSC	STATUS,Z
	GOTO	ACCION_I	;Si es igual a I, saltamos

	MOVLW	A'i'		
	XORWF	var1,W		;Verificamos si el valor en la terminal es una 'i'	
	BTFSC	STATUS,Z
	GOTO	ACCION_I	;Si es igual a i, saltamos	

	GOTO	RECIBIR		;En caso de no ser ningun dato válido, seguimos recibiendo datos

ACCION_D:
	MOVLW	0X80
	MOVWF	PORTB		
	BCF		STATUS,C		;Limpiamos 
	CALL	RETARDO
LOOP1:
	RRF		PORTB			;Recorrimiento a la derecha
	CALL 	RETARDO
	BTFSS	STATUS,C		
	GOTO	LOOP1			;Si C es igual a 0, repetir recorrimiento
	GOTO	RECIBIR			;Si C es igual a 1, recibe 

ACCION_I:
	MOVLW	0X01			
	MOVWF	PORTB			
	BCF		STATUS,C		;Limpiamos 
	CALL	RETARDO
LOOP2:
	RLF		PORTB			;Recorrimiento a la izquierda
	CALL	RETARDO
	BTFSS	STATUS,C		
	GOTO	LOOP2			;Si C es igual a 0, repetir recorrimiento
	GOTO	RECIBIR			;Si C es igual a 1, recibe 

	END