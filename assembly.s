;@============================================================================
;@
;@ Student Name 1: Amirali Farzaneh
;@ Student 1 #: 301292829
;@ Student 1 userid (email): afarzane (afarzane@sfu.ca)
;@
;@ Below, edit to list any people who helped you with the code in this file,
;@      or put ‘none’ if nobody helped (the two of) you.
;@
;@ Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__
;@
;@ Also, reference resources beyond the course textbooks and the course pages on Canvas
;@ that you used in making your submission.
;@
;@ Resources:  ___________
;@
;@% Instructions:
;@ * Put your name(s), student number(s), userid(s) in the above section.
;@ * Edit the "Helpers" line and "Resources" line.
;@ * Your group name should be "<userid1>_<userid2>" (eg. stu1_stu2)
;@ * Form groups as described at:  https://courses.cs.sfu.ca/docs/students
;@ * Submit your file to courses.cs.sfu.ca
;@
;@ Name        : assembly.s
;@ Description : bigAdd subroutine for Assignment.
;@ Copyright (C) 2021 Craig Scratchley    wcs (at) sfu (dot) ca  
;@============================================================================

;@ Tabs set for 8 characters in Edit > Configuration

#include "asm_include.h"
#include "73x_tim_l.h"
#include "73x_eic_l.h"

	IMPORT	printf
		
	PRESERVE8

	GLOBAL	FIQ_Init
	GLOBAL	FIQ_Handler
	GLOBAL	InitHwAssembly
	GLOBAL	LoopFnc
	AREA	||.text||, CODE, READONLY


	;@ *** modify the below lines for this assignment  ***
	;@ *** make pins of I/O port 0 strobe back and forth between
	;@     all the Bits in the range Bit 0 to Bit 15 ***
	;@  Turn on GPIO0 pin 0     
LoopFnc	LDR 	R12, =GPIO0_BASE
	
	;@ Initiate loop here
	LDRH	R1, [R12, #GPIO_PD_OFS]
	ORR 	R1, R1, #GPIO_PIN_0
	STRH 	R1, [R12, #GPIO_PD_OFS]
	ORR 	R1, R1, #GPIO_PIN_1
	STRH 	R1, [R12, #GPIO_PD_OFS]
	ORR 	R1, R1, #GPIO_PIN_2
	STRH 	R1, [R12, #GPIO_PD_OFS]
	
	MOV	R6, #13	;@ Counter
LeftShift
	;@ Shift left
	LDRH	R1, [R12, #GPIO_PD_OFS]
	MOV 	R1, R1, lsl #1
	STRH 	R1, [R12, #GPIO_PD_OFS]
	MOV	R7, #0x10000
	;@ put in a delay here
Delay	SUBS	R7, #1
	BNE	Delay
	
	SUBS	R6, R6, #1
	CMP	R6, #0;
	BNE	LeftShift

	MOV	R6, #13	;@ Counter
RightShift
	;@ Shift right
	LDRH	R1, [R12, #GPIO_PD_OFS]
	MOV 	R1, R1, lsr #1
	STRH 	R1, [R12, #GPIO_PD_OFS]
	MOV	R7, #0x10000
	
Delay2	SUBS	R7, #1
	BNE	Delay2

	SUBS	R6, R6, #1
	CMP	R6, #0;
	BNE	RightShift
	
	;@ Clear loop LED here
	LDRH	R1, [R12, #GPIO_PD_OFS]
	MOV 	R1, #0
	STRH 	R1, [R12, #GPIO_PD_OFS]
	
	MOV	PC, LR
	;@ ^^^ modify the above lines ^^^

InitHwAssembly
	;@  Setup GPIO6 - UART0 Tx pin setup (P6.9)     
	LDR 	R12, =GPIO6_BASE
	
	;@ GPIO_Mode_AF_PP
	LDRH	R1, [R12, #GPIO_PC0_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC0_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC1_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC2_OFS]
	ORR 	R1, R1, #GPIO_PIN_9
	STRH 	R1, [R12, #GPIO_PC2_OFS]

	;@ *** modify the below lines for this assignment  ***
	;@  Setup GPIO0 pin 0     
	LDR 	R12, =GPIO0_BASE
	
	;@ GPIO_Mode_OUT_PP
	
	LDRH	R1, [R12, #GPIO_PC0_OFS]
	ORR 	R1, R1, #GPIO_PIN_0
	ORR 	R1, R1, #GPIO_PIN_1
	ORR 	R1, R1, #GPIO_PIN_2
	ORR 	R1, R1, #GPIO_PIN_3
	ORR 	R1, R1, #GPIO_PIN_4
	ORR 	R1, R1, #GPIO_PIN_5
	ORR 	R1, R1, #GPIO_PIN_6
	ORR 	R1, R1, #GPIO_PIN_7
	ORR 	R1, R1, #GPIO_PIN_8
	ORR 	R1, R1, #GPIO_PIN_9
	ORR 	R1, R1, #GPIO_PIN_10
	ORR 	R1, R1, #GPIO_PIN_11
	ORR 	R1, R1, #GPIO_PIN_12
	ORR 	R1, R1, #GPIO_PIN_13
	ORR 	R1, R1, #GPIO_PIN_14
	ORR 	R1, R1, #GPIO_PIN_15
	STRH 	R1, [R12, #GPIO_PC0_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC1_OFS]
	ORR	R1, #0	;@ Clear bit
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC2_OFS]
	ORR 	R1, R1, #GPIO_PIN_0
	ORR 	R1, R1, #GPIO_PIN_1
	ORR 	R1, R1, #GPIO_PIN_2
	ORR 	R1, R1, #GPIO_PIN_3
	ORR 	R1, R1, #GPIO_PIN_4
	ORR 	R1, R1, #GPIO_PIN_5
	ORR 	R1, R1, #GPIO_PIN_6
	ORR 	R1, R1, #GPIO_PIN_7
	ORR 	R1, R1, #GPIO_PIN_8
	ORR 	R1, R1, #GPIO_PIN_9
	ORR 	R1, R1, #GPIO_PIN_10
	ORR 	R1, R1, #GPIO_PIN_11
	ORR 	R1, R1, #GPIO_PIN_12
	ORR 	R1, R1, #GPIO_PIN_13
	ORR 	R1, R1, #GPIO_PIN_14
	ORR 	R1, R1, #GPIO_PIN_15
	STRH 	R1, [R12, #GPIO_PC2_OFS]
	
	;@ Initialize Pin 8 on GPIO1
	LDR 	R12, =GPIO1_BASE
	LDRH	R1, [R12, #GPIO_PC0_OFS]
	ORR 	R1, R1, #GPIO_PIN_8
	STRH 	R1, [R12, #GPIO_PC0_OFS]
	
	LDRH 	R1, [R12, #GPIO_PC1_OFS]
	ORR	R1, #0	;@ Clear bits
	STRH 	R1, [R12, #GPIO_PC1_OFS]
	STRH 	R1, [R12, #GPIO_PC2_OFS]
	
	;@ Initiate Timer0 and EIC
	;@ Timer0
	LDR 	R12, =TIM0_BASE
	LDRH	R1, [R12, #TIMn_CR1]
	MOV	R1, #0x8000
	ADD	R1, R1, #0x0250
	STRH	R1, [R12, #TIMn_CR1]

	LDRH	R1, [R12, #TIMn_CR2]
	MOV	R1, #0x0800
	ADD	R1, R1, #0x0010
	STRH	R1, [R12, #TIMn_CR2]

	;@ Increase squarewave time - For faster calculation of Fib number
	LDRH	R1, [R12, #TIMn_OCAR]
	MOV	R1, #0xF000	
	STRH	R1, [R12, #TIMn_OCAR]

	LDRH	R1, [R12, #TIMn_OCBR]
	MOV	R1, #0xF000
	STRH	R1, [R12, #TIMn_OCBR]
	
	;@ EIC
	LDR	R12, =EIC_BASE
	LDRH	R1, [R12, #EIC_ICR]
	MOV	R1, #0x0003
	STRH	R1, [R12, #EIC_ICR]

	LDRH	R1, [R12, #EIC_FIER]
	MOV	R1, #0x0003
	STRH	R1, [R12, #EIC_FIER]
	
	;@ Initialize rising edge for External Interrupt
	LDR	R12, =CFG_BASE
	LDRH	R1, [R12, #CFG_EITE0]
	MOV	R1, #1
	STRH	R1, [R12, #CFG_EITE0]
	
	LDRH	R1, [R12, #CFG_EITE1]
	MOV	R1, #0
	STRH	R1, [R12, #CFG_EITE1]
	
	LDRH	R1, [R12, #CFG_EITE2]
	MOV	R1, #1
	STRH	R1, [R12, #CFG_EITE2]
	
	
	;@ ^^^ modify the above lines ^^^
	
	MOV	PC, LR

	
	// Below needed for HW7 and HW8
	// void* FIQ_Init (void* IRQ_Top);
	// make sure that FIQ_Init returns IRQ_Top in R0
	// FIQ_Init() will initialize R8 through R12 as desired,
	//     so is a non-conforming subroutine in this regard.
FIQ_Init
	// You can put your FIQ_Init here.
	MOV	PC, LR
	
FIQ_Handler
	// You can put your FIQ_Handler here.
	// At that point, you can remove some code from LoopFnc above at top.
	STMFD   SP!, {LR}
	
	;@ Stop timer during LED loop
	LDR 	R12, =TIM0_BASE
	LDRH	R1, [R12, #TIMn_CR1]
	MOV	R1, #0x0250
	STRH	R1, [R12, #TIMn_CR1]
	
	;@ Check to see which interrupt is active (Give priority to FIQ)
	LDR	R12, =EIC_BASE
	LDRH	R1, [R12, #EIC_FIR]
	CMP	R1, #0x0000001B
	BLEQ	ServiceExtInt
	
	CMP	R1, #0x0000000B
	BLEQ	ServiceExtInt
	
	CMP	R1, #0x00000013
	BLEQ	ServiceSWI
	
	
ServiceExtInt
	SUBS	R2, R1, #0x0000000B
	
	;@ Clear pending bit
	LDRH	R1, [R12, #EIC_FIPR]
	MOV	R1, #1
	STRH	R1, [R12, #EIC_FIPR]
	
	;@ Increase prescaler by 0x10
	BL	SlowPrescaler
	
	;@ Compare to see if both interrupts were on
	CMP	R2, #0
	BNE	ServiceSWI
	
	;@ Activate LED
	BL LoopFnc
	
	BL ResetTimer
	
	;@ Return
	LDMFD   SP!, {PC}
	
	
ServiceSWI
	;@ Reset/Clear Bits
	;@ Clear OCFB
	LDR 	R12, =TIM0_BASE
	LDRH	R1, [R12, #TIMn_SR]
	MOV	R1, #0x2000
	STRH	R1, [R12, #TIMn_SR]

	;@ Clear pending bit
	LDR	R12, =EIC_BASE
	LDRH	R1, [R12, #EIC_FIPR]
	MOV	R1, #2
	STRH	R1, [R12, #EIC_FIPR]
	
	;@ Check again for interrupt
	LDR	R12, =EIC_BASE
	LDRH	R1, [R12, #EIC_FIR]
	CMP	R1, #0x0000000B
	BEQ	ServiceExtInt
	
	;@ Activate LED
	BL LoopFnc
	
	BL	ResetTimer
	
	;@ Return
	LDMFD   SP!, {PC}
	

SlowPrescaler
	MOV	R10, LR
	LDR 	R12, =TIM0_BASE
	LDRH	R11, [R12, #TIMn_CR2]
	ADD	R11, R11, #0x0010
	CMP	R11, #0x0900
	BLEQ	ResetPrescaler
	STRH	R11, [R12, #TIMn_CR2]
	
	MOV	PC, R10

ResetPrescaler
	MOV	R11, #0x0810
	MOV	PC, LR

ResetTimer
	;@ Reset timer
	LDR 	R12, =TIM0_BASE
	LDRH	R1, [R12, #TIMn_CR1]
	MOV	R1, #0x8000
	ADD	R1, R1, #0x0250
	STRH	R1, [R12, #TIMn_CR1]
	
	MOV	PC, LR

C_str   DCB  "C_string\n",0
	ALIGN	4

	END
