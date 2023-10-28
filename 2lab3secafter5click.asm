; Микроконтроллер: учебный стенд SDK 1.1
;


$Mod812 ; ; включаем файл, содержащий символы микроконтроллера
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
; здесь располагаются символы, определяемые программистом



; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        LJMP START ; ; переход на начало программы
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        
       ; здесь располагаются обработчики прерываний
        
        
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        ORG 80h ; ; адрес начала программы

START:  ; метка начала программы
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        ; Установка адреса регистра клавиатуры в регистры указателя данных DPTR:
        MOV DPL, #0
        MOV DPH, #0
        MOV DPP, #8

        ; Запись нулевого значения в разряд столбца COL2 (второй столбец):
        MOV A, #0FDh ; 11111101b (маска для второго столбца)
        MOVX @DPTR, A

        ; Чтение регистра клавиатуры в аккумулятор:
        MOVX A, @DPTR

        ; Проверка наличия нулевого значения в разряде 5 (ROW1) для клавиши 5:
        ANL A, #020h ; 000100000b (маска для разряда 5)
        JZ KeyPressed ; Переход, если нажата клавиша 5
        ; Код, выполняемый в случае, если клавиша 5 не нажата
        
        
        
        ljmp START
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
      ; XXXXXX - ПОДПРОГРАММЫ - XXXXXX ;
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;

KeyPressed:
        MOV TCON,#01h
        MOV DPP,#8
        MOV DPH,#0
        MOV DPL,#4
        SETB TR0
        MOV A,#10h
        MOVX @DPTR,A
        LCALL DELAY3SEC
        MOV A,#0h
        MOVX @DPTR,A
RET

DELAY3SEC:
    MOV     R3, #10
D0043:
    MOV     R2, #51
D0042:
    MOV     R1, #16
D0041:
    MOV     R0, #0
    DJNZ    R0, $
    DJNZ    R1, D0041
    DJNZ    R2, D0042
    DJNZ    R3, D0043
    RET

  

; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        END ; обязательный признак завершения текста
