include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_6 (блок 4) 'Текст наоборот' ",0
.code

REVERSE proc
      push EAX
      
      mov EAX, 0
      inchar AL
      cmp AL, "."
      jE @sk
      call REVERSE
      outchar AL
@sk:  pop EAX
      ret 
REVERSE endp


Start:
      ConsoleTitle offset T
      outstrln "Введите текст"
      call REVERSE
      pause
      exit
end   Start
