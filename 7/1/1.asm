include console.inc

.data

T     db " Паскаль Егор (группа 110)     "  
      db " Задача_единственная (блок_7) 'Last' ",0
K1    equ 1
K2    equ 2
K3    equ 3
B1    db 10
B2    db 20
B3    db 30
W1    dw 4000
W2    dw 5000
W3    dw 6000
D1    dd 700000
D2    dd 800000
D3    dd 900000

.code

Sum macro Res:=<EAX>, Terms:vararg
      local check
      IF type Res NE 4
            .err <Macros Sum: incorrect arg1 - Res>
            exitm 
      endif
      check = 0
      counter = 0
      For r32, <EAX, EBX, ECX, EDX, ESI, EBP, EDI>
            counter = counter + 1                     ;номер регистра
            IFIDNi <Res>, <r32>
                  check = 1
                  exitm
            endif
      endm

      IF check NE 1                                   ;неподходящий res
            .err <Macros Sum: incorrect arg1 - Res>
            exitm
      endif
      
      IFB <Terms>                                     ;пустой Terms
            echo <Macros Sum: incorrect: arg2 = null>
            exitm 
      endif
      
      check = 0
      BWCheck = 0
      save = 0

      
      For Reg, <Terms>
            ifNB <Reg>
                  if type Reg EQ 1 or type Reg EQ 2
                        BWCheck = 1
                  elseif type Reg EQ 4
                        ifIDNi <Reg>, <Res>
                              save = 1
                        endif
                  else 
                        check = check + Reg           ;;суммирование констант
                  endif
            endif
      endm
      
      mov Res, check                                  ;;в результате сумма констант
      if save EQ 1
            push Res
      endif

      For Reg, <Terms>                                ;;суммирование дв слов
            ifNB <Reg>
                  if type Reg EQ 4
                        ifdifi <Reg>, <Res>
                              add Res, Reg 
                        else
                              add Res, [ESP]          ;;суммрование из стека (для голубых тестов)
                        endif
                  endif
            endif
      endm
      
      if save EQ 1
            add ESP, 4              ;;очищаем стек
      endif
      
      
      if BWCheck EQ 1                   ;;выбор регистра для расширения и его сохранение
            ifDIFi <Res>, <EBX>
                  push EBX 
            else  
                  push ECX
            endif
      endif
      
      
      flagEBCX = 0
      
      For Reg, <Terms>                                ;;суммирование word и byte
            ifNB <Reg>
                  if type Reg EQ 1 or type Reg EQ 2
                        ifDifi <Res>, <EBX>
                              if flagEBCX NE 0
                                    ifIDNi <Reg>, <BL>
                                          pop EBX
                                          push EBX
                                    endif
                                    ifIDNi <Reg>, <BH>
                                          pop EBX
                                          push EBX
                                    endif
                                    ifIDNi <Reg>, <BX>
                                          pop EBX
                                          push EBX
                                    endif
                                    flagEBCX = 1
                              endif
                              movzx EBX, Reg
                              add Res, EBX
                        else
                              if flagEBCX NE 0
                                    flagEBCX = 1
                                    ifIDNi <Reg>, <CL>
                                          pop ECX
                                          push ECX
                                    endif
                                    ifIDNi <Reg>, <CH>
                                          pop ECX
                                          push ECX
                                    endif
                                    ifIDNi <Reg>, <CX>
                                          pop ECX
                                          push ECX
                                    endif
                                    flagEBCX = 1
                              endif
                              movzx ECX, Reg
                              add Res, ECX
                        endif
                  endif
            endif
      endm
      
      if BWCheck EQ 1                         ;;восстанавливаем EBX или ECX
            ifDIFi <Res>, <EBX>
                  pop EBX
            else
                  pop ECX
            endif
      endif

      
endm
Start:

      ConsoleTitle offset T 
      .LISTMACRO
      Sum EAX, <123456,K1,EBX,D1>
      Sum EAX,123456,K1,EBX,ebx,D1
      Sum ,123456,K1,EBX,D1
      Sum eax,123456, ,K1,EBX,D1
      Sum EAX
      Sum
      Sum EAX,2,K2,B2,W2,D2
      Sum AL,1,2,3
      Sum CX,1,K2
      Sum K3,1,2,3
      Sum AL,1,2,3
      Sum B3,1,2,3
      Sum W3,1,2,3
      Sum ESP,1,2,3
      Sum EDX,1,B2,W2, ,K2,D3,123
      Sum ESI,AL,2,3,AH,K1,K2,BL,BH,DL,DH
      Sum EDI,AX,BX,CX,DX,W1,W2,123
      Sum 0,1,2,3
      ;------
      Sum EDX,EDX ,B2,edx, ,K2,D3,eDX
      Sum ,1,EAX,eax, ,K2,EAX,123
      Sum edx,EAX,BL,EDX,ECX,AX,EDX
      .NOLISTMACRO
      pause                
      exit                 
end Start
