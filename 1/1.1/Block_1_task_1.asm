include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_1 (блок_1) 'Степень тройки' ",0       
.code
Start:
      ConsoleTitle offset T 
      inintln EAX, "Введите проверяемое число: "
      cdq   
      mov EBX, 3    ; На эту тройку буду делить данное число
      mov CL, 0     ; K по блок-схеме
L:    cmp EAX, 1    ; проверка N=1
      jE fin
      cmp EDX, 0    ; проверка N mod 3 = 0
      jnE pfin 
      div EBX       
      inc CL        ; K = K + 1
      jmp L
      
pfin: mov CL, -1      
fin:  outint CL,,"Искомая степень: "    
      pause                 
      exit                  
end   Start
