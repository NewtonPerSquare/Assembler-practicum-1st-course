include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_2 (блок 3) 'Max/Min' ",0     
.code
Start:
      ConsoleTitle offset T
      outstrln "Введите выражение"
      mov EAX, 0
L:    inchar AL
      cmp AL, "0"
      jB sk1
      cmp AL, "9"
      jA sk1
      sub AL, "0"
      push EAX
      jmp L
sk1:  cmp AL, "("
      jE L
      cmp AL, ","
      jE L
      cmp AL, "m"
      jNE sk2
      push EAX
      jmp L
sk2:  cmp AL, "M"
      jNE sk3
      push EAX
      jmp L
sk3:  cmp AL, ")"
      jNE sk
      pop EDX
      pop ECX
      pop EBX
      cmp EBX, "M"
      jne sks
      cmp EDX, ECX
      jA sM
      xchg EDX, ECX
sM:   push EDX
      jmp L
sks:  cmp EBX, "m"
      jne sk
      cmp EDX, ECX
      jB sm
      xchg EDX, ECX
sm:   push EDX
      jmp L
sk:   cmp AL, "."
      jne L
      pop EBX
      outint EBX
      pause
      exit
end   Start
