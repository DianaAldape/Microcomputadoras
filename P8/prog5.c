#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT,NOLVP
#use delay(clock=20000000)
#define use_portd_lcd true
#include <lcd.c>
void main() {
	lcd_init();	//Se llama a la función lcd_init del la libreria lcd.c
 while( TRUE ) {
	lcd_gotoxy(1,1); //Se selecciona la fila y columna 1 del LCD 
	printf(lcd_putc," UNAM \n ");	//Se imprime en la posición seleccionada
	lcd_gotoxy(1,2);	//Se selecciona la columna y fila, 1 y 2 respectivamente. 
	printf(lcd_putc," FI \n ");	//Se imprimi en la posición seleccionada
	delay_ms(300); // Retardo de 0.3 s
	}
 }
 
 
 
 
