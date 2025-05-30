include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_4 (блок_1) 'Дробь P/Q' ", 0
P     dd ? ; P>=0
Q     dd ? ; Q>0
.code
Start:
      ConsoleTitle offset T
      inintln P, "Введите число P: "
      inintln Q, "Введите число Q: "
      mov EAX, P      ;подсчет и вывод целой части числа и точки
      cdq
      div Q
      outint EAX
      outchar "."
      mov ECX, 5
      mov EBX, 10
L:    mov EAX, EDX    ;подсчёт и вывод дробной части числа
      mul EBX
      div Q
      outint EAX
      loop L
      pause                 
      exit                  
end   Start
