include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_9 (блок_1) 'Первая и последняя буквы' ", 0
.code
Start:
      ConsoleTitle offset T
      outstrln "Введите непустую последоавтельность непустых слов"
      mov ECX, 0   ; счётчик
L1:   inchar BL
      mov AL, BL   ; в AL будет храниться первая буква слова, в BL - последняя введённая
L2:   mov AH, BL   ; а в AH - предпоследняя введённая (для случая, когда будет введена
      inchar BL    ; запятая, чтобы использовать её как послденюю букву слова 
      cmp BL, ","
      jE L3
      cmp BL, "."
      jE L3
      jmp L2
L3:   cmp AL, AH
      jNE N
      inc ECX
N:    cmp BL, "."
      jNE L1
      outwordln ECX,, "Количество слов с одинаковой первой и последней буквой: "
      pause                 
      exit                  
end   Start
