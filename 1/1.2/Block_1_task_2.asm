include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_2 (����_1) '������� �����' ",0
S      db "���������",0,"������e",0       
N      dd ? 
.code
Start:
      ConsoleTitle offset T 
      mov ESI, offset S
      inintln N, "������� ����������� �����: "
      cmp N, 2
      jLE pfin
      mov EAX, N 
      cdq
      mov EBX, 2 
      div EBX     
      mov EDI, EAX; � EDI ������ ��������� N div 2, ��������� �������� �� �����
 L:   cmp EDX, 0  ; ���� ������� �� ������� 0, ������ ����� ������� ������, �.�. ���������
      jE fin
      mov EAX, N  ; ��������������� EAX
      cdq
      inc EBX     ; ��������� ��������
      cmp EBX, EDI
      jG pfin     ; ����� �����
      div EBX
      jmp L
pfin: mov ESI, offset S+10      
fin:  outstrln ESI      
      pause                 
      exit                  
end   Start
