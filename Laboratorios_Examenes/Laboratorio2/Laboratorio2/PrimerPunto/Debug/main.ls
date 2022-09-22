   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
2523                     	bsct
2524  0000               _CLK_ICKR:
2525  0000 0000          	dc.w	0
2556                     ; 15 main()
2556                     ; 16 {
2558                     	switch	.text
2559  0000               _main:
2563                     ; 17 	configurarReloj();
2565  0000 ad04          	call	_configurarReloj
2567                     ; 18 	activarSalidaReloj();
2569  0002 ad38          	call	_activarSalidaReloj
2571  0004               L1461:
2573  0004 20fe          	jra	L1461
2611                     ; 28 void configurarReloj(){
2612                     	switch	.text
2613  0006               _configurarReloj:
2615  0006 89            	pushw	x
2616       00000002      OFST:	set	2
2619                     ; 30 	int a = 0; 
2621                     ; 35 	CLK_SWCR |= 0x02;
2623  0007 721250c5      	bset	_CLK_SWCR,#1
2624                     ; 41 	CLK_SWR = 0xD2; //Asigna reloj interno  de 128 Khz
2626  000b 35d250c4      	mov	_CLK_SWR,#210
2627                     ; 43 		CLK_ICKR &= 0x08; // Activa la compuerta AND
2629  000f b601          	ld	a,_CLK_ICKR+1
2630  0011 a408          	and	a,#8
2631  0013 b701          	ld	_CLK_ICKR+1,a
2632  0015 3f00          	clr	_CLK_ICKR
2633                     ; 48 	CLK_CMSR = 0xD2; // LLave selectora mux - Se elige el LSI
2635  0017 35d250c3      	mov	_CLK_CMSR,#210
2636                     ; 52 	a = CLK_SWCR & 0x01;
2638  001b c650c5        	ld	a,_CLK_SWCR
2639  001e a401          	and	a,#1
2640  0020 5f            	clrw	x
2641  0021 97            	ld	xl,a
2642  0022 1f01          	ldw	(OFST-1,sp),x
2645  0024 2009          	jra	L7661
2646  0026               L3661:
2647                     ; 55 		a = CLK_SWCR & 0x01;
2649  0026 c650c5        	ld	a,_CLK_SWCR
2650  0029 a401          	and	a,#1
2651  002b 5f            	clrw	x
2652  002c 97            	ld	xl,a
2653  002d 1f01          	ldw	(OFST-1,sp),x
2655  002f               L7661:
2656                     ; 54 	while(a == 1){
2658  002f 1e01          	ldw	x,(OFST-1,sp)
2659  0031 a30001        	cpw	x,#1
2660  0034 27f0          	jreq	L3661
2661                     ; 62 	CLK_SWCR &= ~0x02;
2663  0036 721350c5      	bres	_CLK_SWCR,#1
2664                     ; 65 }
2667  003a 85            	popw	x
2668  003b 81            	ret
2695                     ; 66 void activarSalidaReloj(){
2696                     	switch	.text
2697  003c               _activarSalidaReloj:
2701                     ; 69 	PD_DDR |= 0x01;
2703  003c 72105011      	bset	_PD_DDR,#0
2704                     ; 70 	PD_CR1 |= 0x01;
2706  0040 72105012      	bset	_PD_CR1,#0
2707                     ; 74 	PD_CR2 |= 0x01;
2709  0044 72105013      	bset	_PD_CR2,#0
2710                     ; 86 	CLK_CCOR |= 0x14;   //Set bits 4,2 para dividir en 64 
2712  0048 c650c9        	ld	a,_CLK_CCOR
2713  004b aa14          	or	a,#20
2714  004d c750c9        	ld	_CLK_CCOR,a
2715                     ; 87 	CLK_CCOR &= ~0x0A;	// Set bits 3,1 en 0 
2717  0050 c650c9        	ld	a,_CLK_CCOR
2718  0053 a4f5          	and	a,#245
2719  0055 c750c9        	ld	_CLK_CCOR,a
2720                     ; 91 	CLK_CCOR |= 0x01; 
2722  0058 721050c9      	bset	_CLK_CCOR,#0
2723                     ; 92 }
2726  005c 81            	ret
2750                     	xdef	_main
2751                     	xdef	_CLK_ICKR
2752                     	xdef	_activarSalidaReloj
2753                     	xdef	_configurarReloj
2772                     	end
