include console.inc

.data
N equ 100
S db N dup (?)
T     db " ������� ���� (������ 110) "
      db " ������_6 (���� 4) '����� ��������' ",0
.code

REVERSE proc
      push EAX
      
      mov EAX, 0
      inchar AL
      cmp AL, "."
      jE @sk
      call REVERSE
      outchar AL
@sk:  pop EAX
      ret 
REVERSE endp


Start:
      ConsoleTitle offset T
      outstrln "������� �����"
      call REVERSE
      pause
      exit
end   Start
