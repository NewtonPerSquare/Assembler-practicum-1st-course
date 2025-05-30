include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_5 (блок 4) 'Максимальная цифра в десятичной записи числа' ",0
.code

MaxDig proc
      push EBP
      mov EBP, ESP
      push EDX
      push ECX
      
      mov EDX, 0
      mov EAX, [EBP+8]
      mov EBX, 10
      div EBX
      cmp EAX, 0
      jE @skip
      push EAX
      call MaxDig
@skip:cmp ESI, EDX
      jA @sk
      mov ESI, EDX
      mov EAX, EDX
@sk:  
      pop ECX
      pop EDX
      pop EBP
      ret 4
MaxDig endp


Start:
      ConsoleTitle offset T
      mov ESI, 0
      inint EBX
      push EBX
      call MaxDig
      outint EAX
      pause
      exit
end   Start
