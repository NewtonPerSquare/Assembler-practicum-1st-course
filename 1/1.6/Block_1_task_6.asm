include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_6 (����_1) '���e������ �����' ", 0

.code
Start:
      ConsoleTitle offset T 
      mov ECX, 0
      mov EAX, 0
      inchar CL, "������� ����� � ���������� ������� ��������� � �������� �� �����: "
      mov EBX, 5
L:    sub CL, "0"  ; ������������ ������� � ������������ ������� � ������� ����� �������
      mul EBX
      add EAX, ECX
      inchar CL
      cmp CL, " "
      jnE L
      cmp EDX, 0
      jE fin
      outword EDX
fin:  outword EAX ; ����� ����������
      outstr " - ���� ����� � ���������� ������� ���������"
      pause                 
      exit                  
end   Start
