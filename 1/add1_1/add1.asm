include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_���1 (�������� �����_1) ",0       
.code
Start:
      ConsoleTitle offset T 
      inintln ECX, "������� ����������� ���: "
      mov EAX, ECX
      mov EDX, 0
      mov EBX, 100
      div EBX
      cmp EDX, 0
      jnE next
      mov EDX, 0
      mov EBX, 4
      div EBX
      cmp EDX, 0
      jnE prt
next: mov EDX, 0
      mov EAX, ECX
      mov EBX, 4
      div EBX
      cmp EDX, 0
      jnE prt
print:outstr "����������"
      jmp fin
prt:  outstr "�������"      
fin:  pause                 
      exit                  
end   Start
