#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT
#use delay(clock=20000000)
//Configura modo Maestro, asigna C4 para SDA y C3 para SCL, así como velocidad baja.
#use i2c(MASTER, SDA=PIN_C4, SCL=PIN_C3,SLOW, NOFORCE_SW)
int contador=0;
void escribir_i2c(){
	i2c_start(); 	//Inicia la comunicacion
	i2c_write(0x42);  		//Se envía la dirección del esclavo y se inidica escritura 
	i2c_write(contador);	//Se manda el valor del contador	
	i2c_stop();		//Finaliza la comunicación
}
void main()
{
	 while(true)
	{
		escribir_i2c();	//Se llama a la funcion escribir_i2c
		delay_ms(500);	//Retardo de 0.5 segundos
		contador++;	//Incrementa el contador
	}
}





