include console.inc

.data
N equ 100
S db N dup (?)
T     db " ������� ���� (������ 110) "
      db " ������_7 (���� 4) '������������� � ������������� �����' ",0
.code

PRINT proc
      push EAX
      
      inint EAX
      cmp EAX, 0
      jE @sk
      cmp EAX, 0
      jG @H
      outint EAX,, " "
      call PRINT
      jmp @sk
@H:   call PRINT
      outint EAX,, " "
@sk:  pop EAX
      ret 
PRINT endp


Start:
      ConsoleTitle offset T
      outstrln "������� �����"
      call PRINT
      pause
      exit
end   Start
