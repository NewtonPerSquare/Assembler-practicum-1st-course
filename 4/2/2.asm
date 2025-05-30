include console.inc

.data
N equ 100
S db N dup (?)
T     db " Паскаль Егор (группа 110) "
      db " Задача_2 (блок 4) 'Системы счисления' ",0
.code
ReadText proc
      push EBP
      mov EBP, ESP
      push EBX
      push ESI
      
      outstrln "Введите текст"
      mov ESI, [EBP+8]
      mov EBX, 0
@@:   inchar BL
      cmp BL, '.'
      jE @F
      mov [ESI][EAX], BL
      inc AL
      jmp @B
      
@@:   pop ESI
      pop EBX
      pop EBP
      ret 4
ReadText endp




MaxLet proc
      push EBP
      mov EBP, ESP
      sub ESP, 28
      push EBX
      push ECX
      push ESI
      
      
      mov ECX, 26
@@:   mov byte ptr[ESP][ECX-1], 0
      loop @B
      

      mov ESI, [EBP+8]              ;адрес массива
      mov ECX, [EBP+12]             ;длина массива

      mov EBX, 0                    ;буква-индекс
@@:   mov BL, [ESI][ECX-1]
      sub BL, "a"
      inc byte ptr[ESP][EBX]
      dec ECX
      cmp ECX, 0
      jNE @B
      
      mov BL, [ESP+25]             ;макс значение количества
      mov EAX, "z"                  ;соответствующая буква
      mov ECX, 25
@@:   cmp [ESP][ECX-1], BL
      jBE @sk
      mov EBX, [ESP][ECX-1]
      mov AL, CL
      dec AL
      add AL, "a"
@sk:  dec CL
      cmp CL, 0
      jNE @B
      
      pop ESI
      pop ECX
      pop EBX
      mov ESP, EBP
      pop EBP
      ret 4*2
MaxLet endp



Start:
      ConsoleTitle offset T
      mov EAX, 0
      push offset S
      call ReadText
      push EAX
      push offset S
      call MaxLet
      outchar AL
      pause
      exit
end   Start
