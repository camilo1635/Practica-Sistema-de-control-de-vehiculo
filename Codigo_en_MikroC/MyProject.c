    //Pines de salida para el LCD
    sbit LCD_RS at RD4_bit;
    sbit LCD_EN at RD5_bit;
    sbit LCD_D7 at RD3_bit;
    sbit LCD_D6 at RD2_bit;
    sbit LCD_D5 at RD1_bit;
    sbit LCD_D4 at RD0_bit;
    //Bits de configuración TRIS
    sbit LCD_RS_Direction at TRISD4_bit;
    sbit LCD_EN_Direction at TRISD5_bit;
    sbit LCD_D7_Direction at TRISD3_bit;
    sbit LCD_D6_Direction at TRISD2_bit;
    sbit LCD_D5_Direction at TRISD1_bit;
    sbit LCD_D4_Direction at TRISD0_bit;

    void main(void ) {

      //arreglo para el display 7 segmentos
        const short DIGITOS[10] = {
      0x3F, //Código del dígito 0    0b00111111
      0x06, //Código del dígito 1    0b00000110
      0x5B, //Código del dígito 2
      0x4F, //Código del dígito 3
      0x66, //Código del dígito 4
      0x6D, //Código del dígito 5
      0x7D, //Código del dígito 6
      0x07, //Código del dígito 7
      0x7F, //Código del dígito 8
      0x6F //Código del dígito 9
      };

        //arreglo para las velocidades
        char txt[6];

        unsigned long tiempoTranscurrido = 0;

        //contadores
        short contador = 0;
        short contador1 = 0;
        int contador2 = 0;

        //varible para el funcionamiento del vehículo
        short estado = 0;

        //Pines de entrada y salida
        TRISA = 0b000000;
        TRISB = 0b11111111;
        TRISC = 0;


        PORTC = 0; //Puerto C inicializado en cero (display 7 segmentos).

        Lcd_Init(); //Inicio del LCD.

        while (1) //Bucle infinito.
        {
            if (PORTB.F2 == 1 && contador2 <= 10) {  //Parado con condición para que solo vuelva si la velocidad es menor o igual a cero
                contador = 0;  // valor asignado al contador
                estado = 1;    // Estado asignado
            }

            if (PORTB.F2 == 1 && contador2 > 10) {  //Parado con condicion para encender led azul
                PORTA.F2 =1;
            }


            if (PORTB.F2 == 0) {  // Movimiento
                contador1 = 1;
                estado = 2;

                if(PORTB.F4 == 0) { //Incremente velocidad
                  contador2+=5;   //Aumento de 5 en 5km/h la velocidad
                  delay_ms(300);  //Retarto al presionar el boton para la simulación
                  estado=3;       //estado asignado
                  if(contador2 >= 95){  //Condicion que igual la velocidad a 95km/h como máxima
                 contador2 = 95;
                 }

                }
                else if(PORTB.F6 == 0){ //disminuye velocidad
                   contador2-=3;    //Decremento de 3 en 3km/h la velocidad
                   delay_ms(300);   //Retarto al presionar el boton para la simulación
                   estado=4;        //estado asignado
                }

            }


            if (estado == 1) { //Parado
                PORTC = DIGITOS[contador]; //Muestra '0' en el display
                tiempoTranscurrido = 0;

                while(tiempoTranscurrido < 15000 && PORTB.F2 == 1) {//ciclo que verifica si el estado 1 se mantiene por más de 15 segundos activo
                   delay_ms(1000);
                   tiempoTranscurrido +=1000;
                }
                if(PORTB.F2 == 1){  //Condición para mostrar un texto en LCD al terminar el ciclo while anterior
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(4, 1, "CAMBIARA EN MOVIMIENTO");  // Texto en LCD
                }


            }

            if (estado == 2) {  //Movimiento
                PORTC = DIGITOS[contador1]; // Display muestra '1'

            }

              if (estado == 3) {  // Estado para aumentar la velocidad
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(2,1, "Velocidadlimite:60km");
                      Lcd_Out(3,1, "Incremento");
                      Lcd_Out(1,1, "Velocidad: ");
                      IntToStr(contador2, txt); //Paso de entero a String para luego mostrarlo en LCD
                      Lcd_Out(1,12, txt);


             }

             if (estado == 4) {  // Estado para disminuir la velocidad
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(2,1, "Velocidadlimite:60km");
                      Lcd_Out(3,1, "Decremento");
                      Lcd_Out(1,1, "Velocidad: ");
                      IntToStr(contador2, txt); //Paso de entero a String para luego mostrarlo en LCD
                      Lcd_Out(1,12, txt);
             }



             if(contador2 > 60){ // Condicion si la velocidad supera los 60km/h encienda led rojo
                 PORTA.F3 =1;
             }else{
                PORTA.F3 =0;
             }


        }
    }