include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_4 (блок 2) 'Знаковое 10-е число' ",0     
arr    db 10 dup('0')
       db 0
.code
Start:
      ConsoleTitle offset T
      mov ECX, 10
      mov EBX, 10
      inint EAX, "Введите число из диапозона [-2^31..2^32-1]: "
      cmp EAX, 0
      jG L
      neg EAX
      outchar "-"
L:    mov EDX, 0
      div EBX
      add DL, "0"
      mov arr[ECX]-1, DL
      cmp EAX, 0
      loopne L
      lea EDX, [arr]
      add EDX, ECX
      outstr EDX
      pause                 
      exit                  
end   Start
