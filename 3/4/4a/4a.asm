include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_4a (блок 3) 'Рассвет ч.1' ",0
.code
Start:
      ConsoleTitle offset T
      outintln ESP,,"ESP до: "
      mov ECX, 0
      mov EAX, 0
      outstrln "Введите высоты домов: "
inp:  inint EAX   ;вводим высоты домов (а с ними и их номера)
      cmp AL, 0
      jE endin
      inc ECX
      push ECX
      push EAX
      jmp inp
endin:mov EBX, 0        ;храним максимум по высоте и сравниваем с текущим домом
outpt:pop EAX
      pop ECX
      cmp EAX, EBX
      jBE sk
      mov EBX, EAX
      outint EAX
      outintln ECX,, " "
sk:   cmp ECX, 1
      jA outpt
      
      outint ESP,,"ESP после:"
      pause
      exit
end   Start
