include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_1 (блок 3) 'Алгебраическая сумма' ",0     
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
      cmp AL, "-"
      jNE sk2
      push EAX
      jmp L
sk2:  cmp AL, "+"
      jNE sk3
      push EAX
      jmp L
sk3:  cmp AL, ")"
      jNE sk
      pop EDX
      pop ECX
      pop EBX
      cmp ECX, "+"
      jne sks
      add EBX, EDX
      push EBX
      jmp L
sks:  cmp ECX, "-"
      jne sk
      sub EBX, EDX
      push EBX
      jmp L
sk:   cmp AL, "."
      jne L
      pop EBX
      outint EBX
      pause
      exit
end   Start
