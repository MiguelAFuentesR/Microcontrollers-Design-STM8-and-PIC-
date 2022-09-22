   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
2523                     	bsct
2524  0000               _CLK_ICKR:
2525  0000 0000          	dc.w	0
2556                     ; 16 main()
2556                     ; 17 {
2558                     	switch	.text
2559  0000               _main:
2563                     ; 18 	configurarReloj();
2565  0000 ad04          	call	_configurarReloj
2567                     ; 19 	activarSalidaReloj();
2569  0002 ad30          	call	_activarSalidaReloj
2571  0004               L1461:
2573  0004 20fe          	jra	L1461
2610                     ; 29 void configurarReloj(){
2611                     	switch	.text
2612  0006               _configurarReloj:
2614  0006 89            	pushw	x
2615       00000002      OFST:	set	2
2618                     ; 30 	int a = 0; 
2620                     ; 34 	CLK_SWCR |= 0x02;
2622  0007 721250c5      	bset	_CLK_SWCR,#1
2623                     ; 38 	CLK_SWR = 0xE1;
2625  000b 35e150c4      	mov	_CLK_SWR,#225
2626                     ; 43 	CLK_CKDIVR = 0x00; 
2628  000f 725f50c6      	clr	_CLK_CKDIVR
2629                     ; 47 	a = CLK_SWCR & 0x01;
2631  0013 c650c5        	ld	a,_CLK_SWCR
2632  0016 a401          	and	a,#1
2633  0018 5f            	clrw	x
2634  0019 97            	ld	xl,a
2635  001a 1f01          	ldw	(OFST-1,sp),x
2638  001c 2009          	jra	L7661
2639  001e               L3661:
2640                     ; 50 		a = CLK_SWCR & 0x01;
2642  001e c650c5        	ld	a,_CLK_SWCR
2643  0021 a401          	and	a,#1
2644  0023 5f            	clrw	x
2645  0024 97            	ld	xl,a
2646  0025 1f01          	ldw	(OFST-1,sp),x
2648  0027               L7661:
2649                     ; 49 	while(a == 1){
2651  0027 1e01          	ldw	x,(OFST-1,sp)
2652  0029 a30001        	cpw	x,#1
2653  002c 27f0          	jreq	L3661
2654                     ; 55 	CLK_SWCR &= ~0x02;
2656  002e 721350c5      	bres	_CLK_SWCR,#1
2657                     ; 57 }
2660  0032 85            	popw	x
2661  0033 81            	ret
2688                     ; 59 void activarSalidaReloj() {
2689                     	switch	.text
2690  0034               _activarSalidaReloj:
2694                     ; 62 	PD_DDR |= 0x01;
2696  0034 72105011      	bset	_PD_DDR,#0
2697                     ; 63 	PD_CR1 |= 0x01;
2699  0038 72105012      	bset	_PD_CR1,#0
2700                     ; 66 	PD_CR2 |= 0x01;
2702  003c 72105013      	bset	_PD_CR2,#0
2703                     ; 69 	CLK_CCOR |= 0x1A;   
2705  0040 c650c9        	ld	a,_CLK_CCOR
2706  0043 aa1a          	or	a,#26
2707  0045 c750c9        	ld	_CLK_CCOR,a
2708                     ; 70 	CLK_CCOR &= ~0x04;	
2710  0048 721550c9      	bres	_CLK_CCOR,#2
2711                     ; 73 	CLK_CCOR |= 0x01; 
2713  004c 721050c9      	bset	_CLK_CCOR,#0
2714                     ; 74 }
2717  0050 81            	ret
2741                     	xdef	_main
2742                     	xdef	_activarSalidaReloj
2743                     	xdef	_configurarReloj
2744                     	xdef	_CLK_ICKR
2763                     	end
