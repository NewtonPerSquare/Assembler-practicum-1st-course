include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_9 (блок 4) 'Максимум и минимум' ",0
.code

MaxMin proc
      push EBX
      push EDX
      
      inchar BL
      cmp BL, "0"
      jB @M
      cmp BL, "9"
      jA @M
      mov AL, BL
      sub AL, "0"
      jmp @fin
@M:   cmp BL, "M"
      jNE @m
      inchar BL   ;"("
      call MaxMin
      mov DL, AL
      inchar BL   ;","
      call MaxMin
      inchar BL   ;")"
      cmp AL, DL
      jA @sk1
      xchg AL, DL
@sk1: jmp @fin
@m:   inchar BL   ;"("
      call MaxMin
      mov DL, AL
      inchar BL   ;","
      call MaxMin
      inchar BL   ;")"
      cmp AL, DL
      jB @sk2
      xchg AL, DL
@sk2: jmp @fin
      
      
@fin: pop EDX
      pop EBX
      ret 
MaxMin endp


Start:
      ConsoleTitle offset T
      outstrln "Введите формулу"
      call MaxMin
      outint AL
      pause
      exit
end   Start
