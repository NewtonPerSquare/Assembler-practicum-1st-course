include console.inc

.data

T     db " ������� ���� (������ 110) "
      db " ������_4a (���� 3) '������� �.1' ",0
.code
Start:
      ConsoleTitle offset T
      outintln ESP,,"ESP ��: "
      mov ECX, 0
      mov EAX, 0
      outstrln "������� ������ �����: "
inp:  inint EAX   ;������ ������ ����� (� � ���� � �� ������)
      cmp AL, 0
      jE endin
      inc ECX
      push ECX
      push EAX
      jmp inp
endin:mov EBX, 0        ;������ �������� �� ������ � ���������� � ������� �����
outpt:pop EAX
      pop ECX
      cmp EAX, EBX
      jBE sk
      mov EBX, EAX
      outint EAX
      outintln ECX,, " "
sk:   cmp ECX, 1
      jA outpt
      
      outint ESP,,"ESP �����:"
      pause
      exit
end   Start
