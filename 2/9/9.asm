include console.inc

.data
N     equ 4
M     equ 6
T     db " ������� ���� (������ 110) "
      db " ������_9 (���� 2) '����������� ������� �������' ",0     
A     dd N dup(M dup(?))
.code
Start:
      ConsoleTitle offset T
      outstr "������� ������: "
      mov ESI, 1
      inint A[0]
      mov EBX, A[0] ;���������� �������
      mov ECX, 1    ;������� ����������� ���������
L1:   inint A[4*ESI]
      cmp A[4*ESI], EBX
      jGE BorE
      mov EBX, A[4*ESI]
      mov ECX, 1
      jmp B
BorE: jG B
      inc ECX
B:    inc ESI
      cmp ESI, N*M
      jNE L1
      outint EBX,, "����������� ������� "
      outint ECX,," ������ "
      outstr " ���"
      newline
      outstr "������� ��� ���������: "
      mov ECX, 0
      mov EDI, 1
L2:   mov EDX, 0
L3:   cmp EBX, A[ECX][4*EDX]
      jNE skip
      outint EDI,, "["
      inc EDX
      outint EDX,, ","
      dec EDX
      outstr "] "
skip: inc EDX
      cmp EDX, M
      jB L3
      add ECX, 4*M
      inc EDI
      cmp EDI, N
      jBE L2 
      pause
      exit
end   Start
