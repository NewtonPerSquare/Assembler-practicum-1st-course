include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_доп1 (машинный выход_1) ",0       
.code
Start:
      ConsoleTitle offset T 
      inintln ECX, "Введите проверяемый год: "
      mov EAX, ECX
      mov EDX, 0
      mov EBX, 100
      div EBX
      cmp EDX, 0
      jnE next
      mov EDX, 0
      mov EBX, 4
      div EBX
      cmp EDX, 0
      jnE prt
next: mov EDX, 0
      mov EAX, ECX
      mov EBX, 4
      div EBX
      cmp EDX, 0
      jnE prt
print:outstr "Високосный"
      jmp fin
prt:  outstr "Обычный"      
fin:  pause                 
      exit                  
end   Start
