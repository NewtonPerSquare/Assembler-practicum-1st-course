include console.inc

.data
T     db " Паскаль Егор (группа 110) "
      db " Задача_3 (блок 2) 'Картинка' ",0     
S     db 20 dup ('-'),0
.code
Start:
      ConsoleTitle offset T
      inint ECX, "Введите K: "
      mov S[ECX], 0
      mov EAX, ECX
      lea EBX, S
L:    dec EAX
      mov S[EAX], '*'
      outstr EBX
      newline
      cmp EAX, 0
      jG L
      pause
      exit
end   Start
