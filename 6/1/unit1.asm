include console.inc

.code

In4 proc public
      push EBP
      mov EBP, ESP
      push ESI
      push EAX
      push EBX
      mov ESI, [EBP+8]
      xor EAX, EAX
      xor EBX, EBX
@inpt:inchar BL
      cmp BL, " "
      jE @fin
      sub BL, "0"
      shl EAX, 2
      or EAX, EBX
      jmp @inpt
@fin: mov [ESI], EAX
      pop EBX
      pop EAX
      pop ESI
      pop EBP
      ret 4
In4 endp

Out4 proc public
      push EBP
      mov EBP, ESP
      push EAX
      mov ECX, 0

      mov EAX, [EBP+8]
@tr:  add ECX, 2
      rol EAX, 2
      test EAX, 11b
      jNZ @next
      cmp ECX, 32
      jmp @tr
@next:;outint Cl,,' CL '
      mov EAX, [EBP+8]
      rol EAX, CL
      and EAX, 11b
      outint EAX
      add ECX, 2
      cmp ECX, 32
      jBE @next
      pop EAX
      pop EBP
      ret 4
Out4 endp



end 