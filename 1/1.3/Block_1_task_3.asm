include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_3 (����_1) '������ ������' ", 0
S      db "���", 0, "��", 0
.code
Start:
      ConsoleTitle offset T 
      mov EDX, offset S
      mov AL, 0
      inchar BL, " ������� ������������������ �������� � ������ �� �����: "
L:    cmp BL, "." ; �������� �� �����
      jE pfin
      cmp BL, "(" ; �������� �� ����������� ������
      jNE L1
      inc AL
      jmp Lend
L1:   cmp BL, ")" ; �������� �� ����������� ������
      jNE Lend
      dec AL
      cmp AL, 0   ; �������� �� ��������������� ��������
      jL fin
Lend: inchar BL
      jmp L
pfin: cmp AL, 0            ; ����� ����������
      JNE fin
      mov EDX, offset S+4 
fin:  outstrln EDX  
      pause                 
      exit                  
end   Start
