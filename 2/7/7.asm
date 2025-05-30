include console.inc

.data
N     equ 30
T     db " Паскаль Егор (группа 110) "
      db " Задача_7 (блок 2) 'Сортировка пузырьком' ",0     
X     dd N dup(?)
.code
Start:
      ConsoleTitle offset T
      inint ECX, "Введите размерность массива: "
      mov EAX, 0
      outstr "Введите массив: "
input:inint X[4*EAX]
      inc EAX
      cmp EAX, ECX
      jB input
      
      
      mov EBX, ECX
L1:   dec EBX
      mov ESI, 0
      mov EAX, 0
L2:   mov EDX, X[4*EAX]
      cmp EDX, X[4*EAX+4]
      jLE skip
      xchg EDX, X[4*EAX+4]
      mov X[4*EAX], EDX
      inc ESI
      
skip: inc EAX
      cmp EAX, EBX
      jNE L2
      cmp ESI, 0
      jE fin
      cmp EBX, 1
      jG L1
      
fin:  mov EAX, 0
      outstr "Отсортированный массив:"
outpu:outint X[4*EAX],," "
      inc EAX
      cmp EAX, ECX
      jB outpu
      pause
      exit
end   Start
