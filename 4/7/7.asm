include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_7 (блок 4) 'Отрицательыне и положительные числа' ",0
.code

PRINT proc
      push EAX
      
      inint EAX
      cmp EAX, 0
      jE @sk
      cmp EAX, 0
      jG @H
      outint EAX,, " "
      call PRINT
      jmp @sk
@H:   call PRINT
      outint EAX,, " "
@sk:  pop EAX
      ret 
PRINT endp


Start:
      ConsoleTitle offset T
      outstrln "Введите числа"
      call PRINT
      pause
      exit
end   Start
