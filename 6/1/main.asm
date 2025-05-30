
include console.inc

extern In4@0: proc, Out4@0: proc, swtch: near
public X

.data
 
X dd ?
.code
Start:
      push offset X
      call In4@0
      push X
      call Out4@0
      jmp swtch
      pause
      exit
end   Start

