include console.inc

.data
N     equ 30
T     db " Паскаль Егор (группа 110) "
      db " Задача_8 (блок 2) 'палиндром?' ",0     
S     db N dup(?)
.code
Start:
      ConsoleTitle offset T
      outstr "Введите текст: "
      mov ECX, 0
L1:   inchar AL
      cmp AL, "."
      jE en
      cmp AL, " "
      jE skip
      cmp AL, "a"
      jB sk
      add AL, "A"-"a"
sk:   mov S[ECX], AL
      inc ECX
skip: jmp L1
en:   dec ECX
      mov EBX, 0
L2:   mov DL, S[EBX]
      cmp DL, S[ECX]
      jNE fail
      cmp EBX, ECX
      jAE good
      inc EBX
      dec ECX
      jmp L2
good: outstr "Палиндром"
      jmp fin
fail: outstr "Не палиндром"
fin:  pause
      exit
end   Start
