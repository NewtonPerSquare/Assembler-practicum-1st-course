include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_1 (���� 2) '������ ���������'",0       
LAT    db 'Z'-'A'+ 1 dup(0)
.code
Start:
      ConsoleTitle offset T 
      mov EAX,0 
      mov EBX, 0
      outstrln "������� ������ � ������ �� �����: "            
L1:   inchar AL             
      cmp AL,'.'
      jE fin
      inc LAT[EAX-'A']
      mov BL, LAT[EAX-'A']                       
      cmp EBX, 1
      jNE L1
      outchar AL
      jmp L1
fin:  pause                 
      exit                  
end   Start
