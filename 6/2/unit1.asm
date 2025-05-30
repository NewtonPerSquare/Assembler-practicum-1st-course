include console.inc

.code

Mult proc public
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push ESI
      
      mov EAX, [EBP+8]
      mov EBX, [EBP+12]
      mov ESI, [EBP+16]
      
      mov dword ptr [ESI], 0
      mov dword ptr [ESI+4], 0
      mov ECX, 31
@L:   shl dword ptr [ESI+4], 1
      shl dword ptr [ESI], 1
      adc dword ptr [ESI+4], 0
      shl EBX, 1
      jNC @skip
      add dword ptr [ESI], EAX
      adc dword ptr [ESI+4], 0
@skip:dec ECX
      cmp ECX, 0
      jGE @L
      pop ESI
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
Mult endp


end 