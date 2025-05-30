include console.inc

extern A: dword, B: dword, Z: qword
public check


.code
check:mov EAX, A
      mov EBX, B
      mul EBX
      mov dword ptr Z+4, EDX
      mov dword ptr Z, EAX
      outwordln Z
      pause
      exit
end