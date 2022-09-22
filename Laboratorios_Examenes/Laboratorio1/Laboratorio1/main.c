/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

/* 1.SECCION DE DOCUMENTACION 
	ESTE PROGRAMA RESUELVE UN SISTEMA DE ECUACIONES 3X3 USANDO DETERMINANTES
	
	2. DIRECTIVAS DE PREPROCESADMIENTO 
*/


#include "iostm8s105.h"

//3. DECLARACION DE VARIABLES Y FUNCIONES GLOBALES 

int  fila1[4]= {1,2,3,4}; 
int  fila2[4]= {5,6,7,8}; 
int  fila3[4]= {9,10,9,12}; 

char UnicaSolucion;

int Solucionx ;
int Soluciony ;
int Solucionz ;

int determinanteA(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3);
int determinantex(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3);
int determinantey(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3);
int determinantez(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3);

int X[3];

main()
{		
while(1){

	int a1 = fila1[0];
	int a2 = fila1[1];
	int a3 = fila1[2];
	
	int a4 = fila2[0];
	int a5 = fila2[1];
	int a6 = fila2[2];
	
	int a7 = fila3[0];
	int a8 = fila3[1];
	int a9 = fila3[2];
	
	int b1 = fila1[3];
	int b2 = fila2[3];
	int b3 = fila3[3];
	
	
	int detA=determinanteA(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
	int detx=determinantex(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
	int dety=determinantey(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
	int detz=determinantez(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
	
	 Solucionx = detx/detA ;
	 Soluciony = dety/detA ;
	 Solucionz = detz/detA ;
	 
	 X[0] =  Solucionx; 
	 X[1] =  Soluciony; 
	 X[2] =  Solucionz; 
	 
	 
	if (detA == 0){
		UnicaSolucion = 0;
	} else {
		UnicaSolucion = 1;
		}
		
	}
}


int determinanteA(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){
	int A = ((a1*a5*a9) +(a4*a8*a3) + (a7*a2*a6))-((a7*a5*a3)+(a1*a8*a6)+(a4*a2*a9));
	return A; 
}

int determinantex(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
	int x = ((b1*a5*a9)+(b2*a8*a3)+(b3*a2*a6))-((b3*a5*a3)+(b1*a8*a6)+(b2*a2*a9)) ;
	return x;
}

int determinantey(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
	int y = ((a1*b2*a9)+(a4*b3*a3)+(a7*b1*a6))-((a7*b2*a3)+(a1*b3*a6)+(a4*b1*a9)) ;
	return y;
}

int determinantez(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
		int z = ((a1*a5*b3)+(a4*a8*b1)+(a7*a2*b2))-((a7*a5*b1)+(a1*a8*b2)+(a4*a2*b3)) ;
	return z;

}
