#include <16F877.h>
#fuses HS,NOWDT,NOPROTECT
#use delay(clock=20000000)
#use i2c(MASTER, SDA=PIN_C4, SCL=PIN_C3,SLOW, NOFORCE_SW)
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)
#include <i2c_LCD.c>
void escribir_i2c(int num){
   i2c_start(); //Inicia la comunicacion
   i2c_write(0x42);  //
   i2c_write(num);
   i2c_stop();
}
void escribir_lcd(int num){
   lcd_gotoxy(5,1);
   printf(lcd_putc," DEC: %d\n ",num);
   lcd_gotoxy(5,2);
   printf(lcd_putc," HEX: %x\n", num);
}
int leer_i2c(){
   int dato =0;
   i2c_start(); //Inicia la comunicacion
   i2c_write(0x45);  //
   dato = i2c_read();
   i2c_stop();
   return dato;
}
void main()
{  
   int num = 0;
   lcd_init(0x4E,16,2);
   while(true)
   {
      num = leer_i2c();     
      escribir_i2c(leer_i2c());
      output_d(leer_i2c());
      escribir_lcd(leer_i2c());
      delay_ms(500);
   }
}
