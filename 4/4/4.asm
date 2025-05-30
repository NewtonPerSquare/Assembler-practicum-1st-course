include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_4 (блок 4) 'Переворот порядка слов' ",0
.code

Back proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push EDX
      
      mov EAX, [EBP+12]             ;из-за конструктивных особенностей программы, переменные подаются в обратном порядке. Извините!
      mov EBX, [EBP+8]
      mov EDX, 0
@L:   cmp EAX, EBX
      jAE @fin
      mov DL, [EAX]
      xchg DL, [EBX]
      mov [EAX], DL
      inc EAX
      dec EBX
      jmp @L
      
@fin: pop EDX
      pop EAX
      pop EAX
      pop EBP
      ret 4*2
Back endp


Start:
      ConsoleTitle offset T
      mov ECX, 0
      mov EAX, 0
input:inchar AL
      cmp AL, "."
      jE einpt
      mov S[ECX], AL
      inc ECX
      jmp input
einpt:dec ECX
      mov EDX, ECX
      push offset S
      add EDX, offset S
      push EDX
     
      call Back

      
      
      mov ESI, -1
L:    inc ESI
      cmp ESI, ECX
      jA ou
      cmp S[ESI], " "
      jE L
      mov EDX, ESI
      add EDX, offset S
      push EDX
L1:   inc ESI
      cmp ESI, ECX
      jA preou
      cmp S[ESI], " "
      jNE L1
      mov EDX, ESI
      dec EDX
      add EDX, offset S
      push EDX
      call Back
      jmp L
      
      
preou:mov EDX, ESI
      dec EDX
      add EDX, offset S
      call Back


ou:   mov EDX, 0
outpt:outchar S[EDX]
      inc EDX
      cmp EDX, ECX
      jBE outpt
      pause
      exit
end   Start
