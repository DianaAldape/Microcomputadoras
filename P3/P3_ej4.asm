  processor 16f877
  include<p16f877.inc>
valor1 	equ h'21'
valor2 	equ h'22'
valor3 	equ h'23'
cte1 	equ 20h
cte2 	equ 50h
cte3 	equ 60h
  ORG 0
  GOTO INICIO
  ORG 5
INICIO: 
		BSF STATUS,RP0	;RP0 <- 1, cambia al banco 1 de memoria
  		BCF STATUS,RP1	;RP1 <- 0
  		MOVLW H'0'		;W <- 0x00
  		MOVWF TRISB		;TRISB <- W, configura puerto B como de salida
  		BCF STATUS,RP0	;RP0 <- 0, regresa al banco 0
  		CLRF PORTB		;PORTB <- 0, coloca un cero en puerto B
loop2: 	
		BSF PORTB,0		;Bit0(PORTB) <- 1
  		CALL retardo	;Llama a retardo
  		BCF PORTB,0		;Bit0(PORTB) <- 0
  		CALL retardo	;Llama a retardo
  		GOTO loop2		;Salta a loop2
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