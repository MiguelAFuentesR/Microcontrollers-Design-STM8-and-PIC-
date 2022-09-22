//1.SECCION DE DOCUMENTACION
// se desea implementar un codigo en el 
// microcontrolador STM8S105K4 que permita
// controlar el sentido de giro y la velocidad
// de un motor DC, adicionalmente con el protocolo
// de comunicacion UART enviar los datos a un computador 
// para graficar el movimiento del joystick en 
// una terminal de MATLAB (Grafica XY)

// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO

// se implementan las siguientes librerias
#include "iostm8s105.h"
#include "STM8S.h"
#include "stm8s_adc1.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>



// 3.VARIABLES Y FUNCIONES GLOBALES 

// se implementan las siguientes funciones 

//Funcion de Entradas y Salidas Digitales
void configurarGPIO(void);

//Funciones del ADC
unsigned int Leer_ADC(int Pin);
void ControlDistancia(void);

//Funciones del Timer
void Timer4_Init(void);
void delay_us(int tiempo);
void delay_ms(int tiempo);

//Funciones de control Motor
void CambiarSentido_Motor(void);
void ControlVelocidad_Motor2(void);
void ControlVelocidad_Motor(int Duty,int Incremento);
void PWM_Init(void);


//Funciones de protocolo UART
void UART_TX(unsigned char val);
void EnviarCadena(unsigned char *a);
void EnviarDatos(double Valor);
void UART_Init(void);
void Transmision(void);

//---------------------------------------------------
// se implementan las siguientes Variables

//Variables PWM
signed int pwm_duty = 0;
int Duty,Frecuency = 0;
int Duty,Incremento=0;
int CicloInicial =0;

//Variables de control Motor
int Sentido = 0; 
int delay = 0; 

//Variables del ADC
double Vx=0;
double Vy=0;
double ADC_x = 0;
double ADC_y = 0;
double Centrox,Centroy =0 ;
double Distancia=0;
// ciclo util inicial (22%) de PWM
int calibracion = 220; 

//Variables UART
//arreglo que controla [coma,salto de linea]
//en codigo ASCII
unsigned char comando[2]={10,44};


//4.IMPLEMENTACION DE LAS FUNCIONES 
main()
{
	//se inicializan las funciones 
	configurarGPIO();
	Timer4_Init();
	//PWM 
	PWM_Init();
	//UART
	UART_Init();
	
	while (1){
	//Lectura Valores ADC
	
		ADC_x = Leer_ADC (0);
		ADC_y = Leer_ADC (1);
		//conversión de lectura de ADC  
		//a Voltaje asosiado en X e Y
		Vx = (ADC_x *3.3)/1023;
		Vy = (ADC_y *3.3)/1023;
	
	//Calculo de la Distancia
		// inicialmente se deja el joystick quieto y se
		// anota el valor leido del adc en X e Y
		Centrox = 502;
		Centroy = 513;
		// la formula de distancia es [(ADC_x)^2+(ADC_y)]^(1/2)
		//para determinal el punto leido en el lugar donde se 
		//encuentra el Joystick
		Distancia = sqrt(pow(ADC_x-Centrox, 2) + pow(ADC_y-Centroy, 2));

	//se evalua si el joystick se encuentra en los cuadrantes 1,2 o 3,4
	//si se encuentra en los cuadrantes 1,2 el motor gira en sentido antihorario
	//si se encuentra en los cuadrantes 3,4 el motor gira en sentido horario
	if(ADC_x >= Centrox && ADC_x <= 1023){
		//Giro derecha  max 1023 , min 513 
		Sentido = 0;
	}else{
		//if( ADC_y >= 0 && ADC_y <= Centroy)
		//Giro Izquierda  max 513 , min 0
		Sentido = 1;
	}
		//se evalua la posicion inicial con un minimo 
		//rango para que no todo el tiempo envie datos
		//y se llene innecesariamente de datos el PC
		if (Distancia>10){
		Transmision();
		}
		//el ciclo util sera el valor medido en el ADC
		// mas el valor de calibracion que es de 22% inicial
		Duty=Distancia + calibracion; 
		CambiarSentido_Motor();
		ControlVelocidad_Motor2();
	}
}

void Transmision(void){
	// se evalua si el bit 6 del registro UART2_SR es 1
	// determinando que se termino la transmision de los 
	//datos
	if (UART2_SR & (1 << 5)) {
		EnviarDatos(ADC_x);
		//envia un salto de linea
		UART_TX(comando[1]);
		EnviarDatos(ADC_y);
		//envia una coma
		UART_TX(comando[0]);
    }
}


void UART_Init(void){
  CLK_PCKENR1 = 0xFF;  // Activar todos los perifericos 
	//Configurar el baud rate en 9600 Baudios
	//Para 2Mhz/9600 = 208 
	
	//208--> 000000000 11010000
	//	  0x00       0xD0
	//	0x00D0
	//    0x0D    0x0 | 0x0
	// |||||||||  |||||||||
	// 7	   0  7       0
	// UART_BRR1  UART_BBR2
  UART2_BRR2 = 0x00;
  UART2_BRR1 = 0x0D;  
	//1 STOP BIT
  UART2_CR3 &= ~((1 << 4) | (1 << 5)); 
	//Se activa transmision y Recepcion bit2 y 3 
  UART2_CR2 |= (1 << 2)| (1 << 3); 

}

// se crea un string de 6 posiciones, 3 para el valor entero, 2 para los valores 
// decimales y 1 para la coma, ej: 526,12
unsigned char StringValor[6];
void EnviarDatos(double Valor){
	// %d.%02u significa double con 2 decimales
	sprintf(StringValor,"%d.%02u", (int) Valor, (int) ((Valor - (int) Valor) * 100) );
	EnviarCadena(StringValor);
}
// esta funcion recorre el string y envia al UART para que lo 
// convierta a formato de 8Bits
void EnviarCadena(unsigned char *a){
	//se usa funcion de imprimir un caracter
	int i;
	for(i=0;a[i]!='\0';i++){
		UART_TX(a[i]); 
	}	
}
// mientras el bit 6 de UART2_SR sea distinto de 1 
// se realiza transmision de datos
void UART_TX(unsigned char val) {
  UART2_DR = val;
  while (!(UART2_SR & (1 << 6)));
}
// mientras el bit 6 de UART2_SR sea distinto de 1 
// se realiza transmision de datos
void Enviar_DatosUART(unsigned char valor){
	UART2_DR = valor; 
	 while (!(UART2_SR & (1 << 6)));
}

void PWM_Init(void){
	//se resetea el periferico 
	GPIO_DeInit(GPIOD);
	// se inicializa el timer y GPIO
	TIM2_DeInit();
	GPIO_Init(GPIOD,GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_FAST);

	//Valor hasta el que cuenta 
	// Ciclo Util CCR1H,L => 1000 =  3E8 
	TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000,TIM2_OCPOLARITY_HIGH);
									 
	//Para frecuencia de 1 kHz ; 2MHz/1Khz = 2000
	//Para frecuencia de 2 kHz ; 2MHz/2Khz = 1000
	TIM2_TimeBaseInit(TIM2_PRESCALER_1, 1000);
	//bit CEN=1 habilita contador
	TIM2_CR1 |= 0x01;
}

unsigned int Leer_ADC(int Pin)
 {
   unsigned int conversion = 0;
	//se resetea el periferico
	 ADC1_DeInit();
	// se configura el pin AIN0 es decir PB0
	// como entrada del ADC para leer Vx
	 if (Pin == 0){
	//inicializa el ADC
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS,
                 ADC1_CHANNEL_0,
                 ADC1_PRESSEL_FCPU_D2,
                 ADC1_EXTTRIG_GPIO,
                 DISABLE,
                 ADC1_ALIGN_RIGHT,
                 ADC1_SCHMITTTRIG_CHANNEL0,
                 DISABLE);
	// se configura el pin AIN1 es decir PB1
	// como entrada del ADC para leer Vy
	}else if (Pin == 1){
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS,
                 ADC1_CHANNEL_1,
                 ADC1_PRESSEL_FCPU_D2,
                 ADC1_EXTTRIG_GPIO,
                 DISABLE,
                 ADC1_ALIGN_RIGHT,
                 ADC1_SCHMITTTRIG_CHANNEL0,
                 DISABLE);
	}
	ADC1_Cmd(ENABLE);
	ADC1_StartConversion();
	while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);                    
  conversion = ADC1_GetConversionValue();
  ADC1_ClearFlag(ADC1_FLAG_EOC);
	ADC1_DeInit();
	return conversion; 
 }
void CambiarSentido_Motor(void){
	//si sentido=1 gira en sentido horario,si sentido=0 gira en sentido antihorario
	if(Sentido){
		//Motor Giro Derecha (Horario) IN1=PC7=1 ; IN0=PC6=0
		PC_ODR |= 0x80;
		PC_ODR &= ~0x40;
	}else{
	//Motor Giro Izquierda (AntiHorario) IN1=PC7=0 ;IN0=PC6=1
		PC_ODR &= ~0x80;
		PC_ODR |= 0x40;
	}
	
}
void ControlVelocidad_Motor(int Duty,int Incremento){
// si el valor leido es mayor al actual aumenta a una taza de Incremento
//esto se hace con un delay de captura de 10ms
		//Ciclo Ascenso
for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
	// loop through 
      TIM2_SetCompare1(pwm_duty); //set capture compair for Timer2
      delay_ms(delay); //delay for 10ms
}
// si el valor leido es menor al actual disminuye a una taza de Incremento
//esto se hace con un delay de captura de 10ms		
  //CICLO DESCENSO
for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
      TIM2_SetCompare1(pwm_duty);
			delay_ms(delay);
    }
}

void ControlVelocidad_Motor2(){
		//se establece la captura de comparacion con el timmer2
      TIM2_SetCompare1(Duty); 
      delay_ms(delay); //delay 
}


void configurarGPIO(){
	
	//1. Limpiamos los latch de salida puerto B,C,D
	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
/*
	2. 

		Entradas :
		(1) ADC
		*PB_0 = Joystick Ejex 
		*PB_1 = Joystick Ejey 	
		
		Salidas : 
			MOTOR :
		(3),(4)
		
		*PC_2 = PWM
		*PC_6 = IN_2 en modulo LM298
		*PC_7 = IN_1 en modulo LM298
		
	*/
	
	PB_DDR &= ~0x03;//Bits 0,1 en 0 para entradas Analogicas
	
	PC_DDR |= 0xC4;// Bits 2,6,7 en 1 para salidas 1100 0100
	
	//PD_DDR |= 0x60;// Bits 5,6 en 1 para salidas UART

	
	
	//3. Pines de entrada en configuracion pull-up:
	
	PB_CR1 &= ~0x03;//Entrada como flotante
	
	//PD_CR1 &= ~0xFD;//Salidas push pull

	PC_CR1 |= 0xC4; //Salidas push pull , se colocan en 1


//Pines sin interrupcion externa(Colocar bit en 0)

	PB_CR2 &= ~0x03;

//velocidad superior a 2 MHz(Colocar bit en 0)
	PC_CR2 &= ~0xC4;
	
	}
void Timer4_Init(){
	
//Funcionamiento : 

// Se proporciona un valor para el preescalador  
	TIM4_PSCR = 0x01; 

//Se proporciona un valor de recarga automatica
	TIM4_ARR  = 0xFF;
		
	TIM4_CR1  = 0x00; //Resetear control de registro
	 
//Se modifica bit2 URS:fuente de solicitud de actualizacion
	 //se envia una solicitud de interrupcion de actualizacion
	 //solo cuando el contador llega al desbordamiento
	TIM4_CR1  |= 0x04; 
	 
//Generacion de evento de registro : 

// UG=1
//Reinicializa el contador y genera una actualizacion de los
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