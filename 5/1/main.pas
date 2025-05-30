program main;
var X: longword;        
    Res: shortint;
procedure Power2(X: longword; var Res:shortint);
stdcall;                    
external name '_Power2@0';      
{$L unit.obj}
                            
begin
    readln(X);    
    Power2(X, Res);
    writeln(Res);
    readln;
    readln;
end.
