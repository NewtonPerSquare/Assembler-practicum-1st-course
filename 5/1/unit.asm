.686
.model Flat,stdcall

public Power2


.code
Power2 proc public
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push ESI
      mov EAX, [EBP+8]        ;значение Х
      mov ESI, [EBP+12]       ;ссылка Rez
      mov byte ptr[ESI], -1
      mov EBX, 1b
      mov ECX, 0
@L:   xor EAX, EBX
      jZ @rez
      mov EAX, [EBP+8]
      shl EBX, 1
      inc ECX
      cmp ECX, 32
      jB @L
      jmp @fin
@rez: mov byte ptr[ESI], CL
@fin: pop ESI
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*2
Power2 endp
end
