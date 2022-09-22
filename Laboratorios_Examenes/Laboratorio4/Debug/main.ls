   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
2523                     	bsct
2524  0000               _conteo:
2525  0000 00000000      	dc.w	0,0
2526  0004               _pulsos:
2527  0004 0000          	dc.w	0
2528  0006               _contadorpulsos:
2529  0006 0000          	dc.w	0
2530  0008               _contarRPM:
2531  0008 00000000      	dc.w	0,0
2532  000c               _muestra5:
2533  000c 00000000      	dc.w	0,0
2580                     ; 43 main()
2580                     ; 44 {
2582                     	switch	.text
2583  0000               _main:
2585  0000 5204          	subw	sp,#4
2586       00000004      OFST:	set	4
2589                     ; 45 	configurarGPIO();
2591  0002 cd0150        	call	_configurarGPIO
2593                     ; 46 	ConfiguracionInterrupcion();
2595  0005 cd0103        	call	_ConfiguracionInterrupcion
2597                     ; 47 	Timer4_Init(); 
2599  0008 cd02bc        	call	_Timer4_Init
2601                     ; 48 	IniciarLCD();
2603  000b cd01eb        	call	_IniciarLCD
2605                     ; 49 	LimpiarLCD(); //con el comando clear
2607  000e cd0224        	call	_LimpiarLCD
2609                     ; 60 	LimpiarLCD();
2611  0011 cd0224        	call	_LimpiarLCD
2613                     ; 65 	delay_ms(10);
2615  0014 ae000a        	ldw	x,#10
2616  0017 cd0304        	call	_delay_ms
2618  001a               L5461:
2619                     ; 69 		if (contadorpulsos<=20){
2621  001a 9c            	rvf
2622  001b be06          	ldw	x,_contadorpulsos
2623  001d a30015        	cpw	x,#21
2624  0020 2e40          	jrsge	L1561
2625                     ; 70 			muestra1=contarRPM;
2627  0022 be0a          	ldw	x,_contarRPM+2
2628  0024 bf0e          	ldw	_muestra1+2,x
2629  0026 be08          	ldw	x,_contarRPM
2630  0028 bf0c          	ldw	_muestra1,x
2631                     ; 71 			delay_ms(100);
2633  002a ae0064        	ldw	x,#100
2634  002d cd0304        	call	_delay_ms
2636                     ; 72 			muestra2=contarRPM;
2638  0030 be0a          	ldw	x,_contarRPM+2
2639  0032 bf0a          	ldw	_muestra2+2,x
2640  0034 be08          	ldw	x,_contarRPM
2641  0036 bf08          	ldw	_muestra2,x
2642                     ; 73 			delay_ms(100);
2644  0038 ae0064        	ldw	x,#100
2645  003b cd0304        	call	_delay_ms
2647                     ; 74 			muestra3=contarRPM;
2649  003e be0a          	ldw	x,_contarRPM+2
2650  0040 bf06          	ldw	_muestra3+2,x
2651  0042 be08          	ldw	x,_contarRPM
2652  0044 bf04          	ldw	_muestra3,x
2653                     ; 75 			delay_ms(100);
2655  0046 ae0064        	ldw	x,#100
2656  0049 cd0304        	call	_delay_ms
2658                     ; 76 			muestra4=contarRPM;
2660  004c be0a          	ldw	x,_contarRPM+2
2661  004e bf02          	ldw	_muestra4+2,x
2662  0050 be08          	ldw	x,_contarRPM
2663  0052 bf00          	ldw	_muestra4,x
2664                     ; 77 			delay_ms(100);
2666  0054 ae0064        	ldw	x,#100
2667  0057 cd0304        	call	_delay_ms
2669                     ; 78 			muestra5=contarRPM;
2671  005a be0a          	ldw	x,_contarRPM+2
2672  005c bf0e          	ldw	_muestra5+2,x
2673  005e be08          	ldw	x,_contarRPM
2674  0060 bf0c          	ldw	_muestra5,x
2675  0062               L1561:
2676                     ; 80 		delay_ms(100);
2678  0062 ae0064        	ldw	x,#100
2679  0065 cd0304        	call	_delay_ms
2681                     ; 82 		conteo = (muestra1 + muestra2 + muestra3 +muestra4 +muestra5)/5;
2683  0068 ae000c        	ldw	x,#_muestra1
2684  006b cd0000        	call	c_ltor
2686  006e ae0008        	ldw	x,#_muestra2
2687  0071 cd0000        	call	c_fadd
2689  0074 ae0004        	ldw	x,#_muestra3
2690  0077 cd0000        	call	c_fadd
2692  007a ae0000        	ldw	x,#_muestra4
2693  007d cd0000        	call	c_fadd
2695  0080 ae000c        	ldw	x,#_muestra5
2696  0083 cd0000        	call	c_fadd
2698  0086 ae0022        	ldw	x,#L7561
2699  0089 cd0000        	call	c_fdiv
2701  008c ae0000        	ldw	x,#_conteo
2702  008f cd0000        	call	c_rtol
2704                     ; 83 		PonerCursorLCD(1,1); //coordenada 1,1
2706  0092 ae0101        	ldw	x,#257
2707  0095 cd022c        	call	_PonerCursorLCD
2709                     ; 84 		ImprimirCadenaLCD("El motor gira a:");
2711  0098 ae0011        	ldw	x,#L3661
2712  009b cd029b        	call	_ImprimirCadenaLCD
2714                     ; 86 		PonerCursorLCD(2,1);
2716  009e ae0201        	ldw	x,#513
2717  00a1 cd022c        	call	_PonerCursorLCD
2719                     ; 87     sprintf(stringconteo,"%d.%02u", (int) conteo, (int) ((conteo - (int) conteo ) * 100) );
2721  00a4 ae0000        	ldw	x,#_conteo
2722  00a7 cd0000        	call	c_ltor
2724  00aa cd0000        	call	c_ftoi
2726  00ad cd0000        	call	c_itof
2728  00b0 96            	ldw	x,sp
2729  00b1 1c0001        	addw	x,#OFST-3
2730  00b4 cd0000        	call	c_rtol
2733  00b7 ae0000        	ldw	x,#_conteo
2734  00ba cd0000        	call	c_ltor
2736  00bd 96            	ldw	x,sp
2737  00be 1c0001        	addw	x,#OFST-3
2738  00c1 cd0000        	call	c_fsub
2740  00c4 ae0005        	ldw	x,#L3761
2741  00c7 cd0000        	call	c_fmul
2743  00ca cd0000        	call	c_ftoi
2745  00cd 89            	pushw	x
2746  00ce ae0000        	ldw	x,#_conteo
2747  00d1 cd0000        	call	c_ltor
2749  00d4 cd0000        	call	c_ftoi
2751  00d7 89            	pushw	x
2752  00d8 ae0009        	ldw	x,#L5661
2753  00db 89            	pushw	x
2754  00dc ae0010        	ldw	x,#_stringconteo
2755  00df cd0000        	call	_sprintf
2757  00e2 5b06          	addw	sp,#6
2758                     ; 88 		ImprimirCadenaLCD(stringconteo);
2760  00e4 ae0010        	ldw	x,#_stringconteo
2761  00e7 cd029b        	call	_ImprimirCadenaLCD
2763                     ; 89 		PonerCursorLCD(2,7); //coordenada 1,13
2765  00ea ae0207        	ldw	x,#519
2766  00ed cd022c        	call	_PonerCursorLCD
2768                     ; 90 		ImprimirCadenaLCD(" RPM");
2770  00f0 ae0000        	ldw	x,#L7761
2771  00f3 cd029b        	call	_ImprimirCadenaLCD
2773                     ; 91 		delay_ms(500);
2775  00f6 ae01f4        	ldw	x,#500
2776  00f9 cd0304        	call	_delay_ms
2778                     ; 92 		contadorpulsos =0 ; 
2780  00fc 5f            	clrw	x
2781  00fd bf06          	ldw	_contadorpulsos,x
2783  00ff ac1a001a      	jpf	L5461
2813                     ; 103 void ConfiguracionInterrupcion(){
2814                     	switch	.text
2815  0103               _ConfiguracionInterrupcion:
2819                     ; 106 	sim
2822  0103 9b            sim
2824                     ; 109 	PC_ODR = 0x00;
2826  0104 725f500a      	clr	_PC_ODR
2827                     ; 110 	PC_DDR &= ~0x02;//PC1 como entrada
2829  0108 7213500c      	bres	_PC_DDR,#1
2830                     ; 113 	EXTI_CR1 |= 0x20;
2832  010c 721a50a0      	bset	_EXTI_CR1,#5
2833                     ; 114 	EXTI_CR1 &= ~0x10;
2835  0110 721950a0      	bres	_EXTI_CR1,#4
2836                     ; 116 	PC_CR1 &= ~0x02;// Pin flotante
2838  0114 7213500d      	bres	_PC_CR1,#1
2839                     ; 118 	PC_CR2 |= 0x02;
2841  0118 7212500e      	bset	_PC_CR2,#1
2842                     ; 120 	ITC_SPR2 |= 0x0C;
2844  011c c67f71        	ld	a,_ITC_SPR2
2845  011f aa0c          	or	a,#12
2846  0121 c77f71        	ld	_ITC_SPR2,a
2847                     ; 123 	rim
2850  0124 9a            rim
2852                     ; 125 }
2855  0125 81            	ret
2880                     ; 127 @far @interrupt void EXTI2_IRQHandler(){
2882                     	switch	.text
2883  0126               f_EXTI2_IRQHandler:
2885  0126 be00          	ldw	x,c_x
2886  0128 89            	pushw	x
2887  0129 be02          	ldw	x,c_lreg+2
2888  012b 89            	pushw	x
2889  012c be00          	ldw	x,c_lreg
2890  012e 89            	pushw	x
2893                     ; 128 	contadorpulsos++; 
2895  012f be06          	ldw	x,_contadorpulsos
2896  0131 1c0001        	addw	x,#1
2897  0134 bf06          	ldw	_contadorpulsos,x
2898                     ; 129 	contarRPM = contadorpulsos*3;
2900  0136 be06          	ldw	x,_contadorpulsos
2901  0138 a603          	ld	a,#3
2902  013a cd0000        	call	c_bmulx
2904  013d cd0000        	call	c_itof
2906  0140 ae0008        	ldw	x,#_contarRPM
2907  0143 cd0000        	call	c_rtol
2909                     ; 132 }
2912  0146 85            	popw	x
2913  0147 bf00          	ldw	c_lreg,x
2914  0149 85            	popw	x
2915  014a bf02          	ldw	c_lreg+2,x
2916  014c 85            	popw	x
2917  014d bf00          	ldw	c_x,x
2918  014f 80            	iret
2950                     ; 134 void configurarGPIO(){
2952                     	switch	.text
2953  0150               _configurarGPIO:
2957                     ; 137 	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
2959  0150 725f5005      	clr	_PB_ODR
2960                     ; 138 	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
2962  0154 725f500a      	clr	_PC_ODR
2963                     ; 139 	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
2965  0158 725f500f      	clr	_PD_ODR
2966                     ; 142 	PC_DDR &= ~0xFF;//Todo El registro en 0 para entradas
2968  015c c6500c        	ld	a,_PC_DDR
2969  015f a400          	and	a,#0
2970  0161 c7500c        	ld	_PC_DDR,a
2971                     ; 144 	PD_DDR |= 0x78;// Bits 6,5,4,3 en 1 para salidas
2973  0164 c65011        	ld	a,_PD_DDR
2974  0167 aa78          	or	a,#120
2975  0169 c75011        	ld	_PD_DDR,a
2976                     ; 145 	PB_DDR |= 0x03; // Bits 1,0 en 1 para salidas
2978  016c c65007        	ld	a,_PB_DDR
2979  016f aa03          	or	a,#3
2980  0171 c75007        	ld	_PB_DDR,a
2981                     ; 149  	PC_CR1 &= ~0xFF;//Entradas como flotantes , todo en 0
2983  0174 c6500d        	ld	a,_PC_CR1
2984  0177 a400          	and	a,#0
2985  0179 c7500d        	ld	_PC_CR1,a
2986                     ; 153 	PD_CR1 |= 0x78; //Salidas push pull , se colocan en 1
2988  017c c65012        	ld	a,_PD_CR1
2989  017f aa78          	or	a,#120
2990  0181 c75012        	ld	_PD_CR1,a
2991                     ; 154 	PB_CR1 |= 0x03; //Salidas push pull , se colocan en 1
2993  0184 c65008        	ld	a,_PB_CR1
2994  0187 aa03          	or	a,#3
2995  0189 c75008        	ld	_PB_CR1,a
2996                     ; 157 	PC_CR2 |= 0xFF;
2998  018c c6500e        	ld	a,_PC_CR2
2999  018f aaff          	or	a,#255
3000  0191 c7500e        	ld	_PC_CR2,a
3001                     ; 158 	}
3004  0194 81            	ret
3039                     ; 160 void EnviarNibbleLCD(char nibble){ //los pines para enviar datos son D0-D3
3040                     	switch	.text
3041  0195               _EnviarNibbleLCD:
3043  0195 88            	push	a
3044       00000000      OFST:	set	0
3047                     ; 163 	if(nibble & 0x01){ 
3049  0196 a501          	bcp	a,#1
3050  0198 2706          	jreq	L7471
3051                     ; 165 		PD_ODR |= 0x08; //PD3=D4 se le envia 1
3053  019a 7216500f      	bset	_PD_ODR,#3
3055  019e 2004          	jra	L1571
3056  01a0               L7471:
3057                     ; 168  		PD_ODR &= ~0x08; //PD3=D4 se le envia 0
3059  01a0 7217500f      	bres	_PD_ODR,#3
3060  01a4               L1571:
3061                     ; 173 	if(nibble & 0x02){
3063  01a4 7b01          	ld	a,(OFST+1,sp)
3064  01a6 a502          	bcp	a,#2
3065  01a8 2706          	jreq	L3571
3066                     ; 175 		PD_ODR |= 0x10; // PD4=D5 se le envia 1
3068  01aa 7218500f      	bset	_PD_ODR,#4
3070  01ae 2004          	jra	L5571
3071  01b0               L3571:
3072                     ; 178  		PD_ODR &= ~0x10; //PD4=D5 se le envia 0
3074  01b0 7219500f      	bres	_PD_ODR,#4
3075  01b4               L5571:
3076                     ; 183 	if(nibble & 0x04){ 
3078  01b4 7b01          	ld	a,(OFST+1,sp)
3079  01b6 a504          	bcp	a,#4
3080  01b8 2706          	jreq	L7571
3081                     ; 185 		PD_ODR |= 0x20; // PD5=D6 se le envia 1
3083  01ba 721a500f      	bset	_PD_ODR,#5
3085  01be 2004          	jra	L1671
3086  01c0               L7571:
3087                     ; 189  		PD_ODR &= ~0x20; //PD5=D6 se le envia 0
3089  01c0 721b500f      	bres	_PD_ODR,#5
3090  01c4               L1671:
3091                     ; 193 	if(nibble & 0x08){ 
3093  01c4 7b01          	ld	a,(OFST+1,sp)
3094  01c6 a508          	bcp	a,#8
3095  01c8 2706          	jreq	L3671
3096                     ; 195 		PD_ODR |= 0x40; // PD6=D7 se le envia 1
3098  01ca 721c500f      	bset	_PD_ODR,#6
3100  01ce 2004          	jra	L5671
3101  01d0               L3671:
3102                     ; 199  		PD_ODR &= ~0x40; //PD6=D7 se le envia 0
3104  01d0 721d500f      	bres	_PD_ODR,#6
3105  01d4               L5671:
3106                     ; 201 }
3109  01d4 84            	pop	a
3110  01d5 81            	ret
3147                     ; 203 void EnviarComandoLCD(char a){
3148                     	switch	.text
3149  01d6               _EnviarComandoLCD:
3153                     ; 206 	PB_ODR &= ~0x01; // RS=0 es decir PB0=0 para envio de comandos
3155  01d6 72115005      	bres	_PB_ODR,#0
3156                     ; 207 	EnviarNibbleLCD(a); //envio del dato deseado
3158  01da adb9          	call	_EnviarNibbleLCD
3160                     ; 208 	PB_ODR |= 0x02; //EN=1 es decir PB1 = 1 ; inicia transmision
3162  01dc 72125005      	bset	_PB_ODR,#1
3163                     ; 209 	delay_ms(4); // delay para no preguntar por el estado BF de la LCD
3165  01e0 ae0004        	ldw	x,#4
3166  01e3 cd0304        	call	_delay_ms
3168                     ; 210 	PB_ODR &= ~0x02; // EN=0 es decir PB1 = 0 ; cierra transmision 
3170  01e6 72135005      	bres	_PB_ODR,#1
3171                     ; 211 }	
3174  01ea 81            	ret
3199                     ; 214 void IniciarLCD(){
3200                     	switch	.text
3201  01eb               _IniciarLCD:
3205                     ; 217 	delay_ms(30);
3207  01eb ae001e        	ldw	x,#30
3208  01ee cd0304        	call	_delay_ms
3210                     ; 219 	EnviarComandoLCD(0x03); // RS  R/W~ DB7 DB6 DB5 DB4   segundo paso de algoritmo
3212  01f1 a603          	ld	a,#3
3213  01f3 ade1          	call	_EnviarComandoLCD
3215                     ; 221 	delay_ms(5);           // delay de minimo 4,1ms
3217  01f5 ae0005        	ldw	x,#5
3218  01f8 cd0304        	call	_delay_ms
3220                     ; 222 	EnviarComandoLCD(0x03); //cuarto paso de algoritmo set DB5 y DB4
3222  01fb a603          	ld	a,#3
3223  01fd add7          	call	_EnviarComandoLCD
3225                     ; 223 	delay_ms(11);         //delay de minimo 100us
3227  01ff ae000b        	ldw	x,#11
3228  0202 cd0304        	call	_delay_ms
3230                     ; 224 	EnviarComandoLCD(0x03); // sexto paso set DB5 y DB4
3232  0205 a603          	ld	a,#3
3233  0207 adcd          	call	_EnviarComandoLCD
3235                     ; 225 	EnviarComandoLCD(0x02); // indicar LCD manejo de modo de 4 bits
3237  0209 a602          	ld	a,#2
3238  020b adc9          	call	_EnviarComandoLCD
3240                     ; 229 	EnviarComandoLCD(0x02); // DL=0 de function set
3242  020d a602          	ld	a,#2
3243  020f adc5          	call	_EnviarComandoLCD
3245                     ; 230 	EnviarComandoLCD(0x08); // N=1, F=0 de function set
3247  0211 a608          	ld	a,#8
3248  0213 adc1          	call	_EnviarComandoLCD
3250                     ; 233 	EnviarComandoLCD(0x00);
3252  0215 4f            	clr	a
3253  0216 adbe          	call	_EnviarComandoLCD
3255                     ; 234 	EnviarComandoLCD(0x0C); //D=1 (display on), C=0 (cursor off), B=0 (titilar off) 
3257  0218 a60c          	ld	a,#12
3258  021a adba          	call	_EnviarComandoLCD
3260                     ; 237 	EnviarComandoLCD(0x00);
3262  021c 4f            	clr	a
3263  021d adb7          	call	_EnviarComandoLCD
3265                     ; 238 	EnviarComandoLCD(0x06); // I/D=1
3267  021f a606          	ld	a,#6
3268  0221 adb3          	call	_EnviarComandoLCD
3270                     ; 239 }
3273  0223 81            	ret
3297                     ; 241 void LimpiarLCD(){
3298                     	switch	.text
3299  0224               _LimpiarLCD:
3303                     ; 242   EnviarComandoLCD(0);// bits mas significativo
3305  0224 4f            	clr	a
3306  0225 adaf          	call	_EnviarComandoLCD
3308                     ; 243 	EnviarComandoLCD(1);// bits menos significativos
3310  0227 a601          	ld	a,#1
3311  0229 adab          	call	_EnviarComandoLCD
3313                     ; 244 }
3316  022b 81            	ret
3387                     ; 247 void PonerCursorLCD(char a, char b){
3388                     	switch	.text
3389  022c               _PonerCursorLCD:
3391  022c 89            	pushw	x
3392  022d 89            	pushw	x
3393       00000002      OFST:	set	2
3396                     ; 250 	if(a == 1)
3398  022e 9e            	ld	a,xh
3399  022f a101          	cp	a,#1
3400  0231 2607          	jrne	L3602
3401                     ; 252 		temp = 0x80 + b - 0x01; //80h
3403  0233 9f            	ld	a,xl
3404  0234 ab7f          	add	a,#127
3405  0236 6b02          	ld	(OFST+0,sp),a
3408  0238 200c          	jra	L5602
3409  023a               L3602:
3410                     ; 254 	else if(a == 2)
3412  023a 7b03          	ld	a,(OFST+1,sp)
3413  023c a102          	cp	a,#2
3414  023e 2606          	jrne	L5602
3415                     ; 256 		temp = 0xC0 + b - 1; //C0h
3417  0240 7b04          	ld	a,(OFST+2,sp)
3418  0242 abbf          	add	a,#191
3419  0244 6b02          	ld	(OFST+0,sp),a
3421  0246               L5602:
3422                     ; 258 	z = temp >> 4;
3424  0246 7b02          	ld	a,(OFST+0,sp)
3425  0248 4e            	swap	a
3426  0249 a40f          	and	a,#15
3427  024b 6b01          	ld	(OFST-1,sp),a
3429                     ; 259 	y = temp & 0x0F;
3431  024d 7b02          	ld	a,(OFST+0,sp)
3432  024f a40f          	and	a,#15
3433  0251 6b02          	ld	(OFST+0,sp),a
3435                     ; 260 	EnviarComandoLCD(z);
3437  0253 7b01          	ld	a,(OFST-1,sp)
3438  0255 cd01d6        	call	_EnviarComandoLCD
3440                     ; 261 	EnviarComandoLCD(y);
3442  0258 7b02          	ld	a,(OFST+0,sp)
3443  025a cd01d6        	call	_EnviarComandoLCD
3445                     ; 262 }
3448  025d 5b04          	addw	sp,#4
3449  025f 81            	ret
3504                     ; 264 void ImprimirCharLCD(char data){
3505                     	switch	.text
3506  0260               _ImprimirCharLCD:
3508  0260 88            	push	a
3509  0261 89            	pushw	x
3510       00000002      OFST:	set	2
3513                     ; 266 	Lower_Nibble = data & 0x0F; // leer los primeros 4 bits
3515  0262 a40f          	and	a,#15
3516  0264 6b01          	ld	(OFST-1,sp),a
3518                     ; 267 	Upper_Nibble = data & 0xF0; // leer los segundos 4 bits
3520  0266 7b03          	ld	a,(OFST+1,sp)
3521  0268 a4f0          	and	a,#240
3522  026a 6b02          	ld	(OFST+0,sp),a
3524                     ; 268 	PB_ODR |= 0x01;	                    //PB0=RS=1 para envio de datos 
3526  026c 72105005      	bset	_PB_ODR,#0
3527                     ; 269 	EnviarNibbleLCD(Upper_Nibble >> 4); //envia el MSB nibble
3529  0270 7b02          	ld	a,(OFST+0,sp)
3530  0272 4e            	swap	a
3531  0273 a40f          	and	a,#15
3532  0275 cd0195        	call	_EnviarNibbleLCD
3534                     ; 270 	PB_ODR |= 0x02;	                      // PB1=EN=1
3536  0278 72125005      	bset	_PB_ODR,#1
3537                     ; 271 	delay_ms(1);                      //delay para evitar polling de BF
3539  027c ae0001        	ldw	x,#1
3540  027f cd0304        	call	_delay_ms
3542                     ; 272 	PB_ODR &= ~0x02;                      // PB1=EN=0
3544  0282 72135005      	bres	_PB_ODR,#1
3545                     ; 273 	EnviarNibbleLCD(Lower_Nibble);      //envia el LSB nibble
3547  0286 7b01          	ld	a,(OFST-1,sp)
3548  0288 cd0195        	call	_EnviarNibbleLCD
3550                     ; 274 	PB_ODR |= 0x02;                       // PB1=EN=1
3552  028b 72125005      	bset	_PB_ODR,#1
3553                     ; 275 	delay_ms(1);                      //delay para evitar polling de BF
3555  028f ae0001        	ldw	x,#1
3556  0292 ad70          	call	_delay_ms
3558                     ; 276 	PB_ODR &= ~0x02;                      // PB1=EN=0
3560  0294 72135005      	bres	_PB_ODR,#1
3561                     ; 277 }
3564  0298 5b03          	addw	sp,#3
3565  029a 81            	ret
3610                     ; 279 void ImprimirCadenaLCD(char *a){
3611                     	switch	.text
3612  029b               _ImprimirCadenaLCD:
3614  029b 89            	pushw	x
3615  029c 89            	pushw	x
3616       00000002      OFST:	set	2
3619                     ; 281 	for(i=0;a[i]!='\0';i++){
3621  029d 5f            	clrw	x
3622  029e 1f01          	ldw	(OFST-1,sp),x
3625  02a0 200f          	jra	L5412
3626  02a2               L1412:
3627                     ; 282 		ImprimirCharLCD(a[i]); 
3629  02a2 1e01          	ldw	x,(OFST-1,sp)
3630  02a4 72fb03        	addw	x,(OFST+1,sp)
3631  02a7 f6            	ld	a,(x)
3632  02a8 adb6          	call	_ImprimirCharLCD
3634                     ; 281 	for(i=0;a[i]!='\0';i++){
3636  02aa 1e01          	ldw	x,(OFST-1,sp)
3637  02ac 1c0001        	addw	x,#1
3638  02af 1f01          	ldw	(OFST-1,sp),x
3640  02b1               L5412:
3643  02b1 1e01          	ldw	x,(OFST-1,sp)
3644  02b3 72fb03        	addw	x,(OFST+1,sp)
3645  02b6 7d            	tnz	(x)
3646  02b7 26e9          	jrne	L1412
3647                     ; 284 }
3650  02b9 5b04          	addw	sp,#4
3651  02bb 81            	ret
3680                     ; 289 void Timer4_Init(){
3681                     	switch	.text
3682  02bc               _Timer4_Init:
3686                     ; 294 	TIM4_PSCR = 0x01; 
3688  02bc 35015345      	mov	_TIM4_PSCR,#1
3689                     ; 297 	TIM4_ARR  = 0xFF;
3691  02c0 35ff5346      	mov	_TIM4_ARR,#255
3692                     ; 299 	TIM4_CR1  = 0x00; //Resetear control de registro
3694  02c4 725f5340      	clr	_TIM4_CR1
3695                     ; 304 	TIM4_CR1  |= 0x04; 
3697  02c8 72145340      	bset	_TIM4_CR1,#2
3698                     ; 311 	TIM4_EGR  = 1; 
3700  02cc 35015343      	mov	_TIM4_EGR,#1
3701                     ; 314 	TIM4_CNTR = 0x00;	//Se pone en 0 el contador
3703  02d0 725f5344      	clr	_TIM4_CNTR
3704                     ; 317 	TIM4_IER &= ~0x01; 
3706  02d4 72115341      	bres	_TIM4_IER,#0
3707                     ; 318 }
3710  02d8 81            	ret
3748                     ; 321 void delay_us(int tiempo){
3749                     	switch	.text
3750  02d9               _delay_us:
3752  02d9 89            	pushw	x
3753       00000000      OFST:	set	0
3756                     ; 331 TIM4_EGR |= 0x01; 
3758  02da 72105343      	bset	_TIM4_EGR,#0
3759                     ; 332 TIM4_CNTR = 0x00;	//Se pone en 0 el contador
3761  02de 725f5344      	clr	_TIM4_CNTR
3762                     ; 335 TIM4_CR1 |= 0x01;
3764  02e2 72105340      	bset	_TIM4_CR1,#0
3766  02e6 2008          	jra	L1022
3767  02e8               L7712:
3768                     ; 338 		TIM4_CR1 &= 0x01;
3770  02e8 c65340        	ld	a,_TIM4_CR1
3771  02eb a401          	and	a,#1
3772  02ed c75340        	ld	_TIM4_CR1,a
3773  02f0               L1022:
3774                     ; 337 	while(TIM4_CNTR<tiempo){
3776  02f0 9c            	rvf
3777  02f1 c65344        	ld	a,_TIM4_CNTR
3778  02f4 5f            	clrw	x
3779  02f5 97            	ld	xl,a
3780  02f6 1301          	cpw	x,(OFST+1,sp)
3781  02f8 2fee          	jrslt	L7712
3782                     ; 342 	TIM4_SR  &= 0x01;
3784  02fa c65342        	ld	a,_TIM4_SR
3785  02fd a401          	and	a,#1
3786  02ff c75342        	ld	_TIM4_SR,a
3787                     ; 343 }
3790  0302 85            	popw	x
3791  0303 81            	ret
3826                     ; 344 void delay_ms(int tiempo){
3827                     	switch	.text
3828  0304               _delay_ms:
3830  0304 89            	pushw	x
3831       00000000      OFST:	set	0
3834                     ; 349 	tiempo=tiempo*10;
3836  0305 1e01          	ldw	x,(OFST+1,sp)
3837  0307 a60a          	ld	a,#10
3838  0309 cd0000        	call	c_bmulx
3840  030c 1f01          	ldw	(OFST+1,sp),x
3842  030e 2005          	jra	L5222
3843  0310               L3222:
3844                     ; 351 	delay_us(100);
3846  0310 ae0064        	ldw	x,#100
3847  0313 adc4          	call	_delay_us
3849  0315               L5222:
3850                     ; 350 	while(tiempo--){
3852  0315 1e01          	ldw	x,(OFST+1,sp)
3853  0317 1d0001        	subw	x,#1
3854  031a 1f01          	ldw	(OFST+1,sp),x
3855  031c 1c0001        	addw	x,#1
3856  031f a30000        	cpw	x,#0
3857  0322 26ec          	jrne	L3222
3858                     ; 353 }
3861  0324 85            	popw	x
3862  0325 81            	ret
3968                     	xdef	f_EXTI2_IRQHandler
3969                     	xdef	_main
3970                     	xdef	_muestra5
3971                     	switch	.ubsct
3972  0000               _muestra4:
3973  0000 00000000      	ds.b	4
3974                     	xdef	_muestra4
3975  0004               _muestra3:
3976  0004 00000000      	ds.b	4
3977                     	xdef	_muestra3
3978  0008               _muestra2:
3979  0008 00000000      	ds.b	4
3980                     	xdef	_muestra2
3981  000c               _muestra1:
3982  000c 00000000      	ds.b	4
3983                     	xdef	_muestra1
3984                     	xdef	_contarRPM
3985                     	xdef	_contadorpulsos
3986                     	xdef	_pulsos
3987  0010               _stringconteo:
3988  0010 000000000000  	ds.b	20
3989                     	xdef	_stringconteo
3990                     	xdef	_conteo
3991                     	xdef	_delay_ms
3992                     	xdef	_delay_us
3993                     	xdef	_Timer4_Init
3994                     	xdef	_ConfiguracionInterrupcion
3995                     	xdef	_ImprimirCadenaLCD
3996                     	xdef	_ImprimirCharLCD
3997                     	xdef	_IniciarLCD
3998                     	xdef	_PonerCursorLCD
3999                     	xdef	_LimpiarLCD
4000                     	xdef	_EnviarComandoLCD
4001                     	xdef	_EnviarNibbleLCD
4002                     	xdef	_configurarGPIO
4003                     	xref	_sprintf
4004                     .const:	section	.text
4005  0000               L7761:
4006  0000 2052504d00    	dc.b	" RPM",0
4007  0005               L3761:
4008  0005 42c80000      	dc.w	17096,0
4009  0009               L5661:
4010  0009 25642e253032  	dc.b	"%d.%02u",0
4011  0011               L3661:
4012  0011 456c206d6f74  	dc.b	"El motor gira a:",0
4013  0022               L7561:
4014  0022 40a00000      	dc.w	16544,0
4015                     	xref.b	c_lreg
4016                     	xref.b	c_x
4036                     	xref	c_bmulx
4037                     	xref	c_fmul
4038                     	xref	c_fsub
4039                     	xref	c_itof
4040                     	xref	c_ftoi
4041                     	xref	c_rtol
4042                     	xref	c_fdiv
4043                     	xref	c_fadd
4044                     	xref	c_ltor
4045                     	end
