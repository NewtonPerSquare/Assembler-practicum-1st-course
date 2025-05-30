include console.inc

extern X: dword
public swtch



.code

swtch:newline
      outwordln X
      pause
      exit
end