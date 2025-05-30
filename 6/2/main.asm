
include console.inc

public A, B, Z
extern Mult@0: proc, check: near

.data
 
A dd ?
B dd ?
Z dq ?

.code
Start:
      inintln A,"¬ведите A: "
      inintln B,"¬ведите B: "
      push offset Z
      push B
      push A
      call Mult@0
      outwordln Z
      jmp check
      pause
      exit
end   Start

