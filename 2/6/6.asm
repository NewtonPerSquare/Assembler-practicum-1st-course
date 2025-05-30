include console.inc

.data
N      equ 30
T      db " Паскаль Егор (группа 110) "
       db " Задача_6 (блок 2) 'Сортировка выбором' ",0     
X      dd N dup(?)
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
      
      mov EDX, ECX
L1:   mov EAX, 0     ;fictive index
      mov EBX, X[0]  ;max value
      mov ESI, 0     ;max index
L2:   cmp X[4*EAX], EBX
      jLE skip
      mov EBX, X[4*EAX]
      mov ESI, EAX 
skip: inc EAX
      cmp EAX, EDX
      jL L2
      mov EDI, X[4*ESI]
      xchg X[4*EDX-4], EDI
      mov X[4*ESI], EDI
      dec EDX
      cmp EDX, 0
      jG L1
      mov EAX, 0
outpu:outint X[4*EAX],," "
      inc EAX
      cmp EAX, ECX
      jL outpu
      pause
      exit
end   Start
