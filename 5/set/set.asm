include console.inc

.data

T     db " Паскаль Егор (группа 110) "
      db " Задача_доп (блок 5) 'МНОЖЕСТВА' ", 0
L equ 5
R equ 155
S db (R-L)/8+1 dup(0)
.code

deleteS proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      
      inint EDX
      mov EBX, EDX
      sub EBX, L
      mov CL, BL
      and CL, 111b
      shr EBX, 3
      mov AL, 1111111b
      ror AL, CL
      and S[EBX], AL
      
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret
deleteS endp


writeS proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      
      inint EDX
      mov EBX, EDX
      sub EBX, L
      mov CL, BL
      and CL, 111b
      shr EBX, 3
      mov AL, 10000000b
      ror AL, CL
      or S[EBX], AL
      
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret
writeS endp



print proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX 
      push ESI 
      
      mov ECX,(R-L)/8+1
      mov ESI, 0
      mov EAX, L
@L:   mov DL, 80h
      mov BL, S[ESI]
      inc ESI
@S:   test DL,BL
      jZ @skip
      outword EAX,, ' '
@skip:inc EAX
      shr DL, 1
      cmp DL, 0
      jNE @S
      loop @L
      newline
      
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 
print endp



Search proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX
      
      inint EDX
      mov EBX, EDX
      sub EBX, L
      mov CL, BL
      and CL, 111b
      shr EBX, 3
      mov AL, 10000000b
      ror AL, CL
      test S[EBX], AL
      jNZ @F
      outstrln "Не входит"
      jmp @fin
@@:   outstrln "Входит"
@fin: pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret
Search endp



Quantity proc
      push EBP
      mov EBP, ESP
      push EAX
      push EBX
      push ECX
      push EDX 
      push ESI 
      
      outstr 'Количество: '
      mov ECX,(R-L)/8+1
      mov ESI, 0             
      mov EAX, 0
@L:   mov DL, 80h
      mov BL, S[ESI]
      inc ESI
@S:   test DL,BL
      jZ @sk
      inc EAX
@sk:  shr DL, 1
      cmp DL, 0
      jNE @S
      loop @L
      outwordln EAX
      
      pop ESI
      pop EDX
      pop ECX
      pop EBX
      pop EAX
      pop EBP
      ret 
Quantity endp

Start:
      ConsoleTitle offset T
LL:   inchar AL
      cmp AL, "-"
      jNE next1
      call deleteS
      jmp LL
next1:cmp AL, "+"
      jNE next2
      call writeS
      jmp LL
next2:cmp AL, ":"
      jNE next3
      call print
      jmp LL
next3:cmp AL, "="
      jNE next4
      call Quantity
      jmp LL
next4:cmp AL, "?"
      jNE next5
      call Search
      jmp LL
next5:cmp AL, "."
      jNE LL
      pause
      exit
end   Start
