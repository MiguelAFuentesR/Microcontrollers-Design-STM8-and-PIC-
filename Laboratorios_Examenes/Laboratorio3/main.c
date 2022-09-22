//1.SECCION DE DOCUMENTACION
/* Este programa realiza la suma ,resta , multiplicacion y
division de los numeros enteros de 0 a 7 ingresandolos de
forma binaria y dando el resultado de forma decimal en dos 
display 7 segmentos 
*/
// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO

#include "iostm8s105.h"
#include <stdbool.h> 
#include <stdlib.h> 

// 3.VARIABLES Y FUNCIONES GLOBALES 

int num1_0,num1_1,num1_2 = 0; 
int num2_0,num2_1,num2_2 = 0; 
int op_0,op_1 = 0;

int a;
int b;
int c;
int suma=0;


int numero1dec=0;
int numero2dec=0;
int conversion=0; 
int Resultado=0;
int calculo=0;
int valorconvertido=0;

int division =0 ; 
int negativo =0;

int entero;
int decimal;

void configurarReloj(void); 
void configurarGPIO(void);
void leerdatos(void);


int BinarioDecimal(int bit0,int bit1,int bit2);
int Operaciones(int operando0,int operando1,int numero1,int numero2);
int ConversorBinarioDecimal(char r);
void MostrarDisplay(int NumeroResultado,int menos);
void delayAprox(long del);

int prueba=0;
int caso =0;

//4.IMPLEMENTACION DE LAS FUNCIONES 

main()
{
	configurarReloj();
	configurarGPIO();
	
	while (1){

	
	//Multiplexación
	leerdatos();
	MostrarDisplay(entero,negativo);		

	PB_ODR |= 0x0A;//Enciende display decenas PB3 = 1
	PB_ODR &= ~0x05;//Apaga display unidades PB2 = 0
		if(division==1){
		//Activar punto display 1 PB1 = 0
		PB_ODR &= ~0x02;
	}
	delayAprox(1861);
	MostrarDisplay(decimal,0);
  PB_ODR |= 0x05;//Enciende display Unidades PB2 = 1
  PB_ODR &= ~0x0A;//Apaga display decenas PB3 = 0
	 if(division==1){
		//Activar punto display 1 PB1 = 0
		PB_ODR &= ~0x02;
	}
	delayAprox(1861);

 
	}
}


void leerdatos(){
	division = 0;
	negativo = 0;
	op_0 = PB_IDR&0x01;
	op_1 = (PC_IDR&0x02)>>1; //PC1
	
	num2_0=(PC_IDR&0x04)>>2;//PC2
	num2_1=(PC_IDR&0x08)>>3;//PC3
	num2_2=(PC_IDR&0x10)>>4;//PC4
	
	num1_0=(PC_IDR&0x20)>>5;//PC5
	num1_1=(PC_IDR&0x40)>>6;//PC6
	num1_2=(PC_IDR&0x80)>>7;//PC7
	
	
	
	numero1dec= BinarioDecimal(num1_0,num1_1,num1_2);
	numero2dec= BinarioDecimal(num2_0,num2_1,num2_2);
	Resultado= Operaciones(op_0,op_1,numero1dec,numero2dec);
	
	caso = BinarioDecimal(op_0,op_1,0);
	
	//prueba = Operaciones2(numero1dec,numero2dec,caso);
	
	entero = Resultado/10; //Decenas
	decimal = Resultado%10; //Unidad
	
	if(Resultado<0){
		negativo=1;
		decimal=decimal*(-1);
	}else{
		negativo=0;
	}

}

void configurarGPIO(){
	
	//1. Limpiamos los latch de salida puerto B,C,D
	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
	PE_ODR = 0x00;//Limpiar los latch de salida del puertoE

	
/*
	2. 

		Entradas :
		(1)
		* PC_7:5 = numero1
		* PC_4:2 = numero0
		* PC_1   = Operacion Bit1 
		
		(2)
		* PB_0   = Operacion Bit0
		
		Salidas : 
			Display :
		(3),(4)
		*PD_0 = segmento a 
		*PD_2 = segmento b
		*PD_3 = segmento c
		*PD_4 = segmento d
		*PD_5 = segmento e
		*PD_6 = segmento f
		*PD_7 = segmento g
		
		(5)
		*PB_1 = Punto Display1 (Decenas)
		*PB_2 = Comun Display2 (Unidades)
		*PB_3 = Comun Display1 (Decenas)
	*/
	
	PC_DDR &= ~0xFF;//Todo El registro en 0 para entradas
	PB_DDR &= ~0x01;//Bit0 en 0 para entrada de Operacion Bit0
	
	
	PD_DDR |= 0xFD;// Bits 0,2,3,4,5,6,7 en 1 para salidas
	PB_DDR |= 0x0E;// Bits 1,2,3 en 1 para salidas
	PE_DDR |= 0xFF;// Bits 1,2,3 en 1 para salidas
	
	
	//3. Pines de entrada en configuracion pull-up:
	

 	PC_CR1 &= ~0xFF;//Entradas como flotantes , todo en 0
	PB_CR1 &= ~0x01;//Entrada como flotante
	
	//PD_CR1 &= ~0xFD;//Salidas push pull
	PD_CR1 |= 0xFD;//Salidas push pull 
	PB_CR1 |= 0x0E; //Salidas push pull , se colocan en 1
	PE_CR1 |= 0xFF; //Salidas push pull , se colocan en 1

//Pines sin interrupcion externa(Colocar bit en 0)
	
	PC_CR2 &= ~0xFF;
	PB_CR2 |= ~0x0E;

//velocidad superior a 2 MHz(Colocar bit en 0)
	PD_CR2 &= ~0xFD;
	PB_CR2 &= ~0x0E;
	PE_CR2 &= ~0xFF;

	
	}


int BinarioDecimal(int bit0,int bit1,int bit2){
conversion=0; 	
	if(bit0==1){
		conversion = conversion+1;
	}
	
	if(bit1==1){
		conversion = conversion+2;
	}
	
	if(bit2==1){
		conversion = conversion+4;
	}
	
	return conversion;
}


int Operaciones(int operando0,int operando1,int numero1,int numero2){

	if (operando1==0){
			if(operando0==0){
				calculo = numero1+numero2;
			}else{
				calculo = numero1-numero2;
			}
	}else {
			if(operando0==0){
				calculo = numero1*numero2;
			}else{
				if(numero2==0){
						//chinge a su madre 
				}else{
					calculo = ((numero1*10)/numero2);		
					division=1;
				}
			}

	}
	
	return calculo;	
}


void MostrarDisplay(int NumeroResultado,int menos){
	
if(menos==0){
	switch(NumeroResultado){
			case 0:
			PD_ODR=0x80;
			break;
			case 1:
			PD_ODR=0xF1;
			
			break;
			case 2:
			PD_ODR=0x48;
			PE_ODR = 0x00;
			break;
			case 3:
			PD_ODR=0x60;
			PE_ODR &= ~0x20;
			break;
			case 4:
			PD_ODR=0x31;
			PE_ODR &= ~0x20;
			break;
			case 5:
			PD_ODR=0x24;
			PE_ODR &= ~0x20;
			break;
			case 6:
			PD_ODR=0x04;
			PE_ODR &= ~0x20;
			break;
			case 7:
			PD_ODR=0x70;
			PE_ODR &= ~0x20;
			break;
			case 8:
			PD_ODR=0x00;
			PE_ODR &= ~0x20;
			break;
			case 9:
			PD_ODR=0x30;
			PE_ODR &= ~0x20;
			break;
		}
	}
	else{
		PD_ODR=0xFC;
		PE_ODR &= ~0x20;
	}
	
}


 

void configurarReloj(){
	//FUNCION CONFIGURAR RELOJ 
//Funcion para dejar el reloj a 4 MHz
	
	//1.Cambiamos la fuente de reloj modificando el registro 
	//CLK_SWCR el bit SWEN
	CLK_SWCR |= 0x02;
	
	//2. Modificamos todo el registro CLK_SWR para seleccionar
  //la nueva fuente de reloj
	
	CLK_SWR = 0xB4; //Selecionamos reloj externo 
	//3. Programamos la frecuencia que se usara en el 
	//ejercicio modificando el registro CLK_CKDIVR
	
	CLK_CKDIVR |= 0x01;
	CLK_CKDIVR &= ~0x1E;// bits 4,3,2,1 en 0 del registro

	//4. Esperamos que el bit SWBSY del registro CLK_SWCR 
	//se ponga en cero
	
	a = CLK_SWCR & 0x01;//Comparamos el bit cero
	while(a==1){ 
		a = CLK_SWCR & 0x01;
	}
	
	//5.Desactivamos el bit SWEN para que el microcontrolador 
	//no haga otro cambio de reloj 
	
	CLK_SWCR &=~0x02;  
	
}


void delayAprox(long del){
	long i=0;
	i=del;
	while(i>=0){
	i--;
	}
}
