include console.inc

.data
N equ 100
S db N dup (?)
T     db " ������� ���� (������ 110) "
      db " ������_8 (���� 4) '���������� ����� ��������' ",0
.code

GCD proc
      push EBP
      mov EBP, ESP

      
      
      mov EAX, [EBP+8]
      mov EBX, [EBP+12]
      cmp EAX, EBX
      jE @fin
      jA @sk
      xchg EAX, EBX
@sk:  sub EAX, EBX
      push EAX
      push EBX
      call GCD
      
@fin: pop EBP
      ret 4*2
GCD endp


Start:
      ConsoleTitle offset T
      outstrln "������� �����"
      inint EAX
      inint EBX
      push EBX
      push EAX
      call GCD
      newline
      outint EAX,,"GCD="
      pause
      exit
end   Start
