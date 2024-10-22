//1.SECCION DE DOCUMENTACION

// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO

#include "iostm8s105.h"

// 3.VARIABLES Y FUNCIONES GLOBALES 

int a = 0;
void configurarReloj(void); //metodo
void activarSalidaReloj(void);


//4.IMPLEMENTACION DE LAS FUNCIONES 

main()
{
	configurarReloj();
	activarSalidaReloj();
	while (1){


	}
}

//FUNCION CONFIGURAR RELOJ 
//Funcion para dejar el reloj a 500 kHz y la oportunidad 
//que se pueda ver la se�al por el pin de salida

void configurarReloj(){
	//1.Cambiamos la fuente de reloj modificando el registro 
	//CLK_SWCR el bit SWEN
	CLK_SWCR |= 0x02;
	
	//2. Modificamos todo el registro CLK_SWR para seleccionar
  //la nueva fuente de reloj
	
	CLK_SWR = 0xB4; //Selecionamos reloj externo 
	
	//3. Programamos la frecuencia que se usara en el 
	//ejercicio modificando el registro CLK_CKDIVR
	
	CLK_CKDIVR = 0x00;
	//CLK_CKDIVR |= 0x04;
	//CLK_CKDIVR &= ~0x1B;
	
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
void activarSalidaReloj() {
	//Configurar pin D0 como salida digital 
	
	PD_DDR |= 0x01;
	PD_CR1 |= 0x01;
	
	//Actovar el modo de alta velocidad 
	
	PD_CR2 |= 0x01;
	
	// Configuracion de la fuente de reloj para el pin fCPU 
	
	CLK_CCOR |= 0x10;   
	CLK_CCOR &= ~0x0E;
	
	//Activar salida de reloj en el pin 
	
	CLK_CCOR |= 0x01; 
}