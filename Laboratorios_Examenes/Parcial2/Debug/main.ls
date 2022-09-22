   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
2523                     	bsct
2524  0000               _in:
2525  0000 0000          	dc.w	0
2526  0002               _es:
2527  0002 0000          	dc.w	0
2528  0004               _anguloinicial:
2529  0004 00000000      	dc.w	0,0
2530  0008               _angulodeseado:
2531  0008 00000000      	dc.w	0,0
2532  000c               _angulo:
2533  000c 00000000      	dc.w	0,0
2534  0010               _angulosiguiente:
2535  0010 00000000      	dc.w	0,0
2536  0014               _velocidadgrad:
2537  0014 0000          	dc.w	0
2538  0016               _InicioGiro:
2539  0016 0000          	dc.w	0
2540  0018               _desplazamientoneg:
2541  0018 0000          	dc.w	0
2542  001a               _desplazamientopos:
2543  001a 0000          	dc.w	0
2544  001c               _contadorgirosnegativos:
2545  001c 0000          	dc.w	0
2546  001e               _contadorgirospositivos:
2547  001e 0000          	dc.w	0
2548  0020               _bit0:
2549  0020 0000          	dc.w	0
2550  0022               _bit1:
2551  0022 0000          	dc.w	0
2552  0024               _pasos:
2553  0024 00000000      	dc.w	0,0
2554  0028               _actualizar:
2555  0028 0000          	dc.w	0
2556  002a               _Velocidadpantalla:
2557  002a 00000000      	dc.w	0,0
2614                     ; 94 main()
2614                     ; 95 {
2616                     	switch	.text
2617  0000               _main:
2619  0000 5204          	subw	sp,#4
2620       00000004      OFST:	set	4
2623                     ; 96 	configurarGPIO();
2625  0002 cd0511        	call	_configurarGPIO
2627                     ; 97 	ConfigurarInterrupciones();
2629  0005 cd06fe        	call	_ConfigurarInterrupciones
2631                     ; 98 	Timer4_Init();
2633  0008 cd0868        	call	_Timer4_Init
2635                     ; 99 	FSM_Init();
2637  000b cd01e7        	call	_FSM_Init
2639                     ; 100 	IniciarLCD();
2641  000e cd0797        	call	_IniciarLCD
2643                     ; 101 	LimpiarLCD(); //con el comando clear
2645  0011 cd07d0        	call	_LimpiarLCD
2647                     ; 102 	delay_ms(10);
2649  0014 ae000a        	ldw	x,#10
2650  0017 cd08b0        	call	_delay_ms
2652  001a               L1461:
2653                     ; 105 	CambioVelocidad();
2655  001a cd0556        	call	_CambioVelocidad
2657                     ; 106 	FSM_Init();
2659  001d cd01e7        	call	_FSM_Init
2661                     ; 109 	bit0=(PC_IDR&0x10)>>4;//PC4
2663  0020 c6500b        	ld	a,_PC_IDR
2664  0023 4e            	swap	a
2665  0024 a40f          	and	a,#15
2666  0026 5f            	clrw	x
2667  0027 a401          	and	a,#1
2668  0029 5f            	clrw	x
2669  002a 5f            	clrw	x
2670  002b 97            	ld	xl,a
2671  002c bf20          	ldw	_bit0,x
2672                     ; 110 	bit1=(PC_IDR&0x20)>>5;//PC5
2674  002e c6500b        	ld	a,_PC_IDR
2675  0031 4e            	swap	a
2676  0032 44            	srl	a
2677  0033 a407          	and	a,#7
2678  0035 5f            	clrw	x
2679  0036 a401          	and	a,#1
2680  0038 5f            	clrw	x
2681  0039 5f            	clrw	x
2682  003a 97            	ld	xl,a
2683  003b bf22          	ldw	_bit1,x
2684                     ; 111 	InicioGiro=(PC_IDR&0x08)>>3;//PC3 control inicio movimiento
2686  003d c6500b        	ld	a,_PC_IDR
2687  0040 44            	srl	a
2688  0041 44            	srl	a
2689  0042 44            	srl	a
2690  0043 5f            	clrw	x
2691  0044 a401          	and	a,#1
2692  0046 5f            	clrw	x
2693  0047 5f            	clrw	x
2694  0048 97            	ld	xl,a
2695  0049 bf16          	ldw	_InicioGiro,x
2696                     ; 115 	PonerCursorLCD(1,1); //coordenada 1,1	
2698  004b ae0101        	ldw	x,#257
2699  004e cd07d8        	call	_PonerCursorLCD
2701                     ; 116 	ImprimirCadenaLCD("Act:");
2703  0051 ae002b        	ldw	x,#L5461
2704  0054 cd0847        	call	_ImprimirCadenaLCD
2706                     ; 117 	PonerCursorLCD(2,1); //coordenada 1,7
2708  0057 ae0201        	ldw	x,#513
2709  005a cd07d8        	call	_PonerCursorLCD
2711                     ; 118 	ImprimirCadenaLCD("Des:");
2713  005d ae0026        	ldw	x,#L7461
2714  0060 cd0847        	call	_ImprimirCadenaLCD
2716                     ; 119 	PonerCursorLCD(1,11); //coordenada 1,13	
2718  0063 ae010b        	ldw	x,#267
2719  0066 cd07d8        	call	_PonerCursorLCD
2721                     ; 120 	ImprimirCadenaLCD("Velo:");
2723  0069 ae0020        	ldw	x,#L1561
2724  006c cd0847        	call	_ImprimirCadenaLCD
2727  006f 2014          	jra	L5561
2728  0071               L3561:
2729                     ; 125 		MensajePantallaAnguloSiguiente(angulodeseado);
2731  0071 be0a          	ldw	x,_angulodeseado+2
2732  0073 89            	pushw	x
2733  0074 be08          	ldw	x,_angulodeseado
2734  0076 89            	pushw	x
2735  0077 cd0394        	call	_MensajePantallaAnguloSiguiente
2737  007a 5b04          	addw	sp,#4
2738                     ; 126 		delay_ms(1500);
2740  007c ae05dc        	ldw	x,#1500
2741  007f cd08b0        	call	_delay_ms
2743                     ; 127 		actualizar=0;
2745  0082 5f            	clrw	x
2746  0083 bf28          	ldw	_actualizar,x
2747  0085               L5561:
2748                     ; 124 	while(actualizar){
2750  0085 be28          	ldw	x,_actualizar
2751  0087 26e8          	jrne	L3561
2752                     ; 129 				if(anguloinicial==angulodeseado){
2754  0089 ae0004        	ldw	x,#_anguloinicial
2755  008c cd0000        	call	c_ltor
2757  008f ae0008        	ldw	x,#_angulodeseado
2758  0092 cd0000        	call	c_fcmp
2760  0095 261d          	jrne	L1661
2761                     ; 130 						angulodeseado=0;
2763  0097 ae0000        	ldw	x,#0
2764  009a bf0a          	ldw	_angulodeseado+2,x
2765  009c ae0000        	ldw	x,#0
2766  009f bf08          	ldw	_angulodeseado,x
2767                     ; 131 						contadorgirospositivos=0;
2769  00a1 5f            	clrw	x
2770  00a2 bf1e          	ldw	_contadorgirospositivos,x
2771                     ; 132 						contadorgirosnegativos=0;
2773  00a4 5f            	clrw	x
2774  00a5 bf1c          	ldw	_contadorgirosnegativos,x
2775                     ; 133 						MensajePantallaAnguloSiguiente(angulodeseado);
2777  00a7 ce0032        	ldw	x,L7661+2
2778  00aa 89            	pushw	x
2779  00ab ce0030        	ldw	x,L7661
2780  00ae 89            	pushw	x
2781  00af cd0394        	call	_MensajePantallaAnguloSiguiente
2783  00b2 5b04          	addw	sp,#4
2784  00b4               L1661:
2785                     ; 136 		delay_ms(10);
2787  00b4 ae000a        	ldw	x,#10
2788  00b7 cd08b0        	call	_delay_ms
2790                     ; 137 		MensajePantallaAnguloActual(anguloinicial);
2792  00ba be06          	ldw	x,_anguloinicial+2
2793  00bc 89            	pushw	x
2794  00bd be04          	ldw	x,_anguloinicial
2795  00bf 89            	pushw	x
2796  00c0 cd027f        	call	_MensajePantallaAnguloActual
2798  00c3 5b04          	addw	sp,#4
2799                     ; 138 		MensajePantallaAnguloSiguiente(angulodeseado);
2801  00c5 be0a          	ldw	x,_angulodeseado+2
2802  00c7 89            	pushw	x
2803  00c8 be08          	ldw	x,_angulodeseado
2804  00ca 89            	pushw	x
2805  00cb cd0394        	call	_MensajePantallaAnguloSiguiente
2807  00ce 5b04          	addw	sp,#4
2808                     ; 139 		MensajePantallaVelocidad();
2810  00d0 cd04a9        	call	_MensajePantallaVelocidad
2812                     ; 142 	if(InicioGiro){
2814  00d3 be16          	ldw	x,_InicioGiro
2815  00d5 2603          	jrne	L6
2816  00d7 cc01df        	jp	L3761
2817  00da               L6:
2818                     ; 144 			if(angulodeseado<0){
2820  00da 9c            	rvf
2821  00db 9c            	rvf
2822  00dc 3d08          	tnz	_angulodeseado
2823  00de 2e74          	jrsge	L5761
2824                     ; 146 				desplazamientoneg = abs((contadorgirosnegativos*2)+anguloinicial)/2; //#Numero de ciclos de la FSM
2826  00e0 be1c          	ldw	x,_contadorgirosnegativos
2827  00e2 58            	sllw	x
2828  00e3 cd0000        	call	c_itof
2830  00e6 ae0004        	ldw	x,#_anguloinicial
2831  00e9 cd0000        	call	c_fadd
2833  00ec cd0000        	call	c_ftoi
2835  00ef cd0000        	call	_abs
2837  00f2 a602          	ld	a,#2
2838  00f4 cd0000        	call	c_sdivx
2840  00f7 bf18          	ldw	_desplazamientoneg,x
2842  00f9 2050          	jra	L3071
2843  00fb               L7761:
2844                     ; 150 					if(angulodeseado<anguloinicial){
2846  00fb 9c            	rvf
2847  00fc ae0008        	ldw	x,#_angulodeseado
2848  00ff cd0000        	call	c_ltor
2850  0102 ae0004        	ldw	x,#_anguloinicial
2851  0105 cd0000        	call	c_fcmp
2853  0108 2e11          	jrsge	L7071
2854                     ; 152 						GiroPositivo();// giro horario
2856  010a cd0610        	call	_GiroPositivo
2858                     ; 153 						anguloinicial=anguloinicial-2;
2860  010d ae001c        	ldw	x,#L5171
2861  0110 cd0000        	call	c_ltor
2863  0113 ae0004        	ldw	x,#_anguloinicial
2864  0116 cd0000        	call	c_fgsub
2867  0119 201e          	jra	L1271
2868  011b               L7071:
2869                     ; 155 					}else if(angulodeseado>anguloinicial) {
2871  011b 9c            	rvf
2872  011c ae0008        	ldw	x,#_angulodeseado
2873  011f cd0000        	call	c_ltor
2875  0122 ae0004        	ldw	x,#_anguloinicial
2876  0125 cd0000        	call	c_fcmp
2878  0128 2d0f          	jrsle	L1271
2879                     ; 157 						GiroNegativo();// giro antihorario
2881  012a cd05ba        	call	_GiroNegativo
2883                     ; 158 						anguloinicial=anguloinicial+2;	
2885  012d ae001c        	ldw	x,#L5171
2886  0130 cd0000        	call	c_ltor
2888  0133 ae0004        	ldw	x,#_anguloinicial
2889  0136 cd0000        	call	c_fgadd
2891  0139               L1271:
2892                     ; 161 					desplazamientoneg--;	
2894  0139 be18          	ldw	x,_desplazamientoneg
2895  013b 1d0001        	subw	x,#1
2896  013e bf18          	ldw	_desplazamientoneg,x
2897                     ; 162 					MensajePantallaAnguloActual(anguloinicial);	
2899  0140 be06          	ldw	x,_anguloinicial+2
2900  0142 89            	pushw	x
2901  0143 be04          	ldw	x,_anguloinicial
2902  0145 89            	pushw	x
2903  0146 cd027f        	call	_MensajePantallaAnguloActual
2905  0149 5b04          	addw	sp,#4
2906  014b               L3071:
2907                     ; 148 				while(desplazamientoneg>0){
2909  014b 9c            	rvf
2910  014c be18          	ldw	x,_desplazamientoneg
2911  014e 2cab          	jrsgt	L7761
2913  0150 ac1a001a      	jpf	L1461
2914  0154               L5761:
2915                     ; 166 			}else if (angulodeseado>0){
2917  0154 9c            	rvf
2918  0155 9c            	rvf
2919  0156 3d08          	tnz	_angulodeseado
2920  0158 2c03          	jrsgt	L01
2921  015a cc001a        	jp	L1461
2922  015d               L01:
2923                     ; 168 		desplazamientopos = abs(anguloinicial-(contadorgirospositivos*2))/2; //#Numero de ciclos de la FSM
2925  015d be1e          	ldw	x,_contadorgirospositivos
2926  015f 58            	sllw	x
2927  0160 cd0000        	call	c_itof
2929  0163 96            	ldw	x,sp
2930  0164 1c0001        	addw	x,#OFST-3
2931  0167 cd0000        	call	c_rtol
2934  016a ae0004        	ldw	x,#_anguloinicial
2935  016d cd0000        	call	c_ltor
2937  0170 96            	ldw	x,sp
2938  0171 1c0001        	addw	x,#OFST-3
2939  0174 cd0000        	call	c_fsub
2941  0177 cd0000        	call	c_ftoi
2943  017a cd0000        	call	_abs
2945  017d a602          	ld	a,#2
2946  017f cd0000        	call	c_sdivx
2948  0182 bf1a          	ldw	_desplazamientopos,x
2950  0184 2050          	jra	L5371
2951  0186               L1371:
2952                     ; 171 					if(angulodeseado<anguloinicial){
2954  0186 9c            	rvf
2955  0187 ae0008        	ldw	x,#_angulodeseado
2956  018a cd0000        	call	c_ltor
2958  018d ae0004        	ldw	x,#_anguloinicial
2959  0190 cd0000        	call	c_fcmp
2961  0193 2e11          	jrsge	L1471
2962                     ; 173 						GiroPositivo();// giro horario
2964  0195 cd0610        	call	_GiroPositivo
2966                     ; 174 						anguloinicial=anguloinicial-2;
2968  0198 ae001c        	ldw	x,#L5171
2969  019b cd0000        	call	c_ltor
2971  019e ae0004        	ldw	x,#_anguloinicial
2972  01a1 cd0000        	call	c_fgsub
2975  01a4 201e          	jra	L3471
2976  01a6               L1471:
2977                     ; 176 					}else if(angulodeseado>anguloinicial) {
2979  01a6 9c            	rvf
2980  01a7 ae0008        	ldw	x,#_angulodeseado
2981  01aa cd0000        	call	c_ltor
2983  01ad ae0004        	ldw	x,#_anguloinicial
2984  01b0 cd0000        	call	c_fcmp
2986  01b3 2d0f          	jrsle	L3471
2987                     ; 178 						GiroNegativo();// giro antihorario
2989  01b5 cd05ba        	call	_GiroNegativo
2991                     ; 179 							anguloinicial=anguloinicial+2;	
2993  01b8 ae001c        	ldw	x,#L5171
2994  01bb cd0000        	call	c_ltor
2996  01be ae0004        	ldw	x,#_anguloinicial
2997  01c1 cd0000        	call	c_fgadd
2999  01c4               L3471:
3000                     ; 182 					desplazamientopos--;	
3002  01c4 be1a          	ldw	x,_desplazamientopos
3003  01c6 1d0001        	subw	x,#1
3004  01c9 bf1a          	ldw	_desplazamientopos,x
3005                     ; 183 					MensajePantallaAnguloActual(anguloinicial);	
3007  01cb be06          	ldw	x,_anguloinicial+2
3008  01cd 89            	pushw	x
3009  01ce be04          	ldw	x,_anguloinicial
3010  01d0 89            	pushw	x
3011  01d1 cd027f        	call	_MensajePantallaAnguloActual
3013  01d4 5b04          	addw	sp,#4
3014  01d6               L5371:
3015                     ; 169 				while(desplazamientopos>0){
3017  01d6 9c            	rvf
3018  01d7 be1a          	ldw	x,_desplazamientopos
3019  01d9 2cab          	jrsgt	L1371
3020  01db ac1a001a      	jpf	L1461
3021  01df               L3761:
3022                     ; 190 	PB_ODR &= ~0x02;
3024  01df 72135005      	bres	_PB_ODR,#1
3025  01e3 ac1a001a      	jpf	L1461
3051                     ; 197 void FSM_Init(void){
3052                     	switch	.text
3053  01e7               _FSM_Init:
3057                     ; 198 	FSM[0].SalidaMotor=0x02;//Encender BobinaA  0001 0 
3059  01e7 ae0002        	ldw	x,#2
3060  01ea bf30          	ldw	_FSM,x
3061                     ; 199 	FSM[0].tiempo=velocidadgrad;
3063  01ec be14          	ldw	x,_velocidadgrad
3064  01ee bf32          	ldw	_FSM+2,x
3065                     ; 200 	FSM[0].next[0]=Estado2;
3067  01f0 ae0001        	ldw	x,#1
3068  01f3 bf34          	ldw	_FSM+4,x
3069                     ; 201 	FSM[0].next[1]=Estado8;
3072  01f5 ae0007        	ldw	x,#7
3073  01f8 bf36          	ldw	_FSM+6,x
3074                     ; 203 	FSM[1].SalidaMotor=0x06;//Encender BobinaAyB  0011 0 
3077  01fa ae0006        	ldw	x,#6
3078  01fd bf38          	ldw	_FSM+8,x
3079                     ; 204 	FSM[1].tiempo=velocidadgrad;
3081  01ff be14          	ldw	x,_velocidadgrad
3082  0201 bf3a          	ldw	_FSM+10,x
3083                     ; 205 	FSM[1].next[0]=Estado3;
3085  0203 ae0002        	ldw	x,#2
3086  0206 bf3c          	ldw	_FSM+12,x
3087                     ; 206 	FSM[1].next[1]=Estado1;
3090  0208 5f            	clrw	x
3091  0209 bf3e          	ldw	_FSM+14,x
3092                     ; 208 	FSM[2].SalidaMotor=0x04;//Encender BobinaB  0010 0 
3095  020b ae0004        	ldw	x,#4
3096  020e bf40          	ldw	_FSM+16,x
3097                     ; 209 	FSM[2].tiempo=velocidadgrad;
3099  0210 be14          	ldw	x,_velocidadgrad
3100  0212 bf42          	ldw	_FSM+18,x
3101                     ; 210 	FSM[2].next[0]=Estado4;
3103  0214 ae0003        	ldw	x,#3
3104  0217 bf44          	ldw	_FSM+20,x
3105                     ; 211 	FSM[2].next[1]=Estado2;
3108  0219 ae0001        	ldw	x,#1
3109  021c bf46          	ldw	_FSM+22,x
3110                     ; 213 	FSM[3].SalidaMotor=0x0C;//Encender BobinaByC 0110 0
3113  021e ae000c        	ldw	x,#12
3114  0221 bf48          	ldw	_FSM+24,x
3115                     ; 214 	FSM[3].tiempo=velocidadgrad;
3117  0223 be14          	ldw	x,_velocidadgrad
3118  0225 bf4a          	ldw	_FSM+26,x
3119                     ; 215 	FSM[3].next[0]=Estado5;
3121  0227 ae0004        	ldw	x,#4
3122  022a bf4c          	ldw	_FSM+28,x
3123                     ; 216 	FSM[3].next[1]=Estado3;
3126  022c ae0002        	ldw	x,#2
3127  022f bf4e          	ldw	_FSM+30,x
3128                     ; 218 	FSM[4].SalidaMotor=0x08;//Encender BobinaC 0100 0
3131  0231 ae0008        	ldw	x,#8
3132  0234 bf50          	ldw	_FSM+32,x
3133                     ; 219 	FSM[4].tiempo=velocidadgrad;
3135  0236 be14          	ldw	x,_velocidadgrad
3136  0238 bf52          	ldw	_FSM+34,x
3137                     ; 220 	FSM[4].next[0]=Estado6;
3139  023a ae0005        	ldw	x,#5
3140  023d bf54          	ldw	_FSM+36,x
3141                     ; 221 	FSM[4].next[1]=Estado4;
3144  023f ae0003        	ldw	x,#3
3145  0242 bf56          	ldw	_FSM+38,x
3146                     ; 223 	FSM[5].SalidaMotor=0x18;//Encender BobinaCyD 1100 0
3149  0244 ae0018        	ldw	x,#24
3150  0247 bf58          	ldw	_FSM+40,x
3151                     ; 224 	FSM[5].tiempo=velocidadgrad;
3153  0249 be14          	ldw	x,_velocidadgrad
3154  024b bf5a          	ldw	_FSM+42,x
3155                     ; 225 	FSM[5].next[0]=Estado7;
3157  024d ae0006        	ldw	x,#6
3158  0250 bf5c          	ldw	_FSM+44,x
3159                     ; 226 	FSM[5].next[1]=Estado5;
3162  0252 ae0004        	ldw	x,#4
3163  0255 bf5e          	ldw	_FSM+46,x
3164                     ; 228 	FSM[6].SalidaMotor=0x10;//Encender BobinaD 1000 0
3167  0257 ae0010        	ldw	x,#16
3168  025a bf60          	ldw	_FSM+48,x
3169                     ; 229 	FSM[6].tiempo=velocidadgrad;
3171  025c be14          	ldw	x,_velocidadgrad
3172  025e bf62          	ldw	_FSM+50,x
3173                     ; 230 	FSM[6].next[0]=Estado8;
3175  0260 ae0007        	ldw	x,#7
3176  0263 bf64          	ldw	_FSM+52,x
3177                     ; 231 	FSM[6].next[1]=Estado6;
3180  0265 ae0005        	ldw	x,#5
3181  0268 bf66          	ldw	_FSM+54,x
3182                     ; 233 	FSM[7].SalidaMotor=0x12;//Encender BobinaDyA  1001 0
3185  026a ae0012        	ldw	x,#18
3186  026d bf68          	ldw	_FSM+56,x
3187                     ; 234 	FSM[7].tiempo=velocidadgrad;
3189  026f be14          	ldw	x,_velocidadgrad
3190  0271 bf6a          	ldw	_FSM+58,x
3191                     ; 235 	FSM[7].next[0]=Estado1;
3193  0273 5f            	clrw	x
3194  0274 bf6c          	ldw	_FSM+60,x
3195                     ; 236 	FSM[7].next[1]=Estado7;
3198  0276 ae0006        	ldw	x,#6
3199  0279 bf6e          	ldw	_FSM+62,x
3200                     ; 238 	es=Estado1;
3203  027b 5f            	clrw	x
3204  027c bf02          	ldw	_es,x
3205                     ; 239 	}
3209  027e 81            	ret
3250                     ; 241 void MensajePantallaAnguloActual(double angulo){
3251                     	switch	.text
3252  027f               _MensajePantallaAnguloActual:
3254  027f 5204          	subw	sp,#4
3255       00000004      OFST:	set	4
3258                     ; 243 if(abs(angulo)<10){
3260  0281 9c            	rvf
3261  0282 96            	ldw	x,sp
3262  0283 1c0007        	addw	x,#OFST+3
3263  0286 cd0000        	call	c_ltor
3265  0289 cd0000        	call	c_ftoi
3267  028c cd0000        	call	_abs
3269  028f 9c            	rvf
3270  0290 a3000a        	cpw	x,#10
3271  0293 2e0e          	jrsge	L7771
3272                     ; 244 		PonerCursorLCD(1,7);
3274  0295 ae0107        	ldw	x,#263
3275  0298 cd07d8        	call	_PonerCursorLCD
3277                     ; 245 		ImprimirCadenaLCD(" ");
3279  029b ae001a        	ldw	x,#L1002
3280  029e cd0847        	call	_ImprimirCadenaLCD
3283  02a1 2020          	jra	L3002
3284  02a3               L7771:
3285                     ; 246 		}else if(abs(angulo)<100){
3287  02a3 9c            	rvf
3288  02a4 96            	ldw	x,sp
3289  02a5 1c0007        	addw	x,#OFST+3
3290  02a8 cd0000        	call	c_ltor
3292  02ab cd0000        	call	c_ftoi
3294  02ae cd0000        	call	_abs
3296  02b1 9c            	rvf
3297  02b2 a30064        	cpw	x,#100
3298  02b5 2e0c          	jrsge	L3002
3299                     ; 247 		PonerCursorLCD(1,8);
3301  02b7 ae0108        	ldw	x,#264
3302  02ba cd07d8        	call	_PonerCursorLCD
3304                     ; 248 		ImprimirCadenaLCD(" ");
3306  02bd ae001a        	ldw	x,#L1002
3307  02c0 cd0847        	call	_ImprimirCadenaLCD
3309  02c3               L3002:
3310                     ; 250 	if(angulo<0){
3312  02c3 9c            	rvf
3313  02c4 9c            	rvf
3314  02c5 0d07          	tnz	(OFST+3,sp)
3315  02c7 2e63          	jrsge	L7002
3316                     ; 251 sprintf(stringAnguloinicial,"%d", (int) abs(angulo), (int) ((abs(angulo) - (int) abs(angulo) ) * 100) );
3318  02c9 96            	ldw	x,sp
3319  02ca 1c0007        	addw	x,#OFST+3
3320  02cd cd0000        	call	c_ltor
3322  02d0 cd0000        	call	c_ftoi
3324  02d3 cd0000        	call	_abs
3326  02d6 1f03          	ldw	(OFST-1,sp),x
3328  02d8 96            	ldw	x,sp
3329  02d9 1c0007        	addw	x,#OFST+3
3330  02dc cd0000        	call	c_ltor
3332  02df cd0000        	call	c_ftoi
3334  02e2 cd0000        	call	_abs
3336  02e5 72f003        	subw	x,(OFST-1,sp)
3337  02e8 a664          	ld	a,#100
3338  02ea cd0000        	call	c_bmulx
3340  02ed 89            	pushw	x
3341  02ee 96            	ldw	x,sp
3342  02ef 1c0009        	addw	x,#OFST+5
3343  02f2 cd0000        	call	c_ltor
3345  02f5 cd0000        	call	c_ftoi
3347  02f8 cd0000        	call	_abs
3349  02fb 89            	pushw	x
3350  02fc ae0017        	ldw	x,#L1102
3351  02ff 89            	pushw	x
3352  0300 ae0020        	ldw	x,#_stringAnguloinicial
3353  0303 cd0000        	call	_sprintf
3355  0306 5b06          	addw	sp,#6
3356                     ; 252 	PonerCursorLCD(1,5); 
3358  0308 ae0105        	ldw	x,#261
3359  030b cd07d8        	call	_PonerCursorLCD
3361                     ; 253 	ImprimirCharLCD(45);// Imprimir - 
3363  030e a62d          	ld	a,#45
3364  0310 cd080c        	call	_ImprimirCharLCD
3366                     ; 254 	PonerCursorLCD(1,6); 
3368  0313 ae0106        	ldw	x,#262
3369  0316 cd07d8        	call	_PonerCursorLCD
3371                     ; 255 	ImprimirCadenaLCD(stringAnguloinicial);
3373  0319 ae0020        	ldw	x,#_stringAnguloinicial
3374  031c cd0847        	call	_ImprimirCadenaLCD
3376                     ; 256 	PonerCursorLCD(1,9); 
3378  031f ae0109        	ldw	x,#265
3379  0322 cd07d8        	call	_PonerCursorLCD
3381                     ; 257 	ImprimirCharLCD(223); //Imprimir grados 1101 1111
3383  0325 a6df          	ld	a,#223
3384  0327 cd080c        	call	_ImprimirCharLCD
3387  032a 2065          	jra	L3102
3388  032c               L7002:
3389                     ; 259 sprintf(stringAnguloinicial,"%d", (int) angulo, (int) ((angulo - (int) angulo) * 100) );
3391  032c 96            	ldw	x,sp
3392  032d 1c0007        	addw	x,#OFST+3
3393  0330 cd0000        	call	c_ltor
3395  0333 cd0000        	call	c_ftoi
3397  0336 cd0000        	call	c_itof
3399  0339 96            	ldw	x,sp
3400  033a 1c0001        	addw	x,#OFST-3
3401  033d cd0000        	call	c_rtol
3404  0340 96            	ldw	x,sp
3405  0341 1c0007        	addw	x,#OFST+3
3406  0344 cd0000        	call	c_ltor
3408  0347 96            	ldw	x,sp
3409  0348 1c0001        	addw	x,#OFST-3
3410  034b cd0000        	call	c_fsub
3412  034e ae0013        	ldw	x,#L1202
3413  0351 cd0000        	call	c_fmul
3415  0354 cd0000        	call	c_ftoi
3417  0357 89            	pushw	x
3418  0358 96            	ldw	x,sp
3419  0359 1c0009        	addw	x,#OFST+5
3420  035c cd0000        	call	c_ltor
3422  035f cd0000        	call	c_ftoi
3424  0362 89            	pushw	x
3425  0363 ae0017        	ldw	x,#L1102
3426  0366 89            	pushw	x
3427  0367 ae0020        	ldw	x,#_stringAnguloinicial
3428  036a cd0000        	call	_sprintf
3430  036d 5b06          	addw	sp,#6
3431                     ; 260 	PonerCursorLCD(1,5); 
3433  036f ae0105        	ldw	x,#261
3434  0372 cd07d8        	call	_PonerCursorLCD
3436                     ; 261 	ImprimirCharLCD(43);// Imprimir + 
3438  0375 a62b          	ld	a,#43
3439  0377 cd080c        	call	_ImprimirCharLCD
3441                     ; 262 	PonerCursorLCD(1,6); 
3443  037a ae0106        	ldw	x,#262
3444  037d cd07d8        	call	_PonerCursorLCD
3446                     ; 263 	ImprimirCadenaLCD(stringAnguloinicial);
3448  0380 ae0020        	ldw	x,#_stringAnguloinicial
3449  0383 cd0847        	call	_ImprimirCadenaLCD
3451                     ; 264 	PonerCursorLCD(1,9); 
3453  0386 ae0109        	ldw	x,#265
3454  0389 cd07d8        	call	_PonerCursorLCD
3456                     ; 265 	ImprimirCharLCD(223); //Imprimir grados 1101 1111
3458  038c a6df          	ld	a,#223
3459  038e cd080c        	call	_ImprimirCharLCD
3461  0391               L3102:
3462                     ; 268 }
3465  0391 5b04          	addw	sp,#4
3466  0393 81            	ret
3507                     ; 270 void MensajePantallaAnguloSiguiente(double angulosiguiente){
3508                     	switch	.text
3509  0394               _MensajePantallaAnguloSiguiente:
3511  0394 5204          	subw	sp,#4
3512       00000004      OFST:	set	4
3515                     ; 272 		if(abs(angulosiguiente)<10){
3517  0396 9c            	rvf
3518  0397 96            	ldw	x,sp
3519  0398 1c0007        	addw	x,#OFST+3
3520  039b cd0000        	call	c_ltor
3522  039e cd0000        	call	c_ftoi
3524  03a1 cd0000        	call	_abs
3526  03a4 9c            	rvf
3527  03a5 a3000a        	cpw	x,#10
3528  03a8 2e0e          	jrsge	L3402
3529                     ; 273 		PonerCursorLCD(2,7); //9 antes 
3531  03aa ae0207        	ldw	x,#519
3532  03ad cd07d8        	call	_PonerCursorLCD
3534                     ; 274 		ImprimirCadenaLCD(" ");
3536  03b0 ae001a        	ldw	x,#L1002
3537  03b3 cd0847        	call	_ImprimirCadenaLCD
3540  03b6 2020          	jra	L5402
3541  03b8               L3402:
3542                     ; 275 		}else if(abs(angulosiguiente)<100){
3544  03b8 9c            	rvf
3545  03b9 96            	ldw	x,sp
3546  03ba 1c0007        	addw	x,#OFST+3
3547  03bd cd0000        	call	c_ltor
3549  03c0 cd0000        	call	c_ftoi
3551  03c3 cd0000        	call	_abs
3553  03c6 9c            	rvf
3554  03c7 a30064        	cpw	x,#100
3555  03ca 2e0c          	jrsge	L5402
3556                     ; 276 		PonerCursorLCD(2,9);//10 antes
3558  03cc ae0209        	ldw	x,#521
3559  03cf cd07d8        	call	_PonerCursorLCD
3561                     ; 277 		ImprimirCadenaLCD(" ");
3563  03d2 ae001a        	ldw	x,#L1002
3564  03d5 cd0847        	call	_ImprimirCadenaLCD
3566  03d8               L5402:
3567                     ; 279 	if(angulosiguiente<0){
3569  03d8 9c            	rvf
3570  03d9 9c            	rvf
3571  03da 0d07          	tnz	(OFST+3,sp)
3572  03dc 2e63          	jrsge	L1502
3573                     ; 280 	sprintf(stringAngulodeseado,"%d", (int) abs(angulosiguiente), (int) ((abs(angulosiguiente) - (int) abs(angulosiguiente) ) * 100) );
3575  03de 96            	ldw	x,sp
3576  03df 1c0007        	addw	x,#OFST+3
3577  03e2 cd0000        	call	c_ltor
3579  03e5 cd0000        	call	c_ftoi
3581  03e8 cd0000        	call	_abs
3583  03eb 1f03          	ldw	(OFST-1,sp),x
3585  03ed 96            	ldw	x,sp
3586  03ee 1c0007        	addw	x,#OFST+3
3587  03f1 cd0000        	call	c_ltor
3589  03f4 cd0000        	call	c_ftoi
3591  03f7 cd0000        	call	_abs
3593  03fa 72f003        	subw	x,(OFST-1,sp)
3594  03fd a664          	ld	a,#100
3595  03ff cd0000        	call	c_bmulx
3597  0402 89            	pushw	x
3598  0403 96            	ldw	x,sp
3599  0404 1c0009        	addw	x,#OFST+5
3600  0407 cd0000        	call	c_ltor
3602  040a cd0000        	call	c_ftoi
3604  040d cd0000        	call	_abs
3606  0410 89            	pushw	x
3607  0411 ae0017        	ldw	x,#L1102
3608  0414 89            	pushw	x
3609  0415 ae0010        	ldw	x,#_stringAngulodeseado
3610  0418 cd0000        	call	_sprintf
3612  041b 5b06          	addw	sp,#6
3613                     ; 281 	PonerCursorLCD(2,5);  //7 antes
3615  041d ae0205        	ldw	x,#517
3616  0420 cd07d8        	call	_PonerCursorLCD
3618                     ; 282 	ImprimirCharLCD(45);// Imprimir - 
3620  0423 a62d          	ld	a,#45
3621  0425 cd080c        	call	_ImprimirCharLCD
3623                     ; 283 	PonerCursorLCD(2,6); //8 antes
3625  0428 ae0206        	ldw	x,#518
3626  042b cd07d8        	call	_PonerCursorLCD
3628                     ; 284 	ImprimirCadenaLCD(stringAngulodeseado);
3630  042e ae0010        	ldw	x,#_stringAngulodeseado
3631  0431 cd0847        	call	_ImprimirCadenaLCD
3633                     ; 285 	PonerCursorLCD(2,9); //11 antes
3635  0434 ae0209        	ldw	x,#521
3636  0437 cd07d8        	call	_PonerCursorLCD
3638                     ; 286 	ImprimirCharLCD(223); //Imprimir grados 1101 1111
3640  043a a6df          	ld	a,#223
3641  043c cd080c        	call	_ImprimirCharLCD
3644  043f 2065          	jra	L3502
3645  0441               L1502:
3646                     ; 288 	sprintf(stringAngulodeseado,"%d", (int) angulosiguiente, (int) ((angulosiguiente - (int) angulosiguiente ) * 100) );
3648  0441 96            	ldw	x,sp
3649  0442 1c0007        	addw	x,#OFST+3
3650  0445 cd0000        	call	c_ltor
3652  0448 cd0000        	call	c_ftoi
3654  044b cd0000        	call	c_itof
3656  044e 96            	ldw	x,sp
3657  044f 1c0001        	addw	x,#OFST-3
3658  0452 cd0000        	call	c_rtol
3661  0455 96            	ldw	x,sp
3662  0456 1c0007        	addw	x,#OFST+3
3663  0459 cd0000        	call	c_ltor
3665  045c 96            	ldw	x,sp
3666  045d 1c0001        	addw	x,#OFST-3
3667  0460 cd0000        	call	c_fsub
3669  0463 ae0013        	ldw	x,#L1202
3670  0466 cd0000        	call	c_fmul
3672  0469 cd0000        	call	c_ftoi
3674  046c 89            	pushw	x
3675  046d 96            	ldw	x,sp
3676  046e 1c0009        	addw	x,#OFST+5
3677  0471 cd0000        	call	c_ltor
3679  0474 cd0000        	call	c_ftoi
3681  0477 89            	pushw	x
3682  0478 ae0017        	ldw	x,#L1102
3683  047b 89            	pushw	x
3684  047c ae0010        	ldw	x,#_stringAngulodeseado
3685  047f cd0000        	call	_sprintf
3687  0482 5b06          	addw	sp,#6
3688                     ; 289 	PonerCursorLCD(2,5); 
3690  0484 ae0205        	ldw	x,#517
3691  0487 cd07d8        	call	_PonerCursorLCD
3693                     ; 290 	ImprimirCharLCD(43);// Imprimir + 
3695  048a a62b          	ld	a,#43
3696  048c cd080c        	call	_ImprimirCharLCD
3698                     ; 291 	PonerCursorLCD(2,6); 
3700  048f ae0206        	ldw	x,#518
3701  0492 cd07d8        	call	_PonerCursorLCD
3703                     ; 292 	ImprimirCadenaLCD(stringAngulodeseado);
3705  0495 ae0010        	ldw	x,#_stringAngulodeseado
3706  0498 cd0847        	call	_ImprimirCadenaLCD
3708                     ; 293 	PonerCursorLCD(2,9); 
3710  049b ae0209        	ldw	x,#521
3711  049e cd07d8        	call	_PonerCursorLCD
3713                     ; 294 	ImprimirCharLCD(223); //Imprimir grados
3715  04a1 a6df          	ld	a,#223
3716  04a3 cd080c        	call	_ImprimirCharLCD
3718  04a6               L3502:
3719                     ; 297 }
3722  04a6 5b04          	addw	sp,#4
3723  04a8 81            	ret
3753                     ; 298 void MensajePantallaVelocidad(){
3754                     	switch	.text
3755  04a9               _MensajePantallaVelocidad:
3757  04a9 5204          	subw	sp,#4
3758       00000004      OFST:	set	4
3761                     ; 301 sprintf(stringVelocidad,"%d.%02u", (int) Velocidadpantalla, (int) ((Velocidadpantalla - (int) Velocidadpantalla) * 100) );
3763  04ab ae002a        	ldw	x,#_Velocidadpantalla
3764  04ae cd0000        	call	c_ltor
3766  04b1 cd0000        	call	c_ftoi
3768  04b4 cd0000        	call	c_itof
3770  04b7 96            	ldw	x,sp
3771  04b8 1c0001        	addw	x,#OFST-3
3772  04bb cd0000        	call	c_rtol
3775  04be ae002a        	ldw	x,#_Velocidadpantalla
3776  04c1 cd0000        	call	c_ltor
3778  04c4 96            	ldw	x,sp
3779  04c5 1c0001        	addw	x,#OFST-3
3780  04c8 cd0000        	call	c_fsub
3782  04cb ae0013        	ldw	x,#L1202
3783  04ce cd0000        	call	c_fmul
3785  04d1 cd0000        	call	c_ftoi
3787  04d4 89            	pushw	x
3788  04d5 ae002a        	ldw	x,#_Velocidadpantalla
3789  04d8 cd0000        	call	c_ltor
3791  04db cd0000        	call	c_ftoi
3793  04de 89            	pushw	x
3794  04df ae000b        	ldw	x,#L5602
3795  04e2 89            	pushw	x
3796  04e3 ae0000        	ldw	x,#_stringVelocidad
3797  04e6 cd0000        	call	_sprintf
3799  04e9 5b06          	addw	sp,#6
3800                     ; 304 	PonerCursorLCD(2,10); 
3802  04eb ae020a        	ldw	x,#522
3803  04ee cd07d8        	call	_PonerCursorLCD
3805                     ; 305 	ImprimirCadenaLCD(stringVelocidad);
3807  04f1 ae0000        	ldw	x,#_stringVelocidad
3808  04f4 cd0847        	call	_ImprimirCadenaLCD
3810                     ; 306 	PonerCursorLCD(2,14);
3812  04f7 ae020e        	ldw	x,#526
3813  04fa cd07d8        	call	_PonerCursorLCD
3815                     ; 307 	ImprimirCharLCD(223); //Imprimir grados 1101 1111
3817  04fd a6df          	ld	a,#223
3818  04ff cd080c        	call	_ImprimirCharLCD
3820                     ; 308 	PonerCursorLCD(2,15);
3822  0502 ae020f        	ldw	x,#527
3823  0505 cd07d8        	call	_PonerCursorLCD
3825                     ; 309 	ImprimirCadenaLCD("/s");
3827  0508 ae0008        	ldw	x,#L7602
3828  050b cd0847        	call	_ImprimirCadenaLCD
3830                     ; 311 }
3833  050e 5b04          	addw	sp,#4
3834  0510 81            	ret
3866                     ; 313 void configurarGPIO(){
3867                     	switch	.text
3868  0511               _configurarGPIO:
3872                     ; 316 	PB_ODR = 0x00;//Limpiar los latch de salida del PuertoB
3874  0511 725f5005      	clr	_PB_ODR
3875                     ; 317 	PC_ODR = 0x00;//Limpiar los latch de salida del PuertoC
3877  0515 725f500a      	clr	_PC_ODR
3878                     ; 318 	PD_ODR = 0x00;//Limpiar los latch de salida del puertoD
3880  0519 725f500f      	clr	_PD_ODR
3881                     ; 352 	PC_DDR &= ~0x78;//Bit 6,5,4,3 en 0
3883  051d c6500c        	ld	a,_PC_DDR
3884  0520 a487          	and	a,#135
3885  0522 c7500c        	ld	_PC_DDR,a
3886                     ; 353 	PB_DDR &= ~0x01;//Bit 0 en 0
3888  0525 72115007      	bres	_PB_DDR,#0
3889                     ; 356 	PD_DDR |= 0x7D;// Bits 6,5,4,3,2,0 en 1 para salidas
3891  0529 c65011        	ld	a,_PD_DDR
3892  052c aa7d          	or	a,#125
3893  052e c75011        	ld	_PD_DDR,a
3894                     ; 357 	PB_DDR |= 0x1E; // Bits 1,2,3,4 en 1 para salidas
3896  0531 c65007        	ld	a,_PB_DDR
3897  0534 aa1e          	or	a,#30
3898  0536 c75007        	ld	_PB_DDR,a
3899                     ; 362  	PC_CR1 &= ~0x78;//Entradas como flotantes , todo en 0
3901  0539 c6500d        	ld	a,_PC_CR1
3902  053c a487          	and	a,#135
3903  053e c7500d        	ld	_PC_CR1,a
3904                     ; 363 	PB_CR1 &= ~0x01;//Entradas como flotantes 
3906  0541 72115008      	bres	_PB_CR1,#0
3907                     ; 367 	PD_CR1 |= 0x7D; //Salidas push pull , se colocan en 1
3909  0545 c65012        	ld	a,_PD_CR1
3910  0548 aa7d          	or	a,#125
3911  054a c75012        	ld	_PD_CR1,a
3912                     ; 368 	PB_CR1 |= 0x1E; //Salidas push pull , se colocan en 1
3914  054d c65008        	ld	a,_PB_CR1
3915  0550 aa1e          	or	a,#30
3916  0552 c75008        	ld	_PB_CR1,a
3917                     ; 372 	}
3920  0555 81            	ret
3947                     ; 377 void CambioVelocidad(){
3948                     	switch	.text
3949  0556               _CambioVelocidad:
3951  0556 5204          	subw	sp,#4
3952       00000004      OFST:	set	4
3955                     ; 379 	if(bit1==0 && bit0==0){
3957  0558 be22          	ldw	x,_bit1
3958  055a 2609          	jrne	L1112
3960  055c be20          	ldw	x,_bit0
3961  055e 2605          	jrne	L1112
3962                     ; 380 		 velocidadgrad=10;
3964  0560 ae000a        	ldw	x,#10
3965  0563 bf14          	ldw	_velocidadgrad,x
3966  0565               L1112:
3967                     ; 382 	if(bit1==0 && bit0==1){
3969  0565 be22          	ldw	x,_bit1
3970  0567 260c          	jrne	L3112
3972  0569 be20          	ldw	x,_bit0
3973  056b a30001        	cpw	x,#1
3974  056e 2605          	jrne	L3112
3975                     ; 383 		velocidadgrad=20;
3977  0570 ae0014        	ldw	x,#20
3978  0573 bf14          	ldw	_velocidadgrad,x
3979  0575               L3112:
3980                     ; 385 	if(bit1==1 && bit0==0){ 
3982  0575 be22          	ldw	x,_bit1
3983  0577 a30001        	cpw	x,#1
3984  057a 2609          	jrne	L5112
3986  057c be20          	ldw	x,_bit0
3987  057e 2605          	jrne	L5112
3988                     ; 386 		velocidadgrad=40;
3990  0580 ae0028        	ldw	x,#40
3991  0583 bf14          	ldw	_velocidadgrad,x
3992  0585               L5112:
3993                     ; 388 	if(bit1==1 && bit0==1){
3995  0585 be22          	ldw	x,_bit1
3996  0587 a30001        	cpw	x,#1
3997  058a 260c          	jrne	L7112
3999  058c be20          	ldw	x,_bit0
4000  058e a30001        	cpw	x,#1
4001  0591 2605          	jrne	L7112
4002                     ; 389 		velocidadgrad=80;
4004  0593 ae0050        	ldw	x,#80
4005  0596 bf14          	ldw	_velocidadgrad,x
4006  0598               L7112:
4007                     ; 391 	Velocidadpantalla=86.95652174/velocidadgrad;
4009  0598 be14          	ldw	x,_velocidadgrad
4010  059a cd0000        	call	c_itof
4012  059d 96            	ldw	x,sp
4013  059e 1c0001        	addw	x,#OFST-3
4014  05a1 cd0000        	call	c_rtol
4017  05a4 ae0004        	ldw	x,#L5212
4018  05a7 cd0000        	call	c_ltor
4020  05aa 96            	ldw	x,sp
4021  05ab 1c0001        	addw	x,#OFST-3
4022  05ae cd0000        	call	c_fdiv
4024  05b1 ae002a        	ldw	x,#_Velocidadpantalla
4025  05b4 cd0000        	call	c_rtol
4027                     ; 394 	}
4030  05b7 5b04          	addw	sp,#4
4031  05b9 81            	ret
4059                     ; 396 void GiroNegativo(){
4060                     	switch	.text
4061  05ba               _GiroNegativo:
4063  05ba 5204          	subw	sp,#4
4064       00000004      OFST:	set	4
4067                     ; 398 	pasos=0;	
4069  05bc ae0000        	ldw	x,#0
4070  05bf bf26          	ldw	_pasos+2,x
4071  05c1 ae0000        	ldw	x,#0
4072  05c4 bf24          	ldw	_pasos,x
4074  05c6 2029          	jra	L5412
4075  05c8               L1412:
4076                     ; 400 	PB_ODR=FSM[es].SalidaMotor;
4078  05c8 be02          	ldw	x,_es
4079  05ca 58            	sllw	x
4080  05cb 58            	sllw	x
4081  05cc 58            	sllw	x
4082  05cd e631          	ld	a,(_FSM+1,x)
4083  05cf c75005        	ld	_PB_ODR,a
4084                     ; 401 	delay_ms(FSM[es].tiempo);
4086  05d2 be02          	ldw	x,_es
4087  05d4 58            	sllw	x
4088  05d5 58            	sllw	x
4089  05d6 58            	sllw	x
4090  05d7 ee32          	ldw	x,(_FSM+2,x)
4091  05d9 cd08b0        	call	_delay_ms
4093                     ; 402 	es=FSM[es].next[0];
4095  05dc be02          	ldw	x,_es
4096  05de 58            	sllw	x
4097  05df 58            	sllw	x
4098  05e0 58            	sllw	x
4099  05e1 ee34          	ldw	x,(_FSM+4,x)
4100  05e3 bf02          	ldw	_es,x
4101                     ; 403 	pasos=pasos+1;
4103  05e5 ae0000        	ldw	x,#L5512
4104  05e8 cd0000        	call	c_ltor
4106  05eb ae0024        	ldw	x,#_pasos
4107  05ee cd0000        	call	c_fgadd
4109  05f1               L5412:
4110                     ; 399 	while(pasos<23){
4110                     ; 400 	PB_ODR=FSM[es].SalidaMotor;
4110                     ; 401 	delay_ms(FSM[es].tiempo);
4110                     ; 402 	es=FSM[es].next[0];
4110                     ; 403 	pasos=pasos+1;
4112  05f1 9c            	rvf
4113  05f2 a617          	ld	a,#23
4114  05f4 cd0000        	call	c_ctof
4116  05f7 96            	ldw	x,sp
4117  05f8 1c0001        	addw	x,#OFST-3
4118  05fb cd0000        	call	c_rtol
4121  05fe ae0024        	ldw	x,#_pasos
4122  0601 cd0000        	call	c_ltor
4124  0604 96            	ldw	x,sp
4125  0605 1c0001        	addw	x,#OFST-3
4126  0608 cd0000        	call	c_fcmp
4128  060b 2fbb          	jrslt	L1412
4129                     ; 405 }
4132  060d 5b04          	addw	sp,#4
4133  060f 81            	ret
4161                     ; 407 void GiroPositivo(){
4162                     	switch	.text
4163  0610               _GiroPositivo:
4165  0610 5204          	subw	sp,#4
4166       00000004      OFST:	set	4
4169                     ; 409 	pasos=0;
4171  0612 ae0000        	ldw	x,#0
4172  0615 bf26          	ldw	_pasos+2,x
4173  0617 ae0000        	ldw	x,#0
4174  061a bf24          	ldw	_pasos,x
4176  061c 2029          	jra	L5712
4177  061e               L1712:
4178                     ; 411 	PB_ODR=FSM[es].SalidaMotor;
4180  061e be02          	ldw	x,_es
4181  0620 58            	sllw	x
4182  0621 58            	sllw	x
4183  0622 58            	sllw	x
4184  0623 e631          	ld	a,(_FSM+1,x)
4185  0625 c75005        	ld	_PB_ODR,a
4186                     ; 412 	delay_ms(FSM[es].tiempo);
4188  0628 be02          	ldw	x,_es
4189  062a 58            	sllw	x
4190  062b 58            	sllw	x
4191  062c 58            	sllw	x
4192  062d ee32          	ldw	x,(_FSM+2,x)
4193  062f cd08b0        	call	_delay_ms
4195                     ; 413 	es=FSM[es].next[1];
4197  0632 be02          	ldw	x,_es
4198  0634 58            	sllw	x
4199  0635 58            	sllw	x
4200  0636 58            	sllw	x
4201  0637 ee36          	ldw	x,(_FSM+6,x)
4202  0639 bf02          	ldw	_es,x
4203                     ; 414 	pasos=pasos+1;
4205  063b ae0000        	ldw	x,#L5512
4206  063e cd0000        	call	c_ltor
4208  0641 ae0024        	ldw	x,#_pasos
4209  0644 cd0000        	call	c_fgadd
4211  0647               L5712:
4212                     ; 410 	while(pasos<23){
4212                     ; 411 	PB_ODR=FSM[es].SalidaMotor;
4212                     ; 412 	delay_ms(FSM[es].tiempo);
4212                     ; 413 	es=FSM[es].next[1];
4212                     ; 414 	pasos=pasos+1;
4214  0647 9c            	rvf
4215  0648 a617          	ld	a,#23
4216  064a cd0000        	call	c_ctof
4218  064d 96            	ldw	x,sp
4219  064e 1c0001        	addw	x,#OFST-3
4220  0651 cd0000        	call	c_rtol
4223  0654 ae0024        	ldw	x,#_pasos
4224  0657 cd0000        	call	c_ltor
4226  065a 96            	ldw	x,sp
4227  065b 1c0001        	addw	x,#OFST-3
4228  065e cd0000        	call	c_fcmp
4230  0661 2fbb          	jrslt	L1712
4231                     ; 416 }
4234  0663 5b04          	addw	sp,#4
4235  0665 81            	ret
4261                     ; 420 @far @interrupt void EXTI1_IRQHandler(){
4263                     	switch	.text
4264  0666               f_EXTI1_IRQHandler:
4266       00000004      OFST:	set	4
4267  0666 be00          	ldw	x,c_x
4268  0668 89            	pushw	x
4269  0669 be02          	ldw	x,c_lreg+2
4270  066b 89            	pushw	x
4271  066c be00          	ldw	x,c_lreg
4272  066e 89            	pushw	x
4273  066f 5204          	subw	sp,#4
4276                     ; 422 	if(angulodeseado<300){
4278  0671 9c            	rvf
4279  0672 ae012c        	ldw	x,#300
4280  0675 cd0000        	call	c_itof
4282  0678 96            	ldw	x,sp
4283  0679 1c0001        	addw	x,#OFST-3
4284  067c cd0000        	call	c_rtol
4287  067f ae0008        	ldw	x,#_angulodeseado
4288  0682 cd0000        	call	c_ltor
4290  0685 96            	ldw	x,sp
4291  0686 1c0001        	addw	x,#OFST-3
4292  0689 cd0000        	call	c_fcmp
4294  068c 2e18          	jrsge	L1122
4295                     ; 423 	contadorgirospositivos++;
4297  068e be1e          	ldw	x,_contadorgirospositivos
4298  0690 1c0001        	addw	x,#1
4299  0693 bf1e          	ldw	_contadorgirospositivos,x
4300                     ; 424 	actualizar=1;
4302  0695 ae0001        	ldw	x,#1
4303  0698 bf28          	ldw	_actualizar,x
4304                     ; 425 	angulodeseado=angulodeseado+2; 
4306  069a ae001c        	ldw	x,#L5171
4307  069d cd0000        	call	c_ltor
4309  06a0 ae0008        	ldw	x,#_angulodeseado
4310  06a3 cd0000        	call	c_fgadd
4312  06a6               L1122:
4313                     ; 427 }
4316  06a6 5b04          	addw	sp,#4
4317  06a8 85            	popw	x
4318  06a9 bf00          	ldw	c_lreg,x
4319  06ab 85            	popw	x
4320  06ac bf02          	ldw	c_lreg+2,x
4321  06ae 85            	popw	x
4322  06af bf00          	ldw	c_x,x
4323  06b1 80            	iret
4348                     ; 429 @far @interrupt void EXTI2_IRQHandler(){
4349                     	switch	.text
4350  06b2               f_EXTI2_IRQHandler:
4352       00000004      OFST:	set	4
4353  06b2 be00          	ldw	x,c_x
4354  06b4 89            	pushw	x
4355  06b5 be02          	ldw	x,c_lreg+2
4356  06b7 89            	pushw	x
4357  06b8 be00          	ldw	x,c_lreg
4358  06ba 89            	pushw	x
4359  06bb 5204          	subw	sp,#4
4362                     ; 432 	if(angulodeseado>-270){
4364  06bd 9c            	rvf
4365  06be aefef2        	ldw	x,#65266
4366  06c1 cd0000        	call	c_itof
4368  06c4 96            	ldw	x,sp
4369  06c5 1c0001        	addw	x,#OFST-3
4370  06c8 cd0000        	call	c_rtol
4373  06cb ae0008        	ldw	x,#_angulodeseado
4374  06ce cd0000        	call	c_ltor
4376  06d1 96            	ldw	x,sp
4377  06d2 1c0001        	addw	x,#OFST-3
4378  06d5 cd0000        	call	c_fcmp
4380  06d8 2d18          	jrsle	L3222
4381                     ; 433 		actualizar=1;
4383  06da ae0001        	ldw	x,#1
4384  06dd bf28          	ldw	_actualizar,x
4385                     ; 434 		contadorgirosnegativos++;
4387  06df be1c          	ldw	x,_contadorgirosnegativos
4388  06e1 1c0001        	addw	x,#1
4389  06e4 bf1c          	ldw	_contadorgirosnegativos,x
4390                     ; 435 		angulodeseado= angulodeseado-2;
4392  06e6 ae001c        	ldw	x,#L5171
4393  06e9 cd0000        	call	c_ltor
4395  06ec ae0008        	ldw	x,#_angulodeseado
4396  06ef cd0000        	call	c_fgsub
4398  06f2               L3222:
4399                     ; 438 }
4402  06f2 5b04          	addw	sp,#4
4403  06f4 85            	popw	x
4404  06f5 bf00          	ldw	c_lreg,x
4405  06f7 85            	popw	x
4406  06f8 bf02          	ldw	c_lreg+2,x
4407  06fa 85            	popw	x
4408  06fb bf00          	ldw	c_x,x
4409  06fd 80            	iret
4442                     ; 440 void ConfigurarInterrupciones(){
4444                     	switch	.text
4445  06fe               _ConfigurarInterrupciones:
4449                     ; 446 	sim
4452  06fe 9b            sim
4454                     ; 451 	PC_ODR &= ~0x40;//PC6
4456  06ff 721d500a      	bres	_PC_ODR,#6
4457                     ; 452 	PB_ODR &= ~0x01;//PB0
4459  0703 72115005      	bres	_PB_ODR,#0
4460                     ; 455 	PC_DDR &= ~0x40;
4462  0707 721d500c      	bres	_PC_DDR,#6
4463                     ; 456 	PB_DDR &= ~0x01;
4465  070b 72115007      	bres	_PB_DDR,#0
4466                     ; 464 	EXTI_CR1 |= 0x14; 
4468  070f c650a0        	ld	a,_EXTI_CR1
4469  0712 aa14          	or	a,#20
4470  0714 c750a0        	ld	_EXTI_CR1,a
4471                     ; 465 	EXTI_CR1 &= ~0xEB; 
4473  0717 c650a0        	ld	a,_EXTI_CR1
4474  071a a414          	and	a,#20
4475  071c c750a0        	ld	_EXTI_CR1,a
4476                     ; 468 	PB_CR1 &= ~0x01;// Pin flotante	
4478  071f 72115008      	bres	_PB_CR1,#0
4479                     ; 469 	PC_CR1 &= ~0x40;// Pin flotante
4481  0723 721d500d      	bres	_PC_CR1,#6
4482                     ; 472 	PB_CR2 |= 0x01;
4484  0727 72105009      	bset	_PB_CR2,#0
4485                     ; 473 	PC_CR2 |= 0x40;
4487  072b 721c500e      	bset	_PC_CR2,#6
4488                     ; 477 	ITC_SPR2 |= 0xA3;
4490  072f c67f71        	ld	a,_ITC_SPR2
4491  0732 aaa3          	or	a,#163
4492  0734 c77f71        	ld	_ITC_SPR2,a
4493                     ; 478 	ITC_SPR2 &= ~0x5C;
4495  0737 c67f71        	ld	a,_ITC_SPR2
4496  073a a4a3          	and	a,#163
4497  073c c77f71        	ld	_ITC_SPR2,a
4498                     ; 482 	rim
4501  073f 9a            rim
4503                     ; 484 }
4506  0740 81            	ret
4541                     ; 494 void EnviarNibbleLCD(char nibble){ //los pines para enviar datos son D0-D3
4542                     	switch	.text
4543  0741               _EnviarNibbleLCD:
4545  0741 88            	push	a
4546       00000000      OFST:	set	0
4549                     ; 497 	if(nibble & 0x01){ 
4551  0742 a501          	bcp	a,#1
4552  0744 2706          	jreq	L3522
4553                     ; 499 		PD_ODR |= 0x08; //PD3=D4 se le envia 1
4555  0746 7216500f      	bset	_PD_ODR,#3
4557  074a 2004          	jra	L5522
4558  074c               L3522:
4559                     ; 502  		PD_ODR &= ~0x08; //PD3=D4 se le envia 0
4561  074c 7217500f      	bres	_PD_ODR,#3
4562  0750               L5522:
4563                     ; 507 	if(nibble & 0x02){
4565  0750 7b01          	ld	a,(OFST+1,sp)
4566  0752 a502          	bcp	a,#2
4567  0754 2706          	jreq	L7522
4568                     ; 509 		PD_ODR |= 0x10; // PD4=D5 se le envia 1
4570  0756 7218500f      	bset	_PD_ODR,#4
4572  075a 2004          	jra	L1622
4573  075c               L7522:
4574                     ; 512  		PD_ODR &= ~0x10; //PD4=D5 se le envia 0
4576  075c 7219500f      	bres	_PD_ODR,#4
4577  0760               L1622:
4578                     ; 517 	if(nibble & 0x04){ 
4580  0760 7b01          	ld	a,(OFST+1,sp)
4581  0762 a504          	bcp	a,#4
4582  0764 2706          	jreq	L3622
4583                     ; 519 		PD_ODR |= 0x20; // PD5=D6 se le envia 1
4585  0766 721a500f      	bset	_PD_ODR,#5
4587  076a 2004          	jra	L5622
4588  076c               L3622:
4589                     ; 523  		PD_ODR &= ~0x20; //PD5=D6 se le envia 0
4591  076c 721b500f      	bres	_PD_ODR,#5
4592  0770               L5622:
4593                     ; 527 	if(nibble & 0x08){ 
4595  0770 7b01          	ld	a,(OFST+1,sp)
4596  0772 a508          	bcp	a,#8
4597  0774 2706          	jreq	L7622
4598                     ; 529 		PD_ODR |= 0x40; // PD6=D7 se le envia 1
4600  0776 721c500f      	bset	_PD_ODR,#6
4602  077a 2004          	jra	L1722
4603  077c               L7622:
4604                     ; 533  		PD_ODR &= ~0x40; //PD6=D7 se le envia 0
4606  077c 721d500f      	bres	_PD_ODR,#6
4607  0780               L1722:
4608                     ; 535 }
4611  0780 84            	pop	a
4612  0781 81            	ret
4649                     ; 537 void EnviarComandoLCD(char a){
4650                     	switch	.text
4651  0782               _EnviarComandoLCD:
4655                     ; 540 	PD_ODR &= ~0x04; // RS=0 es decir PD2=0 para envio de comandos
4657  0782 7215500f      	bres	_PD_ODR,#2
4658                     ; 541 	EnviarNibbleLCD(a); //envio del dato deseado
4660  0786 adb9          	call	_EnviarNibbleLCD
4662                     ; 542 	PD_ODR |= 0x01; //EN=1 es decir PD0 = 1 ; inicia transmision
4664  0788 7210500f      	bset	_PD_ODR,#0
4665                     ; 543 	delay_ms(4); // delay para no preguntar por el estado BF de la LCD
4667  078c ae0004        	ldw	x,#4
4668  078f cd08b0        	call	_delay_ms
4670                     ; 544 	PD_ODR &= ~0x01; // EN=0 es decir PD0 = 0 ; cierra transmision 
4672  0792 7211500f      	bres	_PD_ODR,#0
4673                     ; 545 }	
4676  0796 81            	ret
4701                     ; 547 void IniciarLCD(){
4702                     	switch	.text
4703  0797               _IniciarLCD:
4707                     ; 550 	delay_ms(30);
4709  0797 ae001e        	ldw	x,#30
4710  079a cd08b0        	call	_delay_ms
4712                     ; 552 	EnviarComandoLCD(0x03); // RS  R/W~ DB7 DB6 DB5 DB4   segundo paso de algoritmo
4714  079d a603          	ld	a,#3
4715  079f ade1          	call	_EnviarComandoLCD
4717                     ; 554 	delay_ms(5);           // delay de minimo 4,1ms
4719  07a1 ae0005        	ldw	x,#5
4720  07a4 cd08b0        	call	_delay_ms
4722                     ; 555 	EnviarComandoLCD(0x03); //cuarto paso de algoritmo set DB5 y DB4
4724  07a7 a603          	ld	a,#3
4725  07a9 add7          	call	_EnviarComandoLCD
4727                     ; 556 	delay_ms(11);         //delay de minimo 100us
4729  07ab ae000b        	ldw	x,#11
4730  07ae cd08b0        	call	_delay_ms
4732                     ; 557 	EnviarComandoLCD(0x03); // sexto paso set DB5 y DB4
4734  07b1 a603          	ld	a,#3
4735  07b3 adcd          	call	_EnviarComandoLCD
4737                     ; 558 	EnviarComandoLCD(0x02); // indicar LCD manejo de modo de 4 bits
4739  07b5 a602          	ld	a,#2
4740  07b7 adc9          	call	_EnviarComandoLCD
4742                     ; 562 	EnviarComandoLCD(0x02); // DL=0 de function set
4744  07b9 a602          	ld	a,#2
4745  07bb adc5          	call	_EnviarComandoLCD
4747                     ; 563 	EnviarComandoLCD(0x08); // N=1, F=0 de function set
4749  07bd a608          	ld	a,#8
4750  07bf adc1          	call	_EnviarComandoLCD
4752                     ; 566 	EnviarComandoLCD(0x00);
4754  07c1 4f            	clr	a
4755  07c2 adbe          	call	_EnviarComandoLCD
4757                     ; 567 	EnviarComandoLCD(0x0C); //D=1 (display on), C=0 (cursor off), B=0 (titilar off) 
4759  07c4 a60c          	ld	a,#12
4760  07c6 adba          	call	_EnviarComandoLCD
4762                     ; 570 	EnviarComandoLCD(0x00);
4764  07c8 4f            	clr	a
4765  07c9 adb7          	call	_EnviarComandoLCD
4767                     ; 571 	EnviarComandoLCD(0x06); // I/D=1
4769  07cb a606          	ld	a,#6
4770  07cd adb3          	call	_EnviarComandoLCD
4772                     ; 572 }
4775  07cf 81            	ret
4799                     ; 574 void LimpiarLCD(){
4800                     	switch	.text
4801  07d0               _LimpiarLCD:
4805                     ; 575   EnviarComandoLCD(0);// bits mas significativo
4807  07d0 4f            	clr	a
4808  07d1 adaf          	call	_EnviarComandoLCD
4810                     ; 576 	EnviarComandoLCD(1);// bits menos significativos
4812  07d3 a601          	ld	a,#1
4813  07d5 adab          	call	_EnviarComandoLCD
4815                     ; 577 }
4818  07d7 81            	ret
4889                     ; 580 void PonerCursorLCD(char a, char b){
4890                     	switch	.text
4891  07d8               _PonerCursorLCD:
4893  07d8 89            	pushw	x
4894  07d9 89            	pushw	x
4895       00000002      OFST:	set	2
4898                     ; 583 	if(a == 1)
4900  07da 9e            	ld	a,xh
4901  07db a101          	cp	a,#1
4902  07dd 2607          	jrne	L7632
4903                     ; 585 		temp = 0x80 + b - 0x01; //80h
4905  07df 9f            	ld	a,xl
4906  07e0 ab7f          	add	a,#127
4907  07e2 6b02          	ld	(OFST+0,sp),a
4910  07e4 200c          	jra	L1732
4911  07e6               L7632:
4912                     ; 587 	else if(a == 2)
4914  07e6 7b03          	ld	a,(OFST+1,sp)
4915  07e8 a102          	cp	a,#2
4916  07ea 2606          	jrne	L1732
4917                     ; 589 		temp = 0xC0 + b - 1; //C0h
4919  07ec 7b04          	ld	a,(OFST+2,sp)
4920  07ee abbf          	add	a,#191
4921  07f0 6b02          	ld	(OFST+0,sp),a
4923  07f2               L1732:
4924                     ; 591 	z = temp >> 4;
4926  07f2 7b02          	ld	a,(OFST+0,sp)
4927  07f4 4e            	swap	a
4928  07f5 a40f          	and	a,#15
4929  07f7 6b01          	ld	(OFST-1,sp),a
4931                     ; 592 	y = temp & 0x0F;
4933  07f9 7b02          	ld	a,(OFST+0,sp)
4934  07fb a40f          	and	a,#15
4935  07fd 6b02          	ld	(OFST+0,sp),a
4937                     ; 593 	EnviarComandoLCD(z);
4939  07ff 7b01          	ld	a,(OFST-1,sp)
4940  0801 cd0782        	call	_EnviarComandoLCD
4942                     ; 594 	EnviarComandoLCD(y);
4944  0804 7b02          	ld	a,(OFST+0,sp)
4945  0806 cd0782        	call	_EnviarComandoLCD
4947                     ; 595 }
4950  0809 5b04          	addw	sp,#4
4951  080b 81            	ret
5006                     ; 597 void ImprimirCharLCD(char data){
5007                     	switch	.text
5008  080c               _ImprimirCharLCD:
5010  080c 88            	push	a
5011  080d 89            	pushw	x
5012       00000002      OFST:	set	2
5015                     ; 599 	Lower_Nibble = data & 0x0F; // leer los primeros 4 bits
5017  080e a40f          	and	a,#15
5018  0810 6b01          	ld	(OFST-1,sp),a
5020                     ; 600 	Upper_Nibble = data & 0xF0; // leer los segundos 4 bits
5022  0812 7b03          	ld	a,(OFST+1,sp)
5023  0814 a4f0          	and	a,#240
5024  0816 6b02          	ld	(OFST+0,sp),a
5026                     ; 601 	PD_ODR |= 0x04;	                    //PD2=RS=1 para envio de datos 
5028  0818 7214500f      	bset	_PD_ODR,#2
5029                     ; 602 	EnviarNibbleLCD(Upper_Nibble >> 4); //envia el MSB nibble
5031  081c 7b02          	ld	a,(OFST+0,sp)
5032  081e 4e            	swap	a
5033  081f a40f          	and	a,#15
5034  0821 cd0741        	call	_EnviarNibbleLCD
5036                     ; 603 	PD_ODR |= 0x01;	                      // PD0=EN=1
5038  0824 7210500f      	bset	_PD_ODR,#0
5039                     ; 604 	delay_ms(1);                      //delay para evitar polling de BF
5041  0828 ae0001        	ldw	x,#1
5042  082b cd08b0        	call	_delay_ms
5044                     ; 605 	PD_ODR &= ~0x01;                      // PD0=EN=0
5046  082e 7211500f      	bres	_PD_ODR,#0
5047                     ; 606 	EnviarNibbleLCD(Lower_Nibble);      //envia el LSB nibble
5049  0832 7b01          	ld	a,(OFST-1,sp)
5050  0834 cd0741        	call	_EnviarNibbleLCD
5052                     ; 607 	PD_ODR |= 0x01;	                      // PD0=EN=1
5054  0837 7210500f      	bset	_PD_ODR,#0
5055                     ; 608 	delay_ms(1);                      //delay para evitar polling de BF
5057  083b ae0001        	ldw	x,#1
5058  083e ad70          	call	_delay_ms
5060                     ; 609 	PD_ODR &= ~0x01;                         // PD0=EN=0
5062  0840 7211500f      	bres	_PD_ODR,#0
5063                     ; 610 }
5066  0844 5b03          	addw	sp,#3
5067  0846 81            	ret
5112                     ; 612 void ImprimirCadenaLCD(char *a){
5113                     	switch	.text
5114  0847               _ImprimirCadenaLCD:
5116  0847 89            	pushw	x
5117  0848 89            	pushw	x
5118       00000002      OFST:	set	2
5121                     ; 614 	for(i=0;a[i]!='\0';i++){
5123  0849 5f            	clrw	x
5124  084a 1f01          	ldw	(OFST-1,sp),x
5127  084c 200f          	jra	L1542
5128  084e               L5442:
5129                     ; 615 		ImprimirCharLCD(a[i]); 
5131  084e 1e01          	ldw	x,(OFST-1,sp)
5132  0850 72fb03        	addw	x,(OFST+1,sp)
5133  0853 f6            	ld	a,(x)
5134  0854 adb6          	call	_ImprimirCharLCD
5136                     ; 614 	for(i=0;a[i]!='\0';i++){
5138  0856 1e01          	ldw	x,(OFST-1,sp)
5139  0858 1c0001        	addw	x,#1
5140  085b 1f01          	ldw	(OFST-1,sp),x
5142  085d               L1542:
5145  085d 1e01          	ldw	x,(OFST-1,sp)
5146  085f 72fb03        	addw	x,(OFST+1,sp)
5147  0862 7d            	tnz	(x)
5148  0863 26e9          	jrne	L5442
5149                     ; 617 }
5152  0865 5b04          	addw	sp,#4
5153  0867 81            	ret
5182                     ; 621 void Timer4_Init(){
5183                     	switch	.text
5184  0868               _Timer4_Init:
5188                     ; 626 	TIM4_PSCR = 0x01; 
5190  0868 35015345      	mov	_TIM4_PSCR,#1
5191                     ; 629 	TIM4_ARR  = 0xFF;
5193  086c 35ff5346      	mov	_TIM4_ARR,#255
5194                     ; 631 	TIM4_CR1  = 0x00; //Resetear control de registro
5196  0870 725f5340      	clr	_TIM4_CR1
5197                     ; 636 	TIM4_CR1  |= 0x04; 
5199  0874 72145340      	bset	_TIM4_CR1,#2
5200                     ; 643 	TIM4_EGR  = 1; 
5202  0878 35015343      	mov	_TIM4_EGR,#1
5203                     ; 646 	TIM4_CNTR = 0x00;	//Se pone en 0 el contador
5205  087c 725f5344      	clr	_TIM4_CNTR
5206                     ; 649 	TIM4_IER &= ~0x01; 
5208  0880 72115341      	bres	_TIM4_IER,#0
5209                     ; 650 }
5212  0884 81            	ret
5250                     ; 653 void delay_us(int tiempo){
5251                     	switch	.text
5252  0885               _delay_us:
5254  0885 89            	pushw	x
5255       00000000      OFST:	set	0
5258                     ; 663 TIM4_EGR |= 0x01; 
5260  0886 72105343      	bset	_TIM4_EGR,#0
5261                     ; 664 TIM4_CNTR = 0x00;	//Se pone en 0 el contador
5263  088a 725f5344      	clr	_TIM4_CNTR
5264                     ; 667 TIM4_CR1 |= 0x01;
5266  088e 72105340      	bset	_TIM4_CR1,#0
5268  0892 2008          	jra	L5052
5269  0894               L3052:
5270                     ; 670 		TIM4_CR1 &= 0x01;
5272  0894 c65340        	ld	a,_TIM4_CR1
5273  0897 a401          	and	a,#1
5274  0899 c75340        	ld	_TIM4_CR1,a
5275  089c               L5052:
5276                     ; 669 	while(TIM4_CNTR<tiempo){
5278  089c 9c            	rvf
5279  089d c65344        	ld	a,_TIM4_CNTR
5280  08a0 5f            	clrw	x
5281  08a1 97            	ld	xl,a
5282  08a2 1301          	cpw	x,(OFST+1,sp)
5283  08a4 2fee          	jrslt	L3052
5284                     ; 674 	TIM4_SR  &= 0x01;
5286  08a6 c65342        	ld	a,_TIM4_SR
5287  08a9 a401          	and	a,#1
5288  08ab c75342        	ld	_TIM4_SR,a
5289                     ; 675 }
5292  08ae 85            	popw	x
5293  08af 81            	ret
5328                     ; 676 void delay_ms(int tiempo){
5329                     	switch	.text
5330  08b0               _delay_ms:
5332  08b0 89            	pushw	x
5333       00000000      OFST:	set	0
5336                     ; 681 	tiempo=tiempo*10;
5338  08b1 1e01          	ldw	x,(OFST+1,sp)
5339  08b3 a60a          	ld	a,#10
5340  08b5 cd0000        	call	c_bmulx
5342  08b8 1f01          	ldw	(OFST+1,sp),x
5344  08ba 2005          	jra	L1352
5345  08bc               L7252:
5346                     ; 683 	delay_us(100);
5348  08bc ae0064        	ldw	x,#100
5349  08bf adc4          	call	_delay_us
5351  08c1               L1352:
5352                     ; 682 	while(tiempo--){
5354  08c1 1e01          	ldw	x,(OFST+1,sp)
5355  08c3 1d0001        	subw	x,#1
5356  08c6 1f01          	ldw	(OFST+1,sp),x
5357  08c8 1c0001        	addw	x,#1
5358  08cb a30000        	cpw	x,#0
5359  08ce 26ec          	jrne	L7252
5360                     ; 685 }
5363  08d0 85            	popw	x
5364  08d1 81            	ret
5609                     	xdef	f_EXTI2_IRQHandler
5610                     	xdef	f_EXTI1_IRQHandler
5611                     	xdef	_main
5612                     	xdef	_Velocidadpantalla
5613                     	xdef	_actualizar
5614                     	xdef	_pasos
5615                     	xdef	_bit1
5616                     	xdef	_bit0
5617                     	xdef	_contadorgirospositivos
5618                     	xdef	_contadorgirosnegativos
5619                     	xdef	_desplazamientopos
5620                     	xdef	_desplazamientoneg
5621                     	xdef	_InicioGiro
5622                     	switch	.ubsct
5623  0000               _stringVelocidad:
5624  0000 000000000000  	ds.b	16
5625                     	xdef	_stringVelocidad
5626  0010               _stringAngulodeseado:
5627  0010 000000000000  	ds.b	16
5628                     	xdef	_stringAngulodeseado
5629  0020               _stringAnguloinicial:
5630  0020 000000000000  	ds.b	16
5631                     	xdef	_stringAnguloinicial
5632                     	xdef	_velocidadgrad
5633                     	xdef	_angulosiguiente
5634                     	xdef	_angulo
5635                     	xdef	_angulodeseado
5636                     	xdef	_anguloinicial
5637                     	xdef	_es
5638                     	xdef	_in
5639  0030               _FSM:
5640  0030 000000000000  	ds.b	64
5641                     	xdef	_FSM
5642                     	xdef	_GiroNegativo
5643                     	xdef	_GiroPositivo
5644                     	xdef	_FSM_Init
5645                     	xdef	_CambioVelocidad
5646                     	xdef	_ConfigurarInterrupciones
5647                     	xdef	_delay_ms
5648                     	xdef	_delay_us
5649                     	xdef	_Timer4_Init
5650                     	xdef	_MensajePantallaVelocidad
5651                     	xdef	_MensajePantallaAnguloActual
5652                     	xdef	_MensajePantallaAnguloSiguiente
5653                     	xdef	_ImprimirCadenaLCD
5654                     	xdef	_ImprimirCharLCD
5655                     	xdef	_IniciarLCD
5656                     	xdef	_PonerCursorLCD
5657                     	xdef	_LimpiarLCD
5658                     	xdef	_EnviarComandoLCD
5659                     	xdef	_EnviarNibbleLCD
5660                     	xdef	_configurarGPIO
5661                     	xref	_abs
5662                     	xref	_sprintf
5663                     .const:	section	.text
5664  0000               L5512:
5665  0000 3f800000      	dc.w	16256,0
5666  0004               L5212:
5667  0004 42ade9bd      	dc.w	17069,-5699
5668  0008               L7602:
5669  0008 2f7300        	dc.b	"/s",0
5670  000b               L5602:
5671  000b 25642e253032  	dc.b	"%d.%02u",0
5672  0013               L1202:
5673  0013 42c80000      	dc.w	17096,0
5674  0017               L1102:
5675  0017 256400        	dc.b	"%d",0
5676  001a               L1002:
5677  001a 2000          	dc.b	" ",0
5678  001c               L5171:
5679  001c 40000000      	dc.w	16384,0
5680  0020               L1561:
5681  0020 56656c6f3a00  	dc.b	"Velo:",0
5682  0026               L7461:
5683  0026 4465733a00    	dc.b	"Des:",0
5684  002b               L5461:
5685  002b 4163743a00    	dc.b	"Act:",0
5686  0030               L7661:
5687  0030 00000000      	dc.w	0,0
5688                     	xref.b	c_lreg
5689                     	xref.b	c_x
5709                     	xref	c_ctof
5710                     	xref	c_fdiv
5711                     	xref	c_fmul
5712                     	xref	c_bmulx
5713                     	xref	c_fsub
5714                     	xref	c_rtol
5715                     	xref	c_fgadd
5716                     	xref	c_fgsub
5717                     	xref	c_sdivx
5718                     	xref	c_ftoi
5719                     	xref	c_fadd
5720                     	xref	c_itof
5721                     	xref	c_fcmp
5722                     	xref	c_ltor
5723                     	end
