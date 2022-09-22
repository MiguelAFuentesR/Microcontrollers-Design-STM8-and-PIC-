 /*Header file for Arduino like Serial commands on STM8S
 * Website: https://circuitdigest.com/search/node/STM8S
 * Code by: Aswinth Raj
 * Github: https://github.com/CircuitDigest/STM8S103F3_SPL
 */
 
 /*Control on-board LED through USART
 * PD5 - UART2-Tx
 * PD6 - UART2-Rx
 */
 
 #include "stm8s.h"
 #include "stdio.h"

//Funtion Declarations 
 void Serial_begin(uint32_t); //pass baug rate and start serial communiaction 
 void Serial_print_int (int); //pass integer value to print it on screen
 void Serial_print_char (char); //pass char value to print it on screen 
 void Serial_print_string (char[]); //pass string value to print it 
 void Serial_newline(void); //move to next line
 bool Serial_available(void); //check if input serial data available return 1 is yes 
 char Serial_read_char(void); //read the incoming char byte and return it 
 

 char Serial_read_char(void)
 {
	 while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET);
	 UART2_ClearFlag(UART2_FLAG_RXNE);
	 return (UART2_ReceiveData8());
 }

 void Serial_print_char (char value)
 {
	 UART2_SendData8(value);
	 while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET); //wait for sending
 }
 
  void Serial_begin(uint32_t baud_rate)
 {
	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	 
	 UART2_DeInit(); //Deinitialize UART peripherals 
			
                
		UART2_Init(baud_rate, 
                UART2_WORDLENGTH_8D, 
                UART2_STOPBITS_1, 
                UART2_PARITY_NO, 
                UART2_SYNCMODE_CLOCK_DISABLE, 
                UART2_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
                
		UART2_Cmd(ENABLE);
 }
 
 void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 {
	 char count = 0;
	 char digit[5] = "";
	 
	 while (number != 0) //split the int to char array 
	 {
		 digit[count] = number%10;
		 count++;
		 number = number/10;
	 }
	 
	 while (count !=0) //print char array in correct direction 
	 {
		UART2_SendData8(digit[count-1] + 0x30);
		while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET); //wait for sending 
		count--; 
	 }
 }
 
 void Serial_newline(void)
 {
	 UART2_SendData8(0x0a);
	while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET); //wait for sending 
 }
 
 void Serial_print_string (char string[])
 {

	 char i=0;

	 while (string[i] != 0x00)
	 {
		UART2_SendData8(string[i]);
		while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET);
		i++;
	}
 }
 
 bool Serial_available()
 {
	 if(UART2_GetFlagStatus(UART2_FLAG_RXNE) == TRUE)
	 return TRUE;
	 else
	 return FALSE;
 }
 
 
 