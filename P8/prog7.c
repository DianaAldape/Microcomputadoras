#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT,NOLVP
#use delay(clock=20000000)
#define use_portd_lcd true
#include <lcd.c>
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {}
void main() {
	int cont = 0;
	lcd_gotoxy(5,1);
	printf(lcd_putc," %d\n ",cont);
    lcd_gotoxy(5,2);
    printf(lcd_putc," %x \n ",cont);
 	while( TRUE ) {
	    if(input(PIN_A0)){
	      	cont ++;
	    }
	    lcd_gotoxy(5,1);
	    printf(lcd_putc," %d\n ",cont);
	    lcd_gotoxy(5,2);
	    printf(lcd_putc," %x \n ",cont);
	    delay_ms(300);
	}
}


