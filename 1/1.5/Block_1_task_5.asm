include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_5 (����_1) '������������ ������� � ������� ���������� ����' ", 0

.code
Start:
      ConsoleTitle offset T 
      inint EAX, "������� �����: "
      cdq
      mov ESI, 10
      div ESI
      mov BL, DL ; ��������� ������� �����
L:    cmp EAX, 0 ; ���� � ��������� ������� �����
      jE fin
      mov EDX, 0
      div ESI
      jmp L
fin:  mov BH, DL ; ����� � ������� �������� ���������
      mov AL, BL
      mul BH
      outint BL
      outint BH,, "*"
      outint AX,, " = "
      pause                 
      exit                  
end   Start
