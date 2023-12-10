#line 1 "E:/Requerimientos Práctica 2do corte/Codigo Versiones/c/Codigo en IDE/MyProject.c"

 sbit LCD_RS at RD4_bit;
 sbit LCD_EN at RD5_bit;
 sbit LCD_D7 at RD3_bit;
 sbit LCD_D6 at RD2_bit;
 sbit LCD_D5 at RD1_bit;
 sbit LCD_D4 at RD0_bit;

 sbit LCD_RS_Direction at TRISD4_bit;
 sbit LCD_EN_Direction at TRISD5_bit;
 sbit LCD_D7_Direction at TRISD3_bit;
 sbit LCD_D6_Direction at TRISD2_bit;
 sbit LCD_D5_Direction at TRISD1_bit;
 sbit LCD_D4_Direction at TRISD0_bit;

 void main(void ) {


 const short DIGITOS[10] = {
 0x3F,
 0x06,
 0x5B,
 0x4F,
 0x66,
 0x6D,
 0x7D,
 0x07,
 0x7F,
 0x6F
 };


 char txt[6];

 unsigned long tiempoTranscurrido = 0;


 short contador = 0;
 short contador1 = 0;
 int contador2 = 0;


 short estado = 0;


 TRISA = 0b000000;
 TRISB = 0b11111111;
 TRISC = 0;


 PORTC = 0;

 Lcd_Init();

 while (1)
 {
 if (PORTB.F2 == 1 && contador2 <= 10) {
 contador = 0;
 estado = 1;
 }

 if (PORTB.F2 == 1 && contador2 > 10) {
 PORTA.F2 =1;
 }


 if (PORTB.F2 == 0) {
 contador1 = 1;
 estado = 2;

 if(PORTB.F4 == 0) {
 contador2+=5;
 delay_ms(300);
 estado=3;
 if(contador2 >= 95){
 contador2 = 95;
 }

 }
 else if(PORTB.F6 == 0){
 contador2-=3;
 delay_ms(300);
 estado=4;
 }

 }


 if (estado == 1) {
 PORTC = DIGITOS[contador];
 tiempoTranscurrido = 0;

 while(tiempoTranscurrido < 15000 && PORTB.F2 == 1) {
 delay_ms(1000);
 tiempoTranscurrido +=1000;
 }
 if(PORTB.F2 == 1){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(4, 1, "CAMBIARA EN MOVIMIENTO");
 }


 }

 if (estado == 2) {
 PORTC = DIGITOS[contador1];

 }

 if (estado == 3) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1, "Velocidadlimite:60km");
 Lcd_Out(3,1, "Incremento");
 Lcd_Out(1,1, "Velocidad: ");
 IntToStr(contador2, txt);
 Lcd_Out(1,12, txt);


 }

 if (estado == 4) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1, "Velocidadlimite:60km");
 Lcd_Out(3,1, "Decremento");
 Lcd_Out(1,1, "Velocidad: ");
 IntToStr(contador2, txt);
 Lcd_Out(1,12, txt);
 }



 if(contador2 > 60){
 PORTA.F3 =1;
 }else{
 PORTA.F3 =0;
 }


 }
 }
