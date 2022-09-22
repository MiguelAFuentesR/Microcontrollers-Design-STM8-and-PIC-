/*	IO DEFINITIONS FOR STM8L001 J3 family
 *	Copyright (c) 2017 by COSMIC Software
 */

/*	PORTS section
 */
/*	Port A
 */
volatile char PA_ODR        @0x5000;	/* Data Output Latch reg */
volatile char PA_IDR        @0x5001;	/* Input Pin Value reg */
volatile char PA_DDR        @0x5002;	/* Data Direction */
volatile char PA_CR1        @0x5003;	/* Control register 1 */
volatile char PA_CR2        @0x5004;	/* Control register 2 */

/*	Port B
 */
volatile char PB_ODR        @0x5005;	/* Data Output Latch reg */
volatile char PB_IDR        @0x5006;	/* Input Pin Value reg */
volatile char PB_DDR        @0x5007;	/* Data Direction */
volatile char PB_CR1        @0x5008;	/* Control register 1 */
volatile char PB_CR2        @0x5009;	/* Control register 2 */

/*	Port C
 */
volatile char PC_ODR        @0x500a;	/* Data Output Latch reg */
volatile char PC_IDR        @0x500b;	/* Input Pin Value reg */
volatile char PC_DDR        @0x500c;	/* Data Direction */
volatile char PC_CR1        @0x500d;	/* Control register 1 */
volatile char PC_CR2        @0x500e;	/* Control register 2 */

/*	Port D
 */
volatile char PD_ODR        @0x500f;	/* Data Output Latch reg */
volatile char PD_IDR        @0x5010;	/* Input Pin Value reg */
volatile char PD_DDR        @0x5011;	/* Data Direction */
volatile char PD_CR1        @0x5012;	/* Control register 1 */
volatile char PD_CR2        @0x5013;	/* Control register 2 */

/*	FLASH section
 */
volatile char FLASH_CR1     @0x5050;	/* Flash Control Register 1 */
volatile char FLASH_CR2     @0x5051;	/* Flash Control Register 2 */
volatile char FLASH_PUKR    @0x5052;	/* Flash Program memory unprotection reg */
volatile char FLASH_DUKR    @0x5053;	/* Data EEPROM unprotection reg */
volatile char FLASH_IAPSR   @0x5054;	/* Flash in-appl Prog. Status reg */

/*	External Interrupt Controller section
 */
volatile char EXTI_CR1      @0x50a0;	/* Ext Int Ctrl reg 1 */
volatile char EXTI_CR2      @0x50a1;	/* Ext Int Ctrl reg 2 */
volatile char EXTI_CR3      @0x50a2;	/* Ext Int Ctrl reg 3 */
volatile char EXTI_SR1      @0x50a3;	/* Ext Int Status reg 1 */
volatile char EXTI_SR2      @0x50a4;	/* Ext Int Status reg 2 */
volatile char EXTI_CONF     @0x50a5;	/* Ext Int Port Select reg 2 */

/*	WFE section
 */
volatile char WFE_CR1       @0x50a6;	/* Control reg 1 */
volatile char WFE_CR2       @0x50a7;	/* Control reg 2 */

/*	RSTC section
 */
volatile char RST_CR        @0x50b0;	/* Reset Control register */
volatile char RST_SR        @0x50b1;	/* Reset Status register */

/*	CLOCK section
 */
volatile char CLK_CKDIVR    @0x50c0;	/* Master Divider register */
volatile char CLK_PCKENR1   @0x50c3;	/* Peripheral Clock Gating reg 1 */
volatile char CLK_CCOR      @0x50c5;	/* Configurable Clock Ctrl reg */

/*	WATCHDOG section
 */
volatile char IWDG_KR       @0x50e0;	/* IWDG Key register */
volatile char IWDG_PR       @0x50e1;	/* IWDG Prescaler register */
volatile char IWDG_RLR      @0x50e2;	/* IWDG Reload register */

/*	AWU section
 */
volatile char AWU_CSR       @0x50f0;	/* AWU Control/Status reg 1 */
volatile char AWU_APR       @0x50f1;	/* AWU Async Prescale Buffer reg */
volatile char AWU_TBR       @0x50f2;	/* AWU Timebase selection reg */
volatile char BEEP_CSR      @0x50f3;	/* BEEP control/status reg */

/*	SPI1 section
 */
volatile char SPI_CR1       @0x5200;	/* SPI Control register 1 */
volatile char SPI_CR2       @0x5201;	/* SPI Control register 2 */
volatile char SPI_ICR       @0x5202;	/* SPI Interrupt/Ctrl reg */
volatile char SPI_SR        @0x5203;	/* SPI Status register */
volatile char SPI_DR        @0x5204;	/* SPI Data I/O reg */

/*	I2C1 section
 */
volatile char I2C1_CR1      @0x5210;	/* Control register 1 */
volatile char I2C1_CR2      @0x5211;	/* Control register 2 */
volatile char I2C1_FREQR    @0x5212;	/* Frequency register */
volatile char I2C1_OARL     @0x5213;	/* Own Address reg low */
volatile char I2C1_OARH     @0x5214;	/* Own Address reg high */
volatile char I2C1_DR       @0x5216;	/* Data Register */
volatile char I2C1_SR1      @0x5217;	/* Status Register 1 */
volatile char I2C1_SR2      @0x5218;	/* Status Register 2 */
volatile char I2C1_SR3      @0x5219;	/* Status Register 3 */
volatile char I2C1_ITR      @0x521a;	/* Interrupt Control reg */
volatile char I2C1_CCRL     @0x521b;	/* Clock Control reg low */
volatile char I2C1_CCRH     @0x521c;	/* Clock Control reg high */
volatile char I2C1_TRISER   @0x521d;	/* Trise reg */

/*	USART section
 */
volatile char USART_SR      @0x5230;	/* Status register */
volatile char USART_DR      @0x5231;	/* Data register */
volatile char USART_BRR1    @0x5232;	/* Baud Rate reg 1 */
volatile char USART_BRR2    @0x5233;	/* Baud Rate reg 2 */
volatile char USART_CR1     @0x5234;	/* Control register 1 */
volatile char USART_CR2     @0x5235;	/* Control register 2 */
volatile char USART_CR3     @0x5236;	/* Control register 3 */
volatile char USART_CR4     @0x5237;	/* Control register 4 */

/*	TIMER 2 section
 */
volatile char TIM2_CR1      @0x5250;	/* Control register 1 */
volatile char TIM2_CR2      @0x5251;	/* Control register 2 */
volatile char TIM2_SMCR     @0x5252;	/* Slave Mode Control reg */
volatile char TIM2_ETR      @0x5253;	/* External Trigger reg */
volatile char TIM2_IER      @0x5254;	/* Interrupt Enable reg */
volatile char TIM2_SR1      @0x5255;	/* Status register 1 */
volatile char TIM2_SR2      @0x5256;	/* Status register 2 */
volatile char TIM2_EGR      @0x5257;	/* Event Generation reg */
volatile char TIM2_CCMR1    @0x5258;	/* Capture/Compare Mode reg 1 */
volatile char TIM2_CCMR2    @0x5259;	/* Capture/Compare Mode reg 2 */
volatile char TIM2_CCER1    @0x525a;	/* Capture/Compare Enable reg 1 */
volatile char TIM2_CNTRH    @0x525b;	/* Counter reg High */
volatile char TIM2_CNTRL    @0x525c;	/* Counter reg Low */
volatile char TIM2_PSCR     @0x525d;	/* Prescaler reg High */
volatile char TIM2_ARRH     @0x525e;	/* Auto-reload reg High */
volatile char TIM2_ARRL     @0x525f;	/* Auto-reload reg Low */
volatile char TIM2_CCR1H    @0x5260;	/* Capture/Compare reg 1 High */
volatile char TIM2_CCR1L    @0x5261;	/* Capture/Compare reg 1 Low */
volatile char TIM2_CCR2H    @0x5262;	/* Capture/Compare reg 2 High */
volatile char TIM2_CCR2L    @0x5263;	/* Capture/Compare reg 2 Low */
volatile char TIM2_BKR      @0x5264;	/* Break register */
volatile char TIM2_OISR     @0x5265;	/* Output Idle State reg */

/*	TIMER 3 section
 */
volatile char TIM3_CR1      @0x5280;	/* Control register 1 */
volatile char TIM3_CR2      @0x5281;	/* Control register 2 */
volatile char TIM3_SMCR     @0x5282;	/* Slave Mode Control reg */
volatile char TIM3_ETR      @0x5283;	/* External Trigger reg */
volatile char TIM3_IER      @0x5284;	/* Interrupt Enable reg */
volatile char TIM3_SR1      @0x5285;	/* Status register 1 */
volatile char TIM3_SR2      @0x5286;	/* Status register 2 */
volatile char TIM3_EGR      @0x5287;	/* Event Generation reg */
volatile char TIM3_CCMR1    @0x5288;	/* Capture/Compare Mode reg 1 */
volatile char TIM3_CCMR2    @0x5289;	/* Capture/Compare Mode reg 2 */
volatile char TIM3_CCER1    @0x528a;	/* Capture/Compare Enable reg 1 */
volatile char TIM3_CNTRH    @0x528b;	/* Counter reg High */
volatile char TIM3_CNTRL    @0x528c;	/* Counter reg Low */
volatile char TIM3_PSCR     @0x528d;	/* Prescaler reg High */
volatile char TIM3_ARRH     @0x528e;	/* Auto-reload reg High */
volatile char TIM3_ARRL     @0x528f;	/* Auto-reload reg Low */
volatile char TIM3_CCR1H    @0x5290;	/* Capture/Compare reg 1 High */
volatile char TIM3_CCR1L    @0x5291;	/* Capture/Compare reg 1 Low */
volatile char TIM3_CCR2H    @0x5292;	/* Capture/Compare reg 2 High */
volatile char TIM3_CCR2L    @0x5293;	/* Capture/Compare reg 2 Low */
volatile char TIM3_BKR      @0x5294;	/* Break register */
volatile char TIM3_OISR     @0x5295;	/* Output Idle State reg */

/*	TIMER 4 section
 */
volatile char TIM4_CR1      @0x52e0;	/* Control register 1 */
volatile char TIM4_CR2      @0x52e1;	/* Control register 2 */
volatile char TIM4_SMCR     @0x52e2;	/* Slave Mode Control reg */
volatile char TIM4_IER      @0x52e3;	/* Interrupt enable reg */
volatile char TIM4_SR1      @0x52e4;	/* Status register 1 */
volatile char TIM4_EGR      @0x52e5;	/* Event Generation reg */
volatile char TIM4_CNTR     @0x52e6;	/* Counter register */
volatile char TIM4_PSCR     @0x52e7;	/* Prescaler register */
volatile char TIM4_ARR      @0x52e8;	/* Auto-reload register */

/*	IRTIM section
 */
volatile char IR_CR         @0x52ff;	/* Infra-red control register */

/*	COMPARATOR section
 */
volatile char COMP_CR       @0x5300;	/* Comparator control register */
volatile char COMP_CSR      @0x5301;	/* Comparator status register */
volatile char COMP_CCS      @0x5302;	/* Comparator channel selection register */

/*	CFG section
 */
volatile char CFG_GCR       @0x7f60;	/* Global Configuration register */

/*	ITC section
 */
volatile char ITC_SPR1      @0x7f70;	/* Interrupt Software Priority Reg 1 */
volatile char ITC_SPR2      @0x7f71;	/* Interrupt Software Priority Reg 2 */
volatile char ITC_SPR3      @0x7f72;	/* Interrupt Software Priority Reg 3 */
volatile char ITC_SPR4      @0x7f73;	/* Interrupt Software Priority Reg 4 */
volatile char ITC_SPR5      @0x7f74;	/* Interrupt Software Priority Reg 5 */
volatile char ITC_SPR6      @0x7f75;	/* Interrupt Software Priority Reg 6 */
volatile char ITC_SPR7      @0x7f76;	/* Interrupt Software Priority Reg 7 */
volatile char ITC_SPR8      @0x7f77;	/* Interrupt Software Priority Reg 8 */

/*	SWIM section
 */
volatile char SWIM_CSR      @0x7f80;	/* SWIM Control Status Register */

/*	In-Circuit Debugging section
 */                                            
volatile char DM_BK1RE      @0x7f90;	/* IC Debugging Breakpoint 1 ESB Reg */
volatile char DM_BK1RH      @0x7f91;	/* IC Debugging Breakpoint 1 High */
volatile char DM_BK1RL      @0x7f92;	/* IC Debugging Breakpoint 1 Low */
volatile char DM_BK2RE      @0x7f93;	/* IC Debugging Breakpoint 2 ESB Reg */
volatile char DM_BK2RH      @0x7f94;	/* IC Debugging Breakpoint 2 High */
volatile char DM_BK2RL      @0x7f95;	/* IC Debugging Breakpoint 2 Low */
volatile char DM_CR1        @0x7f96;	/* IC Debugging Control register 1 */
volatile char DM_CR2        @0x7f97;	/* IC Debugging Control register 2 */
volatile char DM_CSR1       @0x7f98;	/* IC Debugging Control/Status reg 1 */
volatile char DM_CSR2       @0x7f99;	/* IC Debugging Control/Status reg 2 */
volatile char DM_ENFCTR     @0x7f9a;	/* IC Debugging Function Enable Reg 2 */
