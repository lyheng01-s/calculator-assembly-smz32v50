
 
  DB FB ; 0 R  
  DB 0B ; 1 R
  DB B7 ; 2 R
  DB 9F ; 3 R
  DB 4F ; 4 R
  DB DD ; 5 R
  DB FD ; 6 R
  DB 8B ; 7 R
  DB FF ; 8 R
  DB DF ; 9 R



ORIGINAL:
  ;MOV AL, 00
  MOV BL, 02
  ;MOV CL, [0C]
  MOV CL, 30
  MOV DL, 00
  IN 00
  PUSH AL
  IN 00 
  PUSH AL
  POP DL
  POP DL
  SUB DL, CL
  JZ DISPLAY1_LEFT

LOOP1_LEFT:
  INC BL  
  DEC DL
  ;JZ DISPLAY1_LEFT
  JNZ LOOP1_LEFT

DISPLAY1_LEFT:
  MOV AL, [BL]
  DEC AL
  OUT 02
  MOV DL, [BE]
  MOV BL, 02
  SUB DL, CL
  JZ DISPLAY2_RIGHT
  ;JNZ LOOP2_RIGHT  

LOOP2_RIGHT:
  INC BL
  DEC DL
  ;JZ DISPLAY2_RIGHT
  JNZ LOOP2_RIGHT
  
DISPLAY2_RIGHT:
  MOV AL, [BL]
  OUT 02

  IN 00 
  CMP AL, 3D
  JZ EQUAL
  CMP AL, 2D  ;SUB
  MOV [FF], AL
  JZ STORE_THE_FIRST_INPUT_VALUE
  ;CMP AL, 2B  ;ADD
  ;MOV [FF], AL
  JNZ STORE_THE_FIRST_INPUT_VALUE
;=======================================================================
  

;=======================================================================
;This is the part after addition 
STORE_THE_FIRST_INPUT_VALUE:
  MOV DL, [BF]
  MOV [BD], DL
  MOV DL, [BE]
  MOV [BC], DL
  JMP ORIGINAL

EQUAL:
  MOV DL, [FF] 
  CMP DL, 2D
  JZ SUBSTRACT
  ;JNZ ADDITION  

ADDITION:
  MOV DL, 02
  MOV AL, [BE]
  MOV BL, [BC]
  ADD AL, BL
  SUB AL, 60
  
  MOV BL, [BF]
  MOV CL, [BD]
  ADD BL, CL
  SUB BL, 60

VALUE_CL:
  MOV CL, 00

LOOP_AL:
  INC CL
  DEC AL
  JS DIS_RES_LEFT
  CMP CL, 0A
  ;JZ INCREASE
  JNZ LOOP_AL

INCREASE:
  INC BL
  JMP VALUE_CL  

DIS_RES_LEFT:
  ADD CL, 01
  MOV AL, [CL]
  OUT 02

LOOP_BL:
  INC DL
  DEC BL
  JS End
  ;JZ DIS_RES_RIGHT
  JNZ LOOP_BL
 
DIS_RES_RIGHT:
  MOV AL, [DL]
  DEC AL
  OUT 02
End:
;===================================================
;This is the substraction part
ORG C0
SUBSTRACT:
  MOV DL, 02
  MOV BL, [BD]    ;THE FIRST INPUT
  MOV CL, [BF]
  SUB BL, CL
  
    
  MOV AL, [BC]    ;THE SECOND INPUT
  MOV CL, [BE]
  SUB AL, CL
  JZ DISPLAY_RIGHT_FINAL
  JNS LOOP_TO_FIND_THE_POSITION
  ;MOV DL, [0E]
  

DECREASE:
  DEC BL
  ADD AL, 0A  

LOOP_TO_FIND_THE_POSITION:
  INC DL
  DEC AL
  JS DISPLAY_RIGHT_FINAL
  JNZ LOOP_TO_FIND_THE_POSITION

DISPLAY_RIGHT_FINAL:
  MOV AL, [DL]
  OUT 02
  MOV DL, 02
 

LOOP_AGAIN:
  INC DL
  DEC BL
  JS DISPLAYZERO
  JNZ LOOP_AGAIN
  ;MOV DL, [0E]
  

;DISPLAY_LEFT_FINAL:
  MOV AL, [DL]
  DEC AL
  OUT 02

ORG B5
DISPLAYZERO:
  MOV AL, [02]
  DEC AL
  OUT 02
END
