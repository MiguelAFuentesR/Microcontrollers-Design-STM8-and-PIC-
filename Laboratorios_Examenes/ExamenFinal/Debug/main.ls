   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
2523                     	bsct
2524  0000               _pwm_duty:
2525  0000 0000          	dc.w	0
2526  0002               _Frecuency:
2527  0002 0000          	dc.w	0
2528  0004               _Incremento:
2529  0004 0000          	dc.w	0
2530  0006               _CicloInicial:
2531  0006 0000          	dc.w	0
2532  0008               _Sentido:
2533  0008 0000          	dc.w	0
2534  000a               _delay:
2535  000a 0000          	dc.w	0
2536  000c               _Vx:
2537  000c 00000000      	dc.w	0,0
2538  0010               _Vy:
2539  0010 00000000      	dc.w	0,0
2540  0014               _ADC_x:
2541  0014 00000000      	dc.w	0,0
2542  0018               _ADC_y:
2543  0018 00000000      	dc.w	0,0
2544  001c               _Centroy:
2545  001c 00000000      	dc.w	0,0
2546  0020               _Distancia:
2547  0020 00000000      	dc.w	0,0
2548  0024               _calibracion:
2549  0024 00dc          	dc.w	220
2550  0026               _comando:
2551  0026 0a            	dc.b	10
2552  0027 2c            	dc.b	44
2601                     ; 83 main()
2601                     ; 84 {
2603                     	switch	.text
2604  0000               _main:
2606  0000 5204          	subw	sp,#4
2607       00000004      OFST:	set	4
2610                     ; 86 	configurarGPIO();
2612  0002 cd02f1        	call	_configurarGPIO
2614                     ; 87 	Timer4_Init();
2616  0005 cd032e        	call	_Timer4_Init
2618                     ; 89 	PWM_Init();
2620  0008 cd0204        	call	_PWM_Init
2622                     ; 91 	UART_Init();
2624  000b cd0163        	call	_UART_Init
2626  000e               L1461:
2627                     ; 96 		ADC_x = Leer_ADC (0);
2629  000e 5f            	clrw	x
2630  000f cd0234        	call	_Leer_ADC
2632  0012 cd0000        	call	c_uitof
2634  0015 ae0014        	ldw	x,#_ADC_x
2635  0018 cd0000        	call	c_rtol
2637                     ; 97 		ADC_y = Leer_ADC (1);
2639  001b ae0001        	ldw	x,#1
2640  001e cd0234        	call	_Leer_ADC
2642  0021 cd0000        	call	c_uitof
2644  0024 ae0018        	ldw	x,#_ADC_y
2645  0027 cd0000        	call	c_rtol
2647                     ; 100 		Vx = (ADC_x *3.3)/1023;
2649  002a ae0014        	ldw	x,#_ADC_x
2650  002d cd0000        	call	c_ltor
2652  0030 ae0018        	ldw	x,#L1561
2653  0033 cd0000        	call	c_fmul
2655  0036 ae0014        	ldw	x,#L1661
2656  0039 cd0000        	call	c_fdiv
2658  003c ae000c        	ldw	x,#_Vx
2659  003f cd0000        	call	c_rtol
2661                     ; 101 		Vy = (ADC_y *3.3)/1023;
2663  0042 ae0018        	ldw	x,#_ADC_y
2664  0045 cd0000        	call	c_ltor
2666  0048 ae0018        	ldw	x,#L1561
2667  004b cd0000        	call	c_fmul
2669  004e ae0014        	ldw	x,#L1661
2670  0051 cd0000        	call	c_fdiv
2672  0054 ae0010        	ldw	x,#_Vy
2673  0057 cd0000        	call	c_rtol
2675                     ; 106 		Centrox = 502;
2677  005a ae01f6        	ldw	x,#502
2678  005d cd0000        	call	c_itof
2680  0060 ae0006        	ldw	x,#_Centrox
2681  0063 cd0000        	call	c_rtol
2683                     ; 107 		Centroy = 513;
2685  0066 ae0201        	ldw	x,#513
2686  0069 cd0000        	call	c_itof
2688  006c ae001c        	ldw	x,#_Centroy
2689  006f cd0000        	call	c_rtol
2691                     ; 111 		Distancia = sqrt(pow(ADC_x-Centrox, 2) + pow(ADC_y-Centroy, 2));
2693  0072 ce000e        	ldw	x,L1071+2
2694  0075 89            	pushw	x
2695  0076 ce000c        	ldw	x,L1071
2696  0079 89            	pushw	x
2697  007a ae0018        	ldw	x,#_ADC_y
2698  007d cd0000        	call	c_ltor
2700  0080 ae001c        	ldw	x,#_Centroy
2701  0083 cd0000        	call	c_fsub
2703  0086 be02          	ldw	x,c_lreg+2
2704  0088 89            	pushw	x
2705  0089 be00          	ldw	x,c_lreg
2706  008b 89            	pushw	x
2707  008c cd0000        	call	_pow
2709  008f 5b08          	addw	sp,#8
2710  0091 96            	ldw	x,sp
2711  0092 1c0001        	addw	x,#OFST-3
2712  0095 cd0000        	call	c_rtol
2715  0098 ce000e        	ldw	x,L1071+2
2716  009b 89            	pushw	x
2717  009c ce000c        	ldw	x,L1071
2718  009f 89            	pushw	x
2719  00a0 ae0014        	ldw	x,#_ADC_x
2720  00a3 cd0000        	call	c_ltor
2722  00a6 ae0010        	ldw	x,#L1761
2723  00a9 cd0000        	call	c_fsub
2725  00ac be02          	ldw	x,c_lreg+2
2726  00ae 89            	pushw	x
2727  00af be00          	ldw	x,c_lreg
2728  00b1 89            	pushw	x
2729  00b2 cd0000        	call	_pow
2731  00b5 5b08          	addw	sp,#8
2732  00b7 96            	ldw	x,sp
2733  00b8 1c0001        	addw	x,#OFST-3
2734  00bb cd0000        	call	c_fadd
2736  00be be02          	ldw	x,c_lreg+2
2737  00c0 89            	pushw	x
2738  00c1 be00          	ldw	x,c_lreg
2739  00c3 89            	pushw	x
2740  00c4 cd0000        	call	_sqrt
2742  00c7 5b04          	addw	sp,#4
2743  00c9 ae0020        	ldw	x,#_Distancia
2744  00cc cd0000        	call	c_rtol
2746                     ; 116 	if(ADC_x >= Centrox && ADC_x <= 1023){
2748  00cf 9c            	rvf
2749  00d0 ae0014        	ldw	x,#_ADC_x
2750  00d3 cd0000        	call	c_ltor
2752  00d6 ae0006        	ldw	x,#_Centrox
2753  00d9 cd0000        	call	c_fcmp
2755  00dc 2f22          	jrslt	L5071
2757  00de 9c            	rvf
2758  00df ae03ff        	ldw	x,#1023
2759  00e2 cd0000        	call	c_itof
2761  00e5 96            	ldw	x,sp
2762  00e6 1c0001        	addw	x,#OFST-3
2763  00e9 cd0000        	call	c_rtol
2766  00ec ae0014        	ldw	x,#_ADC_x
2767  00ef cd0000        	call	c_ltor
2769  00f2 96            	ldw	x,sp
2770  00f3 1c0001        	addw	x,#OFST-3
2771  00f6 cd0000        	call	c_fcmp
2773  00f9 2c05          	jrsgt	L5071
2774                     ; 118 		Sentido = 0;
2776  00fb 5f            	clrw	x
2777  00fc bf08          	ldw	_Sentido,x
2779  00fe 2005          	jra	L7071
2780  0100               L5071:
2781                     ; 122 		Sentido = 1;
2783  0100 ae0001        	ldw	x,#1
2784  0103 bf08          	ldw	_Sentido,x
2785  0105               L7071:
2786                     ; 127 		if (Distancia>10){
2788  0105 9c            	rvf
2789  0106 a60a          	ld	a,#10
2790  0108 cd0000        	call	c_ctof
2792  010b 96            	ldw	x,sp
2793  010c 1c0001        	addw	x,#OFST-3
2794  010f cd0000        	call	c_rtol
2797  0112 ae0020        	ldw	x,#_Distancia
2798  0115 cd0000        	call	c_ltor
2800  0118 96            	ldw	x,sp
2801  0119 1c0001        	addw	x,#OFST-3
2802  011c cd0000        	call	c_fcmp
2804  011f 2d02          	jrsle	L1171
2805                     ; 128 		Transmision();
2807  0121 ad1a          	call	_Transmision
2809  0123               L1171:
2810                     ; 132 		Duty=Distancia + calibracion; 
2812  0123 be24          	ldw	x,_calibracion
2813  0125 cd0000        	call	c_itof
2815  0128 ae0020        	ldw	x,#_Distancia
2816  012b cd0000        	call	c_fadd
2818  012e cd0000        	call	c_ftoi
2820  0131 bf0a          	ldw	_Duty,x
2821                     ; 133 		CambiarSentido_Motor();
2823  0133 cd0290        	call	_CambiarSentido_Motor
2825                     ; 134 		ControlVelocidad_Motor2();
2827  0136 cd02e6        	call	_ControlVelocidad_Motor2
2830  0139 ac0e000e      	jpf	L1461
2859                     ; 138 void Transmision(void){
2860                     	switch	.text
2861  013d               _Transmision:
2865                     ; 142 	if (UART2_SR & (1 << 5)) {
2867  013d c65240        	ld	a,_UART2_SR
2868  0140 a520          	bcp	a,#32
2869  0142 271e          	jreq	L3271
2870                     ; 143 		EnviarDatos(ADC_x);
2872  0144 be16          	ldw	x,_ADC_x+2
2873  0146 89            	pushw	x
2874  0147 be14          	ldw	x,_ADC_x
2875  0149 89            	pushw	x
2876  014a ad34          	call	_EnviarDatos
2878  014c 5b04          	addw	sp,#4
2879                     ; 145 		UART_TX(comando[1]);
2881  014e b627          	ld	a,_comando+1
2882  0150 cd01ee        	call	_UART_TX
2884                     ; 146 		EnviarDatos(ADC_y);
2886  0153 be1a          	ldw	x,_ADC_y+2
2887  0155 89            	pushw	x
2888  0156 be18          	ldw	x,_ADC_y
2889  0158 89            	pushw	x
2890  0159 ad25          	call	_EnviarDatos
2892  015b 5b04          	addw	sp,#4
2893                     ; 148 		UART_TX(comando[0]);
2895  015d b626          	ld	a,_comando
2896  015f cd01ee        	call	_UART_TX
2898  0162               L3271:
2899                     ; 150 }
2902  0162 81            	ret
2930                     ; 153 void UART_Init(void){
2931                     	switch	.text
2932  0163               _UART_Init:
2936                     ; 154   CLK_PCKENR1 = 0xFF;  // Activar todos los perifericos 
2938  0163 35ff50c7      	mov	_CLK_PCKENR1,#255
2939                     ; 165   UART2_BRR2 = 0x00;
2941  0167 725f5243      	clr	_UART2_BRR2
2942                     ; 166   UART2_BRR1 = 0x0D;  
2944  016b 350d5242      	mov	_UART2_BRR1,#13
2945                     ; 168   UART2_CR3 &= ~((1 << 4) | (1 << 5)); 
2947  016f c65246        	ld	a,_UART2_CR3
2948  0172 a4cf          	and	a,#207
2949  0174 c75246        	ld	_UART2_CR3,a
2950                     ; 170   UART2_CR2 |= (1 << 2)| (1 << 3); 
2952  0177 c65245        	ld	a,_UART2_CR2
2953  017a aa0c          	or	a,#12
2954  017c c75245        	ld	_UART2_CR2,a
2955                     ; 172 }
2958  017f 81            	ret
2995                     ; 177 void EnviarDatos(double Valor){
2996                     	switch	.text
2997  0180               _EnviarDatos:
2999  0180 5204          	subw	sp,#4
3000       00000004      OFST:	set	4
3003                     ; 179 	sprintf(StringValor,"%d.%02u", (int) Valor, (int) ((Valor - (int) Valor) * 100) );
3005  0182 96            	ldw	x,sp
3006  0183 1c0007        	addw	x,#OFST+3
3007  0186 cd0000        	call	c_ltor
3009  0189 cd0000        	call	c_ftoi
3011  018c cd0000        	call	c_itof
3013  018f 96            	ldw	x,sp
3014  0190 1c0001        	addw	x,#OFST-3
3015  0193 cd0000        	call	c_rtol
3018  0196 96            	ldw	x,sp
3019  0197 1c0007        	addw	x,#OFST+3
3020  019a cd0000        	call	c_ltor
3022  019d 96            	ldw	x,sp
3023  019e 1c0001        	addw	x,#OFST-3
3024  01a1 cd0000        	call	c_fsub
3026  01a4 ae0000        	ldw	x,#L1671
3027  01a7 cd0000        	call	c_fmul
3029  01aa cd0000        	call	c_ftoi
3031  01ad 89            	pushw	x
3032  01ae 96            	ldw	x,sp
3033  01af 1c0009        	addw	x,#OFST+5
3034  01b2 cd0000        	call	c_ltor
3036  01b5 cd0000        	call	c_ftoi
3038  01b8 89            	pushw	x
3039  01b9 ae0004        	ldw	x,#L3571
3040  01bc 89            	pushw	x
3041  01bd ae0000        	ldw	x,#_StringValor
3042  01c0 cd0000        	call	_sprintf
3044  01c3 5b06          	addw	sp,#6
3045                     ; 180 	EnviarCadena(StringValor);
3047  01c5 ae0000        	ldw	x,#_StringValor
3048  01c8 ad03          	call	_EnviarCadena
3050                     ; 181 }
3053  01ca 5b04          	addw	sp,#4
3054  01cc 81            	ret
3099                     ; 184 void EnviarCadena(unsigned char *a){
3100                     	switch	.text
3101  01cd               _EnviarCadena:
3103  01cd 89            	pushw	x
3104  01ce 89            	pushw	x
3105       00000002      OFST:	set	2
3108                     ; 187 	for(i=0;a[i]!='\0';i++){
3110  01cf 5f            	clrw	x
3111  01d0 1f01          	ldw	(OFST-1,sp),x
3114  01d2 200f          	jra	L3102
3115  01d4               L7002:
3116                     ; 188 		UART_TX(a[i]); 
3118  01d4 1e01          	ldw	x,(OFST-1,sp)
3119  01d6 72fb03        	addw	x,(OFST+1,sp)
3120  01d9 f6            	ld	a,(x)
3121  01da ad12          	call	_UART_TX
3123                     ; 187 	for(i=0;a[i]!='\0';i++){
3125  01dc 1e01          	ldw	x,(OFST-1,sp)
3126  01de 1c0001        	addw	x,#1
3127  01e1 1f01          	ldw	(OFST-1,sp),x
3129  01e3               L3102:
3132  01e3 1e01          	ldw	x,(OFST-1,sp)
3133  01e5 72fb03        	addw	x,(OFST+1,sp)
3134  01e8 7d            	tnz	(x)
3135  01e9 26e9          	jrne	L7002
3136                     ; 190 }
3139  01eb 5b04          	addw	sp,#4
3140  01ed 81            	ret
3176                     ; 193 void UART_TX(unsigned char val) {
3177                     	switch	.text
3178  01ee               _UART_TX:
3182                     ; 194   UART2_DR = val;
3184  01ee c75241        	ld	_UART2_DR,a
3186  01f1               L1402:
3187                     ; 195   while (!(UART2_SR & (1 << 6)));
3189  01f1 c65240        	ld	a,_UART2_SR
3190  01f4 a540          	bcp	a,#64
3191  01f6 27f9          	jreq	L1402
3192                     ; 196 }
3195  01f8 81            	ret
3231                     ; 199 void Enviar_DatosUART(unsigned char valor){
3232                     	switch	.text
3233  01f9               _Enviar_DatosUART:
3237                     ; 200 	UART2_DR = valor; 
3239  01f9 c75241        	ld	_UART2_DR,a
3241  01fc               L7602:
3242                     ; 201 	 while (!(UART2_SR & (1 << 6)));
3244  01fc c65240        	ld	a,_UART2_SR
3245  01ff a540          	bcp	a,#64
3246  0201 27f9          	jreq	L7602
3247                     ; 202 }
3250  0203 81            	ret
3279                     ; 204 void PWM_Init(void){
3280                     	switch	.text
3281  0204               _PWM_Init:
3285                     ; 206 	GPIO_DeInit(GPIOD);
3287  0204 ae500f        	ldw	x,#20495
3288  0207 cd0000        	call	_GPIO_DeInit
3290                     ; 208 	TIM2_DeInit();
3292  020a cd0000        	call	_TIM2_DeInit
3294                     ; 209 	GPIO_Init(GPIOD,GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_FAST);
3296  020d 4bf0          	push	#240
3297  020f 4b10          	push	#16
3298  0211 ae500f        	ldw	x,#20495
3299  0214 cd0000        	call	_GPIO_Init
3301  0217 85            	popw	x
3302                     ; 213 	TIM2_OC1Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 1000,TIM2_OCPOLARITY_HIGH);
3304  0218 4b00          	push	#0
3305  021a ae03e8        	ldw	x,#1000
3306  021d 89            	pushw	x
3307  021e ae6011        	ldw	x,#24593
3308  0221 cd0000        	call	_TIM2_OC1Init
3310  0224 5b03          	addw	sp,#3
3311                     ; 217 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, 1000);
3313  0226 ae03e8        	ldw	x,#1000
3314  0229 89            	pushw	x
3315  022a 4f            	clr	a
3316  022b cd0000        	call	_TIM2_TimeBaseInit
3318  022e 85            	popw	x
3319                     ; 219 	TIM2_CR1 |= 0x01;
3321  022f 72105300      	bset	_TIM2_CR1,#0
3322                     ; 220 }
3325  0233 81            	ret
3375                     ; 222 unsigned int Leer_ADC(int Pin)
3375                     ; 223  {
3376                     	switch	.text
3377  0234               _Leer_ADC:
3379  0234 89            	pushw	x
3380  0235 89            	pushw	x
3381       00000002      OFST:	set	2
3384                     ; 224    unsigned int conversion = 0;
3386                     ; 226 	 ADC1_DeInit();
3388  0236 cd0000        	call	_ADC1_DeInit
3390                     ; 229 	 if (Pin == 0){
3392  0239 1e03          	ldw	x,(OFST+1,sp)
3393  023b 2616          	jrne	L5212
3394                     ; 231 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS,
3394                     ; 232                  ADC1_CHANNEL_0,
3394                     ; 233                  ADC1_PRESSEL_FCPU_D2,
3394                     ; 234                  ADC1_EXTTRIG_GPIO,
3394                     ; 235                  DISABLE,
3394                     ; 236                  ADC1_ALIGN_RIGHT,
3394                     ; 237                  ADC1_SCHMITTTRIG_CHANNEL0,
3394                     ; 238                  DISABLE);
3396  023d 4b00          	push	#0
3397  023f 4b00          	push	#0
3398  0241 4b08          	push	#8
3399  0243 4b00          	push	#0
3400  0245 4b10          	push	#16
3401  0247 4b00          	push	#0
3402  0249 ae0100        	ldw	x,#256
3403  024c cd0000        	call	_ADC1_Init
3405  024f 5b06          	addw	sp,#6
3407  0251 201b          	jra	L7212
3408  0253               L5212:
3409                     ; 241 	}else if (Pin == 1){
3411  0253 1e03          	ldw	x,(OFST+1,sp)
3412  0255 a30001        	cpw	x,#1
3413  0258 2614          	jrne	L7212
3414                     ; 242 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS,
3414                     ; 243                  ADC1_CHANNEL_1,
3414                     ; 244                  ADC1_PRESSEL_FCPU_D2,
3414                     ; 245                  ADC1_EXTTRIG_GPIO,
3414                     ; 246                  DISABLE,
3414                     ; 247                  ADC1_ALIGN_RIGHT,
3414                     ; 248                  ADC1_SCHMITTTRIG_CHANNEL0,
3414                     ; 249                  DISABLE);
3416  025a 4b00          	push	#0
3417  025c 4b00          	push	#0
3418  025e 4b08          	push	#8
3419  0260 4b00          	push	#0
3420  0262 4b10          	push	#16
3421  0264 4b00          	push	#0
3422  0266 ae0101        	ldw	x,#257
3423  0269 cd0000        	call	_ADC1_Init
3425  026c 5b06          	addw	sp,#6
3426  026e               L7212:
3427                     ; 251 	ADC1_Cmd(ENABLE);
3429  026e a601          	ld	a,#1
3430  0270 cd0000        	call	_ADC1_Cmd
3432                     ; 252 	ADC1_StartConversion();
3434  0273 cd0000        	call	_ADC1_StartConversion
3437  0276               L5312:
3438                     ; 253 	while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);                    
3440  0276 a680          	ld	a,#128
3441  0278 cd0000        	call	_ADC1_GetFlagStatus
3443  027b 4d            	tnz	a
3444  027c 27f8          	jreq	L5312
3445                     ; 254   conversion = ADC1_GetConversionValue();
3447  027e cd0000        	call	_ADC1_GetConversionValue
3449  0281 1f01          	ldw	(OFST-1,sp),x
3451                     ; 255   ADC1_ClearFlag(ADC1_FLAG_EOC);
3453  0283 a680          	ld	a,#128
3454  0285 cd0000        	call	_ADC1_ClearFlag
3456                     ; 256 	ADC1_DeInit();
3458  0288 cd0000        	call	_ADC1_DeInit
3460                     ; 257 	return conversion; 
3462  028b 1e01          	ldw	x,(OFST-1,sp)
3465  028d 5b04          	addw	sp,#4
3466  028f 81            	ret
3492                     ; 259 void CambiarSentido_Motor(void){
3493                     	switch	.text
3494  0290               _CambiarSentido_Motor:
3498                     ; 261 	if(Sentido){
3500  0290 be08          	ldw	x,_Sentido
3501  0292 270a          	jreq	L1512
3502                     ; 263 		PC_ODR |= 0x80;
3504  0294 721e500a      	bset	_PC_ODR,#7
3505                     ; 264 		PC_ODR &= ~0x40;
3507  0298 721d500a      	bres	_PC_ODR,#6
3509  029c 2008          	jra	L3512
3510  029e               L1512:
3511                     ; 267 		PC_ODR &= ~0x80;
3513  029e 721f500a      	bres	_PC_ODR,#7
3514                     ; 268 		PC_ODR |= 0x40;
3516  02a2 721c500a      	bset	_PC_ODR,#6
3517  02a6               L3512:
3518                     ; 271 }
3521  02a6 81            	ret
3570                     ; 272 void ControlVelocidad_Motor(int Duty,int Incremento){
3571                     	switch	.text
3572  02a7               _ControlVelocidad_Motor:
3574  02a7 89            	pushw	x
3575       00000000      OFST:	set	0
3578                     ; 276 for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
3580  02a8 be06          	ldw	x,_CicloInicial
3581  02aa bf00          	ldw	_pwm_duty,x
3583  02ac 2011          	jra	L3022
3584  02ae               L7712:
3585                     ; 278       TIM2_SetCompare1(pwm_duty); //set capture compair for Timer2
3587  02ae be00          	ldw	x,_pwm_duty
3588  02b0 cd0000        	call	_TIM2_SetCompare1
3590                     ; 279       delay_ms(delay); //delay for 10ms
3592  02b3 be0a          	ldw	x,_delay
3593  02b5 cd0376        	call	_delay_ms
3595                     ; 276 for(pwm_duty = CicloInicial; pwm_duty < Duty; pwm_duty += Incremento){
3597  02b8 be00          	ldw	x,_pwm_duty
3598  02ba 72fb05        	addw	x,(OFST+5,sp)
3599  02bd bf00          	ldw	_pwm_duty,x
3600  02bf               L3022:
3603  02bf 9c            	rvf
3604  02c0 be00          	ldw	x,_pwm_duty
3605  02c2 1301          	cpw	x,(OFST+1,sp)
3606  02c4 2fe8          	jrslt	L7712
3607                     ; 284 for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
3609  02c6 1e01          	ldw	x,(OFST+1,sp)
3610  02c8 bf00          	ldw	_pwm_duty,x
3612  02ca 2011          	jra	L3122
3613  02cc               L7022:
3614                     ; 285       TIM2_SetCompare1(pwm_duty);
3616  02cc be00          	ldw	x,_pwm_duty
3617  02ce cd0000        	call	_TIM2_SetCompare1
3619                     ; 286 			delay_ms(delay);
3621  02d1 be0a          	ldw	x,_delay
3622  02d3 cd0376        	call	_delay_ms
3624                     ; 284 for(pwm_duty = Duty; pwm_duty > CicloInicial; pwm_duty -= Incremento){
3626  02d6 be00          	ldw	x,_pwm_duty
3627  02d8 72f005        	subw	x,(OFST+5,sp)
3628  02db bf00          	ldw	_pwm_duty,x
3629  02dd               L3122:
3632  02dd 9c            	rvf
3633  02de be00          	ldw	x,_pwm_duty
3634  02e0 b306          	cpw	x,_CicloInicial
3635  02e2 2ce8          	jrsgt	L7022
3636                     ; 288 }
3639  02e4 85            	popw	x
3640  02e5 81            	ret
3668                     ; 290 void ControlVelocidad_Motor2(){
3669                     	switch	.text
3670  02e6               _ControlVelocidad_Motor2:
3674                     ; 292       TIM2_SetCompare1(Duty); 
3676  02e6 be0a          	ldw	x,_Duty
3677  02e8 cd0000        	call	_TIM2_SetCompare1
3679                     ; 293       delay_ms(delay); //delay 
3681  02eb be0a          	ldw	x,_delay
3682  02ed cd0376        	call	_delay_ms
3684                     ; 294 }
3687  02f0 81            	ret
3719                     ; 297 void configurarGPIO(){
3720                     	switch	.text
3721  02f1               _configurarGPIO:
3725                     ; 300 	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
3727  02f1 725f5005      	clr	_PB_ODR
3728                     ; 301 	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
3730  02f5 725f500a      	clr	_PC_ODR
3731                     ; 302 	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
3733  02f9 725f500f      	clr	_PD_ODR
3734                     ; 321 	PB_DDR &= ~0x03;//Bits 0,1 en 0 para entradas Analogicas
3736  02fd c65007        	ld	a,_PB_DDR
3737  0300 a4fc          	and	a,#252
3738  0302 c75007        	ld	_PB_DDR,a
3739                     ; 323 	PC_DDR |= 0xC4;// Bits 2,6,7 en 1 para salidas 1100 0100
3741  0305 c6500c        	ld	a,_PC_DDR
3742  0308 aac4          	or	a,#196
3743  030a c7500c        	ld	_PC_DDR,a
3744                     ; 331 	PB_CR1 &= ~0x03;//Entrada como flotante
3746  030d c65008        	ld	a,_PB_CR1
3747  0310 a4fc          	and	a,#252
3748  0312 c75008        	ld	_PB_CR1,a
3749                     ; 335 	PC_CR1 |= 0xC4; //Salidas push pull , se colocan en 1
3751  0315 c6500d        	ld	a,_PC_CR1
3752  0318 aac4          	or	a,#196
3753  031a c7500d        	ld	_PC_CR1,a
3754                     ; 340 	PB_CR2 &= ~0x03;
3756  031d c65009        	ld	a,_PB_CR2
3757  0320 a4fc          	and	a,#252
3758  0322 c75009        	ld	_PB_CR2,a
3759                     ; 343 	PC_CR2 &= ~0xC4;
3761  0325 c6500e        	ld	a,_PC_CR2
3762  0328 a43b          	and	a,#59
3763  032a c7500e        	ld	_PC_CR2,a
3764                     ; 345 	}
3767  032d 81            	ret
3796                     ; 346 void Timer4_Init(){
3797                     	switch	.text
3798  032e               _Timer4_Init:
3802                     ; 351 	TIM4_PSCR = 0x01; 
3804  032e 35015345      	mov	_TIM4_PSCR,#1
3805                     ; 354 	TIM4_ARR  = 0xFF;
3807  0332 35ff5346      	mov	_TIM4_ARR,#255
3808                     ; 356 	TIM4_CR1  = 0x00; //Resetear control de registro
3810  0336 725f5340      	clr	_TIM4_CR1
3811                     ; 361 	TIM4_CR1  |= 0x04; 
3813  033a 72145340      	bset	_TIM4_CR1,#2
3814                     ; 368 	TIM4_EGR  = 1; 
3816  033e 35015343      	mov	_TIM4_EGR,#1
3817                     ; 371 	TIM4_CNTR = 0x00;	//Se pone en 0 el contador
3819  0342 725f5344      	clr	_TIM4_CNTR
3820                     ; 374 	TIM4_IER &= ~0x01; 
3822  0346 72115341      	bres	_TIM4_IER,#0
3823                     ; 375 }
3826  034a 81            	ret
3864                     ; 376 void delay_us(int tiempo){
3865                     	switch	.text
3866  034b               _delay_us:
3868  034b 89            	pushw	x
3869       00000000      OFST:	set	0
3872                     ; 386 TIM4_EGR |= 0x01; 
3874  034c 72105343      	bset	_TIM4_EGR,#0
3875                     ; 387 TIM4_CNTR = 0x00;	//Se pone en 0 el contador
3877  0350 725f5344      	clr	_TIM4_CNTR
3878                     ; 390 TIM4_CR1 |= 0x01;
3880  0354 72105340      	bset	_TIM4_CR1,#0
3882  0358 2008          	jra	L7622
3883  035a               L5622:
3884                     ; 393 		TIM4_CR1 &= 0x01;
3886  035a c65340        	ld	a,_TIM4_CR1
3887  035d a401          	and	a,#1
3888  035f c75340        	ld	_TIM4_CR1,a
3889  0362               L7622:
3890                     ; 392 	while(TIM4_CNTR<tiempo){
3892  0362 9c            	rvf
3893  0363 c65344        	ld	a,_TIM4_CNTR
3894  0366 5f            	clrw	x
3895  0367 97            	ld	xl,a
3896  0368 1301          	cpw	x,(OFST+1,sp)
3897  036a 2fee          	jrslt	L5622
3898                     ; 397 	TIM4_SR  &= 0x01;
3900  036c c65342        	ld	a,_TIM4_SR
3901  036f a401          	and	a,#1
3902  0371 c75342        	ld	_TIM4_SR,a
3903                     ; 398 }
3906  0374 85            	popw	x
3907  0375 81            	ret
3942                     ; 399 void delay_ms(int tiempo){
3943                     	switch	.text
3944  0376               _delay_ms:
3946  0376 89            	pushw	x
3947       00000000      OFST:	set	0
3950                     ; 404 	tiempo=tiempo*10;
3952  0377 1e01          	ldw	x,(OFST+1,sp)
3953  0379 a60a          	ld	a,#10
3954  037b cd0000        	call	c_bmulx
3956  037e 1f01          	ldw	(OFST+1,sp),x
3958  0380 2005          	jra	L3132
3959  0382               L1132:
3960                     ; 406 	delay_us(100);
3962  0382 ae0064        	ldw	x,#100
3963  0385 adc4          	call	_delay_us
3965  0387               L3132:
3966                     ; 405 	while(tiempo--){
3968  0387 1e01          	ldw	x,(OFST+1,sp)
3969  0389 1d0001        	subw	x,#1
3970  038c 1f01          	ldw	(OFST+1,sp),x
3971  038e 1c0001        	addw	x,#1
3972  0391 a30000        	cpw	x,#0
3973  0394 26ec          	jrne	L1132
3974                     ; 408 }
3977  0396 85            	popw	x
3978  0397 81            	ret
4148                     	xdef	_Enviar_DatosUART
4149                     	switch	.ubsct
4150  0000               _StringValor:
4151  0000 000000000000  	ds.b	6
4152                     	xdef	_StringValor
4153                     	xdef	_main
4154                     	xdef	_comando
4155                     	xdef	_calibracion
4156                     	xdef	_Distancia
4157                     	xdef	_Centroy
4158  0006               _Centrox:
4159  0006 00000000      	ds.b	4
4160                     	xdef	_Centrox
4161                     	xdef	_ADC_y
4162                     	xdef	_ADC_x
4163                     	xdef	_Vy
4164                     	xdef	_Vx
4165                     	xdef	_delay
4166                     	xdef	_Sentido
4167                     	xdef	_CicloInicial
4168                     	xdef	_Incremento
4169                     	xdef	_Frecuency
4170  000a               _Duty:
4171  000a 0000          	ds.b	2
4172                     	xdef	_Duty
4173                     	xdef	_pwm_duty
4174                     	xdef	_Transmision
4175                     	xdef	_UART_Init
4176                     	xdef	_EnviarDatos
4177                     	xdef	_EnviarCadena
4178                     	xdef	_UART_TX
4179                     	xdef	_PWM_Init
4180                     	xdef	_ControlVelocidad_Motor
4181                     	xdef	_ControlVelocidad_Motor2
4182                     	xdef	_CambiarSentido_Motor
4183                     	xdef	_delay_ms
4184                     	xdef	_delay_us
4185                     	xdef	_Timer4_Init
4186                     	xdef	_Leer_ADC
4187                     	xdef	_configurarGPIO
4188                     	xref	_sqrt
4189                     	xref	_pow
4190                     	xref	_sprintf
4191                     	xref	_TIM2_SetCompare1
4192                     	xref	_TIM2_OC1Init
4193                     	xref	_TIM2_TimeBaseInit
4194                     	xref	_TIM2_DeInit
4195                     	xref	_GPIO_Init
4196                     	xref	_GPIO_DeInit
4197                     	xref	_ADC1_ClearFlag
4198                     	xref	_ADC1_GetFlagStatus
4199                     	xref	_ADC1_GetConversionValue
4200                     	xref	_ADC1_StartConversion
4201                     	xref	_ADC1_Cmd
4202                     	xref	_ADC1_Init
4203                     	xref	_ADC1_DeInit
4204                     .const:	section	.text
4205  0000               L1671:
4206  0000 42c80000      	dc.w	17096,0
4207  0004               L3571:
4208  0004 25642e253032  	dc.b	"%d.%02u",0
4209  000c               L1071:
4210  000c 40000000      	dc.w	16384,0
4211  0010               L1761:
4212  0010 43fb0000      	dc.w	17403,0
4213  0014               L1661:
4214  0014 447fc000      	dc.w	17535,-16384
4215  0018               L1561:
4216  0018 40533333      	dc.w	16467,13107
4217                     	xref.b	c_lreg
4218                     	xref.b	c_x
4238                     	xref	c_bmulx
4239                     	xref	c_ftoi
4240                     	xref	c_ctof
4241                     	xref	c_fcmp
4242                     	xref	c_fadd
4243                     	xref	c_fsub
4244                     	xref	c_itof
4245                     	xref	c_fdiv
4246                     	xref	c_fmul
4247                     	xref	c_ltor
4248                     	xref	c_rtol
4249                     	xref	c_uitof
4250                     	end
