include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_5 (���� 2) '���������� 16-� �����' ",0     
arr    db 8 dup('0')
       db 0
.code
Start:
      ConsoleTitle offset T
      mov ECX, 8
      mov EBX, 16
      inint EAX, "������� ����� �� ��������� [-2^31..2^32-1]: "
L:    mov EDX, 0
      div EBX
      cmp EDX, 10
      jG chr
      add DL, "0"
      jmp skip
chr:  sub DL, 10
      add DL, "A"
skip: mov arr[ECX]-1, DL
      loop L
      lea EDX, [arr]
      outstr EDX
      pause                 
      exit                  
end   Start
