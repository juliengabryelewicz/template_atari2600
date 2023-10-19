
	processor 6502
	include "vcs.h"
	org $F000
	
;=================
; Constantes
;=================

BackgroundColor = $00
GeneralColor = $0E

;==================
; Variables
;==================

	seg.u Variables
	ORG  $80

;==================
; Code
;==================

	seg Code
	ORG  $f000
	

;==================
; Initialisation
;==================	
Start:
	SEI
	CLD
        LDX #$ff 
        TXS 
        LDA #0
        LDX #$ff
        	
ClearZeroPage:
	STA $0,X
	DEX
        BNE ClearZeroPage
        
InitializeValues:
	LDA #BackgroundColor
	STA COLUBK
	LDA #GeneralColor
	STA COLUPF
	STA COLUP0
	STA COLUP1
	
;==================
; Boucle principale
;==================

Main:
        JSR VerticalSync
        JSR CheckJoystick
        JSR CheckCollision
        JSR CheckScore
        JSR CheckAI
        JSR VerticalBlank
        JSR Drawing
        JSR OverScan
        JMP Main
        
;==================
; Vertical Sync
;==================   
     
VerticalSync:
	LDA #2
	STA VSYNC
	STA WSYNC
	STA WSYNC
	STA WSYNC
	LDA #43
	STA TIM64T
	LDA #0
	STA VSYNC
        
;==================
; Joystick
;==================   
        
CheckJoystick:
	LDA #0
Player0Up:
	LDA %00010000
	BIT SWCHA
Player0Down:
	LDA %00100000
	BIT SWCHA
NoInput:
	RTS
	
;==================
; Check Collision
;================== 

CheckCollision:
	RTS
;==================
; Check Score
;==================
        
CheckScore:
	RTS	
	
;================
; AI
;================	
CheckAI:
	RTS

;================
; Vertical Blank
;================
VerticalBlank:
	LDA INTIM
	BNE VerticalBlank
	STA WSYNC
	STA VBLANK
	LDY #8
	RTS
	
;================
; Drawing
;================
Drawing:
	STA WSYNC
	STA PF0
	STA PF1
	STA PF2
	STA WSYNC
	LDA %00000010
	STA CTRLPF
	LDX #8
ScoreLoop:
	STA WSYNC
	DEX
	BEQ EndScore
	JMP ScoreLoop
EndScore:
	LDA #0
	STA WSYNC
	STA PF1
	STA PF0
	STA PF2
	STA WSYNC
	STA VBLANK
	LDA %00000001
	STA CTRLPF
	LDY #192
ScanLoop:
	STA WSYNC
ProcessingLine:
	TYA
	SEC
DrawLine:
	DEY
	STA WSYNC
	LDA Playfield0,Y
	STA PF0
	LDA Playfield1,Y
	STA PF1
	STA PF2
	DEY
	CPY #0
	BNE ScanLoop
	LDY #29
	RTS
        
;==================
; OverScan
;==================

OverScan:
        STA WSYNC
        LDA #2
        STA VBLANK
        LDA #32
        STA TIM64T
OverScanWait:
        STA WSYNC
        LDA INTIM
        BNE OverScanWait
        RTS
        
;=================
; Subroutines
;=================
	

;=================
; Graphismes
;=================


Playfield0:
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %00110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
	.byte %11110000
Playfield1:
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111

;=================
; End
;=================
	org $FFFC
	.word Start
	.word Start
