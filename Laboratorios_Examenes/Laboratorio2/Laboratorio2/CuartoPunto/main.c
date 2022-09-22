//1.SECCION DE DOCUMENTACION

// 2.SECCION DE DIRECTIVAS DE PREPROCESAMIENTO

#include "iostm8s105.h"

// 3.VARIABLES Y FUNCIONES GLOBALES 

void configurarReloj(void); //metodo
void activarSalidaReloj(void);
// CLK_ICKR = 0; 

//4.IMPLEMENTACION DE LAS FUNCIONES 

main()
{
	configurarReloj();
	activarSalidaReloj();
	while (1){

	}
}

//FUNCION CONFIGURAR RELOJ 
//Funcion para dejar el reloj a 1 MHz y la oportunidad 
//que se pueda ver la señal por el pin de salida

void configurarReloj(){
	
	int a = 0; 
	//1.Activar el bit SWEN en el registro CLK_SWCR para 
	//activar la funcionalidad de cambio de fuente de reloj
	
	
	CLK_SWCR |= 0x02; 

	//2.Escoger la fuente de reloj en el registro CLK_SWR 
	//segun la descripcion que aparece en el datasheet 
	
	CLK_SWR = 0xE1;
	
	// 2.1 Seleccion de 8/8 para el microcontrolador 
	
	CLK_CKDIVR |= 0x00;
	//CLK_CKDIVR |= 0x12;
	//CLK_CKDIVR &= ~0x0D;
	
	
	//3.Esperar a que el bit SWBSY  pase a cero por hardware
	a = CLK_SWCR & 0x01;
	
	while(a == 1){
		a = CLK_SWCR & 0x01;
	}
	
	// 4. Desactivar el bit SWEN del registro CLK_SWCR para 
	// evitar que el microcontrolador intente cambiar 
	// nuevamente la fuente del reloj. 
	
	CLK_SWCR &= ~0x02;

}
void activarSalidaReloj(){
	//Configurar pin D0 como salida digital 
	
	PD_DDR |= 0x01;
	PD_CR1 |= 0x01;
	
	//Activar el modo de alta velocidad 
	
	//PD_CR2 |= 0x01;
	
	// Configuracion de la fuente de reloj para el pin fCPU 
	// Se escoge como salida fCPU del registro CLK_CCOR
	
	CLK_CCOR |= 0x0A;   
	CLK_CCOR &= ~0x14;	
	
	//Activar salida de reloj en el pin 
	
	CLK_CCOR |= 0x01; 
}