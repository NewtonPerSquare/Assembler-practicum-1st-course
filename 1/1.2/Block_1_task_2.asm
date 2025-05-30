include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_2 (блок_1) 'Простое число' ",0
S      db "Составное",0,"Простоe",0       
N      dd ? 
.code
Start:
      ConsoleTitle offset T 
      mov ESI, offset S
      inintln N, "Введите проверяемое число: "
      cmp N, 2
      jLE pfin
      mov EAX, N 
      cdq
      mov EBX, 2 
      div EBX     
      mov EDI, EAX; В EDI теперь находится N div 2, последний делитель из цикла
 L:   cmp EDX, 0  ; если остаток от деления 0, значит число делится нацело, т.е. составное
      jE fin
      mov EAX, N  ; восстанавливаем EAX
      cdq
      inc EBX     ; следующий делитель
      cmp EBX, EDI
      jG pfin     ; конец цикла
      div EBX
      jmp L
pfin: mov ESI, offset S+10      
fin:  outstrln ESI      
      pause                 
      exit                  
end   Start
