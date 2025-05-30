{$mode TP}
{$R+,B+,X-,I+,GOTO-}
{$codepage UTF-8}
program Flags(input, output);
uses Crt;
var
    i, k: integer;
    a, ua, sa, b, ub, sb, res, UpB, DownB: int64;                //int 32 почему-то здесь не предусмотрен. В теории, прогррамму можно запускать и для больших k, но делать интерфейс шире не хочется
    C, O, S, Z: byte;
procedure borders;
var
    i: integer;
begin
    a := 2;
    b := -1;
    for i := 1 to k - 1 do begin
        a := a * 2;
        b := b * 2;
    end; 
    UpB := a - 1;
    DownB := b;
end;

procedure Output2(n: int64);
var 
    i: integer;
    val: string;
begin 
    if n < 0 then
        n := UpB + 1 + n;
    if k <> 16 then begin
        for i := 1 to (16 - k) div 2 do
            write(' ');
    end;
    i := (UpB + 1) div 2;
    repeat
        if i <= n then begin
            write('1');
            n := n - i;
            end
        else
            write('0');
        i := i div 2;
    until i = 0;
     if k <> 16 then begin
        for i := 1 to (16 - k) div 2 + k mod 2 do
            write(' ');
    end;
    write('|');
end;

procedure OutputU(n: int64);
var
    len, i, x: integer;
begin
    if n < 0 then
        n := UpB + n + 1;
    x := n;
    len := 1;
    while x >= 10 do begin
        x := x div 10;
        len := len + 1;
    end;
    for i := 1 to (16 - len) div 2 do
        write(' ');
    write(n);
    for i := 1 to (16 - len) div 2 + len mod 2 do
        write(' ');
    write('|');
end;

procedure OutputS(n: int64);
var
    len, x, i: integer;
begin
    if n > -DownB - 1 then
        n := n - UpB - 1;
    x := n;
        if x = 0 then 
            len := 1
        else 
            len := 2;
    while abs(x) >= 10 do begin
        x := x div 10;
        len := len + 1;
    end;
    for i := 1 to (16 - len) div 2 do
        write(' ');
    if n > 0 then write('+');
    write(n);
    for i := 1 to (16 - len) div 2 + len mod 2 do
        write(' ');
    write('|');
end;

begin
    clrscr;
    TextColor(3);
    C := 0;
    O := 0;
    S := 0;
    Z := 0;
    writeln('Паскаль Егор, 110 группа, задача "Флаги"');
    write('Введите размер ячейки (в битах, от 2 до 16): ');
    readln(k);
    borders;  
    TextColor(6);
    writeln('Диапазон: [', DownB, ', ', UpB, ']');
    TextColor(15);
    writeln('Введите первое число');
    TextColor(9);
    readln(a);
    TextColor(15);
    writeln('Введите второе число');
    TextColor(9);
    readln(b);
    TextColor(15);
    writeln('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
    writeln('|          | В ячейке ЭВМ в | В 10-й системе | В 10-й системе |');
    writeln('|  Числа   |  2-ой ситеме   |  счисления без |  счисления со  |');
    writeln('|          |    счисления   |      знака     |     знаком     |');
    writeln('|----------|----------------|----------------|----------------|');
    write('|1-ое число|');
    Output2(a);
    OutputU(a);
    OutputS(a);
    writeln;
    writeln('|----------|----------------|----------------|----------------|');
    write('|2-ое число|');
    Output2(b);
    OutputU(b);
    OutputS(b);
    writeln;
    writeln('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
    if a < 0 then
        ua := UpB + a + 1
    else 
        ua := a;
    if b < 0 then
        ub := UpB + b + 1
    else
        ub := b;  
    if a > UpB div 2 then
        sa := a - UpB - 1
    else
        sa := a;
    if b > UpB div 2 then
        sb := b - UpB - 1
    else
        sb := b;
    writeln;
    writeln('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
    writeln('|        | В ячейке ЭВМ в | В 10-й системе | В 10-й системе |   |   |   |   |');
    writeln('|Машинная|  2-ой системе  | счисления без  |  счисления со  |CF |OF |SF |ZF |');
    writeln('|операция|   счисления    |     знака      |     знаком     |   |   |   |   |');
    writeln('-----------------------------------------------------------------------------');
    write('| Сумма  |');
    res := ua + ub;
    if res > UpB then begin
        res := res - UpB - 1;
        C := 1;
    end;
    Output2(res);
    OutputU(res);
    res := sa + sb;
    if res < DownB then begin
        res := res + UpB + 1;
        O := 1;
    end;
    if res > -DownB - 1 then begin
        res := res - UpB - 1;
        O := 1;
    end;
    if res = 0 then
        Z := 1;
    if res < 0 then
       S := 1;
    OutputS(res);
    writeln(' ', C, ' | ', O, ' | ', S, ' | ', Z , ' |');
    write('|        |                |');
    if C = 1 then begin
        TextColor(4);
        write('    неверно     ');
        end
    else begin
        TextColor(10);
        write('     верно      ');
    end;
    TextColor(15);
    write('|');
    if O = 1 then begin
        TextColor(4);
        write('    неверно     ')
    end
    else begin
        TextColor(10);
        write('     верно      ');
    end;
    TextColor(15);
    writeln('|   |   |   |   |');
    C := 0;
    O := 0;
    S := 0;
    Z := 0;
    writeln('|--------|----------------|----------------|----------------|---|---|---|---|');
    write('|Разность|');
    res := ua - ub;
    if res < 0 then begin
        res := res + UpB + 1;
        C := 1;
    end;
    Output2(res);
    OutputU(res);
    res := sa - sb;
    if res < DownB then begin
        res := res + UpB + 1;
        O := 1;
    end;
    if res > -DownB - 1 then begin
        res := res - UpB - 1;
        O := 1;
    end;
    if res = 0 then
        Z := 1;
    if res < 0 then
       S := 1;
    OutputS(res);
    writeln(' ', C, ' | ', O, ' | ', S, ' | ', Z , ' |'); 
    write('|        |                |');
    if C = 1 then begin
        TextColor(4);
        write('    неверно     ');
        end
    else begin
        TextColor(10);
        write('     верно      ');
    end;
        TextColor(15);
    write('|');
    if O = 1 then begin
        TextColor(4);
        write('    неверно     ')
    end
    else begin
        TextColor(10);
        write('     верно      ');
    end;
    TextColor(15);
    writeln('|   |   |   |   |');
    writeln('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
end.