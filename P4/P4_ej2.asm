	processor 16f877
  	include<p16f877.inc>

;Variables para el retardo
valor1 	equ H'21'
valor2 	equ H'22'
valor3 	equ H'23'
cte1 	equ H'10' 
cte2 	equ H'50'
cte3 	equ H'60'
;Constantes para comparar la combinación entrante
c0 	equ H'00' 
c1 	equ H'01'
c2 	equ H'02'
c3 	equ H'03'
c4 	equ H'04'
c5 	equ H'05'
	org 0
  	goto inicio
	org 5
inicio:
 	clrf 	PORTA		;Limpia el puerto A
   	bsf 	STATUS,RP0	;Cambio al Banco 1
 	bcf 	STATUS,RP1 
   	movlw 	H'00'		;Mueve 0h a w
   	movwf 	TRISB  		;Configura Puerto B como salida
  	movlw 	H'06'   	
  	movwf 	ADCON1 		;Configura puertos A y E como digitales
   	movlw 	H'3F'   	
  	movwf 	TRISA		;Configura el Puerto A como entrada
   	bcf 	STATUS,RP0	;Regresa al Banco 0
	clrf 	PORTB  		;Limpia los bits de Puerto B (los apaga)
ciclo: 
	;COMBINACION PARA APAGAR LEDS     
  	movlw 	c0			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 00
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	apg    		;La combinacion es 00 y procede a la rutina
	;COMBINACION PARA ENCENDER LEDS 
  	movlw 	c1			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 01
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
  	goto 	enciende	;La combinacion es 01 y procede a la rutina
	;COMBINACION PARA CORRIMIENTO A LA DERECHA 
  	movlw 	c2			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 02
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	derecha		 ;La combinacion es 02 y procede a la rutina
	;COMBINACION PARA CORRIMIENTO A LA IZQUIERDA
  	movlw 	c3			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 03
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto  	izquierda	;La combinacion es 03 y procede a la rutina
	;COMBINACION PARA CORRIMIENTO DE DERECHA A IZQUIERDA 
  	movlw 	c4			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 04
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	der_izq		;La combinacion es 04 y procede a la rutina
	;COMBINACION PARA ENCENDIDO Y APAGADO DE LEDS
  	movlw 	c5			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 05
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	enc_apg		;La combinacion es 05 y procede a la rutina
	goto	ciclo		;Vuelve a preguntar por una combinacion valida
enc_apg:                ;Loop que enciende y apaga los
  	movlw 	h'00'     	;bits del puerto B
   	movwf 	PORTB     
   	call 	retardo
   	movlw 	h'FF'
   	movwf 	PORTB     
   	call 	retardo
   	goto 	ciclo
apg:                   	;Apaga los bits del puerto B
 	movlw 	h'00'	
  	movwf 	PORTB     
  	goto 	ciclo
enciende:         		;Enciende los bits del puerto B
  	movlw 	h'FF'     
  	movwf 	PORTB
 	goto 	ciclo
derecha:             	;Realiza corrimiento a la derecha
 	movlw 	h'80'
  	movwf 	PORTB
   	call 	retardo
derecha1:
  	rrf 	PORTB,1
  	call 	retardo
   	btfss 	PORTB,0
   	goto 	derecha1
  	goto 	ciclo
izquierda:           	;Realiza corrimiento a la izquierda
  	movlw 	h'01'
   	movwf 	PORTB
   	call 	retardo
izquierda1:
  	rlf 	PORTB,1
  	call 	retardo
 	btfss 	PORTB,7
  	goto 	izquierda1
  	goto 	ciclo
der_izq:                ;Realiza corrimiento a la derecha y
 	movlw 	h'80'     	;luego a la izquierda
  	movwf 	PORTB
   	call 	retardo
derecha2:
 	rrf 	PORTB,1
 	call 	retardo
  	btfss 	PORTB,0
  	goto 	derecha2
 	movlw 	h'01'
  	movwf 	PORTB
   	call 	retardo
izquierda2:
  	rlf 	PORTB,1
   	call 	retardo
  	btfss 	PORTB,7
   	goto 	izquierda2
  	goto 	ciclo    
retardo: 
  	movlw 	cte1      	;Rutina que genera un retardo
  	movwf 	valor1
tres: 
	movwf 	cte2
	movwf 	valor2
dos:  
	movlw 	cte3
  	movwf 	valor3
uno:  
	decfsz 	valor3 
  	goto 	uno 
	decfsz 	valor2
 	goto 	dos
 	decfsz 	valor1   
  	goto 	tres
	return
	end