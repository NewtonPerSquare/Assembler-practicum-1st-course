include console.inc
; (ТЕСТЫ ДЛЯ ЭТАПОВ 1,2,3 -  в конце этой программы, копируйте и используйте!)
; ОПИСАНИЕ ТИПОВ (ЗАПИСИ) И (СТРУКТУРЫ):
; КАТЕГОРИЧЕСКИ ЗАПРЕЩЕНО вносить изменения в описания типов и переменных,
; кроме строчки номер 19, где указывать номер(а) сдаваемого(ых) этапа(ов)
; ------------------------------------------------------------------------
; описание типа Date_pack    (УПАКОВАННОЙ ДАТЫ-ЗАПИСИ):
Date_pack record D:5, M:4, Y:7
; ------------------------------------------------------------------------
; описание типа Date_unpack  (РАСПАКОВАННОЙ ДАТЫ-СТРУКТУРЫ):
Date_unpack struc                   ; дата в рамках некоторого столетия
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; месяц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends
; ------------------------------------------------------------------------
; ОПИСАНИЕ ПЕРЕМЕННЫХ:
.data
T   db " Паскаль Егор этап 5(выход-4)",0
N   equ 6
D1  Date_pack <>                    ; упакованная дата_1
D2  Date_pack <>                    ; упакованная дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив ЗАПИСЕЙ (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>) ; массив СТРУКТУР (распакованных дат)
; ------------------------------------------------------------------------
; ОПИСАНИЕ ПРОЦЕДУР: 
.code
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
@sk:  add EBX,type Arr_of_Rec
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
@skip:add EBX,type Arr_of_Rec
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
      add ESI, type Arr_of_Rec
      outchar " "
      loop @L4
      pop ESI
      pop EDX
      pop ECX
      pop EBP
      ret 4*2
Out_Sort endp


; ------------------------------------------------------------------------
; ВЕДУЩАЯ ЧАСТЬ (ОСНОВНАЯ ПРОГРАММА):
start:	
    ConsoleTitle offset T  ; в Т должен быть указан НОМЕР сдаваемого ЭТАПа(ов)	
; ------------------------------------------------------------------------
; ЭТАП 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (каждая в формате dd.mm.yy)
; решение:
COMMENT *
      outstrln 'Введите 1ю дату'
      push offset D1
      call In_Rec
      outstrln 'Введите 2ю дату'
      push offset D2
      call In_Rec
      mov AX, D1
      push EAX
      call Out_Rec
      newline
      mov AX, D2
      push EAX
      call Out_Rec
      newline
      mov AX, D2
      push EAX
      mov AX, D1
      push EAX
      call Less
      outstr 'D1'
      outchar 60
      outstr 'D2 is '
      cmp AL, 0
      jE @f
      outstrln 'true'
      jmp sk1
@@:   outstrln 'false'
sk1:  
*
; (20 очков) сравнение двух дат (D1 < D2 ?)
; решение:


; (10 очков) вывод результата сравнения в виде "D1<D2 is true/false",
; где вместо D1 и D2 должна быть напечатана дата в формате dd.mm.yy
; решение:

   
; ------------------------------------------------------------------------
; ЭТАП 2 (50 очков):
; (15 очков) цикл для ввода N дат и сохранения их в массиве Arr_of_Rec:
; решение:

      mov ECX, N
      lea EBX, Arr_of_Rec
L1:   push EBX
      call In_Rec
      lea EBX, [EBX+2]
      loop L1

; (15 очков) цикл для вывода N дат, хранящихся в массиве Arr_of_Rec
; решение:
      newline
      mov ECX, N
      lea EBX, Arr_of_Rec
L2:   movzx EAX, word ptr [EBX]
      push EAX
      call Out_Rec
      lea EBX, [EBX+2]
      loop L2
      newline
      
; (20 очков) цикл для проверки упорядочены ли элементы-даты по возрастанию
; решение:
      newline     
      mov ECX, N-1
      lea EBX, Arr_of_Rec
L3:   movzx EAX, word ptr [EBX] + type Date_pack
      push EAX
      movzx EAX, word ptr [EBX]
      push EAX
      call Less
      cmp AL, 0
      jE wrng
      lea EBX, [EBX+2]
      loop L3
      outstrln 'Sorted' 
      jmp @F
wrng: outstrln 'Not sorted'
@@:

; ------------------------------------------------------------------------
; ЭТАП 3 (40 очков):
; применение функции Min_Date для поиска наименьшей даты в массиве Arr_of_Rec
; решение:
      push dword ptr N
      push offset Arr_of_Rec
      call Min_Date
      push EAX
      call Out_Rec
      outstrln " is minimum"
      newline
; вывод наименьшей даты в виде "dd.mm.yy is minimum"
; решение:



; ------------------------------------------------------------------------
; ЭТАП 4 (60 очков):
; (30 очков) цикл движения по массиву Arr_of_Rec с целью распаковки дат 
; и сохранения их в массиве структур  Arr_of_Struc
; решение:
      mov ECX, N
      lea ESI, Arr_of_Struc
      lea EAX, Arr_of_Rec
Lc:   push ESI
      mov BX, [EAX]
      push EBX
      call Rec_to_Struc
      add ESI, 3
      add EAX, 2  
      loop Lc

; (30 очков) цикл движения по массиву Arr_of_Struc с целью вывода дат 
; на экран (каждую дату - в формате dd.mm.yy)
; решение
      outstrln 'Arr_of_Struc:'
      mov ECX, N
      lea ESI, Arr_of_Struc
Lo:   push ESI
      call Out_Struc
      outchar " "
      lea ESI, [ESI+type Arr_of_Struc]
      loop Lo
; ------------------------------------------------------------------------
; дополнительные ЭТАПЫ 5 и 6 оформляйте самостоятельно (для них разметки нет)
; ------------------------------------------------------------------------
      newline
      mov ECX, N
      mov ESI, offset Arr_of_Rec
L5:   push ECX
      push ESI
      call Ptr_to_Min_Date
      mov BX, word ptr [EAX]
      xchg word ptr [ESI], BX
      mov word ptr [EAX], BX
      add ESI, type Arr_of_Rec
      dec ECX
      cmp ECX, 1
      jA L5
      push N
      push offset Arr_of_Rec 
      call Out_Sort
      pause ;нужно ТОЛЬКО при отправке по почте 
	exit
end start
	
ТЕСТЫ, на которых надо сдавать программу:
--------------------------------------------------------------------------
ЭТАП 1
--------------------------------------------------------------------------
1)  10.2.20 13.2.20	   ===>   10.2.20<13.2.20 is true
2)  20.2.20 10.3.20	   ===>   20.2.20<10.3.20 is true  
3)  15.2.20 10.2.21	   ===>   15.2.20<10.2.21 is true  
4)  1.2.3 1.2.3	         ===>   1.2.3<1.2.3 is false
5)  10.2.20 15.1.20	   ===>   10.2.20<15.1.20 is false
6)  9.2.20 10.2.19	   ===>   9.2.20<10.2.19 is false
--------------------------------------------------------------------------
ЭТАП 2
--------------------------------------------------------------------------
1)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 15.4.20	===> sorted
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.2	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
--------------------------------------------------------------------------
ЭТАП 3
--------------------------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
--------------------------------------------------------------------------
