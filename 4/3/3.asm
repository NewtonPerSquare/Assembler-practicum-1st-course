include console.inc

.data
MaxSize equ 150
n db ?
m db ?
X dw MaxSize dup(?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_3 (блок 4) 'Матрицы прямоугольные и квадратные' ",0
.code
Output proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X

      outstrln "Ваш массив: "
      mov ECX, 0
      mov EDX, 0
@L0:  outint word ptr [ESI][2*ECX],, " "
      inc ECX
      cmp ECX, EBX
      jNE @L0
      newline
      add ESI, EBX
      add ESI, EBX
      mov ECX, 0
      inc EDX
      cmp EDX, EAX
      jNE @L0
      newline
      
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
Output endp

p1 proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
      outstrln "Пункт 1: "
      mov ECX, 0
      mov EDX, 0
      mov DI, word ptr[ESI]
@L1:  cmp DI, word ptr [ESI][2*ECX]
      jA @F
      mov DI, word ptr [ESI][2*ECX]
      inc ECX
      cmp ECX, EBX
      jNE @L1
      inc EDX
      outint EDX,, " "
      dec EDX
@@:   add ESI, EBX
      add ESI, EBX
      mov ECX, 0
      mov DI, word ptr [ESI]
      inc EDX
      cmp EDX, EAX
      jNE @L1
      newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p1 endp


p2 proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
      outstrln "Пункт 2: "
      mov ECX, 0
      mov EDX, 0
@L2:  push EAX
      mov EAX, EBX
      sub EAX, ECX
      dec EAX
      cmp EAX, ECX
      jBE @L21
      
      mov DI, word ptr [ESI][2*EAX] 
      cmp DI, word ptr [ESI][2*ECX]
      jNE @F
      inc ECX
      pop EAX
      jmp @L2
@L21: inc EDX
      outint EDX,, " "
      dec EDX
@@:   pop EAX
      add ESI, EBX
      add ESI, EBX
      mov ECX, 0
      mov DI, word ptr [ESI]
      inc EDX
      cmp EDX, EAX
      jB @L2
      newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p2 endp

p3 proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
      outstrln "Пункт 3: "
      mov ECX, 0
      push EAX
      mov EDX, EBX
      mul EDX
      mov EDX, EAX
      dec EDX
      add EDX, EDX
      pop EAX
      
      
      
@L3:  mov DI, [ESI][ECX]
@L31: cmp DI, [ESI][ECX]
      jNE @F
      add ECX, EBX
      add ECX, EBX
      cmp ECX, EDX
      jB @L31
      push ESI
      sub ESI, [EBP+8]
      push EAX
      push EDX
      mov EAX, ESI
      mov EDX, 0
      mov ESI, 2
      div ESI
      mov ESI, EAX
      inc ESI
      outint ESI,, " "
      pop EDX
      pop EAX
      pop ESI
@@:   add ESI, 2
      push ESI
      push EBX
      add EBX, EBX
      sub ESI, [EBP+8]
      mov ECX, 0
      cmp ESI, EBX
      pop EBX
      pop ESI
      jB @L3
      newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p3 endp


p4 proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
      outstrln "Пункт 4: "
      mov ECX, 0
      push EAX
      mov EDX, EBX
      mul EDX
      mov EDX, EAX
      dec EDX
      add EDX, EDX
      pop EAX
      mov ECX, 0
@L4:  outint word ptr[ESI][ECX],, " "
      add ECX, EBX
      add ECX, EBX
      add ECX, 2
      cmp ECX, EDX
      jBE @L4
      newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p4 endp


p5 proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      mov EBX, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
      outstrln "Пункт 5: "
      mov ECX, 0
      push EAX
      mov EDX, EBX
      mul EDX
      mov EDX, EAX
      dec EDX
      add EDX, EDX
      pop EAX
      mov ECX, EBX
      add ECX, EBX
      sub ECX, 2
@L5:  outint word ptr[ESI][ECX],, " "
      add ECX, EBX
      add ECX, EBX
      sub ECX, 2
      cmp ECX, EDX
      jB @L5
      newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p5 endp

p6 proc                                         ;переделывал из допа-2, поэтому регистры используются по-другому 
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      push ESI
      push EDI
      
      outstrln "Пункт 6: "
      mov EDI, [EBP+16]             ;m
      mov EAX, [EBP+12]             ;n
      mov ESI, [EBP+8]              ;адрес X
     
      cmp EDI, EAX
      jNE @ou
      
      mov EAX, 0
      mov EBX, 0
      mov ECX, 0
      mov EDX, 0
@L61: push ECX
@L62: push EDI
      push ESI
      add ESI, EDX
      mov DI, word ptr[ESI][2*ECX]
      pop ESI
      push ESI
      add ESI, EAX
      cmp DI, word ptr[ESI][EBX]
      pop ESI
      pop EDI
      jNE @ou
      inc ECX
      lea EBX, [2*EDI][EBX]
      cmp ECX, EDI
      jB @L62
      mov EBX, 0
      lea EAX, [2*EDI+2][EAX]
      lea EDX, [2*EDI][EDX]
      pop ECX
      inc ECX
      cmp ECX, EDI
      jB @L61
      outstr "Симметричная"
      jmp @fin
@ou:  outstr "Не симметричная"  
@fin: newline
      pop EDI
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 4*3
p6 endp


Start:
      ConsoleTitle offset T
      outstrln "Реализованы пункты 1-6"
again:inintln n,"Введите количество строк: "
      inintln m,"Введите количество столбцов: "
      movzx EAX, n
      movzx EBX, m
      cmp EAX, 1
      jBE err
      cmp EBX, 1
      jBE err
      mul EBX
      cmp EAX, 150
      jA err
      jmp ok
err:  outstrln "Введены неподходящие размеры матрицы."
      inchar DL,"Желаете ввести размеры еще раз? (Y/N):"
      newline
      cmp DL, "Y"
      jE again
      jmp fin
ok:   mov ECX, 0
input:inint X[2*ECX]
      inc ECX
      cmp ECX, EAX
      jB input
      flush
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      newline
      call Output
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p1
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p2
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p3
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p4
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p5
      movzx EAX, m
      push EAX
      movzx EAX, n
      push EAX
      mov EAX, offset X
      push EAX
      call p6
      
fin:  pause
      exit
end   Start
