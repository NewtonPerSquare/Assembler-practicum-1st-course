include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_9 (����_1) '������ � ��������� �����' ", 0
.code
Start:
      ConsoleTitle offset T
      outstrln "������� �������� ������������������ �������� ����"
      mov ECX, 0   ; �������
L1:   inchar BL
      mov AL, BL   ; � AL ����� ��������� ������ ����� �����, � BL - ��������� ��������
L2:   mov AH, BL   ; � � AH - ������������� �������� (��� ������, ����� ����� �������
      inchar BL    ; �������, ����� ������������ � ��� ��������� ����� ����� 
      cmp BL, ","
      jE L3
      cmp BL, "."
      jE L3
      jmp L2
L3:   cmp AL, AH
      jNE N
      inc ECX
N:    cmp BL, "."
      jNE L1
      outwordln ECX,, "���������� ���� � ���������� ������ � ��������� ������: "
      pause                 
      exit                  
end   Start
