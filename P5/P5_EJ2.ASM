	processor 16f877
  	include<p16f877.inc>

;Variables para el retardo
valor1 	equ H'21'
valor2 	equ H'22'
valor3 	equ H'23'
cte1 	equ H'01' 
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
cont equ 0x20
cont2 equ 0x24
  
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
	
LoopMain:
		call pasos64
		goto LoopMain
pasos64:
	inicioLoop:
		clrf cont
	Loop:
		call vuelta
		incf cont
		movf cont,w
  		sublw 	0x40 	;Verifica si la entrada es 04
  		btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   		goto 	inicio		;La combinacion es 04 y procede a la rutina
		goto Loop
	retunrn
vuelta:
	inicioloop1:
		clrf cont2
	Loop1:
		call pasos
		incf cont2
		movf cont2,w
  		sublw 	0x08 	;Verifica si la entrada es 04
  		btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   		goto 	inicioloop1		;La combinacion es 04 y procede a la rutina
		goto Loop1	
	return
vueltaAnti:
	inicioloop2:
		clrf cont2
	Loop2:
		call pasosAnti
		incf cont2
		movf cont2,w
  		sublw 	0x08 	;Verifica si la entrada es 04
  		btfsc 	STATUS,Z 	;Verifica el resultado de la xor
   		goto 	inicioloop1		;La combinacion es 04 y procede a la rutina
		goto Loop1	
	return
pasos:
		movlw 	h'C0'     	;A
  		movwf 	PORTB
		call retardo
		movlw 	h'60'     	;B
  		movwf 	PORTB
		call retardo
		movlw 	h'30'     	;C
  		movwf 	PORTB
		call retardo
		movlw 	h'90'     	;D
  		movwf 	PORTB
		call retardo
	return
pasosAnti:
		movlw 	h'C0'     	;A
  		movwf 	PORTB
		call retardo
		movlw 	h'60'     	;B
  		movwf 	PORTB
		call retardo
		movlw 	h'30'     	;C
  		movwf 	PORTB
		call retardo
		movlw 	h'90'     	;D
  		movwf 	PORTB
		call retardo
	return
retardo: 
		MOVLW cte1		;W <- cte1
  		MOVWF valor1	;valor1 <- W
tres 
		MOVLW cte2		;W <- cte2
 	 	MOVWF valor2	;valor2 <- W
dos 
		MOVLW cte3		;W <- cte3
  		MOVWF valor3	;valor3 <- W
uno 
		DECFSZ valor3	;Decrementa valor3, salta si es 0
  		GOTO uno		;Salta a uno
  		DECFSZ valor2	;Decrementa valor2, salta si es 0
  		GOTO dos		;Salta a dos
  		DECFSZ valor1	;Decrementa valor1, salta si es 0
  		GOTO tres		;Salta a tres
  		RETURN			;Retorna a retardo
		END				;Fin del programa



 
