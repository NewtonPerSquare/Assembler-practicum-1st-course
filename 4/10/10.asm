include console.inc

.data
N equ 100
S db N dup (?)
T     db " ������� ���� (������ 110) "
      db " ������_10 (���� 4) '�������' ",0
.code

Form proc
      push EBX
      push ECX
      push EDX
      
      inchar BL
      cmp BL, "0"
      jB @form
      cmp BL, "9"
      jA @form
      sub BL, "0"
      movzx EAX, BL
      jmp @fin
@form:call Form
      mov ECX, EAX
      inchar BL   ;����
      push EBX
      call Form
      mov EDX, EAX
      inchar BL   ;")"
      pop EBX
      cmp BL, "+"
      jNE @sk1
      mov EAX, ECX
      add EAX, EDX
      jmp @fin
@sk1: cmp BL, "-"
      jNE @sk2
      mov EAX, ECX
      sub EAX, EDX
      jmp @fin
@sk2: mov EAX, EDX
      mov EDX, 0
      mul ECX
      jmp @fin
@fin: pop EDX
      pop ECX
      pop EBX
      ret 
Form endp


Start:
      ConsoleTitle offset T
      mov EAX, 0
      outstrln "������� ���������"
      call Form
      mov EBX, EAX
      mov EAX, 0
      inchar CL
      call Form
      cmp EAX, EBX
      jNE no
      outstr "��"
      jmp fin
no:   outstr "���"
fin:  pause
      exit
end   Start
