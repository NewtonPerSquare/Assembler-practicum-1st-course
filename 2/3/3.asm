include console.inc

.data
T     db " ������� ���� (������ 110) "
      db " ������_3 (���� 2) '��������' ",0     
S     db 20 dup ('-'),0
.code
Start:
      ConsoleTitle offset T
      inint ECX, "������� K: "
      mov S[ECX], 0
      mov EAX, ECX
      lea EBX, S
L:    dec EAX
      mov S[EAX], '*'
      outstr EBX
      newline
      cmp EAX, 0
      jG L
      pause
      exit
end   Start
