#include <16f877.h>
#fuses HS,NOPROTECT,// fusbles
#use delay(clock=20000000) // reloj
#org 0x1F00, 0x1FFF void loader16F877(void) {} // se manda a llamar el bootloader 
// con la finalidad de que no se sobre escriba esta seccion de memoria
void main(){ 
   	// seccion de configuraciones y decalaracione de variables
   	while(1){// loop infinito
   		var = input_a(); //Se guarda en var lo que se ingresa en el puerto a 
     	output_b(var);	//Se pasa "var" al puerto b
   	} //while
}//main



