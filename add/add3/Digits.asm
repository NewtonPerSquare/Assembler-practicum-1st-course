include console.inc

.data

T     db " ������� ���� (������ 110) "
      db " ���_������ (����� 3) '�����' ",0  
      Ans   db (9*6+2)*5+1 dup ('0')          ;����� �������� - 9 "�������������" - 9 �� 5 ����� �� 6 �������� �� ������ ������ ��� � 2 �������� ������� ��� "10, 13" 

dig1  db " 000    1    222  3333  4   4 55555  666  77777  888   999  ", 10, 13,
         "0   0  11   2   2     3 4   4 5     6         7 8   8 9   9 ", 10, 13,
         "0   0   1      2   333  44444 5555  6666     7   888   9999 ", 10, 13,
         "0   0   1    22       3     4     5 6   6   7   8   8     9 ", 10, 13,
         " 000   111  22222 3333      4 5555   666   7     888   999  ", 0
         
dig2 db "  ***    *    ***  ****  *   * *****  ***  *****  ***   ***  ", 10, 13,
         "*   *  **   *   *     * *   * *     *         * *   * *   * ", 10, 13,
         "*   *   *      *   ***  ***** ****  ****     *   ***   **** ", 10, 13,
         "*   *   *    **       *     *     * *   *   *   *   *     * ", 10, 13,
         " ***   ***  ***** ****      * ****   ***   *     ***   ***  ", 0, ")"
         
dig3  db " ---    |    ___  ---\  |   | |----  ---  -----  ---   ---  ", 10, 13,
         "|   |  /|   /   \    |  |   | |     /         / |   | |   | ", 10, 13,
         "|   |   |      /  ---|  |---| |--|  |---     /   ---   ---| ", 10, 13,
         "|   |   |    //      |      |    |  \   /   /   |   |     | ", 10, 13,
         " ---   ---  ----- ---/      | ---|   ---   /     ---   ---  ", 0   
.code
COMMENT ~
��������� �������� �� ���������� ���������: ���������� ���� �����, ������ ������ (� ������� ��� ������ �2).
��������� get_length ����� � ������� ECX ���������� �������� � ����� EAX. ��������� prepare_ans �� ��������
ECX �������������� ������-����� Ans. � �����, �� ������ ������ ���������� ���� �� �������� print1-3, ����������
�� ���������� ��������: �� ���������������� �������-������� ���������� ��� ����� (5*6 ��������) � ������-�����
Ans, �� ����� �� EDX-������� �� ������� �� 10. ����� �������, ����� ����������� �� �����, � ��������� �� ���� ������
��������� �����. 
~

prepare_ans proc                 ;��������� ������� ������� Ans ��� ������ �����
      push EAX      
      push EBX
      push ESI
      push EBX
      push EDI
      
      mov EAX, 6
      mul ECX           
      add EAX, 2                 ;�� EAX ����� ������
      mov ESI, 0
      mov EDI, 0
      mov EBX, 0
@@:   inc EBX 
      cmp EBX, EAX
      jB @B
      mov Ans[EBX-2][ESI], 10
      mov Ans[EBX-1][ESI], 13
      add ESI, EAX
      inc EDI
      mov EBX, 0
      cmp EDI, 5
      jB @B
      sub ESI, EAX
      mov Ans[EAX-2][ESI], 0
      
      pop EDI
      pop EBX
      pop ESI
      pop EBX
      pop EAX
      ret
prepare_ans endp

get_length proc
      push EAX
      push EBX
      push EDX
      push ESI
      
      mov ESI, 10
      mov ECX, 1
@@:   mov EDX, 0
      cmp EAX, 10
      jB @F
      div ESI
      inc ECX
      jmp @B
      
@@:   pop ESI
      pop EDX
      pop EBX
      pop EAX
      ret
get_length endp


print1 proc                                                 ;����� 1
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;�������� �� ������� ��� �������-�������
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print1
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;�������� �� ������� ��� �������-������
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;�������� ������ ������ ��� �������-�������

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX
      mov BL, dig1[EDX]
      mov Ans[EDI], BL

      mov Ans[EDI], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print1 endp


print2 proc                                                 ;����� 2
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;�������� �� ������� ��� �������-�������
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print2
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;�������� �� ������� ��� �������-������
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;�������� ������ ������ ��� �������-�������

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX

      mov BL, dig2[EDX]
      cmp BL, "*"
      jne @skip
      mov BL, dig2[310]                       ;�������� ������
@skip:mov Ans[EDI], BL
      mov dig2[EDX], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print2 endp

print3 proc                                                 ;����� 3
      push EAX 
      push EBX 
      push EDX 
      push ESI 
      mov EBX, 10
      mov ESI, (6*10)+2                    ;�������� �� ������� ��� �������-�������
      mov EDX, 0
@@:   div EBX
      cmp EAX, 0
      jE @F
      call print3
@@:   push EDX
      mov EAX, ECX
      mov EBX, 6
      mul EBX
      add EAX, 2                           ;�������� �� ������� ��� �������-������
      pop EDX
      push EAX 
      mov EAX, 6

      mul EDX
      mov EDX, EAX                         ;�������� ������ ������ ��� �������-�������

      pop EAX 
      push ECX 
      mov ECX, 6
@L:   dec ECX
      push ECX 
      mov ECX, 5
      push EDI 
      push EDX 
      push EBX 
      mov EBX, 0
@@:   dec ECX
      mov BL, dig3[EDX]
      mov Ans[EDI], BL

      mov Ans[EDI], BL
      add EDI, EAX
      add EDX, ESI
      cmp ECX, 0
      jNE @B
      pop EBX 
      pop EDX 
      pop EDI 
      pop ECX
      inc EDI
      inc EDX
      cmp ECX, 0
      jNE @L
      pop ECX 
      pop ESI
      pop EDX 
      pop EBX 
      pop EAX 
      ret
print3 endp


Start:
      ConsoleTitle offset T
      
      mov EDI, 0
      inchar dig2[310], "������� ��� ������(����� ��� ������ �2, ��. ����������� � ����): "
COMMENT ~
            ��� - ���������� �������������� ������.
�� ����������� ��� �������, ���� ������� � ������ 303 �� ���������� - ��������� ������ ���������� ��� ������ � ��.
������, � �������� ��������� ��� ������� � ������ �����. ������� ���� ����������, ��� ���������� ������ ���������� 
������ �����, ����� ��� ������� ����� � ������. ����� ����������� ���-�� � �������� inputstr - ��������� ��� ��.
~
      inint EAX, "������� ����� �� 0..999999999: "
      call get_length
      call prepare_ans
      outstrln "�������� ����� (1-3):"
      outstrln "����� 1 - ����� �� ����"
      outstrln "����� 2 - ������������� ����� (�� ���������� �������)"
      outstrln "����� 3 - ����� �� ������ � �������"
input:inint EBX, "������� ����� ������: "
      newline
      newline
      newline
      cmp EBX, 1
      jne ch2
      call print1
      jmp prt
ch2:  cmp EBX, 2
      jne ch3
     ;inchar dig[308], "������� ���� �����"       
      call print2
      jmp prt
ch3:   cmp EBX, 3
      jne Err
      call print3
      jmp prt
Err:  outstr "����������� ����� ����� ������. ���������� ��� ���."
      jmp input
prt:  outstr offset Ans
      pause
      exit
end   Start
