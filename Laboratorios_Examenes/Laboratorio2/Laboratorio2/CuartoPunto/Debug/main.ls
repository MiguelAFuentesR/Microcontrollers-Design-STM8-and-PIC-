   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
2552                     ; 15 main()
2552                     ; 16 {
2554                     	switch	.text
2555  0000               _main:
2559                     ; 17 	configurarReloj();
2561  0000 ad04          	call	_configurarReloj
2563                     ; 18 	activarSalidaReloj();
2565  0002 ad2f          	call	_activarSalidaReloj
2567  0004               L1461:
2569  0004 20fe          	jra	L1461
2606                     ; 28 void configurarReloj(){
2607                     	switch	.text
2608  0006               _configurarReloj:
2610  0006 89            	pushw	x
2611       00000002      OFST:	set	2
2614                     ; 30 	int a = 0; 
2616                     ; 35 	CLK_SWCR |= 0x02; 
2618  0007 721250c5      	bset	_CLK_SWCR,#1
2619                     ; 40 	CLK_SWR = 0xE1;
2621  000b 35e150c4      	mov	_CLK_SWR,#225
2622                     ; 44 	CLK_CKDIVR |= 0x00;
2624  000f c650c6        	ld	a,_CLK_CKDIVR
2625                     ; 50 	a = CLK_SWCR & 0x01;
2627  0012 c650c5        	ld	a,_CLK_SWCR
2628  0015 a401          	and	a,#1
2629  0017 5f            	clrw	x
2630  0018 97            	ld	xl,a
2631  0019 1f01          	ldw	(OFST-1,sp),x
2634  001b 2009          	jra	L7661
2635  001d               L3661:
2636                     ; 53 		a = CLK_SWCR & 0x01;
2638  001d c650c5        	ld	a,_CLK_SWCR
2639  0020 a401          	and	a,#1
2640  0022 5f            	clrw	x
2641  0023 97            	ld	xl,a
2642  0024 1f01          	ldw	(OFST-1,sp),x
2644  0026               L7661:
2645                     ; 52 	while(a == 1){
2647  0026 1e01          	ldw	x,(OFST-1,sp)
2648  0028 a30001        	cpw	x,#1
2649  002b 27f0          	jreq	L3661
2650                     ; 60 	CLK_SWCR &= ~0x02;
2652  002d 721350c5      	bres	_CLK_SWCR,#1
2653                     ; 62 }
2656  0031 85            	popw	x
2657  0032 81            	ret
2683                     ; 63 void activarSalidaReloj(){
2684                     	switch	.text
2685  0033               _activarSalidaReloj:
2689                     ; 66 	PD_DDR |= 0x01;
2691  0033 72105011      	bset	_PD_DDR,#0
2692                     ; 67 	PD_CR1 |= 0x01;
2694  0037 72105012      	bset	_PD_CR1,#0
2695                     ; 76 	CLK_CCOR |= 0x0A;   
2697  003b c650c9        	ld	a,_CLK_CCOR
2698  003e aa0a          	or	a,#10
2699  0040 c750c9        	ld	_CLK_CCOR,a
2700                     ; 77 	CLK_CCOR &= ~0x14;	
2702  0043 c650c9        	ld	a,_CLK_CCOR
2703  0046 a4eb          	and	a,#235
2704  0048 c750c9        	ld	_CLK_CCOR,a
2705                     ; 81 	CLK_CCOR |= 0x01; 
2707  004b 721050c9      	bset	_CLK_CCOR,#0
2708                     ; 82 }
2711  004f 81            	ret
2724                     	xdef	_main
2725                     	xdef	_activarSalidaReloj
2726                     	xdef	_configurarReloj
2745                     	end
