; Микроконтроллер: учебный стенд SDK 1.1
;

$Mod812 ; включаем файл, содержащий символы микроконтроллера
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
; здесь располагаются символы, определяемые программистом


; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        LJMP START ; переход на начало программы
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        
        ; здесь располагаются обработчики прерываний
        
        
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        ORG 80h ; адрес начала программы
START:  ; метка начала программы
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
CYCLE:
	MOV A,#0CFh ;команда адрес памяти 4F
	LCALL CDISP
	MOV A,#02Ah
	LCALL DISPA
	MOV A,#0C0h ;команда адрес памяти 4E -> 40
	LCALL CDISP
	MOV A,#02Ah
	LCALL DISPA
	MOV A,#080h ;команда адрес памяти 0E -> 00
	LCALL CDISP
	MOV A,#02Ah
	LCALL DISPA
	MOV A,#08Fh ;команда адрес памяти 0E -> 00
	LCALL CDISP
	MOV A,#02Ah
	LCALL DISPA
	; очистка против часовой стрелки
	LCALL DELAY10SEC;
	MOV A,#080h ;команда адрес памяти 0E -> 00
	LCALL CDISP
	MOV A,#014h
	LCALL DISPA
	LCALL DELAY10SEC;
	MOV A,#0C0h ;команда адрес памяти 4E -> 40
	LCALL CDISP
	MOV A,#014h
	LCALL DISPA
	LCALL DELAY10SEC;
	MOV A,#0CFh ;команда адрес памяти 4F
	LCALL CDISP
	MOV A,#014h
	LCALL DISPA
	LCALL DELAY10SEC;
	MOV A,#08Fh ;команда адрес памяти 0E -> 00
	LCALL CDISP
	MOV A,#014h
	LCALL DISPA

; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        SJMP $ ; замкнутый бесконечный цикл
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;

        ; XXXXXX - ПОДПРОГРАММЫ - XXXXXX ;

DISPA: ; вывод символа
	MOV DPP,#8
	MOV DPH,#0
	MOV DPL,#1
	MOVX @DPTR,A
	LCALL D40MCS
	MOV DPL,#6
	MOV A,#0Dh
	MOVX @DPTR,A
	LCALL D40MCS
	MOV A,#0Ch
	MOVX @DPTR,A
	LCALL D40MCS
	RET

CDISP: ;запись команды
	MOV DPP,#8
	MOV DPH,#0
	MOV DPL,#1
	MOVX @DPTR,A
	LCALL D2MS
	MOV DPL,#6
	MOV A,#09h
	MOVX @DPTR,A
	LCALL D40MCS
	MOV A,#08h
	MOVX @DPTR,A
	LCALL D40MCS
	RET
; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
; подпрограмма задержки на 40 мкс
D40MCS:
	MOV     R3, #1
D8101:
    	MOV     R2, #23
    	DJNZ    R2, $
    	DJNZ    R3, D8101
    	RET

; подпрограмма задержки на 2 мс
D2MS:
    	MOV     R3, #17
D5561:
    	MOV     R2, #80
    	DJNZ    R2, $
    	DJNZ    R3, D5561
	RET

D3S:
    	MOV     R4, #42
D9582:
    	MOV     R3, #230
D9581:
    	MOV     R2, #214
    	DJNZ    R2, $
    	DJNZ    R3, D9581
    	DJNZ    R4, D9582
        RET ; обязательный признак завершения подпрограммы

DELAY10SEC:
    MOV     R3, #2
D3333:
    MOV     R2, #106
D3332:
    MOV     R1, #128
D3331:
    MOV     R0, #0
    DJNZ    R0, $
    DJNZ    R1, D3331
    DJNZ    R2, D3332
    DJNZ    R3, D3333
    RET		

; XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ;
        END ; обязательный признак завершения текста
