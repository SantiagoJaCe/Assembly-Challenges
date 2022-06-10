#include "p16f877a.inc"
;A01024830
; CONFIG
; __config 0x3FFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF

 
 CBLOCK 0X20
 VALOR
 VALOR2
 ENDC
 
 ORG 0
    
 BSF STATUS,RP0 ;BANK 1
 
 MOVLW H'06'
 MOVWF ADCON1
 
 CLRF TRISB
 
 MOVLW B'11111111'
 MOVWF TRISA
 
 CLRF TRISC
 
 
 BCF STATUS,RP0 ;BANK 0
 
 ;Init el LCD
 MOVLW H'0F'
 MOVWF PORTB
 BSF PORTB,6
 BCF PORTB,6
 
 ;Step 2
 MOVLW B'00000010'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 ;Step 3
 MOVLW B'00000010'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 MOVLW B'00000000'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 ;Step 4
 MOVLW B'00000000'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 MOVLW B'00001110'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 ;Step 5
 MOVLW B'00000000'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 
 MOVLW B'00000110'
 MOVWF PORTB
 CALL ENVIAR
 CALL RETARDO
 ;Fin de init
 
 
 ;Teclado
 
 LOOP
 ;COLUMNA 3
 BSF PORTC,0
 BTFSC PORTA,0
 CALL TRES
 BTFSC PORTA,1
 CALL SEIS
 BTFSC PORTA,2
 CALL NUEVE
 BTFSC PORTA,3
 CALL GATO
 BCF PORTC,0
 
 ;COLUMNA 2
 BSF PORTC,1
 BTFSC PORTA,0
 CALL DOS
 BTFSC PORTA,1
 CALL CINCO
 BTFSC PORTA,2
 CALL OCHO
 BTFSC PORTA,3
 CALL CERO
 BCF PORTC,1
 
 ;COLUMNA 1
 BSF PORTC,2
 BTFSC PORTA,0
 CALL UNO
 BTFSC PORTA,1
 CALL CUATRO
 BTFSC PORTA,2
 CALL SIETE
 BTFSC PORTA,3
 CALL AST
 BCF PORTC,2
 
 GOTO LOOP
 ;Fin
 

 ;RETARDO/DELAY
 RETARDO
 MOVLW D'255'
 MOVWF VALOR
 CICLO
 DECFSZ VALOR,1
 GOTO CICLO
 RETURN
 
 ;RETARDO2/DELAY2
 RETARDO2
 MOVLW D'255'
 MOVWF VALOR2
 CICLO2
 CALL RETARDO
 DECFSZ VALOR2,1
 GOTO CICLO2
 RETURN
 
 ;ENVIAR/ENABLE
 ENVIAR
 MOVWF PORTB
 BSF PORTB,6
 CALL RETARDO
 BCF PORTB,6
 RETURN
 
 ;CERO
 CERO
 BTFSC PORTA,3
 GOTO CERO
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100000'
 CALL ENVIAR
 RETURN
 
 ;UNO
 UNO
 BTFSC PORTA,0
 GOTO UNO
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100001'
 CALL ENVIAR
 RETURN
 
 ;DOS
 DOS
 BTFSC PORTA,0
 GOTO DOS
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100010'
 CALL ENVIAR
 RETURN
 
 ;TRES
 TRES
 BTFSC PORTA,0
 GOTO TRES
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100011'
 CALL ENVIAR
 RETURN
 
 ;CUATRO
 CUATRO
 BTFSC PORTA,1
 GOTO CUATRO
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100100'
 CALL ENVIAR
 RETURN
 
 ;CINCO
 CINCO
 BTFSC PORTA,1
 GOTO CINCO
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100101'
 CALL ENVIAR
 RETURN
 
 ;SEIS
 SEIS
 BTFSC PORTA,1
 GOTO SEIS
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100110'
 CALL ENVIAR
 RETURN
 
 ;SIETE
 SIETE
 BTFSC PORTA,2
 GOTO SIETE
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00100111'
 CALL ENVIAR
 RETURN
 
 ;OCHO
 OCHO
 BTFSC PORTA,2
 GOTO OCHO
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00101000'
 CALL ENVIAR
 RETURN
 
 ;NUEVE
 NUEVE
 BTFSC PORTA,2
 GOTO NUEVE
 MOVLW B'00100011'
 CALL ENVIAR
 MOVLW B'00101001'
 CALL ENVIAR
 RETURN
 
 ;GATO
 GATO
 BTFSC PORTA,3
 GOTO GATO
 MOVLW B'00000001'
 CALL ENVIAR
 MOVLW B'00001000'
 CALL ENVIAR
 CALL RETARDO2
 GOTO GATO
 RETURN
 
 ;AST
 AST
 BTFSC PORTA,3
 GOTO AST
 MOVLW B'00100010'
 CALL ENVIAR
 MOVLW B'00101010'
 CALL ENVIAR
 RETURN
 
 END
 
 