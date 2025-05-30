include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_4b (блок 3) 'Рассвет ч.2' ",0
.code
Start:
      ConsoleTitle offset T
      outintln ESP,,"ESP до: "
      mov EDX, ESP      ;сохранили ESP
      mov ECX, 0
      mov EAX, 0
      mov ESI, ESP
      sub ESI, 4             ;первый элемент стека
      outstrln "Введите высоты домов: "
inp:  inint EAX         ;вводим высоты домом (а с ними и их номера)
      cmp AL, 0
      jE endin
      inc ECX
      push ECX
      push EAX
      jmp inp
endin:push ESI          ;сравниваем высоту текущего дома со всеми последующими
      mov EBX, 0
L1:   mov EAX, [ESI-4]
      mov ECX, [ESI]
      push ESI
      sub ESI, 4
L2:   sub ESI, 8

      cmp ESI, ESP
      jBE endch
      cmp EAX, [ESI]

      jA L2
      jmp lower
endch:outint EAX              ;если дом выше всех домов правее, то выводим
      outintln ECX,, " "
lower:pop ESI                 ;следующий дом
      sub ESI, 8
      cmp ESI, ESP
      jA L1
      mov ESP, EDX            ;восстановили ESP
      outint ESP,,"ESP после:"
      pause
      exit
end   Start
