include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_8 (����_1) '�������������� �����' ", 0
S      dw ?
.code
Start:
      ConsoleTitle offset T
      inchar AL, "������� �������� ����������: "
      sub AL, "0"
      cbw
      add S, AX
L:    inchar AL        ; ���������� �������� ����� � �����, � ����������� �� �����
      cmp AL, "+"      ; ����� ������������ � ���������� ��� ���������� �� ����
      jE L1            ; ����� ���� �������� �� �����, ��� ��������� �� �������
      cmp AL, "-"      ; ���������� ����� �� ����� � ����� ����������
      jE L2
      cmp AL, "."
      jE fin
L1:   inchar AL
      sub AL, "0"
      cbw
      add S, AX
      jmp L
L2:   inchar AL
      sub AL, "0"
      cbw
      sub S, AX
      jmp L
fin:  outint S,,"��������� ����� " 
      pause                 
      exit                  
end   Start
