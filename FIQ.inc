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

;#include "asm_include.h"
;#include "73x_tim_l.h"
;#include "73x_eic_l.h"
		
	LDR	PC, 	FIQ_Addr
	
FIQ_Addr	DCD	FIQHandler

;	SUB     LR, LR, #4              ; Update Link Register
;        STMFD   SP!, {R0-R7, LR}        ; Save Workspace & LR to Stack
;        MRS     R0, SPSR                ; Copy SPSR to R0
;        STMFD   SP!, {R0}               ; Save SPSR to Stack (8-byte)
;	
;        ;@ Stop timer during LED loop
;	LDR 	R12, =TIM0_BASE
;	LDRH	R1, [R12, #TIMn_CR1]
;	MOV	R1, #0x0250
;	STRH	R1, [R12, #TIMn_CR1]
;	
;	;@ Check to see which interrupt is active (Give priority to FIQ)
;	LDR	R12, =EIC_BASE
;	LDRH	R1, [R12, #EIC_FIR]
;	CMP	R1, #0x0000001B
;	BLEQ	ServiceExtInt
;	
;	CMP	R1, #0x0000000B
;	BLEQ	ServiceExtInt
;	
;	CMP	R1, #0x00000013
;	BLEQ	ServiceSWI
;	
;	
;ServiceExtInt
;	SUBS	R2, R1, #0x0000000B
;	
;	;@ Clear pending bit
;	LDRH	R1, [R12, #EIC_FIPR]
;	MOV	R1, #1
;	STRH	R1, [R12, #EIC_FIPR]
;	
;	;@ Increase prescaler by 0x10
;	BL	SlowPrescaler
;	
;	;@ Compare to see if both interrupts were on
;	CMP	R2, #0
;	BNE	ServiceSWI
;	
;	;@ Activate LED
;	BL LoopFnc
;	
;	BL ResetTimer
;	
;	;@ Return
;	B	Return
;	
;	
;ServiceSWI
;	;@ Reset/Clear Bits
;	;@ Clear OCFB
;	LDR 	R12, =TIM0_BASE
;	LDRH	R1, [R12, #TIMn_SR]
;	MOV	R1, #0x2000
;	STRH	R1, [R12, #TIMn_SR]

;	;@ Clear pending bit
;	LDR	R12, =EIC_BASE
;	LDRH	R1, [R12, #EIC_FIPR]
;	MOV	R1, #2
;	STRH	R1, [R12, #EIC_FIPR]
;	
;	;@ Check again for interrupt
;	LDR	R12, =EIC_BASE
;	LDRH	R1, [R12, #EIC_FIR]
;	CMP	R1, #0x0000000B
;	BEQ	ServiceExtInt
;	
;	;@ Activate LED
;	BL LoopFnc
;	
;	BL	ResetTimer
;	
;	B	Return
;	
;	
;SlowPrescaler
;	MOV	R10, LR
;	LDR 	R12, =TIM0_BASE
;	LDRH	R11, [R12, #TIMn_CR2]
;	ADD	R11, R11, #0x0010
;	CMP	R11, #0x0900
;	BLEQ	ResetPrescaler
;	STRH	R11, [R12, #TIMn_CR2]
;	
;	MOV	PC, R10


;ResetPrescaler
;	MOV	R11, #0x0810
;	MOV	PC, LR


;ResetTimer
;	;@ Reset timer
;	LDR 	R12, =TIM0_BASE
;	LDRH	R1, [R12, #TIMn_CR1]
;	MOV	R1, #0x8000
;	ADD	R1, R1, #0x0250
;	STRH	R1, [R12, #TIMn_CR1]
;	
;	MOV	PC, LR
;	
;	
;LoopFnc	LDR 	R12, =GPIO0_BASE
;	
;	;@ Initiate loop here
;	LDRH	R1, [R12, #GPIO_PD_OFS]
;	ORR 	R1, R1, #GPIO_PIN_0
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	ORR 	R1, R1, #GPIO_PIN_1
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	ORR 	R1, R1, #GPIO_PIN_2
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	
;	MOV	R6, #13	;@ Counter
;LeftShift
;	;@ Shift left
;	LDRH	R1, [R12, #GPIO_PD_OFS]
;	MOV 	R1, R1, lsl #1
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	MOV	R7, #0x10000
;	;@ put in a delay here
;Delay	SUBS	R7, #1
;	BNE	Delay
;	
;	SUBS	R6, R6, #1
;	CMP	R6, #0;
;	BNE	LeftShift

;	MOV	R6, #13	;@ Counter
;RightShift
;	;@ Shift right
;	LDRH	R1, [R12, #GPIO_PD_OFS]
;	MOV 	R1, R1, lsr #1
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	MOV	R7, #0x10000
;	
;Delay2	SUBS	R7, #1
;	BNE	Delay2

;	SUBS	R6, R6, #1
;	CMP	R6, #0;
;	BNE	RightShift
;	
;	;@ Clear loop LED here
;	LDRH	R1, [R12, #GPIO_PD_OFS]
;	MOV 	R1, #0
;	STRH 	R1, [R12, #GPIO_PD_OFS]
;	
;	MOV	PC, LR
;	;@ ^^^ modify the above lines ^^^
;	
;	
;Return
;        LDMFD   SP!, {R0}               ; Restore SPSR to R0
;        MSR     SPSR_cxsf, R0           ; Restore SPSR
;        LDMFD   SP!, {R0-R7, PC}^       ; Return to program after
	
	