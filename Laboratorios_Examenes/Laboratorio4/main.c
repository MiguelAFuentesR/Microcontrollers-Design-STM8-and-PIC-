//1.SECCION DE DOCUMENTACION


// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO


#include "iostm8s105.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 3.VARIABLES Y FUNCIONES GLOBALES 
void configurarGPIO(void);

//Funciones Pantalla
void EnviarNibbleLCD(char nibble);
void EnviarComandoLCD(char a);
void LimpiarLCD(void);
void PonerCursorLCD(char a, char b);
void IniciarLCD(void);
void ImprimirCharLCD(char data);
void ImprimirCadenaLCD(char *a);
void ConfiguracionInterrupcion(void);
//Funciones Timer
void Timer4_Init(void);
void delay_us(int tiempo);
void delay_ms(int tiempo);



double conteo=0; 
char stringconteo[20];


int pulsos=0;
int contadorpulsos=0;
double contarRPM=0;

double muestra1,muestra2,muestra3,muestra4,muestra5=0;


//4.IMPLEMENTACION DE LAS FUNCIONES 
main()
{
	configurarGPIO();
	ConfiguracionInterrupcion();
	Timer4_Init(); 
	IniciarLCD();
	LimpiarLCD(); //con el comando clear
	
	while (1){
	//PD6 para pruebas de timer 
	/*
	PD_ODR |= 0x40; //Enciende led 
	delay_ms(1000);
	PD_ODR &= ~0x40; //Apaga led
	delay_ms(1000);
	*/
	
	LimpiarLCD();
	//PonerCursorLCD(1,1); //coordenada 1,1
	//ImprimirCadenaLCD("Hola Mundo STM8!  ");
	//PonerCursorLCD(1,13); //coordenada 1,13
	//ImprimirCharLCD(161);
	delay_ms(10);
	

	while(1){
		if (contadorpulsos<=20){
			muestra1=contarRPM;
			delay_ms(100);
			muestra2=contarRPM;
			delay_ms(100);
			muestra3=contarRPM;
			delay_ms(100);
			muestra4=contarRPM;
			delay_ms(100);
			muestra5=contarRPM;
		}
		delay_ms(100);
		//conteo=contarRPM;
		conteo = (muestra1 + muestra2 + muestra3 +muestra4 +muestra5)/5;
		PonerCursorLCD(1,1); //coordenada 1,1
		ImprimirCadenaLCD("El motor gira a:");
			//de la 1 a la 7 se muestran rpm
		PonerCursorLCD(2,1);
    sprintf(stringconteo,"%d.%02u", (int) conteo, (int) ((conteo - (int) conteo ) * 100) );
		ImprimirCadenaLCD(stringconteo);
		PonerCursorLCD(2,7); //coordenada 1,13
		ImprimirCadenaLCD(" RPM");
		delay_ms(500);
		contadorpulsos =0 ; 
		//delay_ms(500);
		
	}
	conteo=0;
			muestra1 =0;muestra2 =0;muestra3 =0;muestra4 =0;muestra5 =0;

	}
}

//Programamos la interrupcion
void ConfiguracionInterrupcion(){
//1. Deshabilitamos las interupciones globales 
	#asm
	sim
	#endasm
//2.Configurar los pines como entrada digital
	PC_ODR = 0x00;
	PC_DDR &= ~0x02;//PC1 como entrada
	
//3.Configuramos el tipo de flanco como bajada
	EXTI_CR1 |= 0x20;
	EXTI_CR1 &= ~0x10;
//4.Configuramos los pines como interrupcion externa
	PC_CR1 &= ~0x02;// Pin flotante
	//Pin con interrupcion eterna
	PC_CR2 |= 0x02;
//5.Configuramos la prioridad de la fuente de interrupci�n
	ITC_SPR2 |= 0x0C;
//6.Activamos todas las itnerrupciones
	#asm
	rim
	#endasm
}

@far @interrupt void EXTI2_IRQHandler(){
	contadorpulsos++; 
	contarRPM = contadorpulsos*3;
	//contarRPM = contadorpulsos*1.875;

}

void configurarGPIO(){
	
	//1. Limpiamos los latch de salida puerto B,C,D
	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
	
	
	PC_DDR &= ~0xFF;//Todo El registro en 0 para entradas
	
	PD_DDR |= 0x78;// Bits 6,5,4,3 en 1 para salidas
	PB_DDR |= 0x03; // Bits 1,0 en 1 para salidas
	
	//3. Pines de entrada en configuracion pull-up:
	
 	PC_CR1 &= ~0xFF;//Entradas como flotantes , todo en 0
	
	//Salidas push pull

	PD_CR1 |= 0x78; //Salidas push pull , se colocan en 1
	PB_CR1 |= 0x03; //Salidas push pull , se colocan en 1

//Pines con interrupcion externa(Colocar bit en 1)
	PC_CR2 |= 0xFF;
	}
	
void EnviarNibbleLCD(char nibble){ //los pines para enviar datos son D0-D3

/* leyendo o validando estado de bit 0 */
	if(nibble & 0x01){ 
	
		PD_ODR |= 0x08; //PD3=D4 se le envia 1
		
	}else{
 		PD_ODR &= ~0x08; //PD3=D4 se le envia 0
		
	}
	
 /* leyendo o validando estado de bit 1	*/
	if(nibble & 0x02){
		
		PD_ODR |= 0x10; // PD4=D5 se le envia 1
		
	}else{
 		PD_ODR &= ~0x10; //PD4=D5 se le envia 0
		
	}
	
/* leyendo o validando estado de bit 2	*/
	if(nibble & 0x04){ 
	
		PD_ODR |= 0x20; // PD5=D6 se le envia 1
		
	}else{
	
 		PD_ODR &= ~0x20; //PD5=D6 se le envia 0
		
	}
/* leyendo o validando estado de bit 3 */
	if(nibble & 0x08){ 
	
		PD_ODR |= 0x40; // PD6=D7 se le envia 1
		
	}else{

 		PD_ODR &= ~0x40; //PD6=D7 se le envia 0
	}
}
	
void EnviarComandoLCD(char a){

// este comando es de 4 bits 
	PB_ODR &= ~0x01; // RS=0 es decir PB0=0 para envio de comandos
	EnviarNibbleLCD(a); //envio del dato deseado
	PB_ODR |= 0x02; //EN=1 es decir PB1 = 1 ; inicia transmision
	delay_ms(4); // delay para no preguntar por el estado BF de la LCD
	PB_ODR &= ~0x02; // EN=0 es decir PB1 = 0 ; cierra transmision 
}	


void IniciarLCD(){
	//para iniciar LCD ir a algoritmo de fig 24 del datasheet del hd44780 
//1. delay inicial de minimo 15ms despues de power on con vcc por encima de 4,5V
	delay_ms(30);
	
	EnviarComandoLCD(0x03); // RS  R/W~ DB7 DB6 DB5 DB4   segundo paso de algoritmo
 	                        //  0   0    0   0   1   1	
	delay_ms(5);           // delay de minimo 4,1ms
	EnviarComandoLCD(0x03); //cuarto paso de algoritmo set DB5 y DB4
	delay_ms(11);         //delay de minimo 100us
	EnviarComandoLCD(0x03); // sexto paso set DB5 y DB4
	EnviarComandoLCD(0x02); // indicar LCD manejo de modo de 4 bits
													//en este punto se empiezan a hacer transmisiones de a 4 bits

	//comando function set
	EnviarComandoLCD(0x02); // DL=0 de function set
	EnviarComandoLCD(0x08); // N=1, F=0 de function set

	//comando display on/off control 
	EnviarComandoLCD(0x00);
	EnviarComandoLCD(0x0C); //D=1 (display on), C=0 (cursor off), B=0 (titilar off) 
	
	//comando entry mode set (poner cursor en 1,1) 
	EnviarComandoLCD(0x00);
	EnviarComandoLCD(0x06); // I/D=1
}

void LimpiarLCD(){
  EnviarComandoLCD(0);// bits mas significativo
	EnviarComandoLCD(1);// bits menos significativos
}


void PonerCursorLCD(char a, char b){
	
	char temp,z,y;
	if(a == 1)
	{
		temp = 0x80 + b - 0x01; //80h
	}
	else if(a == 2)
	{
		temp = 0xC0 + b - 1; //C0h
	}
	z = temp >> 4;
	y = temp & 0x0F;
	EnviarComandoLCD(z);
	EnviarComandoLCD(y);
}

void ImprimirCharLCD(char data){
	char Lower_Nibble,Upper_Nibble;
	Lower_Nibble = data & 0x0F; // leer los primeros 4 bits
	Upper_Nibble = data & 0xF0; // leer los segundos 4 bits
	PB_ODR |= 0x01;	                    //PB0=RS=1 para envio de datos 
	EnviarNibbleLCD(Upper_Nibble >> 4); //envia el MSB nibble
	PB_ODR |= 0x02;	                      // PB1=EN=1
	delay_ms(1);                      //delay para evitar polling de BF
	PB_ODR &= ~0x02;                      // PB1=EN=0
	EnviarNibbleLCD(Lower_Nibble);      //envia el LSB nibble
	PB_ODR |= 0x02;                       // PB1=EN=1
	delay_ms(1);                      //delay para evitar polling de BF
	PB_ODR &= ~0x02;                      // PB1=EN=0
}

void ImprimirCadenaLCD(char *a){
	int i;
	for(i=0;a[i]!='\0';i++){
		ImprimirCharLCD(a[i]); 
	}	//se usa funcion de imprimir un caracter
}


// Funcion para inicializar el temporizador4 :

void Timer4_Init(){
	
//Funcionamiento : 

// Se proporciona un valor para el preescalador  
	TIM4_PSCR = 0x01; 

//Se proporciona un valor de recarga automatica
	TIM4_ARR  = 0xFF;
		
	TIM4_CR1  = 0x00; //Resetear control de registro
	 
//Se modifica bit2 URS:fuente de solicitud de actualizacion
	 //se env�a una solicitud de interrupci�n de actualizaci�n
	 //solo cuando el contador llega al desbordamiento
	TIM4_CR1  |= 0x04; 
	 
//Generacion de evento de registro : 

// UG=1
//Reinicializa el contador y genera una actualizaci�n de los
//registros, el contador del prescaler tambi�n se borra. 
	TIM4_EGR  = 1; 
	

	TIM4_CNTR = 0x00;	//Se pone en 0 el contador

//Se Modifica UIE = 0 para indicar que se antendieron los eventos
	TIM4_IER &= ~0x01; 
}


void delay_us(int tiempo){
/*
Esta funcion permite generar delays de 0 a 255 microseg
Funcionamiento : 
Habilita el temporizador por medio de la configuracion del
bit 0 del registro CR1, luego se espera a que CNTR alcance 
el conteo necesario , luego se deshabilita el temporizador 
borrando nuevamente el bit 0 del registro CR1. 
*/

TIM4_EGR |= 0x01; 
TIM4_CNTR = 0x00;	//Se pone en 0 el contador

//Modificando CEN = 1 , para activar contador 
TIM4_CR1 |= 0x01;
	
	while(TIM4_CNTR<tiempo){
		TIM4_CR1 &= 0x01;
	}
	//Actualizar la bandera del evento  ,
	//Se modifica el Bit UIF=0 
	TIM4_SR  &= 0x01;
}
void delay_ms(int tiempo){
/*
Funcionamiento : 
Se realiza un ciclo while en donde se realice a partir de delays de us 
*/
	tiempo=tiempo*10;
	while(tiempo--){
	delay_us(100);
	}
}