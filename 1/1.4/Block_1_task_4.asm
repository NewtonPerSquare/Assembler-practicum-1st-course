include console.inc

.data

T     db " ������� ���� (������ 110) "
      db " ������_4 (����_1) '����� P/Q' ", 0
P     dd ? ; P>=0
Q     dd ? ; Q>0
.code
Start:
      ConsoleTitle offset T
      inintln P, "������� ����� P: "
      inintln Q, "������� ����� Q: "
      mov EAX, P      ;������� � ����� ����� ����� ����� � �����
      cdq
      div Q
      outint EAX
      outchar "."
      mov ECX, 5
      mov EBX, 10
L:    mov EAX, EDX    ;������� � ����� ������� ����� �����
      mul EBX
      div Q
      outint EAX
      loop L
      pause                 
      exit                  
end   Start
