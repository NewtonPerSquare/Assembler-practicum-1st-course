include console.inc

.data

T      db " Паскаль Егор (группа 110) "
       db " Задача_8 (блок_1) 'Алгебраическая сумма' ", 0
S      dw ?
.code
Start:
      ConsoleTitle offset T
      inchar AL, "Введите линейную комбинацию: "
      sub AL, "0"
      cbw
      add S, AX
L:    inchar AL        ; поочередно вводятся цифры и знаки, в зависимости от знака
      cmp AL, "+"      ; цифра прибавляется к результату или вычитается из него
      jE L1            ; также идет проверка на точку, при попадании на которую
      cmp AL, "-"      ; происходит выход из цикла и вывод результата
      jE L2
      cmp AL, "."
      jE fin
L1:   inchar AL
      sub AL, "0"
      cbw
      add S, AX
      jmp L
L2:   inchar AL
      sub AL, "0"
      cbw
      sub S, AX
      jmp L
fin:  outint S,,"Результат равен " 
      pause                 
      exit                  
end   Start
