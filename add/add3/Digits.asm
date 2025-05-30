include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Доп_задача (выход 3) 'Цифры' ",0  
      Ans   db (9*6+2)*5+1 dup ('0')          ;всего символов - 9 "макросимволов" - 9 на 5 строк по 6 символов на каждой внутри них и 2 запасных символа под "10, 13" 

dig1  db " 000    1    222  3333  4   4 55555  666  77777  888   999  ", 10, 13,
         "0   0  11   2   2     3 4   4 5     6         7 8   8 9   9 ", 10, 13,
         "0   0   1      2   333  44444 5555  6666     7   888   9999 ", 10, 13,
         "0   0   1    22       3     4     5 6   6   7   8   8     9 ", 10, 13,
         " 000   111  22222 3333      4 5555   666   7     888   999  ", 0
         
dig2 db "  ***    *    ***  ****  *   * *****  ***  *****  ***   ***  ", 10, 13,
         "*   *  **   *   *     * *   * *     *         * *   * *   * ", 10, 13,
         "*   *   *      *   ***  ***** ****  ****     *   ***   **** ", 10, 13,
         "*   *   *    **       *     *     * *   *   *   *   *     * ", 10, 13,
         " ***   ***  ***** ****      * ****   ***   *     ***   ***  ", 0, ")"
         
dig3  db " ---    |    ___  ---\  |   | |----  ---  -----  ---   ---  ", 10, 13,
         "|   |  /|   /   \    |  |   | |     /         / |   | |   | ", 10, 13,
         "|   |   |      /  ---|  |---| |--|  |---     /   ---   ---| ", 10, 13,
         "|   |   |    //      |      |    |  \   /   /   |   |     | ", 10, 13,
         " ---   ---  ----- ---/      | ---|   ---   /     ---   ---  ", 0   
.code
COMMENT ~
Программа работает по следующему алгоритму: происходит ввод числа, номера шрифта (и символа для шрифта №2).
Процедура get_length кладёт в регистр ECX количество символов в числе EAX. Процедура prepare_ans по значению
ECX подготавливает массив-ответ Ans. А затем, по номеру шрифта вызывается одна из процедур print1-3, работающих
по следующему принципу: из соответствующего массива-образца копируется его часть (5*6 символов) в массив-ответ
Ans, по числу на EDX-остатку от деления на 10. Таким образом, число разбивается на цифры, и процедура по этим цифрам
формирует ответ. 
~

prepare_ans proc                 ;подгоняем размеры массива Ans под нужную длину
      push EAX      
      push EBX
      push ESI
      push EBX
      push EDI
      
      mov EAX, 6
      mul ECX           
      add EAX, 2                 ;на EAX длина строки
      mov ESI, 0
      mov EDI, 0
      mov EBX, 0
@@:   inc EBX 
      cmp EBX, EAX
      jB @B
      mov Ans[EBX-2][ESI], 10
      mov Ans[EBX-1][ESI], 13
      add ESI, EAX
      inc EDI
      mov EBX, 0
      cmp EDI, 5
      jB @B
      sub ESI, EAX
      mov Ans[EAX-2][ESI], 0
      
      pop EDI
      pop EBX
      pop ESI
      pop EBX
      pop EAX
      ret
prepare_ans endp

get_length proc
      push EAX
      push EBX
      push EDX
      push ESI
      
      mov ESI, 10
      mov ECX, 1
@@:   mov EDX, 0
      cmp EAX, 10
      jB @F
      div ESI
      inc ECX
      jmp @B
      
@@:   pop ESI
      pop EDX
      pop EBX
      pop EAX
      ret
get_length endp


print1 proc                                                 ;шрифт 1
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;смещение по строкам для массива-образца
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print1
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;смещение по строкам для массива-ответа
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;смещение внутри строки для массива-образца

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX
      mov BL, dig1[EDX]
      mov Ans[EDI], BL

      mov Ans[EDI], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print1 endp


print2 proc                                                 ;шрифт 2
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;смещение по строкам для массива-образца
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print2
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;смещение по строкам для массива-ответа
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;смещение внутри строки для массива-образца

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX

      mov BL, dig2[EDX]
      cmp BL, "*"
      jne @skip
      mov BL, dig2[310]                       ;введённый символ
@skip:mov Ans[EDI], BL
      mov dig2[EDX], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print2 endp

print3 proc                                                 ;шрифт 3
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;смещение по строкам для массива-образца
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print3
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;смещение по строкам для массива-ответа
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;смещение внутри строки для массива-образца

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX
      mov BL, dig3[EDX]
      mov Ans[EDI], BL

      mov Ans[EDI], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print3 endp


Start:
      ConsoleTitle offset T
      
      mov EDI, 0
      inchar dig2[310], "Введите Ваш символ(нужно для шрифта №2, см. комментарии в коде): "
COMMENT ~
            Это - реализация универсального шрифта.
По неизвестной мне причине, ввод символа в строке 303 не происходит - программа просто пропускает эту строку и всё.
Причём, я пробовал поставить эту команду в разные места. Опытным путём выяснилось, что адекватная работа происходит 
только тогда, когда эта команда стоит в начале. Хотел попробовать что-то с командой inputstr - результат тот же.
~
      inint EAX, "Введите число из 0..999999999: "
      call get_length
      call prepare_ans
      outstrln "Выберите шрифт (1-3):"
      outstrln "Шрифт 1 - шрифт из цифр"
      outstrln "Шрифт 2 - универсальный шрифт (из выбранного символа)"
      outstrln "Шрифт 3 - шрифт из слэшей и дефисов"
input:inint EBX, "Введите номер шрифта: "
      newline
      newline
      newline
      cmp EBX, 1
      jne ch2
      call print1
      jmp prt
ch2:  cmp EBX, 2
      jne ch3
     ;inchar dig[308], "Введите Ваше число"       
      call print2
      jmp prt
ch3:   cmp EBX, 3
      jne Err
      call print3
      jmp prt
Err:  outstr "Неправильно введён номер шрифта. Попробуйте ещё раз."
      jmp input
prt:  outstr offset Ans
      pause
      exit
end   Start
