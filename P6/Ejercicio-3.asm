processor 16f877
include <p16f877A.inc>

vol1 equ h'30'	;registro para guardar valor de voltaje1
vol2 equ h'31'	;registro para guardar valor de voltaje2
vol3 equ h'32'	;registro para guardar valor de voltaje3

valor1 equ h'21'	;En la direccion 21 se nombra el registro como valor1
valor2 equ h'22'	;En la direccion 22 se nombra el registro como valor2
valor3 equ h'23'	;En la direccion 23 se nombra el registro como valor3

cte1 equ 10h	;Define cte1 10H
cte2 equ 25h	;Define cte1 25H
cte3 equ 30h	;Define cte1 30H

		ORG 0			;Vector de reset
		GOTO INICIO		;Se mueve al codigo del programa
		ORG 5			;Define origen del programa
INICIO:
		CLRF PORTA		;Limpia PORTA
		BSF STATUS,RP0	;Coloca en 1 la bandera RP0 del registro STATUS para ir al banco 01
		BCF STATUS,RP1 	;Coloca en 0 la bandera RP1 del registro STATUS
		MOVLW 00H		;Se le da valor de 00 hexadecimal al registro W 
		MOVWF ADCON1	;El valor contenido en W se asigna en el registro ADCON1
						;Para definir como anal�gico
		MOVLW 00H		;Se le da valor de 0 hexadecimal al registro W
		MOVWF TRISD	 	;El valor contenido en W se asigna en el registro TRISD
		BCF STATUS,RP0 	;Se define en 0 el bit RP0 de STATUS, regreso al banco BANCO 0
LECTURA:
		MOVLW B'00101001';Se le da valor de B'11101001' al registro W 
		MOVWF ADCON0	;El valor contenido en W se asigna en el registro ADCON0
		BSF ADCON0,2	;Inicia la conversion colocando GO/DONE = 1
		CALL retardo	;Se llama a retardo
		BCF ADCON0,2	;Termiando el proceso de conversi�n se indica que ha terminado con G0/DONE = 0
		MOVFW ADRESH	;Lectura del resultado
		MOVWF vol1		;guarda el resultado en vol1
		MOVLW B'00110001';Configuraci�n de convertidor
		MOVWF ADCON0	;El valor contenido en W se asigna en el registro ADCON0
		BSF ADCON0,2	;Inicia la conversion colocando GO/DONE = 1
		CALL retardo	;Se llama a retardo de 20 microsegundos
		BCF ADCON0,2	;Termiando el proceso de conversi�n se indica que ha terminado con G0/DONE = 0
		MOVFW ADRESH	;Lectura del resultado
		MOVWF vol2		;guarda el resultado en vol2
		MOVLW B'00111001';Configuraci�n de convertidor
		MOVWF ADCON0	;El valor contenido en W se asigna en el registro ADCON0
		BSF ADCON0,2	;Inicia la conversion colocando GO/DONE = 1
		CALL retardo	;Se llama a retardo de 20 microsegundos
		BCF ADCON0,2	;Termiando el proceso de conversi�n se indica que ha terminado con G0/DONE = 0
		MOVFW ADRESH	;Lectura del resultado
		MOVWF vol3		;guarda el resultado en vol3
		
COMPARAV1_V2:	;comparacion de entrada 1 con entrada 2
		MOVF vol2,W	;mover el valor de vol2 a W
		SUBWF vol1,W	;resta con vol1 para determinar quien es mayor
		BTFSS STATUS,C	;verificacion para saber si vol 1 es menor o no
		GOTO COMPARAV2_V3 	;salto incondicional a comparav2_v3
		GOTO COMPARAV1_V3	;salto incondicional a comparav1_v3

COMPARAV1_V3:	;comparacion de entrada 1 con entrada 3
		MOVF vol3,W	;mover el valor de vol3 a W
		SUBWF vol1,W	;resta con vol1 para determinar quien es mayor
		BTFSS STATUS,C	;verificacion para saber si vol 1 es menor o no
		GOTO V3MAY	;salto incondicional a v3may
		GOTO V1MAY	;salto incondicional a v1may
		
COMPARAV2_V3:	;comparacion de entrada 2 con entrada 3
		MOVF vol3,W	;mover el valor de vol3 a W
		SUBWF vol2,W	;resta con vol2 para determinar quien es mayor
		BTFSS STATUS,C	;verificacion para saber si vol 2 es menor o no
		GOTO V3MAY	;salto incondicional a v3may
		GOTO V2MAY	;salto incondicional a v2may

V1MAY:	;procedimiento para encender leds
		MOVLW 0X01 	;mueve el valor 01h a W
		MOVWF PORTD	;pasa el valor de W a portd, enciende 1 led
		GOTO LECTURA	;salto verifica la entrada
		
V2MAY:	;procedimiento para encender leds
		MOVLW 0X03	;mueve el valor 03h a W
		MOVWF PORTD	;pasa el valor de W a portd, enciende 2 led
		GOTO LECTURA	;salto verifica la entrada
		
V3MAY:	;procedimiento para encender leds
		MOVLW 0X07	;mueve el valor 07h a W
		MOVWF PORTD	;pasa el valor de W a portd, enciende 3 led
		GOTO LECTURA	;salto verifica la entrada
		
retardo:	;Funci�n retardo 
		;Ciclos anidados de decrementos
		MOVLW cte1 		;Se le da el valor de cte1 (20h) al registro W	
		MOVWF valor1 	;Se asigna el valor del registro W en la variable valor1
tres:  	MOVLW cte2 		;Se le da el valor de cte2 (50h) al registro W
		MOVWF valor2 	;Se asigna el valor del registro W en la variable valor2
dos:  	MOVLW cte3 		;Se le da el valor de cte3 (60h) al registro W
		MOVWF valor3 	;Se asigna el valor del registro W en la variable valor3
uno: 	decfsz valor3 	;Decrementa el valor de valor3, si es 0 pasa a la siguiente instrucci�n
		GOTO uno 		;Ir a uno
		DECFSZ valor2 	;Decrementa el valor de valor2, si es 0 pasa a la siguiente instrucci�n
		GOTO dos 		;Ir a dos
		DECFSZ valor1 	;Decrementa el valor de valor1, si es 0 pasa a la siguiente instrucci�n
		GOTO tres 		;Ir a tres
		RETURN 			;Regreso de la subrutina

		END 			;Fin del programa