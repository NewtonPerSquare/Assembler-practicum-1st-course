include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_10 (блок_1) 'Таблица умножения' ", 0
N     dd ?
.code
Start:
      ConsoleTitle offset T
      mov ECX, 11
      mov AL, 0
      mov AH, 0
      outstrln "Таблица умножения"
      outstrln "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
      outstrln "   |  0 |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 | 10 |"
L1:   dec ECX
      mov AL, 0
      outstrln "---|----|----|----|----|----|----|----|----|----|----|----|"
      outint AH, 3
      mov N, ECX
      mov ECX, 11 
L2:   outint AL,4,"|"
      add AL, AH
      loop L2
      outcharln "|"
      mov ECX, N
      inc AH
      cmp ECX, 0
      jNE L1
      outstrln "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
      pause                 
      exit                  
end   Start
