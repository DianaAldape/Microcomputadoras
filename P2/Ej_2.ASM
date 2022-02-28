PROCESSOR 16f877 ;version del procesador
;programa que guarda en las localidades del banco 1 de memoria desde 020 hasta 03F, por medio de un apuntador
INCLUDE <p16f877.inc> ;biblioteca de la version del procesador
Min equ H'40'
ORG 0 ; origen donde se pondra este script en memoria
 GOTO INICIO ; se dirije a la etiqueta inicio
 ORG 5 ; se pone la etiqueta inicio 5 localidades despues del origen donde pone el programa en memoria
INICIO:
	;se accede al banco 1 
	BCF STATUS,RP1; RP1 = 0
	BSF STATUS,RP0; RP0 = 1
	MOVLW 0X20; W = 0x20
	MOVWF FSR; FSR = 0x20
	MOVF INDF, 0; w = INDF
	BCF STATUS,RP0; RP0 = 0
	MOVWF Min; min = INDF
	LOOP:
		BSF STATUS,RP0; RP0 = 1
		INCF FSR; FSR ++
		; si INDF < min: min = INDF si no: pass
		;BSF STATUS,RP0; RP0 = 0
		MOVF INDF, W; w = INDF
		BCF STATUS,RP0; RP0 = 0
		SUBWF Min, W; W = INDF - min
		BTFSS STATUS,C; si DC == 1: ir(si Z == 0) si no: ir a continuar loop
		GOTO CONTINUARLOOP
		BTFSC STATUS,Z; si Z == 0: ir a asignarmin si no: ir a continuar loop
		GOTO CONTINUARLOOP
		GOTO ASIGNARMIN
		CONTINUARLOOP:
			BSF STATUS,RP0; RP0 = 1
			BTFSS FSR,6; si FSR[6] == 1: ir a $ si no: LOOP 
			GOTO LOOP
			GOTO $
		ASIGNARMIN:
			BSF STATUS,RP0; RP0 = 1
			MOVF INDF, 0; w = INDF
			BCF STATUS,RP0; RP0 = 0
			MOVWF Min; min = INDF
			GOTO CONTINUARLOOP
 END