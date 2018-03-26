DATA SEGMENT                                    ; save data
    MYNAME    DB 'NAME: Tao Yuanzheng$'           ; name = Tao Yuanzheng
    ID      DB 'ID: 1600012799$'                ; id = 1600012799
    BYE     DB 'Good Bye!$'                     ; say goodbye!
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
            MOV CX, 2                           ; set CX equal to 1
            
            MOV AH, 1
            INT 21H
            CMP AL, 1BH
            JE HALT

            LOOP MAIN
            
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

