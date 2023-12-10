
_main:

;MyProject.c,16 :: 		void main(void ) {
;MyProject.c,35 :: 		unsigned long tiempoTranscurrido = 0;
	CLRF       main_tiempoTranscurrido_L0+0
	CLRF       main_tiempoTranscurrido_L0+1
	CLRF       main_tiempoTranscurrido_L0+2
	CLRF       main_tiempoTranscurrido_L0+3
	CLRF       main_contador_L0+0
	CLRF       main_contador1_L0+0
	CLRF       main_contador2_L0+0
	CLRF       main_contador2_L0+1
	CLRF       main_estado_L0+0
;MyProject.c,46 :: 		TRISA = 0b000000;
	CLRF       TRISA+0
;MyProject.c,47 :: 		TRISB = 0b11111111;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,48 :: 		TRISC = 0;
	CLRF       TRISC+0
;MyProject.c,51 :: 		PORTC = 0; //Puerto C inicializado en cero (display 7 segmentos).
	CLRF       PORTC+0
;MyProject.c,53 :: 		Lcd_Init(); //Inicio del LCD.
	CALL       _Lcd_Init+0
;MyProject.c,55 :: 		while (1) //Bucle infinito.
L_main0:
;MyProject.c,57 :: 		if (PORTB.F2 == 1 && contador2 <= 10) {  //Parado con condición para que solo vuelva si la velocidad es menor o igual a cero
	BTFSS      PORTB+0, 2
	GOTO       L_main4
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_contador2_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVF       main_contador2_L0+0, 0
	SUBLW      10
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main4
L__main29:
;MyProject.c,58 :: 		contador = 0;  // valor asignado al contador
	CLRF       main_contador_L0+0
;MyProject.c,59 :: 		estado = 1;    // Estado asignado
	MOVLW      1
	MOVWF      main_estado_L0+0
;MyProject.c,60 :: 		}
L_main4:
;MyProject.c,62 :: 		if (PORTB.F2 == 1 && contador2 > 10) {  //Parado con condicion para encender led azul
	BTFSS      PORTB+0, 2
	GOTO       L_main7
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_contador2_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       main_contador2_L0+0, 0
	SUBLW      10
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
L__main28:
;MyProject.c,63 :: 		PORTA.F2 =1;
	BSF        PORTA+0, 2
;MyProject.c,64 :: 		}
L_main7:
;MyProject.c,67 :: 		if (PORTB.F2 == 0) {  // Movimiento
	BTFSC      PORTB+0, 2
	GOTO       L_main8
;MyProject.c,68 :: 		contador1 = 1;
	MOVLW      1
	MOVWF      main_contador1_L0+0
;MyProject.c,69 :: 		estado = 2;
	MOVLW      2
	MOVWF      main_estado_L0+0
;MyProject.c,71 :: 		if(PORTB.F4 == 0) { //Incremente velocidad
	BTFSC      PORTB+0, 4
	GOTO       L_main9
;MyProject.c,72 :: 		contador2+=5;   //Aumento de 5 en 5km/h la velocidad
	MOVLW      5
	ADDWF      main_contador2_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       main_contador2_L0+1, 1
;MyProject.c,73 :: 		delay_ms(300);  //Retarto al presionar el boton para la simulación
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;MyProject.c,74 :: 		estado=3;       //estado asignado
	MOVLW      3
	MOVWF      main_estado_L0+0
;MyProject.c,75 :: 		if(contador2 >= 95){  //Condicion que igual la velocidad a 95km/h como máxima
	MOVLW      128
	XORWF      main_contador2_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      95
	SUBWF      main_contador2_L0+0, 0
L__main33:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;MyProject.c,76 :: 		contador2 = 95;
	MOVLW      95
	MOVWF      main_contador2_L0+0
	MOVLW      0
	MOVWF      main_contador2_L0+1
;MyProject.c,77 :: 		}
L_main11:
;MyProject.c,79 :: 		}
	GOTO       L_main12
L_main9:
;MyProject.c,80 :: 		else if(PORTB.F6 == 0){ //disminuye velocidad
	BTFSC      PORTB+0, 6
	GOTO       L_main13
;MyProject.c,81 :: 		contador2-=3;    //Decremento de 3 en 3km/h la velocidad
	MOVLW      3
	SUBWF      main_contador2_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_contador2_L0+1, 1
;MyProject.c,82 :: 		delay_ms(300);   //Retarto al presionar el boton para la simulación
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
	NOP
;MyProject.c,83 :: 		estado=4;        //estado asignado
	MOVLW      4
	MOVWF      main_estado_L0+0
;MyProject.c,84 :: 		}
L_main13:
L_main12:
;MyProject.c,86 :: 		}
L_main8:
;MyProject.c,89 :: 		if (estado == 1) { //Parado
	MOVF       main_estado_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;MyProject.c,90 :: 		PORTC = DIGITOS[contador]; //Muestra '0' en el display
	MOVF       main_contador_L0+0, 0
	ADDLW      main_DIGITOS_L0+0
	MOVWF      R0+0
	MOVLW      hi_addr(main_DIGITOS_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      0
	BTFSC      main_contador_L0+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,91 :: 		tiempoTranscurrido = 0;
	CLRF       main_tiempoTranscurrido_L0+0
	CLRF       main_tiempoTranscurrido_L0+1
	CLRF       main_tiempoTranscurrido_L0+2
	CLRF       main_tiempoTranscurrido_L0+3
;MyProject.c,93 :: 		while(tiempoTranscurrido < 15000 && PORTB.F2 == 1) {//ciclo que verifica si el estado 1 se mantiene por más de 15 segundos activo
L_main16:
	MOVLW      0
	SUBWF      main_tiempoTranscurrido_L0+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      0
	SUBWF      main_tiempoTranscurrido_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      58
	SUBWF      main_tiempoTranscurrido_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      152
	SUBWF      main_tiempoTranscurrido_L0+0, 0
L__main34:
	BTFSC      STATUS+0, 0
	GOTO       L_main17
	BTFSS      PORTB+0, 2
	GOTO       L_main17
L__main27:
;MyProject.c,94 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;MyProject.c,95 :: 		tiempoTranscurrido +=1000;
	MOVLW      232
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       main_tiempoTranscurrido_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       main_tiempoTranscurrido_L0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_tiempoTranscurrido_L0+1, 0
	ADDWF      R0+1, 1
	MOVF       main_tiempoTranscurrido_L0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_tiempoTranscurrido_L0+2, 0
	ADDWF      R0+2, 1
	MOVF       main_tiempoTranscurrido_L0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     main_tiempoTranscurrido_L0+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      main_tiempoTranscurrido_L0+0
	MOVF       R0+1, 0
	MOVWF      main_tiempoTranscurrido_L0+1
	MOVF       R0+2, 0
	MOVWF      main_tiempoTranscurrido_L0+2
	MOVF       R0+3, 0
	MOVWF      main_tiempoTranscurrido_L0+3
;MyProject.c,96 :: 		}
	GOTO       L_main16
L_main17:
;MyProject.c,97 :: 		if(PORTB.F2 == 1){  //Condición para mostrar un texto en LCD al terminar el ciclo while anterior
	BTFSS      PORTB+0, 2
	GOTO       L_main21
;MyProject.c,98 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,99 :: 		Lcd_Out(4, 1, "CAMBIARA EN MOVIMIENTO");  // Texto en LCD
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,100 :: 		}
L_main21:
;MyProject.c,103 :: 		}
L_main15:
;MyProject.c,105 :: 		if (estado == 2) {  //Movimiento
	MOVF       main_estado_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,106 :: 		PORTC = DIGITOS[contador1]; // Display muestra '1'
	MOVF       main_contador1_L0+0, 0
	ADDLW      main_DIGITOS_L0+0
	MOVWF      R0+0
	MOVLW      hi_addr(main_DIGITOS_L0+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      0
	BTFSC      main_contador1_L0+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,108 :: 		}
L_main22:
;MyProject.c,110 :: 		if (estado == 3) {  // Estado para aumentar la velocidad
	MOVF       main_estado_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;MyProject.c,111 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,112 :: 		Lcd_Out(2,1, "Velocidadlimite:60km");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,113 :: 		Lcd_Out(3,1, "Incremento");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,114 :: 		Lcd_Out(1,1, "Velocidad: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,115 :: 		IntToStr(contador2, txt); //Paso de entero a String para luego mostrarlo en LCD
	MOVF       main_contador2_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_contador2_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,116 :: 		Lcd_Out(1,12, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,119 :: 		}
L_main23:
;MyProject.c,121 :: 		if (estado == 4) {  // Estado para disminuir la velocidad
	MOVF       main_estado_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProject.c,122 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,123 :: 		Lcd_Out(2,1, "Velocidadlimite:60km");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,124 :: 		Lcd_Out(3,1, "Decremento");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,125 :: 		Lcd_Out(1,1, "Velocidad: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,126 :: 		IntToStr(contador2, txt); //Paso de entero a String para luego mostrarlo en LCD
	MOVF       main_contador2_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_contador2_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,127 :: 		Lcd_Out(1,12, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,128 :: 		}
L_main24:
;MyProject.c,132 :: 		if(contador2 > 60){ // Condicion si la velocidad supera los 60km/h encienda led rojo
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_contador2_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVF       main_contador2_L0+0, 0
	SUBLW      60
L__main35:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;MyProject.c,133 :: 		PORTA.F3 =1;
	BSF        PORTA+0, 3
;MyProject.c,134 :: 		}else{
	GOTO       L_main26
L_main25:
;MyProject.c,135 :: 		PORTA.F3 =0;
	BCF        PORTA+0, 3
;MyProject.c,136 :: 		}
L_main26:
;MyProject.c,139 :: 		}
	GOTO       L_main0
;MyProject.c,140 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
