include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_3 (блок 3) 'Округление' ",0
m     db ?
.code
Start:
      ConsoleTitle offset T
      mov EAX, 0
      outintln ESP,,"ESP до "
      outstrln "Введите число X"
      push "0"                    ;запасная цифра (для случая, когда образуется новый разряд)
      mov ESI, ESP
      sub ESI, 4                ;начало целой части
input:inchar AL
      cmp AL, "."
      jne sk1
      inchar AL
      cmp AL, " "
      jE err
      cmp AL, "0"
      jB err
      cmp AL, "9"
      jA err
      push EAX
      mov EDI, ESP                 ;начало дробной части
      jmp input
sk1:  cmp AL, " "
      jE ou
      cmp AL, "0"
      jB err
      cmp AL, "9"
      jA err
      push EAX
      jmp input
      
ou:   inintln m, "Введите число m: "

      mov ECX, 0
      mov CL, m
      mov AL, 4
      mul CL
      sub EAX, EDI
      neg EAX
      add EAX, 4              ;вычислили адрес последней цифры
     
zrs:  cmp EAX, ESP            ;дополняем нулями в случае их нехватки
      jA corr
      push "0"
      jmp zrs
       
corr:
      push EAX                ;адрес цифры, следующей за последней
      mov ECX, ESI
      cmp byte ptr[EAX-4], "5"      ;проверка на необходимость округления
      jB ou1
L1:   inc byte ptr[EAX]
      cmp byte ptr[EAX], "9"        ;последующие изменения числа, в случае его округления
      jBE ou1
      sub byte ptr[EAX], 10
      add EAX, 4
      jmp L1 
ou1:  pop EAX
      cmp byte ptr [ESI+4], "1"        ;проверяем, нужно ли выводить запасённый нами разряд
      jNE outpt
      outchar "1"
outpt:outchar byte ptr [ECX]           ;вывод целой части
      sub ECX, 4
      cmp ECX, EDI
      jA outpt
      cmp m, 0                        ;проверка на необходимость вывода дробной части числа
      jE fin
      outchar "."
ou2:  outchar byte ptr [EDI]              ;вывод дробной части числа
      sub EDI, 4
      cmp EDI, EAX
      jAE ou2
      jmp fin
err:  outstrln "Ошибка в записи числа."
fin:  newline
      mov ESP, ESI
      add ESP, 8                    ;восстановили ESP
      outintln ESP,, "ESP после "
      pause
      exit
end   Start
