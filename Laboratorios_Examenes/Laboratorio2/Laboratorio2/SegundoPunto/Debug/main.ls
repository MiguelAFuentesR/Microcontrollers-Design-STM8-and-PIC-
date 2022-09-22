   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
2523                     	bsct
2524  0000               _a:
2525  0000 0000          	dc.w	0
2556                     ; 16 main()
2556                     ; 17 {
2558                     	switch	.text
2559  0000               _main:
2563                     ; 18 	configurarReloj();
2565  0000 ad04          	call	_configurarReloj
2567                     ; 19 	activarSalidaReloj();
2569  0002 ad2e          	call	_activarSalidaReloj
2571  0004               L1461:
2573  0004 20fe          	jra	L1461
2600                     ; 30 void configurarReloj(){
2601                     	switch	.text
2602  0006               _configurarReloj:
2606                     ; 33 	CLK_SWCR |= 0x02;
2608  0006 721250c5      	bset	_CLK_SWCR,#1
2609                     ; 38 	CLK_SWR = 0xB4; //Selecionamos reloj externo 
2611  000a 35b450c4      	mov	_CLK_SWR,#180
2612                     ; 43 	CLK_CKDIVR = 0x00;
2614  000e 725f50c6      	clr	_CLK_CKDIVR
2615                     ; 50 	a = CLK_SWCR & 0x01;//Comparamos el bit cero
2617  0012 c650c5        	ld	a,_CLK_SWCR
2618  0015 a401          	and	a,#1
2619  0017 5f            	clrw	x
2620  0018 97            	ld	xl,a
2621  0019 bf00          	ldw	_a,x
2623  001b 2009          	jra	L1661
2624  001d               L5561:
2625                     ; 52 		a = CLK_SWCR & 0x01;
2627  001d c650c5        	ld	a,_CLK_SWCR
2628  0020 a401          	and	a,#1
2629  0022 5f            	clrw	x
2630  0023 97            	ld	xl,a
2631  0024 bf00          	ldw	_a,x
2632  0026               L1661:
2633                     ; 51 	while(a==1){ 
2635  0026 be00          	ldw	x,_a
2636  0028 a30001        	cpw	x,#1
2637  002b 27f0          	jreq	L5561
2638                     ; 58 	CLK_SWCR &=~0x02;  
2640  002d 721350c5      	bres	_CLK_SWCR,#1
2641                     ; 60 }
2644  0031 81            	ret
2671                     ; 61 void activarSalidaReloj() {
2672                     	switch	.text
2673  0032               _activarSalidaReloj:
2677                     ; 64 	PD_DDR |= 0x01;
2679  0032 72105011      	bset	_PD_DDR,#0
2680                     ; 65 	PD_CR1 |= 0x01;
2682  0036 72105012      	bset	_PD_CR1,#0
2683                     ; 69 	PD_CR2 |= 0x01;
2685  003a 72105013      	bset	_PD_CR2,#0
2686                     ; 73 	CLK_CCOR |= 0x10;   
2688  003e 721850c9      	bset	_CLK_CCOR,#4
2689                     ; 74 	CLK_CCOR &= ~0x0E;
2691  0042 c650c9        	ld	a,_CLK_CCOR
2692  0045 a4f1          	and	a,#241
2693  0047 c750c9        	ld	_CLK_CCOR,a
2694                     ; 78 	CLK_CCOR |= 0x01; 
2696  004a 721050c9      	bset	_CLK_CCOR,#0
2697                     ; 79 }
2700  004e 81            	ret
2724                     	xdef	_main
2725                     	xdef	_activarSalidaReloj
2726                     	xdef	_configurarReloj
2727                     	xdef	_a
2746                     	end
