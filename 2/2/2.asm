include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_2 (���� 2) '����� � �������' ",0     
z2     db '����', 0
z3     db '�����', 0
z4     db '������', 0
z5     db '�������', 0     
adr    dd z2, z3, z4, z5    
.code
Start:
      ConsoleTitle offset T 
      inint EBX, "������� ������: "
      mov EBX, [adr][4*EBX-8]
      outstrln EBX
      pause                 
      exit                  
end   Start
