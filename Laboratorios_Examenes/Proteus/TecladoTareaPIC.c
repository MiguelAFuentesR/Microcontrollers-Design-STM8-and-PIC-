/*
--------------------------------------------------------------------------------
 * 1. SECCION DE DOCUMENTACION
--------------------------------------------------------------------------------
 Este programa recorre un teclado matricial y detecta las teclas presionadas
 manejando las interrupciones de cambio en el puerto B para mostrar en un siete
 segmentos enlazado en proteus la tecla correspondiente.
 -------------------------------------------------------------------------------
 * INTEGRANTES:
 * Dely Catalina Ardila Medina 20191005011
 * Sara Valentina Barrero Medina 20191005170
 * Emanuell Arrieta Rodriguez
 -------------------------------------------------------------------------------
 * DOCENTE:
 * Holman Bueno Contreras
 -------------------------------------------------------------------------------
 * MATERIA
 * Dise�o de microcontroladores
 -------------------------------------------------------------------------------
 * UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS
--------------------------------------------------------------------------------
 * 2. SECCION DE DIRECTIVAS DE PREPROSESAMIENTO
--------------------------------------------------------------------------------
 se uso PIC18F25K20 
 */
#include <xc.h>
#define _XTAL_FREQ 8000000 // cristal de 8MHz
/*
--------------------------------------------------------------------------------
 * 3. DECLARACION DE VARIABLES Y FUNCIONES GLOBALES
--------------------------------------------------------------------------------
 */
void ConfigurarGPIO(void);
void InterrupcionMatriz(void);
/*
--------------------------------------------------------------------------------
 * 4. IMPLEMENTACION DE LAS FUNCIONES
--------------------------------------------------------------------------------
 */
void main(void) {
    //funcion Configuracion entradas y salidas digitales
    ConfigurarGPIO();
    //funcion Configuracion interrupciones
    InterrupcionMatriz();
    while(1){
    }
    return;
}
void ConfigurarGPIO(){
    //se limpia latch de salida puerto B y C
    LATB = 0x00;
    LATC = 0x00;
    // definimos RB 4,3,2,1 y 0 como pines digitales.
    ANSELH &=~ 0x1F;
    //Activamos pull-ups para  puerto B
    INTCON2 &=~ 0x80;
    //Asignamos pines RB 7,6,5,4 como pull-ups
    WPUB |= 0xF0;
    // configuramos RB 3,2,1,0 como salidas y RB 7,6,5,4 como entradas 
    TRISB |= 0xF0;
    TRISB &=~ 0x0F;
    // configuramos puerto RC como salida
    TRISC &=~ 0xFF;
}
void InterrupcionMatriz(void){
    //desactivamos las interrupciones globales y las del Puerto B
    RCON &=~ 0x80;
    // Ponemos bit GIE, PEIE y RBIE (bit 7,6 y 3) en cero
    INTCON &=~ 0xC8;
    //se habilita interrupci�n para los pines RB(7:4)
    IOCB |= 0xF0;
    //se establece prioridad de interrupcion en PortRB
    INTCON2 |= 0x01;
    //se activan interrupciones globales y de portB, bit 7 de RCON en 1
    RCON |= 0x80;
    // Ponemos bit GIE, PEIE y RBIE (bit 7,6 y 3) en uno
    INTCON |= 0xC8;
}
void __interrupt(high_priority) RecorridoMatriz(void){
    //si el bit RBIF (bandera) esta en 1, ejecuta la interrupcion
    //lee el boton presionado
    if (INTCON & 0x01){
        LATB |= 0x0E; //Ponemos RB0 en cero y RB1,RB2,RB3 en uno
        if ((RB7==0)&&(RB0==0)){ //SW4
            LATC = 0x77;//Dice presiona division
        }
        if ((RB6==0)&&(RB0==0)){ //SW3
            LATC = 0x67;// Dice presiona 9
        }
        if ((RB5==0)&&(RB0==0)){ //SW2
            LATC = 0x7F;//Dice presiona 8
        }
        if ((RB4==0)&&(RB0==0)){ //SW1
            LATC = 0x07;//Dice presiona 7
        }
        
        LATB &=~ 0x0F; //RB0,RB1,RB2,RB3en cero
        LATB |= 0x0D; //RB0,RB2,RB3 en uno, RB1 en uno
         if ((RB7==0)&&(RB1==0)){ //SW8
            LATC = 0x7C;//Dice presiona multiplicacion
        }
         if ((RB6==0)&&(RB1==0)){ //SW7
            LATC = 0x7D;//Dice presiona 6
        }
        if ((RB5==0)&&(RB1==0)){ //SW6
            LATC = 0x6D;//Dice presiona 5
        }
        if ((RB4==0)&&(RB1==0)){ //SW5
            LATC = 0x66;//Dice presiona 4
        }
        LATB &=~ 0x0F; //RB0,RB1,RB2,RB3 en cero
        LATB |= 0x0B; //RB0,RB1,RB3 en uno
        if ((RB7==0)&&(RB2==0)){ //SW12
            LATC = 0x39;//Dice presiona resta
        }
        if ((RB6==0)&&(RB2==0)){ //SW11
            LATC = 0x4F;//Dice presiona 3
        }
        if ((RB5==0)&&(RB2==0)){ //SW10
            LATC = 0x5B;//Dice presiona 2
        }
        if ((RB4==0)&&(RB2==0)){ //SW9
            LATC = 0x06;//Dice presiona 1
        }
        //RB0,RB1,RB2,RB3 en cero
        LATB &=~ 0x0F; 
        //RB0,RB1,RB2 en uno
        LATB |= 0x07; 
        if ((RB4==0)&&(RB3==0)){ //SW13
            LATC = 0x76;//Dice presiona on/c
        }
        if ((RB5==0)&&(RB3==0)){ //SW14
            LATC = 0x3F;//Dice presiona 0
        }
        if ((RB6==0)&&(RB3==0)){ //SW15
            LATC = 0x36;//Dice presiona igual
        }
        if ((RB7==0)&&(RB3==0)){ //SW16
            LATC = 0x5E;//Dice presiona suma
        }
        LATB &=~ 0x0F;//RB0,RB1,RB2,RB3 en cero
        __delay_us(90);//Tiempo de espera entre eventos
        int a=PORTB;
        INTCON &=~ 0x01; //bit bandera RBIF en cero
    }
}