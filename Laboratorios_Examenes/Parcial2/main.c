//1.SECCION DE DOCUMENTACION


// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO
#include "iostm8s105.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

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

void MensajePantallaAnguloSiguiente(double angulosiguiente);
void MensajePantallaAnguloActual(double angulo);
void MensajePantallaVelocidad(void);
//Funciones Timer
void Timer4_Init(void);
void delay_us(int tiempo);
void delay_ms(int tiempo);

//Funciones Interrupciones

void ConfigurarInterrupciones(void);

//Funciones Motor 
void CambioVelocidad(void);
void FSM_Init(void);
void GiroPositivo(void);
void GiroNegativo(void);


//Para la maquina de estados
struct Estado{
	unsigned int SalidaMotor;
	unsigned int tiempo;
	unsigned int next[2];
};
	typedef struct Estado tipoEst;
	tipoEst FSM[8];//Cantidad estados
	int in=0; //Toma el valor de la entrada
	int es=0; //estado actual

/*------------------VARIABLES ---------------------*/

//Mostrar Pantalla

double anguloinicial=0; 
double angulodeseado=0; 
double angulo=0;
double angulosiguiente=0;

int velocidadgrad=0; 
char stringAnguloinicial[16];
char stringAngulodeseado[16];
char stringVelocidad[16];

// Interrupciones 

int InicioGiro=0;
int desplazamientoneg=0;
int desplazamientopos=0;


//Motor
int contadorgirosnegativos=0;
int contadorgirospositivos=0;

#define Estado1 0;
#define Estado2 1;
#define Estado3 2;
#define Estado4 3;
#define Estado5 4;
#define Estado6 5;
#define Estado7 6;
#define Estado8 7;

//Control Velocidad
int bit0=0;
int bit1=0;

double pasos=0;
int actualizar=0;
double Velocidadpantalla =0;
main()
{
	configurarGPIO();
	ConfigurarInterrupciones();
	Timer4_Init();
	FSM_Init();
	IniciarLCD();
	LimpiarLCD(); //con el comando clear
	delay_ms(10);
	
	while (1){
	CambioVelocidad();
	FSM_Init();
	
	
	bit0=(PC_IDR&0x10)>>4;//PC4
	bit1=(PC_IDR&0x20)>>5;//PC5
	InicioGiro=(PC_IDR&0x08)>>3;//PC3 control inicio movimiento
	
	
	// Fijo 
	PonerCursorLCD(1,1); //coordenada 1,1	
	ImprimirCadenaLCD("Act:");
	PonerCursorLCD(2,1); //coordenada 1,7
	ImprimirCadenaLCD("Des:");
	PonerCursorLCD(1,11); //coordenada 1,13	
	ImprimirCadenaLCD("Velo:");
	
	
	
	while(actualizar){
		MensajePantallaAnguloSiguiente(angulodeseado);
		delay_ms(1500);
		actualizar=0;
	}
				if(anguloinicial==angulodeseado){
						angulodeseado=0;
						contadorgirospositivos=0;
						contadorgirosnegativos=0;
						MensajePantallaAnguloSiguiente(angulodeseado);
						
		}
		delay_ms(10);
		MensajePantallaAnguloActual(anguloinicial);
		MensajePantallaAnguloSiguiente(angulodeseado);
		MensajePantallaVelocidad();
	
	
	if(InicioGiro){

			if(angulodeseado<0){
			//Realizar Giro de -2 (rotar hacia la derecha en sentido horario)
				desplazamientoneg = abs((contadorgirosnegativos*2)+anguloinicial)/2; //#Numero de ciclos de la FSM
				
				while(desplazamientoneg>0){
				
					if(angulodeseado<anguloinicial){
						
						GiroPositivo();// giro horario
						anguloinicial=anguloinicial-2;
							
					}else if(angulodeseado>anguloinicial) {
						
						GiroNegativo();// giro antihorario
						anguloinicial=anguloinicial+2;	
													
				}
					desplazamientoneg--;	
					MensajePantallaAnguloActual(anguloinicial);	
				}
				
	// DESPLAMIENTO  DE +2 GRAD
			}else if (angulodeseado>0){
				//Realizar Giro de +2 (rotar hacia la izquierda en sentido antihorario)
		desplazamientopos = abs(anguloinicial-(contadorgirospositivos*2))/2; //#Numero de ciclos de la FSM
				while(desplazamientopos>0){
				
					if(angulodeseado<anguloinicial){
						
						GiroPositivo();// giro horario
						anguloinicial=anguloinicial-2;
							
					}else if(angulodeseado>anguloinicial) {
						
						GiroNegativo();// giro antihorario
							anguloinicial=anguloinicial+2;	
													
				}
					desplazamientopos--;	
					MensajePantallaAnguloActual(anguloinicial);	
					
				}
			}
	
	}
	else{
	PB_ODR &= ~0x02;
	}
	
		
	}
}

void FSM_Init(void){
	FSM[0].SalidaMotor=0x02;//Encender BobinaA  0001 0 
	FSM[0].tiempo=velocidadgrad;
	FSM[0].next[0]=Estado2;
	FSM[0].next[1]=Estado8;
	
	FSM[1].SalidaMotor=0x06;//Encender BobinaAyB  0011 0 
	FSM[1].tiempo=velocidadgrad;
	FSM[1].next[0]=Estado3;
	FSM[1].next[1]=Estado1;
	
	FSM[2].SalidaMotor=0x04;//Encender BobinaB  0010 0 
	FSM[2].tiempo=velocidadgrad;
	FSM[2].next[0]=Estado4;
	FSM[2].next[1]=Estado2;
	
	FSM[3].SalidaMotor=0x0C;//Encender BobinaByC 0110 0
	FSM[3].tiempo=velocidadgrad;
	FSM[3].next[0]=Estado5;
	FSM[3].next[1]=Estado3;
	
	FSM[4].SalidaMotor=0x08;//Encender BobinaC 0100 0
	FSM[4].tiempo=velocidadgrad;
	FSM[4].next[0]=Estado6;
	FSM[4].next[1]=Estado4;
	
	FSM[5].SalidaMotor=0x18;//Encender BobinaCyD 1100 0
	FSM[5].tiempo=velocidadgrad;
	FSM[5].next[0]=Estado7;
	FSM[5].next[1]=Estado5;
	
	FSM[6].SalidaMotor=0x10;//Encender BobinaD 1000 0
	FSM[6].tiempo=velocidadgrad;
	FSM[6].next[0]=Estado8;
	FSM[6].next[1]=Estado6;
	
	FSM[7].SalidaMotor=0x12;//Encender BobinaDyA  1001 0
	FSM[7].tiempo=velocidadgrad;
	FSM[7].next[0]=Estado1;
	FSM[7].next[1]=Estado7;
	//Estado inicial
	es=Estado1;
	}

void MensajePantallaAnguloActual(double angulo){

if(abs(angulo)<10){
		PonerCursorLCD(1,7);
		ImprimirCadenaLCD(" ");
		}else if(abs(angulo)<100){
		PonerCursorLCD(1,8);
		ImprimirCadenaLCD(" ");
		}
	if(angulo<0){
sprintf(stringAnguloinicial,"%d", (int) abs(angulo), (int) ((abs(angulo) - (int) abs(angulo) ) * 100) );
	PonerCursorLCD(1,5); 
	ImprimirCharLCD(45);// Imprimir - 
	PonerCursorLCD(1,6); 
	ImprimirCadenaLCD(stringAnguloinicial);
	PonerCursorLCD(1,9); 
	ImprimirCharLCD(223); //Imprimir grados 1101 1111
	}else{
sprintf(stringAnguloinicial,"%d", (int) angulo, (int) ((angulo - (int) angulo) * 100) );
	PonerCursorLCD(1,5); 
	ImprimirCharLCD(43);// Imprimir + 
	PonerCursorLCD(1,6); 
	ImprimirCadenaLCD(stringAnguloinicial);
	PonerCursorLCD(1,9); 
	ImprimirCharLCD(223); //Imprimir grados 1101 1111
	}

}

void MensajePantallaAnguloSiguiente(double angulosiguiente){

		if(abs(angulosiguiente)<10){
		PonerCursorLCD(2,7); //9 antes 
		ImprimirCadenaLCD(" ");
		}else if(abs(angulosiguiente)<100){
		PonerCursorLCD(2,9);//10 antes
		ImprimirCadenaLCD(" ");
		}
	if(angulosiguiente<0){
	sprintf(stringAngulodeseado,"%d", (int) abs(angulosiguiente), (int) ((abs(angulosiguiente) - (int) abs(angulosiguiente) ) * 100) );
	PonerCursorLCD(2,5);  //7 antes
	ImprimirCharLCD(45);// Imprimir - 
	PonerCursorLCD(2,6); //8 antes
	ImprimirCadenaLCD(stringAngulodeseado);
	PonerCursorLCD(2,9); //11 antes
	ImprimirCharLCD(223); //Imprimir grados 1101 1111
	}else{
	sprintf(stringAngulodeseado,"%d", (int) angulosiguiente, (int) ((angulosiguiente - (int) angulosiguiente ) * 100) );
	PonerCursorLCD(2,5); 
	ImprimirCharLCD(43);// Imprimir + 
	PonerCursorLCD(2,6); 
	ImprimirCadenaLCD(stringAngulodeseado);
	PonerCursorLCD(2,9); 
	ImprimirCharLCD(223); //Imprimir grados
	}

}
void MensajePantallaVelocidad(){

	// Variable
sprintf(stringVelocidad,"%d.%02u", (int) Velocidadpantalla, (int) ((Velocidadpantalla - (int) Velocidadpantalla) * 100) );
	

	PonerCursorLCD(2,10); 
	ImprimirCadenaLCD(stringVelocidad);
	PonerCursorLCD(2,14);
	ImprimirCharLCD(223); //Imprimir grados 1101 1111
	PonerCursorLCD(2,15);
	ImprimirCadenaLCD("/s");
	
}

void configurarGPIO(){
	
	//1. Limpiamos los latch de salida puerto B,C,D
	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
	
/*Puerto C como entrada 
	PC6 = -2°  
	PC5=bit1 
	PC4=bit0
	PC3 = Control Inicio giro

*/
	/*Puerto D como salidas 
	PD6 = D7
	PD5 = D6
	PD4 = D5
	PD3 = D4
	PD2 = RS
	PD0 = EN
	*/
	
	/*
	Puerto B como salidas 
	PB1 = A = IN1
	PB2 = A = IN2
	PB3 = A = IN3
	PB4 = A = IN4
	
	Puerto B como entrada 
	
	PB0= +2°
	
	

	*/
	
	//Entradas 
	PC_DDR &= ~0x78;//Bit 6,5,4,3 en 0
	PB_DDR &= ~0x01;//Bit 0 en 0
	
	//Salidas
	PD_DDR |= 0x7D;// Bits 6,5,4,3,2,0 en 1 para salidas
	PB_DDR |= 0x1E; // Bits 1,2,3,4 en 1 para salidas
	
	
	//3. Pines de entrada en configuracion pull-up:
	
 	PC_CR1 &= ~0x78;//Entradas como flotantes , todo en 0
	PB_CR1 &= ~0x01;//Entradas como flotantes 
	
	//Salidas push pull

	PD_CR1 |= 0x7D; //Salidas push pull , se colocan en 1
	PB_CR1 |= 0x1E; //Salidas push pull , se colocan en 1


	
	}
	
	
	//CAMBIO VELOCIDAD 
	
void CambioVelocidad(){
			
	if(bit1==0 && bit0==0){
		 velocidadgrad=10;
	}
	if(bit1==0 && bit0==1){
		velocidadgrad=20;
	}
	if(bit1==1 && bit0==0){ 
		velocidadgrad=40;
	}
	if(bit1==1 && bit0==1){
		velocidadgrad=80;
	}
	Velocidadpantalla=86.95652174/velocidadgrad;
	//1/((10*10^-3*(#pasos/2)))/tiempo deseado
	
	}
	
void GiroNegativo(){
	//Giro derecha , giro de -2 
	pasos=0;	
	while(pasos<23){
	PB_ODR=FSM[es].SalidaMotor;
	delay_ms(FSM[es].tiempo);
	es=FSM[es].next[0];
	pasos=pasos+1;
	}
}

void GiroPositivo(){
	//Giro izquierda , giro de +2 
	pasos=0;
	while(pasos<23){
	PB_ODR=FSM[es].SalidaMotor;
	delay_ms(FSM[es].tiempo);
	es=FSM[es].next[1];
	pasos=pasos+1;
	}		
}
	
	//INTERRUPCIONES 
	
@far @interrupt void EXTI1_IRQHandler(){
	//Interrupcion PB0 giro +2 
	if(angulodeseado<300){
	contadorgirospositivos++;
	actualizar=1;
	angulodeseado=angulodeseado+2; 
	}	
}

@far @interrupt void EXTI2_IRQHandler(){
	//Interrupcion PC6 giro -2 
	
	if(angulodeseado>-270){
		actualizar=1;
		contadorgirosnegativos++;
		angulodeseado= angulodeseado-2;
	}	
	
}
//Configurar interrupción para el interruptor1(+2°)
void ConfigurarInterrupciones(){
	//PC6  -2
	//PB0  +2
	
	//1. Deshabilitamos las interupciones globales 
	#asm
	sim
	#endasm
	
//2. Limpiar los latch de salida de los pines
	
	PC_ODR &= ~0x40;//PC6
	PB_ODR &= ~0x01;//PB0

// 3. Ambos puertos como entradas digitales
	PC_DDR &= ~0x40;
	PB_DDR &= ~0x01;
	
//4.Configuramos el tipo de flanco 

/*
Configura PBIS[1:0] ,bit 3 y 2-Interrupcion PORTB
Configura PCIS[1:0] ,bit 5 y 4-Interrupcion PORTB
*/
	EXTI_CR1 |= 0x14; 
	EXTI_CR1 &= ~0xEB; 

//5.Configuramos los pines como interrupcion externa
	PB_CR1 &= ~0x01;// Pin flotante	
	PC_CR1 &= ~0x40;// Pin flotante
	
	//Pin con interrupcion eterna
	PB_CR2 |= 0x01;
	PC_CR2 |= 0x40;
	
//6.Configuramos la prioridad de la fuente de interrupción
//PC prioridad 2 , PB prioridad 3 , PE-PD prioridad 0
	ITC_SPR2 |= 0xA3;
	ITC_SPR2 &= ~0x5C;
	
//7.Activamos todas las interrupciones
	#asm
	rim
	#endasm
}
	
	
	
	
	
	
	//FUNCIONES DE LA PANTALLA 
	
	
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
	PD_ODR &= ~0x04; // RS=0 es decir PD2=0 para envio de comandos
	EnviarNibbleLCD(a); //envio del dato deseado
	PD_ODR |= 0x01; //EN=1 es decir PD0 = 1 ; inicia transmision
	delay_ms(4); // delay para no preguntar por el estado BF de la LCD
	PD_ODR &= ~0x01; // EN=0 es decir PD0 = 0 ; cierra transmision 
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
	PD_ODR |= 0x04;	                    //PD2=RS=1 para envio de datos 
	EnviarNibbleLCD(Upper_Nibble >> 4); //envia el MSB nibble
	PD_ODR |= 0x01;	                      // PD0=EN=1
	delay_ms(1);                      //delay para evitar polling de BF
	PD_ODR &= ~0x01;                      // PD0=EN=0
	EnviarNibbleLCD(Lower_Nibble);      //envia el LSB nibble
	PD_ODR |= 0x01;	                      // PD0=EN=1
	delay_ms(1);                      //delay para evitar polling de BF
	PD_ODR &= ~0x01;                         // PD0=EN=0
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
	 //se env?a una solicitud de interrupci?n de actualizaci?n
	 //solo cuando el contador llega al desbordamiento
	TIM4_CR1  |= 0x04; 
	 
//Generacion de evento de registro : 

// UG=1
//Reinicializa el contador y genera una actualizaci?n de los
//registros, el contador del prescaler tambi?n se borra. 
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