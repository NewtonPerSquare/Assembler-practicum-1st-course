include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_7 (����_1) '��������� �����, ������� ����' ", 0
.code
Start:
      ConsoleTitle offset T 
      inint EBX, "������� �����: "
      mov EAX, EBX
      mov EDX, 0
      mov ESI, 7
      div ESI
      cmp EDX, 4     ; �������� �������: ���� ������� EDX <= 3, �� ��������� �������
      jGE L1         ; ���� ����� ����� �� EDX ������ ��������� ����� (� �.�. ��� EDX=0)
      sub EBX, EDX   ; �����, ��������� ����� �� 7-EDX ������ ���������
      jmp L
L1:   add EBX, 7
      sub EBX, EDX
L:    outword EBX,, "��������� ������� 7 �����: "      
      pause                 
      exit                  
end   Start
