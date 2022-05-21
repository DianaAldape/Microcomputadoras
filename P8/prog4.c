#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {}
void main(){
 	while(1){
		output_b(0xff); 	//se pasa el valor de 1 al puerto B => 11111111
		printf(" Todos los bits encendidos \n\r"); 	//Se imprime en la terminal 
		delay_ms(1000);	//Retardo de 1 segundo
		output_b(0x00);	// se pasa el valor de 0 al puerto B => 00000000
		printf(" Todos los leds apagados \n\r");
		delay_ms(1000);	//Retardo de 1 seg
	}//while
}//main



