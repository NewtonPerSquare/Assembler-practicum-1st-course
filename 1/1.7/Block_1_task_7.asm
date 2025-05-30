include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_7 (блок_1) 'Ближайшее число, кратное семи' ", 0
.code
Start:
      ConsoleTitle offset T 
      inint EBX, "Введите число: "
      mov EAX, EBX
      mov EDX, 0
      mov ESI, 7
      div ESI
      cmp EDX, 4     ; проверка остатка: если остаток EDX <= 3, то ближайшее кратное
      jGE L1         ; семи число будет на EDX меньше исходного числа (в т.ч. для EDX=0)
      sub EBX, EDX   ; иначе, ближайшее число на 7-EDX больше исходного
      jmp L
L1:   add EBX, 7
      sub EBX, EDX
L:    outword EBX,, "Ближайшее кратное 7 число: "      
      pause                 
      exit                  
end   Start
