include console.inc

.data

T     db " ������� ���� (������ 110) "
      db " ������_4b (���� 3) '������� �.2' ",0
.code
Start:
      ConsoleTitle offset T
      outintln ESP,,"ESP ��: "
      mov EDX, ESP      ;��������� ESP
      mov ECX, 0
      mov EAX, 0
      mov ESI, ESP
      sub ESI, 4             ;������ ������� �����
      outstrln "������� ������ �����: "
inp:  inint EAX         ;������ ������ ����� (� � ���� � �� ������)
      cmp AL, 0
      jE endin
      inc ECX
      push ECX
      push EAX
      jmp inp
endin:push ESI          ;���������� ������ �������� ���� �� ����� ������������
      mov EBX, 0
L1:   mov EAX, [ESI-4]
      mov ECX, [ESI]
      push ESI
      sub ESI, 4
L2:   sub ESI, 8

      cmp ESI, ESP
      jBE endch
      cmp EAX, [ESI]

      jA L2
      jmp lower
endch:outint EAX              ;���� ��� ���� ���� ����� ������, �� �������
      outintln ECX,, " "
lower:pop ESI                 ;��������� ���
      sub ESI, 8
      cmp ESI, ESP
      jA L1
      mov ESP, EDX            ;������������ ESP
      outint ESP,,"ESP �����:"
      pause
      exit
end   Start
