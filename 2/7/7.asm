include console.inc

.data
N     equ 30
T     db " ������� ���� (������ 110) "
      db " ������_7 (���� 2) '���������� ���������' ",0     
X     dd N dup(?)
.code
Start:
      ConsoleTitle offset T
      inint ECX, "������� ����������� �������: "
      mov EAX, 0
      outstr "������� ������: "
input:inint X[4*EAX]
      inc EAX
      cmp EAX, ECX
      jB input
      
      
      mov EBX, ECX
L1:   dec EBX
      mov ESI, 0
      mov EAX, 0
L2:   mov EDX, X[4*EAX]
      cmp EDX, X[4*EAX+4]
      jLE skip
      xchg EDX, X[4*EAX+4]
      mov X[4*EAX], EDX
      inc ESI
      
skip: inc EAX
      cmp EAX, EBX
      jNE L2
      cmp ESI, 0
      jE fin
      cmp EBX, 1
      jG L1
      
fin:  mov EAX, 0
      outstr "��������������� ������:"
outpu:outint X[4*EAX],," "
      inc EAX
      cmp EAX, ECX
      jB outpu
      pause
      exit
end   Start
