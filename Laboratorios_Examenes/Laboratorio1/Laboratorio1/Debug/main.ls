   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
2523                     	bsct
2524  0000               _fila1:
2525  0000 0001          	dc.w	1
2526  0002 0002          	dc.w	2
2527  0004 0003          	dc.w	3
2528  0006 0004          	dc.w	4
2529  0008               _fila2:
2530  0008 0005          	dc.w	5
2531  000a 0006          	dc.w	6
2532  000c 0007          	dc.w	7
2533  000e 0008          	dc.w	8
2534  0010               _fila3:
2535  0010 0009          	dc.w	9
2536  0012 000a          	dc.w	10
2537  0014 0009          	dc.w	9
2538  0016 000c          	dc.w	12
2725                     ; 33 main()
2725                     ; 34 {		
2727                     	switch	.text
2728  0000               _main:
2730  0000 521e          	subw	sp,#30
2731       0000001e      OFST:	set	30
2734  0002               L3471:
2735                     ; 37 	int a1 = fila1[0];
2737  0002 be00          	ldw	x,_fila1
2738  0004 1f1d          	ldw	(OFST-1,sp),x
2740                     ; 38 	int a2 = fila1[1];
2742  0006 be02          	ldw	x,_fila1+2
2743  0008 1f05          	ldw	(OFST-25,sp),x
2745                     ; 39 	int a3 = fila1[2];
2747  000a be04          	ldw	x,_fila1+4
2748  000c 1f07          	ldw	(OFST-23,sp),x
2750                     ; 41 	int a4 = fila2[0];
2752  000e be08          	ldw	x,_fila2
2753  0010 1f09          	ldw	(OFST-21,sp),x
2755                     ; 42 	int a5 = fila2[1];
2757  0012 be0a          	ldw	x,_fila2+2
2758  0014 1f0b          	ldw	(OFST-19,sp),x
2760                     ; 43 	int a6 = fila2[2];
2762  0016 be0c          	ldw	x,_fila2+4
2763  0018 1f0d          	ldw	(OFST-17,sp),x
2765                     ; 45 	int a7 = fila3[0];
2767  001a be10          	ldw	x,_fila3
2768  001c 1f0f          	ldw	(OFST-15,sp),x
2770                     ; 46 	int a8 = fila3[1];
2772  001e be12          	ldw	x,_fila3+2
2773  0020 1f11          	ldw	(OFST-13,sp),x
2775                     ; 47 	int a9 = fila3[2];
2777  0022 be14          	ldw	x,_fila3+4
2778  0024 1f13          	ldw	(OFST-11,sp),x
2780                     ; 49 	int b1 = fila1[3];
2782  0026 be06          	ldw	x,_fila1+6
2783  0028 1f15          	ldw	(OFST-9,sp),x
2785                     ; 50 	int b2 = fila2[3];
2787  002a be0e          	ldw	x,_fila2+6
2788  002c 1f17          	ldw	(OFST-7,sp),x
2790                     ; 51 	int b3 = fila3[3];
2792  002e be16          	ldw	x,_fila3+6
2793  0030 1f19          	ldw	(OFST-5,sp),x
2795                     ; 54 	int detA=determinanteA(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
2797  0032 1e19          	ldw	x,(OFST-5,sp)
2798  0034 89            	pushw	x
2799  0035 1e19          	ldw	x,(OFST-5,sp)
2800  0037 89            	pushw	x
2801  0038 1e19          	ldw	x,(OFST-5,sp)
2802  003a 89            	pushw	x
2803  003b 1e19          	ldw	x,(OFST-5,sp)
2804  003d 89            	pushw	x
2805  003e 1e19          	ldw	x,(OFST-5,sp)
2806  0040 89            	pushw	x
2807  0041 1e19          	ldw	x,(OFST-5,sp)
2808  0043 89            	pushw	x
2809  0044 1e19          	ldw	x,(OFST-5,sp)
2810  0046 89            	pushw	x
2811  0047 1e19          	ldw	x,(OFST-5,sp)
2812  0049 89            	pushw	x
2813  004a 1e19          	ldw	x,(OFST-5,sp)
2814  004c 89            	pushw	x
2815  004d 1e19          	ldw	x,(OFST-5,sp)
2816  004f 89            	pushw	x
2817  0050 1e19          	ldw	x,(OFST-5,sp)
2818  0052 89            	pushw	x
2819  0053 1e33          	ldw	x,(OFST+21,sp)
2820  0055 cd0113        	call	_determinanteA
2822  0058 5b16          	addw	sp,#22
2823  005a 1f1b          	ldw	(OFST-3,sp),x
2825                     ; 57 	int detx=determinantex(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
2827  005c 1e19          	ldw	x,(OFST-5,sp)
2828  005e 89            	pushw	x
2829  005f 1e19          	ldw	x,(OFST-5,sp)
2830  0061 89            	pushw	x
2831  0062 1e19          	ldw	x,(OFST-5,sp)
2832  0064 89            	pushw	x
2833  0065 1e19          	ldw	x,(OFST-5,sp)
2834  0067 89            	pushw	x
2835  0068 1e19          	ldw	x,(OFST-5,sp)
2836  006a 89            	pushw	x
2837  006b 1e19          	ldw	x,(OFST-5,sp)
2838  006d 89            	pushw	x
2839  006e 1e19          	ldw	x,(OFST-5,sp)
2840  0070 89            	pushw	x
2841  0071 1e19          	ldw	x,(OFST-5,sp)
2842  0073 89            	pushw	x
2843  0074 1e19          	ldw	x,(OFST-5,sp)
2844  0076 89            	pushw	x
2845  0077 1e19          	ldw	x,(OFST-5,sp)
2846  0079 89            	pushw	x
2847  007a 1e19          	ldw	x,(OFST-5,sp)
2848  007c 89            	pushw	x
2849  007d 1e33          	ldw	x,(OFST+21,sp)
2850  007f cd017e        	call	_determinantex
2852  0082 5b16          	addw	sp,#22
2853  0084 1f01          	ldw	(OFST-29,sp),x
2855                     ; 58 	int dety=determinantey(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
2857  0086 1e19          	ldw	x,(OFST-5,sp)
2858  0088 89            	pushw	x
2859  0089 1e19          	ldw	x,(OFST-5,sp)
2860  008b 89            	pushw	x
2861  008c 1e19          	ldw	x,(OFST-5,sp)
2862  008e 89            	pushw	x
2863  008f 1e19          	ldw	x,(OFST-5,sp)
2864  0091 89            	pushw	x
2865  0092 1e19          	ldw	x,(OFST-5,sp)
2866  0094 89            	pushw	x
2867  0095 1e19          	ldw	x,(OFST-5,sp)
2868  0097 89            	pushw	x
2869  0098 1e19          	ldw	x,(OFST-5,sp)
2870  009a 89            	pushw	x
2871  009b 1e19          	ldw	x,(OFST-5,sp)
2872  009d 89            	pushw	x
2873  009e 1e19          	ldw	x,(OFST-5,sp)
2874  00a0 89            	pushw	x
2875  00a1 1e19          	ldw	x,(OFST-5,sp)
2876  00a3 89            	pushw	x
2877  00a4 1e19          	ldw	x,(OFST-5,sp)
2878  00a6 89            	pushw	x
2879  00a7 1e33          	ldw	x,(OFST+21,sp)
2880  00a9 cd01e9        	call	_determinantey
2882  00ac 5b16          	addw	sp,#22
2883  00ae 1f03          	ldw	(OFST-27,sp),x
2885                     ; 59 	int detz=determinantez(a1,a2,a3,a4,a5,a6,a7,a8,a9,b1,b2,b3);
2887  00b0 1e19          	ldw	x,(OFST-5,sp)
2888  00b2 89            	pushw	x
2889  00b3 1e19          	ldw	x,(OFST-5,sp)
2890  00b5 89            	pushw	x
2891  00b6 1e19          	ldw	x,(OFST-5,sp)
2892  00b8 89            	pushw	x
2893  00b9 1e19          	ldw	x,(OFST-5,sp)
2894  00bb 89            	pushw	x
2895  00bc 1e19          	ldw	x,(OFST-5,sp)
2896  00be 89            	pushw	x
2897  00bf 1e19          	ldw	x,(OFST-5,sp)
2898  00c1 89            	pushw	x
2899  00c2 1e19          	ldw	x,(OFST-5,sp)
2900  00c4 89            	pushw	x
2901  00c5 1e19          	ldw	x,(OFST-5,sp)
2902  00c7 89            	pushw	x
2903  00c8 1e19          	ldw	x,(OFST-5,sp)
2904  00ca 89            	pushw	x
2905  00cb 1e19          	ldw	x,(OFST-5,sp)
2906  00cd 89            	pushw	x
2907  00ce 1e19          	ldw	x,(OFST-5,sp)
2908  00d0 89            	pushw	x
2909  00d1 1e33          	ldw	x,(OFST+21,sp)
2910  00d3 cd0254        	call	_determinantez
2912  00d6 5b16          	addw	sp,#22
2913  00d8 1f1d          	ldw	(OFST-1,sp),x
2915                     ; 61 	 Solucionx = detx/detA ;
2917  00da 1e01          	ldw	x,(OFST-29,sp)
2918  00dc 161b          	ldw	y,(OFST-3,sp)
2919  00de cd0000        	call	c_idiv
2921  00e1 bf0a          	ldw	_Solucionx,x
2922                     ; 62 	 Soluciony = dety/detA ;
2924  00e3 1e03          	ldw	x,(OFST-27,sp)
2925  00e5 161b          	ldw	y,(OFST-3,sp)
2926  00e7 cd0000        	call	c_idiv
2928  00ea bf08          	ldw	_Soluciony,x
2929                     ; 63 	 Solucionz = detz/detA ;
2931  00ec 1e1d          	ldw	x,(OFST-1,sp)
2932  00ee 161b          	ldw	y,(OFST-3,sp)
2933  00f0 cd0000        	call	c_idiv
2935  00f3 bf06          	ldw	_Solucionz,x
2936                     ; 65 	 X[0] =  Solucionx; 
2938  00f5 be0a          	ldw	x,_Solucionx
2939  00f7 bf00          	ldw	_X,x
2940                     ; 66 	 X[1] =  Soluciony; 
2942  00f9 be08          	ldw	x,_Soluciony
2943  00fb bf02          	ldw	_X+2,x
2944                     ; 67 	 X[2] =  Solucionz; 
2946  00fd be06          	ldw	x,_Solucionz
2947  00ff bf04          	ldw	_X+4,x
2948                     ; 70 	if (detA == 0){
2950  0101 1e1b          	ldw	x,(OFST-3,sp)
2951  0103 2606          	jrne	L7471
2952                     ; 71 		UnicaSolucion = 0;
2954  0105 3f0c          	clr	_UnicaSolucion
2956  0107 ac020002      	jpf	L3471
2957  010b               L7471:
2958                     ; 73 		UnicaSolucion = 1;
2960  010b 3501000c      	mov	_UnicaSolucion,#1
2961  010f ac020002      	jpf	L3471
3076                     ; 80 int determinanteA(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){
3077                     	switch	.text
3078  0113               _determinanteA:
3080  0113 89            	pushw	x
3081  0114 520c          	subw	sp,#12
3082       0000000c      OFST:	set	12
3085                     ; 81 	int A = ((a1*a5*a9) +(a4*a8*a3) + (a7*a2*a6))-((a7*a5*a3)+(a1*a8*a6)+(a4*a2*a9));
3087  0116 1e15          	ldw	x,(OFST+9,sp)
3088  0118 1611          	ldw	y,(OFST+5,sp)
3089  011a cd0000        	call	c_imul
3091  011d 161f          	ldw	y,(OFST+19,sp)
3092  011f cd0000        	call	c_imul
3094  0122 1f09          	ldw	(OFST-3,sp),x
3096  0124 1e0d          	ldw	x,(OFST+1,sp)
3097  0126 161d          	ldw	y,(OFST+17,sp)
3098  0128 cd0000        	call	c_imul
3100  012b 1619          	ldw	y,(OFST+13,sp)
3101  012d cd0000        	call	c_imul
3103  0130 1f07          	ldw	(OFST-5,sp),x
3105  0132 1e1b          	ldw	x,(OFST+15,sp)
3106  0134 1617          	ldw	y,(OFST+11,sp)
3107  0136 cd0000        	call	c_imul
3109  0139 1613          	ldw	y,(OFST+7,sp)
3110  013b cd0000        	call	c_imul
3112  013e 72fb07        	addw	x,(OFST-5,sp)
3113  0141 72fb09        	addw	x,(OFST-3,sp)
3114  0144 1f05          	ldw	(OFST-7,sp),x
3116  0146 1e1b          	ldw	x,(OFST+15,sp)
3117  0148 1611          	ldw	y,(OFST+5,sp)
3118  014a cd0000        	call	c_imul
3120  014d 1619          	ldw	y,(OFST+13,sp)
3121  014f cd0000        	call	c_imul
3123  0152 1f03          	ldw	(OFST-9,sp),x
3125  0154 1e15          	ldw	x,(OFST+9,sp)
3126  0156 161d          	ldw	y,(OFST+17,sp)
3127  0158 cd0000        	call	c_imul
3129  015b 1613          	ldw	y,(OFST+7,sp)
3130  015d cd0000        	call	c_imul
3132  0160 1f01          	ldw	(OFST-11,sp),x
3134  0162 1e0d          	ldw	x,(OFST+1,sp)
3135  0164 1617          	ldw	y,(OFST+11,sp)
3136  0166 cd0000        	call	c_imul
3138  0169 161f          	ldw	y,(OFST+19,sp)
3139  016b cd0000        	call	c_imul
3141  016e 72fb01        	addw	x,(OFST-11,sp)
3142  0171 72fb03        	addw	x,(OFST-9,sp)
3143  0174 72f005        	subw	x,(OFST-7,sp)
3144  0177 1f0b          	ldw	(OFST-1,sp),x
3146                     ; 82 	return A; 
3148  0179 1e0b          	ldw	x,(OFST-1,sp)
3151  017b 5b0e          	addw	sp,#14
3152  017d 81            	ret
3276                     ; 85 int determinantex(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
3277                     	switch	.text
3278  017e               _determinantex:
3280  017e 89            	pushw	x
3281  017f 520c          	subw	sp,#12
3282       0000000c      OFST:	set	12
3285                     ; 86 	int x = ((b1*a5*a9)+(b2*a8*a3)+(b3*a2*a6))-((b3*a5*a3)+(b1*a8*a6)+(b2*a2*a9)) ;
3287  0181 1e23          	ldw	x,(OFST+23,sp)
3288  0183 1611          	ldw	y,(OFST+5,sp)
3289  0185 cd0000        	call	c_imul
3291  0188 161f          	ldw	y,(OFST+19,sp)
3292  018a cd0000        	call	c_imul
3294  018d 1f09          	ldw	(OFST-3,sp),x
3296  018f 1e21          	ldw	x,(OFST+21,sp)
3297  0191 161d          	ldw	y,(OFST+17,sp)
3298  0193 cd0000        	call	c_imul
3300  0196 1619          	ldw	y,(OFST+13,sp)
3301  0198 cd0000        	call	c_imul
3303  019b 1f07          	ldw	(OFST-5,sp),x
3305  019d 1e25          	ldw	x,(OFST+25,sp)
3306  019f 1617          	ldw	y,(OFST+11,sp)
3307  01a1 cd0000        	call	c_imul
3309  01a4 1613          	ldw	y,(OFST+7,sp)
3310  01a6 cd0000        	call	c_imul
3312  01a9 72fb07        	addw	x,(OFST-5,sp)
3313  01ac 72fb09        	addw	x,(OFST-3,sp)
3314  01af 1f05          	ldw	(OFST-7,sp),x
3316  01b1 1e25          	ldw	x,(OFST+25,sp)
3317  01b3 1611          	ldw	y,(OFST+5,sp)
3318  01b5 cd0000        	call	c_imul
3320  01b8 1619          	ldw	y,(OFST+13,sp)
3321  01ba cd0000        	call	c_imul
3323  01bd 1f03          	ldw	(OFST-9,sp),x
3325  01bf 1e23          	ldw	x,(OFST+23,sp)
3326  01c1 161d          	ldw	y,(OFST+17,sp)
3327  01c3 cd0000        	call	c_imul
3329  01c6 1613          	ldw	y,(OFST+7,sp)
3330  01c8 cd0000        	call	c_imul
3332  01cb 1f01          	ldw	(OFST-11,sp),x
3334  01cd 1e21          	ldw	x,(OFST+21,sp)
3335  01cf 1617          	ldw	y,(OFST+11,sp)
3336  01d1 cd0000        	call	c_imul
3338  01d4 161f          	ldw	y,(OFST+19,sp)
3339  01d6 cd0000        	call	c_imul
3341  01d9 72fb01        	addw	x,(OFST-11,sp)
3342  01dc 72fb03        	addw	x,(OFST-9,sp)
3343  01df 72f005        	subw	x,(OFST-7,sp)
3344  01e2 1f0b          	ldw	(OFST-1,sp),x
3346                     ; 87 	return x;
3348  01e4 1e0b          	ldw	x,(OFST-1,sp)
3351  01e6 5b0e          	addw	sp,#14
3352  01e8 81            	ret
3467                     ; 90 int determinantey(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
3468                     	switch	.text
3469  01e9               _determinantey:
3471  01e9 89            	pushw	x
3472  01ea 520c          	subw	sp,#12
3473       0000000c      OFST:	set	12
3476                     ; 91 	int y = ((a1*b2*a9)+(a4*b3*a3)+(a7*b1*a6))-((a7*b2*a3)+(a1*b3*a6)+(a4*b1*a9)) ;
3478  01ec 1e15          	ldw	x,(OFST+9,sp)
3479  01ee 1621          	ldw	y,(OFST+21,sp)
3480  01f0 cd0000        	call	c_imul
3482  01f3 161f          	ldw	y,(OFST+19,sp)
3483  01f5 cd0000        	call	c_imul
3485  01f8 1f09          	ldw	(OFST-3,sp),x
3487  01fa 1e0d          	ldw	x,(OFST+1,sp)
3488  01fc 1625          	ldw	y,(OFST+25,sp)
3489  01fe cd0000        	call	c_imul
3491  0201 1619          	ldw	y,(OFST+13,sp)
3492  0203 cd0000        	call	c_imul
3494  0206 1f07          	ldw	(OFST-5,sp),x
3496  0208 1e1b          	ldw	x,(OFST+15,sp)
3497  020a 1623          	ldw	y,(OFST+23,sp)
3498  020c cd0000        	call	c_imul
3500  020f 1613          	ldw	y,(OFST+7,sp)
3501  0211 cd0000        	call	c_imul
3503  0214 72fb07        	addw	x,(OFST-5,sp)
3504  0217 72fb09        	addw	x,(OFST-3,sp)
3505  021a 1f05          	ldw	(OFST-7,sp),x
3507  021c 1e1b          	ldw	x,(OFST+15,sp)
3508  021e 1621          	ldw	y,(OFST+21,sp)
3509  0220 cd0000        	call	c_imul
3511  0223 1619          	ldw	y,(OFST+13,sp)
3512  0225 cd0000        	call	c_imul
3514  0228 1f03          	ldw	(OFST-9,sp),x
3516  022a 1e15          	ldw	x,(OFST+9,sp)
3517  022c 1625          	ldw	y,(OFST+25,sp)
3518  022e cd0000        	call	c_imul
3520  0231 1613          	ldw	y,(OFST+7,sp)
3521  0233 cd0000        	call	c_imul
3523  0236 1f01          	ldw	(OFST-11,sp),x
3525  0238 1e0d          	ldw	x,(OFST+1,sp)
3526  023a 1623          	ldw	y,(OFST+23,sp)
3527  023c cd0000        	call	c_imul
3529  023f 161f          	ldw	y,(OFST+19,sp)
3530  0241 cd0000        	call	c_imul
3532  0244 72fb01        	addw	x,(OFST-11,sp)
3533  0247 72fb03        	addw	x,(OFST-9,sp)
3534  024a 72f005        	subw	x,(OFST-7,sp)
3535  024d 1f0b          	ldw	(OFST-1,sp),x
3537                     ; 92 	return y;
3539  024f 1e0b          	ldw	x,(OFST-1,sp)
3542  0251 5b0e          	addw	sp,#14
3543  0253 81            	ret
3658                     ; 95 int determinantez(int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8,int a9,int b1,int b2,int b3){	
3659                     	switch	.text
3660  0254               _determinantez:
3662  0254 89            	pushw	x
3663  0255 520c          	subw	sp,#12
3664       0000000c      OFST:	set	12
3667                     ; 96 		int z = ((a1*a5*b3)+(a4*a8*b1)+(a7*a2*b2))-((a7*a5*b1)+(a1*a8*b2)+(a4*a2*b3)) ;
3669  0257 1e15          	ldw	x,(OFST+9,sp)
3670  0259 1611          	ldw	y,(OFST+5,sp)
3671  025b cd0000        	call	c_imul
3673  025e 1625          	ldw	y,(OFST+25,sp)
3674  0260 cd0000        	call	c_imul
3676  0263 1f09          	ldw	(OFST-3,sp),x
3678  0265 1e0d          	ldw	x,(OFST+1,sp)
3679  0267 161d          	ldw	y,(OFST+17,sp)
3680  0269 cd0000        	call	c_imul
3682  026c 1623          	ldw	y,(OFST+23,sp)
3683  026e cd0000        	call	c_imul
3685  0271 1f07          	ldw	(OFST-5,sp),x
3687  0273 1e1b          	ldw	x,(OFST+15,sp)
3688  0275 1617          	ldw	y,(OFST+11,sp)
3689  0277 cd0000        	call	c_imul
3691  027a 1621          	ldw	y,(OFST+21,sp)
3692  027c cd0000        	call	c_imul
3694  027f 72fb07        	addw	x,(OFST-5,sp)
3695  0282 72fb09        	addw	x,(OFST-3,sp)
3696  0285 1f05          	ldw	(OFST-7,sp),x
3698  0287 1e1b          	ldw	x,(OFST+15,sp)
3699  0289 1611          	ldw	y,(OFST+5,sp)
3700  028b cd0000        	call	c_imul
3702  028e 1623          	ldw	y,(OFST+23,sp)
3703  0290 cd0000        	call	c_imul
3705  0293 1f03          	ldw	(OFST-9,sp),x
3707  0295 1e15          	ldw	x,(OFST+9,sp)
3708  0297 161d          	ldw	y,(OFST+17,sp)
3709  0299 cd0000        	call	c_imul
3711  029c 1621          	ldw	y,(OFST+21,sp)
3712  029e cd0000        	call	c_imul
3714  02a1 1f01          	ldw	(OFST-11,sp),x
3716  02a3 1e0d          	ldw	x,(OFST+1,sp)
3717  02a5 1617          	ldw	y,(OFST+11,sp)
3718  02a7 cd0000        	call	c_imul
3720  02aa 1625          	ldw	y,(OFST+25,sp)
3721  02ac cd0000        	call	c_imul
3723  02af 72fb01        	addw	x,(OFST-11,sp)
3724  02b2 72fb03        	addw	x,(OFST-9,sp)
3725  02b5 72f005        	subw	x,(OFST-7,sp)
3726  02b8 1f0b          	ldw	(OFST-1,sp),x
3728                     ; 97 	return z;
3730  02ba 1e0b          	ldw	x,(OFST-1,sp)
3733  02bc 5b0e          	addw	sp,#14
3734  02be 81            	ret
3825                     	xdef	_main
3826                     	switch	.ubsct
3827  0000               _X:
3828  0000 000000000000  	ds.b	6
3829                     	xdef	_X
3830                     	xdef	_determinantez
3831                     	xdef	_determinantey
3832                     	xdef	_determinantex
3833                     	xdef	_determinanteA
3834  0006               _Solucionz:
3835  0006 0000          	ds.b	2
3836                     	xdef	_Solucionz
3837  0008               _Soluciony:
3838  0008 0000          	ds.b	2
3839                     	xdef	_Soluciony
3840  000a               _Solucionx:
3841  000a 0000          	ds.b	2
3842                     	xdef	_Solucionx
3843  000c               _UnicaSolucion:
3844  000c 00            	ds.b	1
3845                     	xdef	_UnicaSolucion
3846                     	xdef	_fila3
3847                     	xdef	_fila2
3848                     	xdef	_fila1
3849                     	xref.b	c_x
3869                     	xref	c_imul
3870                     	xref	c_idiv
3871                     	end
