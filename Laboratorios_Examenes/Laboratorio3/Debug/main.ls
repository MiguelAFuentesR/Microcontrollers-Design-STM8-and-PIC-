   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
2523                     	bsct
2524  0000               _num1_2:
2525  0000 0000          	dc.w	0
2526  0002               _num2_2:
2527  0002 0000          	dc.w	0
2528  0004               _op_1:
2529  0004 0000          	dc.w	0
2530  0006               _suma:
2531  0006 0000          	dc.w	0
2532  0008               _numero1dec:
2533  0008 0000          	dc.w	0
2534  000a               _numero2dec:
2535  000a 0000          	dc.w	0
2536  000c               _conversion:
2537  000c 0000          	dc.w	0
2538  000e               _Resultado:
2539  000e 0000          	dc.w	0
2540  0010               _calculo:
2541  0010 0000          	dc.w	0
2542  0012               _valorconvertido:
2543  0012 0000          	dc.w	0
2544  0014               _division:
2545  0014 0000          	dc.w	0
2546  0016               _negativo:
2547  0016 0000          	dc.w	0
2548  0018               _prueba:
2549  0018 0000          	dc.w	0
2550  001a               _caso:
2551  001a 0000          	dc.w	0
2590                     ; 54 main()
2590                     ; 55 {
2592                     	switch	.text
2593  0000               _main:
2597                     ; 56 	configurarReloj();
2599  0000 cd02c7        	call	_configurarReloj
2601                     ; 57 	configurarGPIO();
2603  0003 cd013d        	call	_configurarGPIO
2605  0006               L1461:
2606                     ; 63 	leerdatos();
2608  0006 ad63          	call	_leerdatos
2610                     ; 64 	MostrarDisplay(entero,negativo);		
2612  0008 be16          	ldw	x,_negativo
2613  000a 89            	pushw	x
2614  000b be02          	ldw	x,_entero
2615  000d cd0235        	call	_MostrarDisplay
2617  0010 85            	popw	x
2618                     ; 66 	PB_ODR |= 0x0A;//Enciende display decenas PB3 = 1
2620  0011 c65005        	ld	a,_PB_ODR
2621  0014 aa0a          	or	a,#10
2622  0016 c75005        	ld	_PB_ODR,a
2623                     ; 67 	PB_ODR &= ~0x05;//Apaga display unidades PB2 = 0
2625  0019 c65005        	ld	a,_PB_ODR
2626  001c a4fa          	and	a,#250
2627  001e c75005        	ld	_PB_ODR,a
2628                     ; 68 		if(division==1){
2630  0021 be14          	ldw	x,_division
2631  0023 a30001        	cpw	x,#1
2632  0026 2604          	jrne	L5461
2633                     ; 70 		PB_ODR &= ~0x02;
2635  0028 72135005      	bres	_PB_ODR,#1
2636  002c               L5461:
2637                     ; 72 	delayAprox(1861);
2639  002c ae0745        	ldw	x,#1861
2640  002f 89            	pushw	x
2641  0030 ae0000        	ldw	x,#0
2642  0033 89            	pushw	x
2643  0034 cd02fb        	call	_delayAprox
2645  0037 5b04          	addw	sp,#4
2646                     ; 73 	MostrarDisplay(decimal,0);
2648  0039 5f            	clrw	x
2649  003a 89            	pushw	x
2650  003b be00          	ldw	x,_decimal
2651  003d cd0235        	call	_MostrarDisplay
2653  0040 85            	popw	x
2654                     ; 74   PB_ODR |= 0x05;//Enciende display Unidades PB2 = 1
2656  0041 c65005        	ld	a,_PB_ODR
2657  0044 aa05          	or	a,#5
2658  0046 c75005        	ld	_PB_ODR,a
2659                     ; 75   PB_ODR &= ~0x0A;//Apaga display decenas PB3 = 0
2661  0049 c65005        	ld	a,_PB_ODR
2662  004c a4f5          	and	a,#245
2663  004e c75005        	ld	_PB_ODR,a
2664                     ; 76 	 if(division==1){
2666  0051 be14          	ldw	x,_division
2667  0053 a30001        	cpw	x,#1
2668  0056 2604          	jrne	L7461
2669                     ; 78 		PB_ODR &= ~0x02;
2671  0058 72135005      	bres	_PB_ODR,#1
2672  005c               L7461:
2673                     ; 80 	delayAprox(1861);
2675  005c ae0745        	ldw	x,#1861
2676  005f 89            	pushw	x
2677  0060 ae0000        	ldw	x,#0
2678  0063 89            	pushw	x
2679  0064 cd02fb        	call	_delayAprox
2681  0067 5b04          	addw	sp,#4
2683  0069 209b          	jra	L1461
2726                     ; 87 void leerdatos(){
2727                     	switch	.text
2728  006b               _leerdatos:
2732                     ; 88 	division = 0;
2734  006b 5f            	clrw	x
2735  006c bf14          	ldw	_division,x
2736                     ; 89 	negativo = 0;
2738  006e 5f            	clrw	x
2739  006f bf16          	ldw	_negativo,x
2740                     ; 90 	op_0 = PB_IDR&0x01;
2742  0071 c65006        	ld	a,_PB_IDR
2743  0074 a401          	and	a,#1
2744  0076 5f            	clrw	x
2745  0077 97            	ld	xl,a
2746  0078 bf0a          	ldw	_op_0,x
2747                     ; 91 	op_1 = (PC_IDR&0x02)>>1; //PC1
2749  007a c6500b        	ld	a,_PC_IDR
2750  007d 44            	srl	a
2751  007e 5f            	clrw	x
2752  007f a401          	and	a,#1
2753  0081 5f            	clrw	x
2754  0082 5f            	clrw	x
2755  0083 97            	ld	xl,a
2756  0084 bf04          	ldw	_op_1,x
2757                     ; 93 	num2_0=(PC_IDR&0x04)>>2;//PC2
2759  0086 c6500b        	ld	a,_PC_IDR
2760  0089 44            	srl	a
2761  008a 44            	srl	a
2762  008b 5f            	clrw	x
2763  008c a401          	and	a,#1
2764  008e 5f            	clrw	x
2765  008f 5f            	clrw	x
2766  0090 97            	ld	xl,a
2767  0091 bf0e          	ldw	_num2_0,x
2768                     ; 94 	num2_1=(PC_IDR&0x08)>>3;//PC3
2770  0093 c6500b        	ld	a,_PC_IDR
2771  0096 44            	srl	a
2772  0097 44            	srl	a
2773  0098 44            	srl	a
2774  0099 5f            	clrw	x
2775  009a a401          	and	a,#1
2776  009c 5f            	clrw	x
2777  009d 5f            	clrw	x
2778  009e 97            	ld	xl,a
2779  009f bf0c          	ldw	_num2_1,x
2780                     ; 95 	num2_2=(PC_IDR&0x10)>>4;//PC4
2782  00a1 c6500b        	ld	a,_PC_IDR
2783  00a4 4e            	swap	a
2784  00a5 a40f          	and	a,#15
2785  00a7 5f            	clrw	x
2786  00a8 a401          	and	a,#1
2787  00aa 5f            	clrw	x
2788  00ab 5f            	clrw	x
2789  00ac 97            	ld	xl,a
2790  00ad bf02          	ldw	_num2_2,x
2791                     ; 97 	num1_0=(PC_IDR&0x20)>>5;//PC5
2793  00af c6500b        	ld	a,_PC_IDR
2794  00b2 4e            	swap	a
2795  00b3 44            	srl	a
2796  00b4 a407          	and	a,#7
2797  00b6 5f            	clrw	x
2798  00b7 a401          	and	a,#1
2799  00b9 5f            	clrw	x
2800  00ba 5f            	clrw	x
2801  00bb 97            	ld	xl,a
2802  00bc bf12          	ldw	_num1_0,x
2803                     ; 98 	num1_1=(PC_IDR&0x40)>>6;//PC6
2805  00be c6500b        	ld	a,_PC_IDR
2806  00c1 4e            	swap	a
2807  00c2 44            	srl	a
2808  00c3 44            	srl	a
2809  00c4 a403          	and	a,#3
2810  00c6 5f            	clrw	x
2811  00c7 a401          	and	a,#1
2812  00c9 5f            	clrw	x
2813  00ca 5f            	clrw	x
2814  00cb 97            	ld	xl,a
2815  00cc bf10          	ldw	_num1_1,x
2816                     ; 99 	num1_2=(PC_IDR&0x80)>>7;//PC7
2818  00ce c6500b        	ld	a,_PC_IDR
2819  00d1 49            	rlc	a
2820  00d2 4f            	clr	a
2821  00d3 49            	rlc	a
2822  00d4 5f            	clrw	x
2823  00d5 97            	ld	xl,a
2824  00d6 bf00          	ldw	_num1_2,x
2825                     ; 103 	numero1dec= BinarioDecimal(num1_0,num1_1,num1_2);
2827  00d8 be00          	ldw	x,_num1_2
2828  00da 89            	pushw	x
2829  00db be10          	ldw	x,_num1_1
2830  00dd 89            	pushw	x
2831  00de be12          	ldw	x,_num1_0
2832  00e0 cd01be        	call	_BinarioDecimal
2834  00e3 5b04          	addw	sp,#4
2835  00e5 bf08          	ldw	_numero1dec,x
2836                     ; 104 	numero2dec= BinarioDecimal(num2_0,num2_1,num2_2);
2838  00e7 be02          	ldw	x,_num2_2
2839  00e9 89            	pushw	x
2840  00ea be0c          	ldw	x,_num2_1
2841  00ec 89            	pushw	x
2842  00ed be0e          	ldw	x,_num2_0
2843  00ef cd01be        	call	_BinarioDecimal
2845  00f2 5b04          	addw	sp,#4
2846  00f4 bf0a          	ldw	_numero2dec,x
2847                     ; 105 	Resultado= Operaciones(op_0,op_1,numero1dec,numero2dec);
2849  00f6 be0a          	ldw	x,_numero2dec
2850  00f8 89            	pushw	x
2851  00f9 be08          	ldw	x,_numero1dec
2852  00fb 89            	pushw	x
2853  00fc be04          	ldw	x,_op_1
2854  00fe 89            	pushw	x
2855  00ff be0a          	ldw	x,_op_0
2856  0101 cd01ef        	call	_Operaciones
2858  0104 5b06          	addw	sp,#6
2859  0106 bf0e          	ldw	_Resultado,x
2860                     ; 107 	caso = BinarioDecimal(op_0,op_1,0);
2862  0108 5f            	clrw	x
2863  0109 89            	pushw	x
2864  010a be04          	ldw	x,_op_1
2865  010c 89            	pushw	x
2866  010d be0a          	ldw	x,_op_0
2867  010f cd01be        	call	_BinarioDecimal
2869  0112 5b04          	addw	sp,#4
2870  0114 bf1a          	ldw	_caso,x
2871                     ; 111 	entero = Resultado/10; //Decenas
2873  0116 be0e          	ldw	x,_Resultado
2874  0118 a60a          	ld	a,#10
2875  011a cd0000        	call	c_sdivx
2877  011d bf02          	ldw	_entero,x
2878                     ; 112 	decimal = Resultado%10; //Unidad
2880  011f be0e          	ldw	x,_Resultado
2881  0121 a60a          	ld	a,#10
2882  0123 cd0000        	call	c_smodx
2884  0126 bf00          	ldw	_decimal,x
2885                     ; 114 	if(Resultado<0){
2887  0128 9c            	rvf
2888  0129 be0e          	ldw	x,_Resultado
2889  012b 2e0c          	jrsge	L1661
2890                     ; 115 		negativo=1;
2892  012d ae0001        	ldw	x,#1
2893  0130 bf16          	ldw	_negativo,x
2894                     ; 116 		decimal=decimal*(-1);
2896  0132 be00          	ldw	x,_decimal
2897  0134 50            	negw	x
2898  0135 bf00          	ldw	_decimal,x
2900  0137 2003          	jra	L3661
2901  0139               L1661:
2902                     ; 118 		negativo=0;
2904  0139 5f            	clrw	x
2905  013a bf16          	ldw	_negativo,x
2906  013c               L3661:
2907                     ; 121 }
2910  013c 81            	ret
2949                     ; 123 void configurarGPIO(){
2950                     	switch	.text
2951  013d               _configurarGPIO:
2955                     ; 126 	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
2957  013d 725f5005      	clr	_PB_ODR
2958                     ; 127 	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
2960  0141 725f500a      	clr	_PC_ODR
2961                     ; 128 	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
2963  0145 725f500f      	clr	_PD_ODR
2964                     ; 129 	PE_ODR = 0x00;//Limpiar los latch de salida del puertoE
2966  0149 725f5014      	clr	_PE_ODR
2967                     ; 161 	PC_DDR &= ~0xFF;//Todo El registro en 0 para entradas
2969  014d c6500c        	ld	a,_PC_DDR
2970  0150 a400          	and	a,#0
2971  0152 c7500c        	ld	_PC_DDR,a
2972                     ; 162 	PB_DDR &= ~0x01;//Bit0 en 0 para entrada de Operacion Bit0
2974  0155 72115007      	bres	_PB_DDR,#0
2975                     ; 165 	PD_DDR |= 0xFD;// Bits 0,2,3,4,5,6,7 en 1 para salidas
2977  0159 c65011        	ld	a,_PD_DDR
2978  015c aafd          	or	a,#253
2979  015e c75011        	ld	_PD_DDR,a
2980                     ; 166 	PB_DDR |= 0x0E;// Bits 1,2,3 en 1 para salidas
2982  0161 c65007        	ld	a,_PB_DDR
2983  0164 aa0e          	or	a,#14
2984  0166 c75007        	ld	_PB_DDR,a
2985                     ; 167 	PE_DDR |= 0xFF;// Bits 1,2,3 en 1 para salidas
2987  0169 c65016        	ld	a,_PE_DDR
2988  016c aaff          	or	a,#255
2989  016e c75016        	ld	_PE_DDR,a
2990                     ; 173  	PC_CR1 &= ~0xFF;//Entradas como flotantes , todo en 0
2992  0171 c6500d        	ld	a,_PC_CR1
2993  0174 a400          	and	a,#0
2994  0176 c7500d        	ld	_PC_CR1,a
2995                     ; 174 	PB_CR1 &= ~0x01;//Entrada como flotante
2997  0179 72115008      	bres	_PB_CR1,#0
2998                     ; 177 	PD_CR1 |= 0xFD;//Salidas push pull 
3000  017d c65012        	ld	a,_PD_CR1
3001  0180 aafd          	or	a,#253
3002  0182 c75012        	ld	_PD_CR1,a
3003                     ; 178 	PB_CR1 |= 0x0E; //Salidas push pull , se colocan en 1
3005  0185 c65008        	ld	a,_PB_CR1
3006  0188 aa0e          	or	a,#14
3007  018a c75008        	ld	_PB_CR1,a
3008                     ; 179 	PE_CR1 |= 0xFF; //Salidas push pull , se colocan en 1
3010  018d c65017        	ld	a,_PE_CR1
3011  0190 aaff          	or	a,#255
3012  0192 c75017        	ld	_PE_CR1,a
3013                     ; 183 	PC_CR2 &= ~0xFF;
3015  0195 c6500e        	ld	a,_PC_CR2
3016  0198 a400          	and	a,#0
3017  019a c7500e        	ld	_PC_CR2,a
3018                     ; 184 	PB_CR2 |= ~0x0E;
3020  019d c65009        	ld	a,_PB_CR2
3021  01a0 aaf1          	or	a,#241
3022  01a2 c75009        	ld	_PB_CR2,a
3023                     ; 187 	PD_CR2 &= ~0xFD;
3025  01a5 c65013        	ld	a,_PD_CR2
3026  01a8 a402          	and	a,#2
3027  01aa c75013        	ld	_PD_CR2,a
3028                     ; 188 	PB_CR2 &= ~0x0E;
3030  01ad c65009        	ld	a,_PB_CR2
3031  01b0 a4f1          	and	a,#241
3032  01b2 c75009        	ld	_PB_CR2,a
3033                     ; 189 	PE_CR2 &= ~0xFF;
3035  01b5 c65018        	ld	a,_PE_CR2
3036  01b8 a400          	and	a,#0
3037  01ba c75018        	ld	_PE_CR2,a
3038                     ; 192 	}
3041  01bd 81            	ret
3094                     ; 195 int BinarioDecimal(int bit0,int bit1,int bit2){
3095                     	switch	.text
3096  01be               _BinarioDecimal:
3098  01be 89            	pushw	x
3099       00000000      OFST:	set	0
3102                     ; 196 conversion=0; 	
3104  01bf 5f            	clrw	x
3105  01c0 bf0c          	ldw	_conversion,x
3106                     ; 197 	if(bit0==1){
3108  01c2 1e01          	ldw	x,(OFST+1,sp)
3109  01c4 a30001        	cpw	x,#1
3110  01c7 2605          	jrne	L3271
3111                     ; 198 		conversion = conversion+1;
3113  01c9 ae0001        	ldw	x,#1
3114  01cc bf0c          	ldw	_conversion,x
3115  01ce               L3271:
3116                     ; 201 	if(bit1==1){
3118  01ce 1e05          	ldw	x,(OFST+5,sp)
3119  01d0 a30001        	cpw	x,#1
3120  01d3 2607          	jrne	L5271
3121                     ; 202 		conversion = conversion+2;
3123  01d5 be0c          	ldw	x,_conversion
3124  01d7 1c0002        	addw	x,#2
3125  01da bf0c          	ldw	_conversion,x
3126  01dc               L5271:
3127                     ; 205 	if(bit2==1){
3129  01dc 1e07          	ldw	x,(OFST+7,sp)
3130  01de a30001        	cpw	x,#1
3131  01e1 2607          	jrne	L7271
3132                     ; 206 		conversion = conversion+4;
3134  01e3 be0c          	ldw	x,_conversion
3135  01e5 1c0004        	addw	x,#4
3136  01e8 bf0c          	ldw	_conversion,x
3137  01ea               L7271:
3138                     ; 209 	return conversion;
3140  01ea be0c          	ldw	x,_conversion
3143  01ec 5b02          	addw	sp,#2
3144  01ee 81            	ret
3207                     ; 213 int Operaciones(int operando0,int operando1,int numero1,int numero2){
3208                     	switch	.text
3209  01ef               _Operaciones:
3211  01ef 89            	pushw	x
3212       00000000      OFST:	set	0
3215                     ; 215 	if (operando1==0){
3217  01f0 1e05          	ldw	x,(OFST+5,sp)
3218  01f2 2616          	jrne	L3671
3219                     ; 216 			if(operando0==0){
3221  01f4 1e01          	ldw	x,(OFST+1,sp)
3222  01f6 2609          	jrne	L5671
3223                     ; 217 				calculo = numero1+numero2;
3225  01f8 1e07          	ldw	x,(OFST+7,sp)
3226  01fa 72fb09        	addw	x,(OFST+9,sp)
3227  01fd bf10          	ldw	_calculo,x
3229  01ff 202f          	jra	L1771
3230  0201               L5671:
3231                     ; 219 				calculo = numero1-numero2;
3233  0201 1e07          	ldw	x,(OFST+7,sp)
3234  0203 72f009        	subw	x,(OFST+9,sp)
3235  0206 bf10          	ldw	_calculo,x
3236  0208 2026          	jra	L1771
3237  020a               L3671:
3238                     ; 222 			if(operando0==0){
3240  020a 1e01          	ldw	x,(OFST+1,sp)
3241  020c 260b          	jrne	L3771
3242                     ; 223 				calculo = numero1*numero2;
3244  020e 1e07          	ldw	x,(OFST+7,sp)
3245  0210 1609          	ldw	y,(OFST+9,sp)
3246  0212 cd0000        	call	c_imul
3248  0215 bf10          	ldw	_calculo,x
3250  0217 2017          	jra	L1771
3251  0219               L3771:
3252                     ; 225 				if(numero2==0){
3254  0219 1e09          	ldw	x,(OFST+9,sp)
3255  021b 2713          	jreq	L1771
3257                     ; 228 					calculo = ((numero1*10)/numero2);		
3259  021d 1e07          	ldw	x,(OFST+7,sp)
3260  021f a60a          	ld	a,#10
3261  0221 cd0000        	call	c_bmulx
3263  0224 1609          	ldw	y,(OFST+9,sp)
3264  0226 cd0000        	call	c_idiv
3266  0229 bf10          	ldw	_calculo,x
3267                     ; 229 					division=1;
3269  022b ae0001        	ldw	x,#1
3270  022e bf14          	ldw	_division,x
3271  0230               L1771:
3272                     ; 235 	return calculo;	
3274  0230 be10          	ldw	x,_calculo
3277  0232 5b02          	addw	sp,#2
3278  0234 81            	ret
3323                     ; 239 void MostrarDisplay(int NumeroResultado,int menos){
3324                     	switch	.text
3325  0235               _MostrarDisplay:
3327  0235 89            	pushw	x
3328       00000000      OFST:	set	0
3331                     ; 241 if(menos==0){
3333  0236 1e05          	ldw	x,(OFST+5,sp)
3334  0238 2703cc02bd    	jrne	L1502
3335                     ; 242 	switch(NumeroResultado){
3337  023d 1e01          	ldw	x,(OFST+1,sp)
3339                     ; 281 			break;
3340  023f 5d            	tnzw	x
3341  0240 271d          	jreq	L3002
3342  0242 5a            	decw	x
3343  0243 2720          	jreq	L5002
3344  0245 5a            	decw	x
3345  0246 2723          	jreq	L7002
3346  0248 5a            	decw	x
3347  0249 272a          	jreq	L1102
3348  024b 5a            	decw	x
3349  024c 2731          	jreq	L3102
3350  024e 5a            	decw	x
3351  024f 2738          	jreq	L5102
3352  0251 5a            	decw	x
3353  0252 273f          	jreq	L7102
3354  0254 5a            	decw	x
3355  0255 2746          	jreq	L1202
3356  0257 5a            	decw	x
3357  0258 274d          	jreq	L3202
3358  025a 5a            	decw	x
3359  025b 2754          	jreq	L5202
3360  025d 2066          	jra	L7502
3361  025f               L3002:
3362                     ; 243 			case 0:
3362                     ; 244 			PD_ODR=0x80;
3364  025f 3580500f      	mov	_PD_ODR,#128
3365                     ; 245 			break;
3367  0263 2060          	jra	L7502
3368  0265               L5002:
3369                     ; 246 			case 1:
3369                     ; 247 			PD_ODR=0xF1;
3371  0265 35f1500f      	mov	_PD_ODR,#241
3372                     ; 249 			break;
3374  0269 205a          	jra	L7502
3375  026b               L7002:
3376                     ; 250 			case 2:
3376                     ; 251 			PD_ODR=0x48;
3378  026b 3548500f      	mov	_PD_ODR,#72
3379                     ; 252 			PE_ODR = 0x00;
3381  026f 725f5014      	clr	_PE_ODR
3382                     ; 253 			break;
3384  0273 2050          	jra	L7502
3385  0275               L1102:
3386                     ; 254 			case 3:
3386                     ; 255 			PD_ODR=0x60;
3388  0275 3560500f      	mov	_PD_ODR,#96
3389                     ; 256 			PE_ODR &= ~0x20;
3391  0279 721b5014      	bres	_PE_ODR,#5
3392                     ; 257 			break;
3394  027d 2046          	jra	L7502
3395  027f               L3102:
3396                     ; 258 			case 4:
3396                     ; 259 			PD_ODR=0x31;
3398  027f 3531500f      	mov	_PD_ODR,#49
3399                     ; 260 			PE_ODR &= ~0x20;
3401  0283 721b5014      	bres	_PE_ODR,#5
3402                     ; 261 			break;
3404  0287 203c          	jra	L7502
3405  0289               L5102:
3406                     ; 262 			case 5:
3406                     ; 263 			PD_ODR=0x24;
3408  0289 3524500f      	mov	_PD_ODR,#36
3409                     ; 264 			PE_ODR &= ~0x20;
3411  028d 721b5014      	bres	_PE_ODR,#5
3412                     ; 265 			break;
3414  0291 2032          	jra	L7502
3415  0293               L7102:
3416                     ; 266 			case 6:
3416                     ; 267 			PD_ODR=0x04;
3418  0293 3504500f      	mov	_PD_ODR,#4
3419                     ; 268 			PE_ODR &= ~0x20;
3421  0297 721b5014      	bres	_PE_ODR,#5
3422                     ; 269 			break;
3424  029b 2028          	jra	L7502
3425  029d               L1202:
3426                     ; 270 			case 7:
3426                     ; 271 			PD_ODR=0x70;
3428  029d 3570500f      	mov	_PD_ODR,#112
3429                     ; 272 			PE_ODR &= ~0x20;
3431  02a1 721b5014      	bres	_PE_ODR,#5
3432                     ; 273 			break;
3434  02a5 201e          	jra	L7502
3435  02a7               L3202:
3436                     ; 274 			case 8:
3436                     ; 275 			PD_ODR=0x00;
3438  02a7 725f500f      	clr	_PD_ODR
3439                     ; 276 			PE_ODR &= ~0x20;
3441  02ab 721b5014      	bres	_PE_ODR,#5
3442                     ; 277 			break;
3444  02af 2014          	jra	L7502
3445  02b1               L5202:
3446                     ; 278 			case 9:
3446                     ; 279 			PD_ODR=0x30;
3448  02b1 3530500f      	mov	_PD_ODR,#48
3449                     ; 280 			PE_ODR &= ~0x20;
3451  02b5 721b5014      	bres	_PE_ODR,#5
3452                     ; 281 			break;
3454  02b9 200a          	jra	L7502
3455  02bb               L5502:
3457  02bb 2008          	jra	L7502
3458  02bd               L1502:
3459                     ; 285 		PD_ODR=0xFC;
3461  02bd 35fc500f      	mov	_PD_ODR,#252
3462                     ; 286 		PE_ODR &= ~0x20;
3464  02c1 721b5014      	bres	_PE_ODR,#5
3465  02c5               L7502:
3466                     ; 289 }
3469  02c5 85            	popw	x
3470  02c6 81            	ret
3497                     ; 294 void configurarReloj(){
3498                     	switch	.text
3499  02c7               _configurarReloj:
3503                     ; 300 	CLK_SWCR |= 0x02;
3505  02c7 721250c5      	bset	_CLK_SWCR,#1
3506                     ; 305 	CLK_SWR = 0xB4; //Selecionamos reloj externo 
3508  02cb 35b450c4      	mov	_CLK_SWR,#180
3509                     ; 309 	CLK_CKDIVR |= 0x01;
3511  02cf 721050c6      	bset	_CLK_CKDIVR,#0
3512                     ; 310 	CLK_CKDIVR &= ~0x1E;// bits 4,3,2,1 en 0 del registro
3514  02d3 c650c6        	ld	a,_CLK_CKDIVR
3515  02d6 a4e1          	and	a,#225
3516  02d8 c750c6        	ld	_CLK_CKDIVR,a
3517                     ; 315 	a = CLK_SWCR & 0x01;//Comparamos el bit cero
3519  02db c650c5        	ld	a,_CLK_SWCR
3520  02de a401          	and	a,#1
3521  02e0 5f            	clrw	x
3522  02e1 97            	ld	xl,a
3523  02e2 bf08          	ldw	_a,x
3525  02e4 2009          	jra	L5702
3526  02e6               L1702:
3527                     ; 317 		a = CLK_SWCR & 0x01;
3529  02e6 c650c5        	ld	a,_CLK_SWCR
3530  02e9 a401          	and	a,#1
3531  02eb 5f            	clrw	x
3532  02ec 97            	ld	xl,a
3533  02ed bf08          	ldw	_a,x
3534  02ef               L5702:
3535                     ; 316 	while(a==1){ 
3537  02ef be08          	ldw	x,_a
3538  02f1 a30001        	cpw	x,#1
3539  02f4 27f0          	jreq	L1702
3540                     ; 323 	CLK_SWCR &=~0x02;  
3542  02f6 721350c5      	bres	_CLK_SWCR,#1
3543                     ; 325 }
3546  02fa 81            	ret
3589                     ; 328 void delayAprox(long del){
3590                     	switch	.text
3591  02fb               _delayAprox:
3593  02fb 5204          	subw	sp,#4
3594       00000004      OFST:	set	4
3597                     ; 329 	long i=0;
3599                     ; 330 	i=del;
3601  02fd 1e09          	ldw	x,(OFST+5,sp)
3602  02ff 1f03          	ldw	(OFST-1,sp),x
3603  0301 1e07          	ldw	x,(OFST+3,sp)
3604  0303 1f01          	ldw	(OFST-3,sp),x
3607  0305 2009          	jra	L7212
3608  0307               L3212:
3609                     ; 332 	i--;
3611  0307 96            	ldw	x,sp
3612  0308 1c0001        	addw	x,#OFST-3
3613  030b a601          	ld	a,#1
3614  030d cd0000        	call	c_lgsbc
3617  0310               L7212:
3618                     ; 331 	while(i>=0){
3618                     ; 332 	i--;
3620  0310 9c            	rvf
3621  0311 9c            	rvf
3622  0312 0d01          	tnz	(OFST-3,sp)
3623  0314 2ef1          	jrsge	L3212
3624                     ; 334 }
3627  0316 5b04          	addw	sp,#4
3628  0318 81            	ret
3859                     	xdef	_main
3860                     	xdef	_caso
3861                     	xdef	_prueba
3862                     	xdef	_delayAprox
3863                     	xdef	_MostrarDisplay
3864                     	xdef	_Operaciones
3865                     	xdef	_BinarioDecimal
3866                     	xdef	_leerdatos
3867                     	xdef	_configurarGPIO
3868                     	xdef	_configurarReloj
3869                     	switch	.ubsct
3870  0000               _decimal:
3871  0000 0000          	ds.b	2
3872                     	xdef	_decimal
3873  0002               _entero:
3874  0002 0000          	ds.b	2
3875                     	xdef	_entero
3876                     	xdef	_negativo
3877                     	xdef	_division
3878                     	xdef	_valorconvertido
3879                     	xdef	_calculo
3880                     	xdef	_Resultado
3881                     	xdef	_conversion
3882                     	xdef	_numero2dec
3883                     	xdef	_numero1dec
3884                     	xdef	_suma
3885  0004               _c:
3886  0004 0000          	ds.b	2
3887                     	xdef	_c
3888  0006               _b:
3889  0006 0000          	ds.b	2
3890                     	xdef	_b
3891  0008               _a:
3892  0008 0000          	ds.b	2
3893                     	xdef	_a
3894                     	xdef	_op_1
3895  000a               _op_0:
3896  000a 0000          	ds.b	2
3897                     	xdef	_op_0
3898                     	xdef	_num2_2
3899  000c               _num2_1:
3900  000c 0000          	ds.b	2
3901                     	xdef	_num2_1
3902  000e               _num2_0:
3903  000e 0000          	ds.b	2
3904                     	xdef	_num2_0
3905                     	xdef	_num1_2
3906  0010               _num1_1:
3907  0010 0000          	ds.b	2
3908                     	xdef	_num1_1
3909  0012               _num1_0:
3910  0012 0000          	ds.b	2
3911                     	xdef	_num1_0
3912                     	xref.b	c_x
3932                     	xref	c_lgsbc
3933                     	xref	c_idiv
3934                     	xref	c_bmulx
3935                     	xref	c_imul
3936                     	xref	c_smodx
3937                     	xref	c_sdivx
3938                     	end
