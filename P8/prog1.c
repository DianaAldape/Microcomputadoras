#include <16f877.h>
#fuses HS,NOPROTECT,// fusbles
#use delay(clock=20000000) // reloj
#org 0x1F00, 0x1FFF void loader16F877(void) {} // se manda a llamar el bootloader con la finalidad de que no se sobre escriba esta seccion de memoria
void main(){ 
   // seccion de configuraciones y decalaracione de variables
   while(1){// loop infinito
      output_b(0x01); // se pasa el valor de 1 al puerto B => 00000001
      delay_ms(1000); // retardo de 1 segundo
      output_b(0x00); // se pasa el valor de 0 al puerto B => 00000000
      delay_ms(1000); 
   } //while
}//main
