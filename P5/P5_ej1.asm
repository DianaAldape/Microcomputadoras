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
c6 	equ H'06'
c7 	equ H'07'
c8 	equ H'08'
  
	org 0
  	goto inicio
	org 5

inicio:
 	clrf 	PORTA		;Limpia el puerto A
   	bsf 	STATUS,RP0	;Cambio al Banco 1
 	bcf 	STATUS,RP1 
   	movlw 	H'00'		;Mueve 0h a w
   	movwf 	TRISB  		;Configura Puerto B como salida
   	movwf 	TRISC  		;Configura Puerto C como salida
  	movlw 	H'06'   	
  	movwf 	ADCON1 		;Configura puertos A y E como digitales
   	movlw 	H'3F'   	
  	movwf 	TRISA		;Configura el Puerto A como entrada
   	bcf 	STATUS,RP0	;Regresa al Banco 0
	clrf 	PORTB  		;Limpia los bits de Puerto B (los apaga)
	clrf 	PORTC
	movlw 	H'06'
	movwf 	PORTC
ciclo: 
	;COMBINACION PARA APAGAR LEDS     
  	movlw 	c0			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 00
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO0    		;La combinacion es 00 y procede a la rutina
	;COMBINACION PARA ENCENDER LEDS 
  	movlw 	c1			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 01
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
  	goto 	CASO1	;La combinacion es 01 y procede a la rutina
 
	;COMBINACION PARA CORRIMIENTO A LA DERECHA 
  	movlw 	c2			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 02
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO2		 ;La combinacion es 02 y procede a la rutina
  
	;COMBINACION PARA CORRIMIENTO A LA IZQUIERDA
  	movlw 	c3			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 03
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto  	CASO3	;La combinacion es 03 y procede a la rutina
      
  	movlw 	c4			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 04
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO4		;La combinacion es 04 y procede a la rutina

	movlw 	c5			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 04
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO5		;La combinacion es 04 y procede a la rutina 

	movlw 	c6			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 04
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO6		;La combinacion es 04 y procede a la rutina 

	movlw 	c7			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 04
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO7		;La combinacion es 04 y procede a la rutina 

  	movlw 	c8			;Mueve 0 a w
  	xorwf 	PORTA,w  	;Verifica si la entrada es 05
  	btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   	goto 	CASO8		;La combinacion es 05 y procede a la rutina
	goto	ciclo		;Vuelve a preguntar por una combinacion valida

CASO0:               ;Apaga los bits del puerto B
 	movlw 	h'00'	
  	movwf 	PORTB     
  	goto 	ciclo

CASO1:         		;Enciende los bits del puerto B
  	movlw 	h'08'     
  	movwf 	PORTB
 	goto 	ciclo

CASO2:             	;Realiza corrimiento a la derecha
 	movlw 	h'04'
  	movwf 	PORTB
   	goto 	ciclo

CASO3:           	;Realiza corrimiento a la izquierda
  	movlw 	h'01'
   	movwf 	PORTB
    goto 	ciclo

CASO4:                ;Realiza corrimiento a la derecha y
 	movlw 	h'02'     	;luego a la izquierda
  	movwf 	PORTB
   	goto 	ciclo
CASO5:                ;Realiza corrimiento a la derecha y
 	movlw 	h'09'     	;luego a la izquierda
  	movwf 	PORTB
   	goto 	ciclo
CASO6:                ;Realiza corrimiento a la derecha y
 	movlw 	h'06'     	;luego a la izquierda
  	movwf 	PORTB
   	goto 	ciclo
CASO7:                ;Realiza corrimiento a la derecha y
 	movlw 	h'05'     	;luego a la izquierda
  	movwf 	PORTB
   	goto 	ciclo
CASO8:                ;Realiza corrimiento a la derecha y
 	movlw 	h'10'     	;luego a la izquierda
  	movwf 	PORTB
   	goto 	ciclo
     
	end