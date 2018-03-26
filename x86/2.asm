DATA SEGMENT                                    ; save data
    MYNAME  DB 'NAME: Tao Yuanzheng$'           ; name = Tao Yuanzheng
    ID      DB 'ID: 1600012799$'                ; id = 1600012799
    BYE     DB 'Good Bye!$'                     ; say goodbye!
    SUCC    DB 'Got it! Location: $'         ; if success
    FAIL    DB 'Sorry!$'                       ; if fail
    BUFFER  DB 100
            DB 0
    STRING  DB 100 DUP(0)                        ; reading string
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
            MOV AX, DATA
            MOV ES, AX                          ; set initial value to ES
            MOV AX, TOP
            MOV SP, AX                          ; set initial value to SP
            
            MOV DX, OFFSET BUFFER               ; read buffer from keyboard
            MOV AH, 0AH
            INT 21H

            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H
   
    MAIN:
            MOV AH, 01H                         ; read char
            INT 21H
            CMP AL, 1BH
            JE HALT1
             
             
            MOV SI, OFFSET BUFFER               ; read buffer
            MOV DI, OFFSET BUFFER
            ADD DI, 1                           ; di is the address of length
            ADD SI, 2
            MOV CX, 0
            MOV CL, [DI]                        ; get length
            MOV SP, 0                           ; set counter

    WORK:
            MOV BL, [SI]                        ; pick out char
            ADD SI, 1H
            ADD SP, 1
            CMP BL, AL                          ; cmp
            JE FOUND
            CMP CX, SP                          ; if end
            JE NOF
            JMP WORK 

    HALT1:  JMP HALT

    NOF:
            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H
            
            MOV DX, OFFSET FAIL                 
            MOV AH, 09H
            INT 21H
            
            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H
            
            JMP MAIN

    FOUND: 
            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
            INT 21H 
            
            MOV DX, OFFSET SUCC                 ; we assume the total length<100
            MOV AH, 09H
            INT 21H
            MOV AX, SP
            MOV AH, 0
            MOV BL, 10
            IDIV BL
            CMP AL, 0                           ; if answer<10, go nex
            JE NEX
            MOV DX, 0
            MOV DL, AL
            ADD DX, 30H
            MOV AH, 2H
            INT 21H
            MOV DX, 0
            MOV DL, AH
            ADD DX, 30H
            JMP NEXX
    NEX:    MOV DX, SP
            ADD DX, 30H
    NEXX:
            MOV AH, 2H
            INT 21H

            MOV DL, 0DH
            MOV AH, 2                           ; print enter
            INT 21H

            MOV DL, 0AH
            MOV AH, 2                           ; print \n
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


