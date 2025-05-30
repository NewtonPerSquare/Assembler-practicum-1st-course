comment *
-------------------------------------------------------------------
�����-5 (������_2, �������� ������) 
-------------------------------------------------------------------
*

include console.inc

extern In_Rec@0: proc, Less@0: proc, Out_Rec@0: proc, Min_Date@0: proc, Rec_to_Struc@0: proc, Out_Struc@0: proc, Ptr_to_Min_Date@0: proc, Out_Sort@0: proc
Date_pack record D:5, M:4, Y:7
; ------------------------------------------------------------------------
; �������� ���� Date_unpack  (������������� ����-���������):
Date_unpack struc                   ; ���� � ������ ���������� ��������
D   db ?                            ; ���� (�� 1 �� 31)
M   db ?                            ; ����� (�� 1 �� 12)
Y   db ?                            ; ��� (�� 0 �� 99)
Date_unpack ends
; ------------------------------------------------------------------------
; �������� ����������:
.data
T   db " ������� ���� ���� 5(�����-4)",0
N   equ 6
D1  Date_pack <>                    ; ����������� ����_1
D2  Date_pack <>                    ; ����������� ����_2
Arr_of_Rec Date_pack N dup (<>)     ; ������ ������� (����������� ���)
Arr_of_Struc Date_unpack N dup (<>) ; ������ �������� (������������� ���)
.code

Start:	;------------- ���� 1 -------(40 �����)-----------------------------
	ConsoleTitle " ������� ����    ������_���-2 (�����-4)"
    ConsoleTitle offset T  ; � � ������ ���� ������ ����� ���������� �����(��)	
; ------------------------------------------------------------------------
; ���� 1 (40 �����):
; (10 �����) ���� ���� ��� D1 � D2 (������ � ������� dd.mm.yy)
; �������:
COMMENT *
      outstrln '������� 1� ����'
      push offset D1
      call In_Rec
      outstrln '������� 2� ����'
      push offset D2
      call In_Rec
      mov AX, D1
      push EAX
      call Out_Rec
      newline
      mov AX, D2
      push EAX
      call Out_Rec
      newline
      mov AX, D2
      push EAX
      mov AX, D1
      push EAX
      call Less
      outstr 'D1'
      outchar 60
      outstr 'D2 is '
      cmp AL, 0
      jE @f
      outstrln 'true'
      jmp sk1
@@:   outstrln 'false'
sk1:  
*
; (20 �����) ��������� ���� ��� (D1 < D2 ?)
; �������:


; (10 �����) ����� ���������� ��������� � ���� "D1<D2 is true/false",
; ��� ������ D1 � D2 ������ ���� ���������� ���� � ������� dd.mm.yy
; �������:

   
; ------------------------------------------------------------------------
; ���� 2 (50 �����):
; (15 �����) ���� ��� ����� N ��� � ���������� �� � ������� Arr_of_Rec:
; �������:

      mov ECX, N
      lea EBX, Arr_of_Rec
L1:   push EBX
      call In_Rec@0
      lea EBX, [EBX+2]
      loop L1

; (15 �����) ���� ��� ������ N ���, ���������� � ������� Arr_of_Rec
; �������:
      newline
      mov ECX, N
      lea EBX, Arr_of_Rec
L2:   movzx EAX, word ptr [EBX]
      push EAX
      call Out_Rec@0
      lea EBX, [EBX+2]
      loop L2
      newline
      
; (20 �����) ���� ��� �������� ����������� �� ��������-���� �� �����������
; �������:
      newline     
      mov ECX, N-1
      lea EBX, Arr_of_Rec
L3:   movzx EAX, word ptr [EBX] + type Date_pack
      push EAX
      movzx EAX, word ptr [EBX]
      push EAX
      call Less@0
      cmp AL, 0
      jE wrng
      lea EBX, [EBX+2]
      loop L3
      outstrln 'Sorted' 
      jmp @F
wrng: outstrln 'Not sorted'
@@:

; ------------------------------------------------------------------------
; ���� 3 (40 �����):
; ���������� ������� Min_Date ��� ������ ���������� ���� � ������� Arr_of_Rec
; �������:
      push dword ptr N
      push offset Arr_of_Rec
      call Min_Date@0
      push EAX
      call Out_Rec@0
      outstrln " is minimum"
      newline
; ����� ���������� ���� � ���� "dd.mm.yy is minimum"
; �������:



; ------------------------------------------------------------------------
; ���� 4 (60 �����):
; (30 �����) ���� �������� �� ������� Arr_of_Rec � ����� ���������� ��� 
; � ���������� �� � ������� ��������  Arr_of_Struc
; �������:
      mov ECX, N
      lea ESI, Arr_of_Struc
      lea EAX, Arr_of_Rec
Lc:   push ESI
      mov BX, [EAX]
      push EBX
      call Rec_to_Struc@0
      add ESI, 3
      add EAX, 2  
      loop Lc

; (30 �����) ���� �������� �� ������� Arr_of_Struc � ����� ������ ��� 
; �� ����� (������ ���� - � ������� dd.mm.yy)
; �������
      outstrln 'Arr_of_Struc:'
      mov ECX, N
      lea ESI, Arr_of_Struc
Lo:   push ESI
      call Out_Struc@0
      outchar " "
      lea ESI, [ESI+type Arr_of_Struc]
      loop Lo
; ------------------------------------------------------------------------
; �������������� ����� 5 � 6 ���������� �������������� (��� ��� �������� ���)
; ------------------------------------------------------------------------
      newline
      mov ECX, N
      mov ESI, offset Arr_of_Rec
L5:   push ECX
      push ESI
      call Ptr_to_Min_Date@0
      mov BX, word ptr [EAX]
      xchg word ptr [ESI], BX
      mov word ptr [EAX], BX
      add ESI, type Arr_of_Rec
      dec ECX
      cmp ECX, 1
      jA L5
      push N
      push offset Arr_of_Rec 
      call Out_Sort@0


    pause     ; ����� ��� ����� �� email
    exit
end Start






comment ~

----------------------------------------------------------------------
���������� �� ���������� ���� ������������� ���������:
----------------------------------------------------------------------
������������:
�������� ���� prompt1.bat ��� ������� ���� ��������� ������. 

��� ���������� ����� ������ (m2.asm) ��������� (�� ��������� ������):
ml /c /coff /Fl m2.asm

��� ���������� ���������������� ������ (u2.asm) ���������:
ml /c /coff /Fl u2.asm

��� ������ (��������) ���� ������� ���������:
link /subsystem:console m2.obj u2.obj 

��� ������� ������� ��������� �� ���� ���������:
m2

~
