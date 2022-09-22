   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
2523                     	bsct
2524  0000               _Sentido:
2525  0000 0000          	dc.w	0
2526  0002               _pwm_duty:
2527  0002 0000          	dc.w	0
2528  0004               _x:
2529  0004 0000          	dc.w	0
2530  0006               _y:
2531  0006 0000          	dc.w	0
2532  0008               _Incremento:
2533  0008 0000          	dc.w	0
2534  000a               _CicloInicial:
2535  000a 0000          	dc.w	0
2536  000c               _delay:
2537  000c 0000          	dc.w	0
2583                     ; 36 void main(void)
2583                     ; 37 {
2585                     	switch	.text
2586  0000               _main:
2590                     ; 38 	configurarGPIO();
2592  0000 cd00b8        	call	_configurarGPIO
2594                     ; 39 	Timer4_Init();
2596  0003 cd00f5        	call	_Timer4_Init
2598                     ; 40   GPIO_DeInit(GPIOD);
2600  0006 ae500f        	ldw	x,#20495
2601  0009 cd0000        	call	_GPIO_DeInit
2603                     ; 42 TIM2_DeInit();
2605  000c cd0000        	call	_TIM2_DeInit
2607                     ; 43 GPIO_Init(GPIOD,GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_FAST);
2609  000f 4bf0          	push	#240
2610  0011 4b10          	push	#16
2611  0013 ae500f        	ldw	x,#20495
2612  0016 cd0000        	call	_GPIO_Init
2614  0019 85            	popw	x
2615                     ; 48 TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000,TIM2_OCPOLARITY_HIGH);
2617  001a 4b00          	push	#0
2618  001c ae03e8        	ldw	x,#1000
2619  001f 89            	pushw	x
2620  0020 ae6011        	ldw	x,#24593
2621  0023 cd0000        	call	_TIM2_OC1Init
2623  0026 5b03          	addw	sp,#3
2624                     ; 52 TIM2_TimeBaseInit(TIM2_PRESCALER_1, 1000);
2626  0028 ae03e8        	ldw	x,#1000
2627  002b 89            	pushw	x
2628  002c 4f            	clr	a
2629  002d cd0000        	call	_TIM2_TimeBaseInit
2631  0030 85            	popw	x
2632                     ; 55 TIM2_CR1 |= 0x01;
2634  0031 72105300      	bset	_TIM2_CR1,#0
2635  0035               L1461:
2636                     ; 58 	x =40;
2638  0035 ae0028        	ldw	x,#40
2639  0038 bf04          	ldw	_x,x
2640                     ; 59 	y = 512;	
2642  003a ae0200        	ldw	x,#512
2643  003d bf06          	ldw	_y,x
2644                     ; 63 		CicloInicial = 500; //50%
2646  003f ae01f4        	ldw	x,#500
2647  0042 bf0a          	ldw	_CicloInicial,x
2648                     ; 64 		Duty=600; //80%
2650  0044 ae0258        	ldw	x,#600
2651  0047 bf00          	ldw	_Duty,x
2652                     ; 65 		Incremento=2;
2654  0049 ae0002        	ldw	x,#2
2655  004c bf08          	ldw	_Incremento,x
2656                     ; 66 		delay = 30; 
2658  004e ae001e        	ldw	x,#30
2659  0051 bf0c          	ldw	_delay,x
2660                     ; 86 		Sentido =0;
2662  0053 5f            	clrw	x
2663  0054 bf00          	ldw	_Sentido,x
2664                     ; 87 		CambiarSentido_Motor();
2666  0056 ad49          	call	_CambiarSentido_Motor
2668                     ; 88 		ControlVelocidad_Motor(Duty,Incremento);
2670  0058 be08          	ldw	x,_Incremento
2671  005a 89            	pushw	x
2672  005b be00          	ldw	x,_Duty
2673  005d ad03          	call	_ControlVelocidad_Motor
2675  005f 85            	popw	x
2677  0060 20d3          	jra	L1461
2726                     ; 95 void ControlVelocidad_Motor(int Duty,int Incremento){
2727                     	switch	.text
2728  0062               _ControlVelocidad_Motor:
2730  0062 89            	pushw	x
2731       00000000      OFST:	set	0
2734                     ; 98 for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
2736  0063 be0a          	ldw	x,_CicloInicial
2737  0065 bf02          	ldw	_pwm_duty,x
2739  0067 2011          	jra	L3761
2740  0069               L7661:
2741                     ; 100       TIM2_SetCompare1(pwm_duty); //set capture compair for Timer2
2743  0069 be02          	ldw	x,_pwm_duty
2744  006b cd0000        	call	_TIM2_SetCompare1
2746                     ; 101      delay_ms(delay); //delay for 10ms
2748  006e be0c          	ldw	x,_delay
2749  0070 cd013d        	call	_delay_ms
2751                     ; 98 for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
2753  0073 be02          	ldw	x,_pwm_duty
2754  0075 72fb05        	addw	x,(OFST+5,sp)
2755  0078 bf02          	ldw	_pwm_duty,x
2756  007a               L3761:
2759  007a 9c            	rvf
2760  007b be02          	ldw	x,_pwm_duty
2761  007d 1301          	cpw	x,(OFST+1,sp)
2762  007f 2fe8          	jrslt	L7661
2763                     ; 105 for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
2765  0081 1e01          	ldw	x,(OFST+1,sp)
2766  0083 bf02          	ldw	_pwm_duty,x
2768  0085 2011          	jra	L3071
2769  0087               L7761:
2770                     ; 106       TIM2_SetCompare1(pwm_duty);
2772  0087 be02          	ldw	x,_pwm_duty
2773  0089 cd0000        	call	_TIM2_SetCompare1
2775                     ; 107 			delay_ms(delay);
2777  008c be0c          	ldw	x,_delay
2778  008e cd013d        	call	_delay_ms
2780                     ; 105 for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
2782  0091 be02          	ldw	x,_pwm_duty
2783  0093 72f005        	subw	x,(OFST+5,sp)
2784  0096 bf02          	ldw	_pwm_duty,x
2785  0098               L3071:
2788  0098 9c            	rvf
2789  0099 be02          	ldw	x,_pwm_duty
2790  009b b30a          	cpw	x,_CicloInicial
2791  009d 2ce8          	jrsgt	L7761
2792                     ; 109 }
2795  009f 85            	popw	x
2796  00a0 81            	ret
2822                     ; 114 void CambiarSentido_Motor(void){
2823                     	switch	.text
2824  00a1               _CambiarSentido_Motor:
2828                     ; 116 	if(Sentido){
2830  00a1 be00          	ldw	x,_Sentido
2831  00a3 270a          	jreq	L7171
2832                     ; 118 		PC_ODR |= 0x80;
2834  00a5 721e500a      	bset	_PC_ODR,#7
2835                     ; 119 		PC_ODR &= ~0x40;
2837  00a9 721d500a      	bres	_PC_ODR,#6
2839  00ad 2008          	jra	L1271
2840  00af               L7171:
2841                     ; 122 		PC_ODR &= ~0x80;
2843  00af 721f500a      	bres	_PC_ODR,#7
2844                     ; 123 		PC_ODR |= 0x40;
2846  00b3 721c500a      	bset	_PC_ODR,#6
2847  00b7               L1271:
2848                     ; 126 }
2851  00b7 81            	ret
2883                     ; 127 void configurarGPIO(){
2884                     	switch	.text
2885  00b8               _configurarGPIO:
2889                     ; 130 	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
2891  00b8 725f5005      	clr	_PB_ODR
2892                     ; 131 	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
2894  00bc 725f500a      	clr	_PC_ODR
2895                     ; 132 	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
2897  00c0 725f500f      	clr	_PD_ODR
2898                     ; 151 	PB_DDR &= ~0x03;//Bits 0,1 en 0 para entradas Analogicas
2900  00c4 c65007        	ld	a,_PB_DDR
2901  00c7 a4fc          	and	a,#252
2902  00c9 c75007        	ld	_PB_DDR,a
2903                     ; 153 	PC_DDR |= 0xC4;// Bits 2,6,7 en 1 para salidas 1100 0100
2905  00cc c6500c        	ld	a,_PC_DDR
2906  00cf aac4          	or	a,#196
2907  00d1 c7500c        	ld	_PC_DDR,a
2908                     ; 161 	PB_CR1 &= ~0x03;//Entrada como flotante
2910  00d4 c65008        	ld	a,_PB_CR1
2911  00d7 a4fc          	and	a,#252
2912  00d9 c75008        	ld	_PB_CR1,a
2913                     ; 165 	PC_CR1 |= 0xC4; //Salidas push pull , se colocan en 1
2915  00dc c6500d        	ld	a,_PC_CR1
2916  00df aac4          	or	a,#196
2917  00e1 c7500d        	ld	_PC_CR1,a
2918                     ; 170 	PB_CR2 &= ~0x03;
2920  00e4 c65009        	ld	a,_PB_CR2
2921  00e7 a4fc          	and	a,#252
2922  00e9 c75009        	ld	_PB_CR2,a
2923                     ; 173 	PC_CR2 &= ~0xC4;
2925  00ec c6500e        	ld	a,_PC_CR2
2926  00ef a43b          	and	a,#59
2927  00f1 c7500e        	ld	_PC_CR2,a
2928                     ; 175 	}	
2931  00f4 81            	ret
2960                     ; 176 void Timer4_Init(){
2961                     	switch	.text
2962  00f5               _Timer4_Init:
2966                     ; 181 	TIM4_PSCR = 0x01; 
2968  00f5 35015345      	mov	_TIM4_PSCR,#1
2969                     ; 184 	TIM4_ARR  = 0xFF;
2971  00f9 35ff5346      	mov	_TIM4_ARR,#255
2972                     ; 186 	TIM4_CR1  = 0x00; //Resetear control de registro
2974  00fd 725f5340      	clr	_TIM4_CR1
2975                     ; 191 	TIM4_CR1  |= 0x04; 
2977  0101 72145340      	bset	_TIM4_CR1,#2
2978                     ; 198 	TIM4_EGR  = 1; 
2980  0105 35015343      	mov	_TIM4_EGR,#1
2981                     ; 201 	TIM4_CNTR = 0x00;	//Se pone en 0 el contador
2983  0109 725f5344      	clr	_TIM4_CNTR
2984                     ; 204 	TIM4_IER &= ~0x01; 
2986  010d 72115341      	bres	_TIM4_IER,#0
2987                     ; 205 }
2990  0111 81            	ret
3028                     ; 206 void delay_us(int tiempo){
3029                     	switch	.text
3030  0112               _delay_us:
3032  0112 89            	pushw	x
3033       00000000      OFST:	set	0
3036                     ; 216 TIM4_EGR |= 0x01; 
3038  0113 72105343      	bset	_TIM4_EGR,#0
3039                     ; 217 TIM4_CNTR = 0x00;	//Se pone en 0 el contador
3041  0117 725f5344      	clr	_TIM4_CNTR
3042                     ; 220 TIM4_CR1 |= 0x01;
3044  011b 72105340      	bset	_TIM4_CR1,#0
3046  011f 2008          	jra	L3671
3047  0121               L1671:
3048                     ; 223 		TIM4_CR1 &= 0x01;
3050  0121 c65340        	ld	a,_TIM4_CR1
3051  0124 a401          	and	a,#1
3052  0126 c75340        	ld	_TIM4_CR1,a
3053  0129               L3671:
3054                     ; 222 	while(TIM4_CNTR<tiempo){
3056  0129 9c            	rvf
3057  012a c65344        	ld	a,_TIM4_CNTR
3058  012d 5f            	clrw	x
3059  012e 97            	ld	xl,a
3060  012f 1301          	cpw	x,(OFST+1,sp)
3061  0131 2fee          	jrslt	L1671
3062                     ; 227 	TIM4_SR  &= 0x01;
3064  0133 c65342        	ld	a,_TIM4_SR
3065  0136 a401          	and	a,#1
3066  0138 c75342        	ld	_TIM4_SR,a
3067                     ; 228 }
3070  013b 85            	popw	x
3071  013c 81            	ret
3106                     ; 229 void delay_ms(int tiempo){
3107                     	switch	.text
3108  013d               _delay_ms:
3110  013d 89            	pushw	x
3111       00000000      OFST:	set	0
3114                     ; 234 	tiempo=tiempo*10;
3116  013e 1e01          	ldw	x,(OFST+1,sp)
3117  0140 a60a          	ld	a,#10
3118  0142 cd0000        	call	c_bmulx
3120  0145 1f01          	ldw	(OFST+1,sp),x
3122  0147 2005          	jra	L7002
3123  0149               L5002:
3124                     ; 236 	delay_us(100);
3126  0149 ae0064        	ldw	x,#100
3127  014c adc4          	call	_delay_us
3129  014e               L7002:
3130                     ; 235 	while(tiempo--){
3132  014e 1e01          	ldw	x,(OFST+1,sp)
3133  0150 1d0001        	subw	x,#1
3134  0153 1f01          	ldw	(OFST+1,sp),x
3135  0155 1c0001        	addw	x,#1
3136  0158 a30000        	cpw	x,#0
3137  015b 26ec          	jrne	L5002
3138                     ; 238 }
3141  015d 85            	popw	x
3142  015e 81            	ret
3229                     	xdef	_main
3230                     	xdef	_delay
3231                     	xdef	_CicloInicial
3232                     	xdef	_Incremento
3233                     	switch	.ubsct
3234  0000               _Duty:
3235  0000 0000          	ds.b	2
3236                     	xdef	_Duty
3237                     	xdef	_y
3238                     	xdef	_x
3239                     	xdef	_pwm_duty
3240                     	xdef	_Sentido
3241                     	xdef	_ControlVelocidad_Motor
3242                     	xdef	_CambiarSentido_Motor
3243                     	xdef	_delay_ms
3244                     	xdef	_delay_us
3245                     	xdef	_Timer4_Init
3246                     	xdef	_configurarGPIO
3247                     	xref	_TIM2_SetCompare1
3248                     	xref	_TIM2_OC1Init
3249                     	xref	_TIM2_TimeBaseInit
3250                     	xref	_TIM2_DeInit
3251                     	xref	_GPIO_Init
3252                     	xref	_GPIO_DeInit
3253                     	xref.b	c_x
3273                     	xref	c_bmulx
3274                     	end
