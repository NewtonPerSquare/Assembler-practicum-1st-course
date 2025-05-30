include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_1 (блок 4) 'Системы счисления' ",0     
.code
OutD proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push EDX
      push ESI
      push ESP
      
      mov EAX, [EBP+8]
      mov EBX, [EBP+12]
      mov ESI, ESP
@L1:  mov EDX, 0
      div EBX
      push EDX
      cmp EAX, 0
      jNE @L1
@L2:  pop EAX
      outint EAX
      cmp ESP, ESI
      jNE @L2
      
      pop ESP
      pop ESI
      pop EDX
      pop EBX
      pop EAX
      pop EBP
      ret 4*2
OutD endp

Start:
      ConsoleTitle offset T
      inintln EAX,"Введите число: "
      inintln EBX,"Введите основание системы счисления: "
      push EBX
      push EAX
      call OutD
      pause
      exit
end   Start
