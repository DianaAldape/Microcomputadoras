#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT,NOLVP
#use delay(clock=20000000)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#org 0x1F00, 0x1FFF void loader16F877(void) {}
void main() {
   char dato;
   int i;
   int aux;
 while( TRUE ) {
    dato = getchar();
    putchar(dato);
    switch(dato){
    	case '0':
	        output_b(0);
	        break;
      	case '1':
         	output_b(255);
         	break;
      	case '2':
	        aux = 0x01;
	        for(i=0; i<8 ; i++){
	        	delay_ms(500);
	            output_b(aux);
	            aux <<= 0b1;
	        }
        	break;
      	case '3':
        	aux =0b10000000;
	        for(i=0; i<8 ; i++){
	            delay_ms(500);
	            output_b(aux);
	            
	            aux >>= 0b1;
	        }
        	break;
       	case '4': 
        	aux = 0x01;
	        for(i=0; i<7 ; i++){
	        	delay_ms(500);
	            output_b(aux);
	            aux <<= 0b1;    
	        }
	        for(i=0; i<8 ; i++){
	           	delay_ms(500);
	           	output_b(aux);
	           	aux >>= 0b1;
	        }
	        break;
       	case '5':
	        output_b(0);
	        delay_ms(500);
	        output_b(255);
	        delay_ms(500);
	        output_b(0);
	        delay_ms(500);
	        output_b(255);
         	break;
    	}
  	}
 }
