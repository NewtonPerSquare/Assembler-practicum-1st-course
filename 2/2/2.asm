include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_2 (блок 2) 'Зачёт с оценкой' ",0     
z2     db 'неуд', 0
z3     db 'удовл', 0
z4     db 'хорошо', 0
z5     db 'отлично', 0     
adr    dd z2, z3, z4, z5    
.code
Start:
      ConsoleTitle offset T 
      inint EBX, "Введите оценку: "
      mov EBX, [adr][4*EBX-8]
      outstrln EBX
      pause                 
      exit                  
end   Start
