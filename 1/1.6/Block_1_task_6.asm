include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_6 (блок_1) 'Пятeричное число' ", 0

.code
Start:
      ConsoleTitle offset T 
      mov ECX, 0
      mov EAX, 0
      inchar CL, "Введите число в пятеричной системе счисления с пробелом на конце: "
      mov EBX, 5
L:    sub CL, "0"  ; посимвольный перевод в десятеричную систему с помощью схемы Горнера
      mul EBX
      add EAX, ECX
      inchar CL
      cmp CL, " "
      jnE L
      cmp EDX, 0
      jE fin
      outword EDX
fin:  outword EAX ; вывод результата
      outstr " - Ваше число в десятичной системе счисления"
      pause                 
      exit                  
end   Start
