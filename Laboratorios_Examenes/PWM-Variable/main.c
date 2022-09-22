//1.SECCION DE DOCUMENTACION


// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO


#include "iostm8s105.h"
#include "STM8S.h"

// 3.VARIABLES Y FUNCIONES GLOBALES 
void configurarGPIO(void);

//Funciones Timer
void Timer4_Init(void);
void delay_us(int tiempo);
void delay_ms(int tiempo);

//Funciones Motor
void CambiarSentido_Motor(void);

void ControlVelocidad_Motor(int Duty,int Incremento);




//Variables Motor

int Sentido = 0; 

signed int pwm_duty = 0;
int x=0;
int y=0;
int Duty,Incremento=0;
int CicloInicial =0;
int delay = 0; 
void main(void)
{
	configurarGPIO();
	Timer4_Init();
  GPIO_DeInit(GPIOD);
	
TIM2_DeInit();
GPIO_Init(GPIOD,GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_FAST);

//Valor hasta el que cuenta 

// Ciclo Util CCR1H,L => 1000 =  3E8 
TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000,TIM2_OCPOLARITY_HIGH);
									 
//Para frecuencia de 1 kHz ; 2MHz/1Khz = 2000
//TIM2_PRESCALER_1  = ((uint8_t)0x00),
TIM2_TimeBaseInit(TIM2_PRESCALER_1, 1000);
//TIM2_Cmd(ENABLE);

TIM2_CR1 |= 0x01;

  while(1){
	x =40;
	y = 512;	
	
		if(x>=0 && x<50){
		
		CicloInicial = 500; //50%
		Duty=600; //80%
		Incremento=2;
		delay = 30; 
		}
		else if(x>=50 && x<100){
		CicloInicial = 950; //50%
		Duty=1000; //80%
		Incremento=2;
   	delay = 10;
		}else if(x>=100 && x<150){
		CicloInicial = 750; //50%
		Duty=800; //80%
		Incremento=2;
   	delay = 10;
		}else if(x>=150 && x<200){
	
		}else if(x>=200 && x<250){
	
		}else if(x>=250 && x<300){
	
		}
		
		Sentido =0;
		CambiarSentido_Motor();
		ControlVelocidad_Motor(Duty,Incremento);
		
		
  }
	
}

void ControlVelocidad_Motor(int Duty,int Incremento){

		//Ciclo Ascenso
for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
	// loop through 
      TIM2_SetCompare1(pwm_duty); //set capture compair for Timer2
     delay_ms(delay); //delay for 10ms
}
			
  //CICLO DESCENSO
for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
      TIM2_SetCompare1(pwm_duty);
			delay_ms(delay);
    }
}




void CambiarSentido_Motor(void){
	
	if(Sentido){
		//Motor Giro Derecha (Horario) IN1=PC7=1 ; IN1=PC6=0
		PC_ODR |= 0x80;
		PC_ODR &= ~0x40;
	}else{
	//Motor Giro Izquierda (AntiHorario) IN=PC7=0 ;IN1=PC6=1
		PC_ODR &= ~0x80;
		PC_ODR |= 0x40;
	}
	
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