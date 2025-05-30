include console.inc

.data
T     db " Паскаль Егор (группа 110) "
      db " Задача_3 (блок 5) 'Анализ и преобразование двоичного числа' ",0
.code




Start:
      ConsoleTitle offset T
      mov ECX, 8
      xor EAX, EAX
      xor EBX, EBX
input:push ECX
      mov ECX, 4
in4:  inchar DL
      sub DL, "0" 
      or AL, DL
      or BL, DL
      rol EAX, 1
      ror EBX, 1
      loop in4
      pop ECX
      inchar DL   ;для пробела
      loop input
      ror EAX, 1
      mov EDX, EAX
      xor EDX, EBX
      cmp EDX, 0
      jNE ns
      outstrln "СИММЕТРИЧНАЯ"
      rol EAX, 16
      xor ECX, ECX
L:    inc ECX
      rol EAX, 1
      jC conv
      cmp ECX, 16
      jB L
      jmp s
conv: xor EAX, 1
      ror EAX, CL
      ror EAX, CL
      rol EAX, 1
      xor EAX, 1
      ror EAX, 1
      rol EAX, CL
      ror EAX, 16
      jmp s
      
ns:   outstrln "НЕ СИММЕТРИЧНАЯ"
      xor DL, DL
      xor CL, CL
      ror EAX, 1
      adc CL, 0   ;r
      rol EAX, 2
      adc DL, 0   ;l
      ror EAX, 1
      cmp CL, 1
      jE skip1
      and EAX, not 1
skip1:cmp DL, 1
      jE skip2
      rol EAX, 1
      and EAX, not 1
      ror EAX, 1
skip2:
s:    mov ECX, 8
outrz:push ECX
      mov ECX, 4
out4: mov DL, 0
      ror EAX, 1
      adc DL, 0
      outint DL
      loop out4
      pop ECX
      outchar " "
      dec ECX
      jNZ outrz
      pause
      exit
end   Start
