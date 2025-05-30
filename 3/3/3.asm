include console.inc

.data

T     db " ������� ���� (������ 110) "
      db " ������_3 (���� 3) '����������' ",0
m     db ?
.code
Start:
      ConsoleTitle offset T
      mov EAX, 0
      outintln ESP,,"ESP �� "
      outstrln "������� ����� X"
      push "0"                    ;�������� ����� (��� ������, ����� ���������� ����� ������)
      mov ESI, ESP
      sub ESI, 4                ;������ ����� �����
input:inchar AL
      cmp AL, "."
      jne sk1
      inchar AL
      cmp AL, " "
      jE err
      cmp AL, "0"
      jB err
      cmp AL, "9"
      jA err
      push EAX
      mov EDI, ESP                 ;������ ������� �����
      jmp input
sk1:  cmp AL, " "
      jE ou
      cmp AL, "0"
      jB err
      cmp AL, "9"
      jA err
      push EAX
      jmp input
      
ou:   inintln m, "������� ����� m: "

      mov ECX, 0
      mov CL, m
      mov AL, 4
      mul CL
      sub EAX, EDI
      neg EAX
      add EAX, 4              ;��������� ����� ��������� �����
     
zrs:  cmp EAX, ESP            ;��������� ������ � ������ �� ��������
      jA corr
      push "0"
      jmp zrs
       
corr:
      push EAX                ;����� �����, ��������� �� ���������
      mov ECX, ESI
      cmp byte ptr[EAX-4], "5"      ;�������� �� ������������� ����������
      jB ou1
L1:   inc byte ptr[EAX]
      cmp byte ptr[EAX], "9"        ;����������� ��������� �����, � ������ ��� ����������
      jBE ou1
      sub byte ptr[EAX], 10
      add EAX, 4
      jmp L1 
ou1:  pop EAX
      cmp byte ptr [ESI+4], "1"        ;���������, ����� �� �������� ��������� ���� ������
      jNE outpt
      outchar "1"
outpt:outchar byte ptr [ECX]           ;����� ����� �����
      sub ECX, 4
      cmp ECX, EDI
      jA outpt
      cmp m, 0                        ;�������� �� ������������� ������ ������� ����� �����
      jE fin
      outchar "."
ou2:  outchar byte ptr [EDI]              ;����� ������� ����� �����
      sub EDI, 4
      cmp EDI, EAX
      jAE ou2
      jmp fin
err:  outstrln "������ � ������ �����."
fin:  newline
      mov ESP, ESI
      add ESP, 8                    ;������������ ESP
      outintln ESP,, "ESP ����� "
      pause
      exit
end   Start
