#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT
#use delay(clock=20000000)
//Configura modo Maestro, asigna C4 para SDA y C3 para SCL, así como velocidad baja.
#use i2c(MASTER, SDA=PIN_C4, SCL=PIN_C3,SLOW, NOFORCE_SW)
#include <lcd.c>
int contador=0;
void escribir_i2c(){
      i2c_start();    //Inicia la comunicacion
   i2c_write(0x42);        //Se envía la dirección del esclavo y se inidica escritura 
   i2c_write(contador);   //Se manda el valor del contador   
   i2c_stop();      //Finaliza la comunicación
}
//Función para mandar el valor del contador en Decimal y Hexadecimal al LCD
void escribir_lcd(){
      lcd_gotoxy(5,1);   //Seleccionamos la columna y las filas a usar
      printf(lcd_putc," DEC: %d\n ",contador);   //Se imprime el valor del contador en Decimal
      lcd_gotoxy(5,2);   //Seleccionamos la columna y las filas a usar
      printf(lcd_putc," HEX: %x\n ",contador);   //Se imprime el valor del contador en Hexadecimal
}
void main()
{
   lcd_init(0x4E,16,2);
   while(true)
   {
         escribir_i2c();         //Se llama a la función escribir_i2c
         output_b(contador);      //Se pone el valor del contador en el puerto b
         escribir_lcd();      //Se llama a la función escribir_lcd
         delay_ms(500);      //Retardo de 0.5 segundos
         contador++;         //Se incrementa el contador   
   }
}





