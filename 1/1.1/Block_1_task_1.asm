include console.inc

.data

T      db " ������� ���� (������ 110) "
       db " ������_1 (����_1) '������� ������' ",0       
.code
Start:
      ConsoleTitle offset T 
      inintln EAX, "������� ����������� �����: "
      cdq   
      mov EBX, 3    ; �� ��� ������ ���� ������ ������ �����
      mov CL, 0     ; K �� ����-�����
L:    cmp EAX, 1    ; �������� N=1
      jE fin
      cmp EDX, 0    ; �������� N mod 3 = 0
      jnE pfin 
      div EBX       
      inc CL        ; K = K + 1
      jmp L
      
pfin: mov CL, -1      
fin:  outint CL,,"������� �������: "    
      pause                 
      exit                  
end   Start
