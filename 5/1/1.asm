include console.inc

.data
T     db " ������� ���� (������ 110) "
      db " ������_1 (���� 5) '����-����� ��������� �����' ",0
.code




Start:
      ConsoleTitle offset T
      outstrln "������� �����: "
      xor EAX, EAX
input:inchar DL
      cmp DL, " "
      jE endin
      sub DL, "0"
      shl EAX, 1
      or AL, DL
      jmp input
endin:mov ECX, 32
out1: xor DL, DL
      shl EAX, 1
      adc DL, 0
      loopZ out1
      jECXz onedg
out2: outint DL
      mov DL, 0
      shl EAX, 1
      adc DL, 0
      loop out2
      outint DL
      jmp fin
onedg:outint DL
fin:  pause
      exit
end   Start
