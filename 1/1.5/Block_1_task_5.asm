include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_5 (блок_1) 'Произведение младшей и старшей десятичных цифр' ", 0

.code
Start:
      ConsoleTitle offset T 
      inint EAX, "Введите число: "
      cdq
      mov ESI, 10
      div ESI
      mov BL, DL ; сохраняем младшую цифру
L:    cmp EAX, 0 ; ищем и сохраняем старшую цифру
      jE fin
      mov EDX, 0
      div ESI
      jmp L
fin:  mov BH, DL ; вывод и подсчёт искомого выражения
      mov AL, BL
      mul BH
      outint BL
      outint BH,, "*"
      outint AX,, " = "
      pause                 
      exit                  
end   Start
