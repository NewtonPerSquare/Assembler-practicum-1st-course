include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_3 (блок_1) 'Баланс скобок' ", 0
S      db "Нет", 0, "Да", 0
.code
Start:
      ConsoleTitle offset T 
      mov EDX, offset S
      mov AL, 0
      inchar BL, " Введите посдедовательность символов с точкой на конце: "
L:    cmp BL, "." ; проверка на точку
      jE pfin
      cmp BL, "(" ; проверка на открывающую скобку
      jNE L1
      inc AL
      jmp Lend
L1:   cmp BL, ")" ; проверка на закрывающую скобку
      jNE Lend
      dec AL
      cmp AL, 0   ; проверка на отрицательность счётчика
      jL fin
Lend: inchar BL
      jmp L
pfin: cmp AL, 0            ; вывод результата
      JNE fin
      mov EDX, offset S+4 
fin:  outstrln EDX  
      pause                 
      exit                  
end   Start
