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
      flagEBCX = 0
      
      For Reg, <Terms>
            ifNB <Reg>
                  if type Reg EQ 1 or type Reg EQ 2
                        BWcheck = 1
                        ifIDNi <EBX>, <Reg>
                              flagEBCX = 1
                        endif
                        if counter EQ 1 ; EAX ---------------------------------------
                              ifIDNi <Reg>, <AL>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <AH>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <AX>
                                    save = 1
                              endif
                        elseif counter EQ 2 ; EBX-------------------------------------
                              ifIDNi <Reg>, <BL>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <BH>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <BX>
                                    save = 1
                              endif
                        elseif counter EQ 3 ; ECX ----------------------------------------------------
                              ifIDNi <Reg>, <CL>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <CH>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <CX>
                                    save = 1
                              endif
                        elseif counter EQ 4; EDX ------------------------------------------------------
                              ifIDNi <Reg>, <DL>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <DH>
                                    save = 1
                              endif
                              ifIDNi <Reg>, <DX>
                                    save = 1
                              endif
                        elseif counter EQ 5; ESI -----------------------------------------------------
                              ifIDNi <Reg>, <SI>
                                    save = 1
                              endif
                        elseif counter EQ 6 ; EBP -----------------------------------------------------
                              ifIDNi <Reg>, <BP>
                                    save = 1
                              endif
                        else                ; EDI --------------------------------------------------------
                              ifIDNi <Reg>, <DI>
                                    save = 1
                              endif
                        endif
                  elseif type Reg EQ 4     
                        ifIDNi <Reg>, <Res>
                              save = 1
                        endif
                  else 
                        check = check + Reg           ;;суммирование констант
                  endif
            endif
      endm
      
      

      if save EQ 1
            push Res
      endif

      mov Res, check                                  ;;в результате сумма констант

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
      
      
      if BWCheck EQ 1                   ;;выбор регистра для расширения и его сохранение
            ifDIFi <Res>, <EBX>
                  push EBX 
            else  
                  push ECX
            endif
      endif
      
      badEBX = 0


      For Reg, <Terms>                                 ;суммируем байты и слова
            ifNB <Reg>
                  if type Reg EQ 1 or type Reg EQ 2
                        flag = 0
                        if counter EQ 1 ; EAX ---------------------------------------
                              ifIDNi <Reg>, <AL>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+4
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <AH>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+5
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <AX>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        elseif counter EQ 2 ; EBX-------------------------------------
                              ifDifi <Res>, <EBX> 
                                    ifIDNi <Reg>, <BL>
                                          flag = 1
                                          movzx EBX, byte ptr [ESP]+4
                                          add Res, EBX
                                    endif
                                    ifIDNi <Reg>, <BH>
                                          flag = 1
                                          movzx EBX, byte ptr [ESP]+5
                                          add Res, EBX
                                    endif
                                    ifIDNi <Reg>, <BX>
                                          flag = 1
                                          movzx EBX, word ptr [ESP]+4
                                          add Res, EBX
                                    endif
                              else ; ---------------------------------EBX or ECX -------------------
                                    ifIDNi <Reg>, <BL>
                                          flag = 1
                                          movzx ECX, byte ptr [ESP]+4
                                          add Res, ECX
                                    endif
                                    ifIDNi <Reg>, <BH>
                                          flag = 1
                                          movzx ECX, byte ptr [ESP]+5
                                          add Res, ECX
                                    endif
                                    ifIDNi <Reg>, <BX>
                                          flag = 1
                                          movzx ECX, word ptr [ESP]+4
                                          add Res, ECX
                                    endif
                              endif
                        elseif counter EQ 3 ; ECX ----------------------------------------------------
                              ifIDNi <Reg>, <CL>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+4
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <CH>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+5
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <CX>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        elseif counter EQ 4; EDX ------------------------------------------------------
                              ifIDNi <Reg>, <DL>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+4
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <DH>
                                    flag = 1
                                    movzx EBX, byte ptr [ESP]+5
                                    add Res, EBX
                              endif
                              ifIDNi <Reg>, <DX>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        elseif counter EQ 5; ESI -----------------------------------------------------
                              ifIDNi <Reg>, <SI>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        elseif counter EQ 6 ; EBP -----------------------------------------------------
                              ifIDNi <Reg>, <BP>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        else
                              ifIDNi <Reg>, <DI>
                                    flag = 1
                                    movzx EBX, word ptr [ESP]+4
                                    add Res, EBX
                              endif
                        endif
                        if flag EQ 0 ;---------------------common case-----------------------
                              ifDifi <Res>, <EBX>
                                    flag = 0                              ;; 0 - BX  1 - BL 2 - BH 3 - Не сохранен EBX // аналогичное ECX
                                    ifIDNi <Reg>, <BL>
                                          if not (badEBX EQ 1 or badEBX EQ 0)
                                                pop EBX
                                                push EBX
                                                badEBX = 1
                                                flag = 1
                                          endif
                                    endif
                                    ifIDNi <Reg>, <BH>
                                          if not (badEBX EQ 2 or badEBX EQ 0)
                                                pop EBX
                                                push EBX
                                                badEBX = 2
                                                flag = 1
                                          endif
                                    endif
                                    ifIDNi <Reg>, <BX>
                                          if not (badEBX EQ 0)
                                                pop EBX
                                                push EBX
                                                badEBX = 0
                                                flag = 1
                                          endif
                                    endif
                                    if flag EQ 0
                                          badEBX = 3
                                    endif
                                    movzx EBX, Reg
                                    add Res, EBX
                              else
                                    ifIDNi <Reg>, <CL>
                                          if not (badEBX EQ 1 or badEBX EQ 0)
                                                pop ECX
                                                push ECX
                                                badEBX = 1
                                                flag = 1
                                          endif
                                    endif
                                    ifIDNi <Reg>, <CH>
                                          if not (badEBX EQ 2 or badEBX EQ 0)
                                                pop ECX
                                                push ECX
                                                badEBX = 2
                                                flag = 1
                                          endif
                                    endif
                                    ifIDNi <Reg>, <CX>
                                          if not (badEBX EQ 0)
                                                pop ECX
                                                push ECX
                                                badEBX = 0
                                                flag = 1
                                          endif
                                    endif
                                    if flag EQ 0
                                          badEBX = 3
                                    endif
                                    movzx ECX, Reg
                                    add Res, ECX
                              endif
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
      
      if save EQ 1
            add ESP, 4              ;;очищаем стек
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
      ;------
      Sum ECX,CL,CH, ,CX,cl,ch,cx
      Sum ,AL,al,AH, ,ah,AX,ax,EAX,eax
      Sum edx,BL,EAX,DL,DH,ECX,CX,EDX
      .NOLISTMACRO
      pause
      exit
end Start
