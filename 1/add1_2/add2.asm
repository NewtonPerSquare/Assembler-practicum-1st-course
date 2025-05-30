include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_���2 (�������� �����_1) ",0       
.code
Start:
      ConsoleTitle offset T 

      mov ECX, 0 ; ������ � ECX ������� �������� ��� �������
      mov BH, '0'
      mov DL, 0
      inchar AL, "������� ����� � �������� �� �����: " ; ���� 1�� �������
      cmp AL, '0'
      jE next
      inc ECX 
      mov BL, AL  
      cmp AL, '0'
      jB prt
      cmp AL, '9' 
      jA prt
      jmp L
next: inchar BL ; ���� ��������� ��������
L:    cmp BL, ' '            
      jE right 
      cmp BL, 'h'     
      jE chk0
      cmp BL, 'a' ; "A"<"a"
      jB chk2          
      cmp BL, 'f'
      jA prt
      jmp skip
chk2: cmp BL, 'A'
      jB dig
      cmp BL, 'F'
      jA prt
skip: cmp BL, 'A'
      jAE chk1 
dig:  cmp BL, '0' 
      jB prt
      cmp BL, '9'
      jA prt
      jmp chk1
chk0: inc DL ; ������� ���� h
      cmp DL, 1
      jA prt
chk1: mov BH, BL  
      inc ECX
      cmp ECX, 10 ; �������� �����
      jA prt
      jmp next 
right:cmp BH, 'h' ; �������� "h"
      jNE prt
      outstrln "Yes"
      jmp en  
prt:  outstrln "No"
en:   pause                 
      exit                  
end Start
