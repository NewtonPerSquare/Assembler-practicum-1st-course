include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_1 (блок 2) 'Первые вхождения'",0       
LAT    db 'Z'-'A'+ 1 dup(0)
.code
Start:
      ConsoleTitle offset T 
      mov EAX,0 
      mov EBX, 0
      outstrln "Введите строку с точкой на конце: "            
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
