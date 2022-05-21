processor 16f877      ;
include <p16f877.inc> 

valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'

cte1 equ 90h          
cte2 equ 90h
cte3 equ 90h

       org 0          
       goto inicio 
       org 5
	   
inicio bsf STATUS, RP0  
       bcf STATUS, RP1 ;Cambio a Banco 0  
       movlw h'0'
       movwf TRISB    
       bcf STATUS, RP0  
       clrf PORTB      

loop2 
;ESTADO 1
    BCF PORTB,7
	BCF PORTB,6
	BCF PORTB,5	
	BCF PORTB,4
	BCF PORTB,3 
	BSF PORTB,2 ;VERDE 1
	BCF PORTB,1
	BSF PORTB,0 ;ROJO 1
	call retardo

;ESTADO 2
    BCF PORTB,7
	BCF PORTB,6
	BCF PORTB,5	
	BCF PORTB,4
	BCF PORTB,3 
	BCF PORTB,2
	BSF PORTB,1	;AMARILLO 1
	BSF PORTB,0 ;ROJO 1
	call retardo

;ESTADO 3
    BCF PORTB,7
	BSF PORTB,6 ;VERDE 2
	BCF PORTB,5	
	BCF PORTB,4
	BCF PORTB,3 
	BCF PORTB,2
	BCF PORTB,1	
	BSF PORTB,0 ;ROJO 1
	call retardo

;ESTADO 4
    BCF PORTB,7
	BCF PORTB,6
	BSF PORTB,5	;AMARILLO 2
	BCF PORTB,4
	BCF PORTB,3 
	BCF PORTB,2
	BCF PORTB,1	
	BSF PORTB,0 ;ROJO 1
	call retardo
    goto loop2     
       
retardo 
		movlw cte1        	;W=90H
		movwf valor1		;valor1=90H
tres 
		movwf cte2			;W=90H
		movwf valor2		;valor2=90H
dos  
		movlw cte3			;W=60h
		movwf valor3		;valor3=90H
uno  
		decfsz valor3 		
     	goto uno 			
     	decfsz valor2		
     	goto dos			
    	decfsz valor1   	
    	goto tres			
     	return
     	end 
