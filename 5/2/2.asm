include console.inc

.data
T     db " ������� ���� (������ 110) "
      db " ������_2 (���� 5) '����-����� ������������������ �����' ",0
      dig16 db '0123456789ABCDEF'
.code




Start:
      ConsoleTitle offset T
      outstrln "������� �����: "
      xor EAX, EAX
input:inchar BL
      cmp BL, " "
      jE endin
      cmp BL, "9"
      jBE skip
      sub BL, "A"
      add BL, 10
      shl EAX, 4
      or AL, BL
      jmp input
skip: sub BL, "0"
      shl EAX, 4
      or AL, BL
      jmp input
endin:mov ECX, 8
outpt:rol EAX, 4
      mov EBX, EAX
      and EBX, 1111b
      outchar dig16[EBX]
      loop outpt
      pause
      exit
end   Start
