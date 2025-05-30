comment *
------------------------------------------------------------------------
ВЫХОД-5 (Задача_2, вспомогательный модуль) 
------------------------------------------------------------------------
*

include console.inc

public In_Rec, Less, Out_Rec, Min_Date, Rec_to_Struc, Out_Struc, Ptr_to_Min_Date, Out_Sort

Date_pack record D:5, M:4, Y:7
; ------------------------------------------------------------------------
; описание типа Date_unpack  (РАСПАКОВАННОЙ ДАТЫ-СТРУКТУРЫ):
Date_unpack struc                   ; дата в рамках некоторого столетия
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; месяц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends

.code
;-----------------------------------------------------------------------
; procedure In_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: ввод K-буквенного слова, преобразование его к верхнему регистру
; и сохранение этого слова по адресу, заданному параметром Elem_of_Array.
; Перед окончанием работы процедура In_word  "чистит" буфер ввода 
; (макрокомандой flush) от управляющих символов, попавших в буфер в 
; результате нажатия клавиши ENTER (сделать это надо обязательно, иначе  
; дальнейший ввод будет осуществляться некорректно !!!). 
;-----------------------------------------------------------------------
; ------------------------------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; ДЕЙСТВИЕ: ввод значений полей D, M, Y записи типа Date_pack

; [EBP+8] ~ offset D
In_Rec proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      mov EBX, [EBP+8]
      mov word ptr [EBX], 0
      inint AX
      shl AX, D
      or [EBX], AX
      inint AX
      shl AX, M
      or [EBX], AX
      inint AX
      or [EBX], AX
      pop EBX
      pop EAX
      pop EBP
      ret 4
In_Rec endp
; ------------------------------------------------------------------------
; function Less(D1, D2: Date_pack): byte
; ДЕЙСТВИЕ:
; AL := 1 (если D1<D2, т.е. если дата_1 предшествует дате_2)
; AL := 0 (иначе)
Less proc
; [EBP+8]  ~ D1
; [EBP+12] ~ D2
      
      push EBP
      mov EBP, ESP
      push ESI
      push EBX
      push ECX
      push EDX
      mov SI, [EBP+8]
      mov BX, [EBP+12]
      mov CX, SI
      and CX, mask Y
      mov DX, BX
      and DX, mask Y
      cmp CX, DX
      jA @More
      jB @Less
      mov CX, SI
      and CX, mask M
      mov DX, BX
      and DX, mask M
      cmp CX, DX
      jA @More
      jB @Less
      mov CX, SI
      and CX, mask D
      mov DX, BX
      and DX, mask D
      cmp CX, DX
      jAE @More
@Less:mov AL, 1 
      jmp @f
@More:mov AL, 0
@@:   pop EDX
      pop ECX
      pop EBX
      pop ESI
      pop EBP
      ret 4*2
Less endp
; ------------------------------------------------------------------------
; procedure Out_Rec(D: Date_pack)
; ДЕЙСТВИЕ: вывод значений полей D, M, Y записи типа Date_pack
Out_Rec proc
; [EBP+8]  ~ D
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      mov AX, [EBP+8]
      mov CX, AX
      and CX, mask D
      shr CX, D
      outword CX
      mov CX, AX
      and CX, mask M
      shr CX, M
      outword CX,,'.'
      mov CX, AX
      and CX, mask Y
      outword CX,,'.'
      outchar ' '
      pop ECX
      pop EBX
      pop EAX
      mov ESP, EBP
      pop EBP
      ret 4
Out_Rec endp
; ------------------------------------------------------------------------
; function Min_Date(var Arr: array of Date_pack; N: longword): word
; ДЕЙСТВИЕ: АХ := минимальная дата среди элементов-дат массива Arr
; (минимальная - предшествующая всем остальным датам)
; Функция Min_Date в процессе своей работы для сравнения текущего минимума 
; с очередной датой обращается к ранее отлаженной функции Less(D1,D2)
Min_Date proc
; [EBP+8]  ~ offset Arr
; [EBP+12] ~ N
      push EBP
      mov EBP,ESP
      push EBX
      push ECX
      push EDX
      push EDI
      mov EBX,[EBP+8]
      mov ECX,[EBP+12]
      dec ECX
      movzx EDX, word ptr [EBX]
@L1:  movzx EDI, word ptr [EBX+2]
      push EDI
      push EDX
      call Less
      cmp AL,1
      jE @sk
      mov EDX,EDI
@sk:  add EBX, 2
      loop @L1
      mov AX,DX
      pop EDI
      pop EDX
      pop ECX
      pop EBX
      mov ESP,EBP
      pop EBP
      ret 4*2
Min_Date endp
; ------------------------------------------------------------------------
; procedure Rec_to_Struс(D_pack: Date_pack; var D_unpack: Date_unpack)
; ДЕЙСТВИЕ: распаковка даты 
; (из ЗАПИСИ типа Date_pack в СТРУКТУРУ типа Date_unpack)
Rec_to_Struc proc
; [EBP+8]  ~ запись D_pack (слово)
; [EBP+12] ~ адрес структуры D_unpack
      push EBP
      mov EBP, ESP
      push EBX
      push ECX
      push EDX
      push ESI
      mov BX, [EBP+8]
      mov ESI, [EBP+12]
      and BX, mask Y
      mov (Date_unpack ptr [ESI]).Y, BL
      mov BX, [EBP+8]
      and BX, mask M
      shr BX, M
      mov (Date_unpack ptr [ESI]).M, BL
      mov BX, [EBP+8]
      and BX, mask D
      shr BX, D
      mov (Date_unpack ptr [ESI]).D, BL
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EBP
      ret 4*2
Rec_to_Struc endp
; ------------------------------------------------------------------------
; procedure Out_Struc(var D: Date_unpack)
; ДЕЙСТВИЕ: вывод значений полей D, M, Y структуры типа Date_unpack
Out_Struc proc
; [EBP+8]  ~ адрес структуры
      push EBP
      mov EBP, ESP
      push ESI
      mov ESI, [EBP+8]
      outword (Date_unpack ptr [ESI]).D
      outword (Date_unpack ptr [ESI]).M,,"."
      outword (Date_unpack ptr [ESI]).Y,,"."
      pop ESI
      pop EBP
      ret 4
Out_Struc endp


Ptr_to_Min_Date proc
      push EBP
      mov EBP,ESP
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      mov EBX,[EBP+8]
      mov ECX,[EBP+12]
      dec ECX
      movzx EDX, word ptr [EBX]
      mov ESI, EBX
@L2:  movzx EDI, word ptr [EBX+2]
      push EDI
      push EDX
      call Less
      cmp AL,1
      jE @skip
      mov EDX,EDI
      mov ESI, EBX
      add ESI, 2
@skip:add EBX, 2
      loop @L2
      mov EAX, ESI
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EBP
      ret 4*2
Ptr_to_Min_Date endp


Out_Sort proc
      push EBP
      mov EBP, ESP
      push ECX
      push EDX
      push ESI
      mov ESI, [EBP+8]
      mov ECX, [EBP+12]
@L4:  movzx EDX, word ptr [ESI]
      push EDX
      call Out_Rec
      add ESI, 2
      outchar " "
      loop @L4
      pop ESI
      pop EDX
      pop ECX
      pop EBP
      ret 4*2
Out_Sort endp

;-----------------------------------------------------------------------
	
end