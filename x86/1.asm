DATA SEGMENT                                    ; save data
    MYNAME  DB 'NAME: Tao Yuanzheng$'           ; name = Tao Yuanzheng
    ID      DB 'ID: 1600012799$'                ; id = 1600012799
    BYE     DB 'Good Bye!$'                     ; say goodbye!
    STR0    DB 'alpha $bravo $charlie $delta $echo $foxtrot $golf $hotel $india $juliet $kilo $lima $mike $november $oscar $papa $quebec $romeo $sierra $tango $uniform $victor $whisky $x-ray $yankee $zulu $'         ; lower case
    STR1    DB 'Alpha $Bravo $Charlie $Delta $Echo $Foxtrot $Golf $Hotel $India $Juliet $Kilo $Lima $Mike $November $Oscar $Papa $Quebec $Romeo $Sierra $Tango $Uniform $Victor $Whisky $X-ray $Yankee $Zulu $'         ; capital data
    INDEX1  DW 0,7,14,23,30,36,45,51,58,65,73,79,85,91,101,108,114,122,129,137,144,153,161,169,176,184                              ; index of word
    STR2    DB 'zero $one $two $three $four $five $six $seven $eight $nine $'
    INDEX2  DW 0,6,11,16,23,29,35,40,47,54
DATA ENDS

STACK SEGMENT STACK                             ; stack segment
    STA     DB 50 DUP(?)
    TOP     EQU LENGTH STA
STACK ENDS

CODE SEGMENT                                    ; code segment
    ASSUME CS:CODE, DS:DATA, SS:STACK
    BEGIN:
            MOV AX, DATA
            MOV DS, AX                          ; set initial value to DS
            MOV AX, STACK
            MOV SS, AX                          ; set initial value to SS
            MOV AX, TOP
            MOV SP, AX                          ; set initial value to SP
            
    MAIN:
            MOV CX, 2                           ; set CX equal to 2
            
            MOV AH, 1                           ; read a char
            INT 21H

            CMP AL, 1BH                         ; if esc
            JE NEAR PTR HALT1

            SUB AL, 48                          ; if others
            CMP AL, 0
            JL OTHERS

            SUB AL, 10                          ; if numbers
            JL GETNUM

            SUB AL, 7                           ; if capital
            CMP AL, 0
            JL OTHERS
            SUB AL, 26
            CMP AL, 0
            JL CAPITAL

            SUB AL, 6                           ; if lower case
            CMP AL, 0
            JL OTHERS
            SUB AL, 26
            CMP AL, 0
            JL LOWER

            JMP OTHERS

            LOOP MAIN
    
    LOWER:                                      ; lower case
            ADD AL, 26
            MOV DX, OFFSET INDEX1
            MOV BL, 2
            MUL BL
            CBW
            ADD DX, AX
            MOV SI, DX
            MOV AX, [SI]
            MOV DX, OFFSET STR0
            ADD DX, AX
            MOV AH, 9
            INT 21H
            JMP MAIN
    
    HALT1:  JMP HALT

    CAPITAL:                                    ; capital
            ADD AL, 26
            MOV DX, OFFSET INDEX1
            MOV BL, 2
            MUL BL
            CBW
            ADD DX, AX
            MOV SI, DX
            MOV AX, [SI]
            MOV DX, OFFSET STR1
            ADD DX, AX
            MOV AH, 9
            INT 21H
            JMP MAIN

    GETNUM:
            ADD AL, 10                          ; get index
            MOV DX, OFFSET INDEX2
            MOV BL, 2
            MUL BL
            CBW
            ADD DX, AX
            MOV SI, DX
            MOV AX, [SI]                        ; find address
            MOV DX, OFFSET STR2
            ADD DX, AX
            MOV AH, 9
            INT 21H
            JMP MAIN

    OTHERS:
            MOV DL, 42
            MOV AH, 2
            INT 21H
            JMP MAIN

    HALT:
            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H
 
            MOV DX, OFFSET MYNAME
            MOV AH, 09H                         ; print NAME
            INT 21H

            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H
            
            MOV DX, OFFSET ID
            MOV AH, 09H                         ; print ID
            INT 21H

            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H

            MOV AH, 4CH                         ; exit the program
            INT 21H

CODE ENDS
            END BEGIN                           ; the end of program

