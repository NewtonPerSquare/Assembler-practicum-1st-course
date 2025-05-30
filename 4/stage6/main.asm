comment *
-------------------------------------------------------------------
¬џ’ќƒ-5 («адача_2, головной модуль) 
-------------------------------------------------------------------
*

include console.inc

extern In_Rec@0: proc, Less@0: proc, Out_Rec@0: proc, Min_Date@0: proc, Rec_to_Struc@0: proc, Out_Struc@0: proc, Ptr_to_Min_Date@0: proc, Out_Sort@0: proc
Date_pack record D:5, M:4, Y:7
; ------------------------------------------------------------------------
; описание типа Date_unpack  (–ј—ѕј ќ¬јЌЌќ… ƒј“џ-—“–” “”–џ):
Date_unpack struc                   ; дата в рамках некоторого столети€
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; мес€ц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends
; ------------------------------------------------------------------------
; ќѕ»—јЌ»≈ ѕ≈–≈ћ≈ЌЌџ’:
.data
T   db " ѕаскаль ≈гор этап 5(выход-4)",0
N   equ 6
D1  Date_pack <>                    ; упакованна€ дата_1
D2  Date_pack <>                    ; упакованна€ дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив «јѕ»—≈… (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>) ; массив —“–” “”– (распакованных дат)
.code

Start:	;------------- этап 1 -------(40 очков)-----------------------------
	ConsoleTitle " ѕаскаль ≈гор    «јƒј„ј_доп-2 (выход-4)"
    ConsoleTitle offset T  ; в “ должен быть указан Ќќћ≈– сдаваемого Ё“јѕа(ов)	
; ------------------------------------------------------------------------
; Ё“јѕ 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (кажда€ в формате dd.mm.yy)
; решение:
COMMENT *
      outstrln '¬ведите 1ю дату'
      push offset D1
      call In_Rec
      outstrln '¬ведите 2ю дату'
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


; (10 очков) вывод результата сравнени€ в виде "D1<D2 is true/false",
; где вместо D1 и D2 должна быть напечатана дата в формате dd.mm.yy
; решение:

   
; ------------------------------------------------------------------------
; Ё“јѕ 2 (50 очков):
; (15 очков) цикл дл€ ввода N дат и сохранени€ их в массиве Arr_of_Rec:
; решение:

      mov ECX, N
      lea EBX, Arr_of_Rec
L1:   push EBX
      call In_Rec@0
      lea EBX, [EBX+2]
      loop L1

; (15 очков) цикл дл€ вывода N дат, хран€щихс€ в массиве Arr_of_Rec
; решение:
      newline
      mov ECX, N
      lea EBX, Arr_of_Rec
L2:   movzx EAX, word ptr [EBX]
      push EAX
      call Out_Rec@0
      lea EBX, [EBX+2]
      loop L2
      newline
      
; (20 очков) цикл дл€ проверки упор€дочены ли элементы-даты по возрастанию
; решение:
      newline     
      mov ECX, N-1
      lea EBX, Arr_of_Rec
L3:   movzx EAX, word ptr [EBX] + type Date_pack
      push EAX
      movzx EAX, word ptr [EBX]
      push EAX
      call Less@0
      cmp AL, 0
      jE wrng
      lea EBX, [EBX+2]
      loop L3
      outstrln 'Sorted' 
      jmp @F
wrng: outstrln 'Not sorted'
@@:

; ------------------------------------------------------------------------
; Ё“јѕ 3 (40 очков):
; применение функции Min_Date дл€ поиска наименьшей даты в массиве Arr_of_Rec
; решение:
      push dword ptr N
      push offset Arr_of_Rec
      call Min_Date@0
      push EAX
      call Out_Rec@0
      outstrln " is minimum"
      newline
; вывод наименьшей даты в виде "dd.mm.yy is minimum"
; решение:



; ------------------------------------------------------------------------
; Ё“јѕ 4 (60 очков):
; (30 очков) цикл движени€ по массиву Arr_of_Rec с целью распаковки дат 
; и сохранени€ их в массиве структур  Arr_of_Struc
; решение:
      mov ECX, N
      lea ESI, Arr_of_Struc
      lea EAX, Arr_of_Rec
Lc:   push ESI
      mov BX, [EAX]
      push EBX
      call Rec_to_Struc@0
      add ESI, 3
      add EAX, 2  
      loop Lc

; (30 очков) цикл движени€ по массиву Arr_of_Struc с целью вывода дат 
; на экран (каждую дату - в формате dd.mm.yy)
; решение
      outstrln 'Arr_of_Struc:'
      mov ECX, N
      lea ESI, Arr_of_Struc
Lo:   push ESI
      call Out_Struc@0
      outchar " "
      lea ESI, [ESI+type Arr_of_Struc]
      loop Lo
; ------------------------------------------------------------------------
; дополнительные Ё“јѕџ 5 и 6 оформл€йте самосто€тельно (дл€ них разметки нет)
; ------------------------------------------------------------------------
      newline
      mov ECX, N
      mov ESI, offset Arr_of_Rec
L5:   push ECX
      push ESI
      call Ptr_to_Min_Date@0
      mov BX, word ptr [EAX]
      xchg word ptr [ESI], BX
      mov word ptr [EAX], BX
      add ESI, type Arr_of_Rec
      dec ECX
      cmp ECX, 1
      jA L5
      push N
      push offset Arr_of_Rec 
      call Out_Sort@0


    pause     ; нужно при сдаче по email
    exit
end Start






comment ~

----------------------------------------------------------------------
»Ќ—“–” ÷»я ѕќ –ј«–јЅќ“ ≈ Ё“ќ… ƒ¬”’ћќƒ”Ћ№Ќќ… ѕ–ќ√–јћћџ:
----------------------------------------------------------------------
»спользовать:
пакетный файл prompt1.bat дл€ запуска окна командной строки. 

ƒл€ трансл€ции этого модул€ (m2.asm) выполнить (из командной строки):
ml /c /coff /Fl m2.asm

ƒл€ трансл€ции вспомогательного модул€ (u2.asm) выполнить:
ml /c /coff /Fl u2.asm

ƒл€ сборки (линковки) двух модулей выполнить:
link /subsystem:console m2.obj u2.obj 

ƒл€ запуска готовой программы на счЄт выполнить:
m2

~
