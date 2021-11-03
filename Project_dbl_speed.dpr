program Project_dbl_speed;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Diagnostics,
  D_Data in 'D_Data.pas',
  U_Comp_Dir in 'U_Comp_Dir.pas',
  Write_Outfile in 'Write_Outfile.pas';

const
  N_times = 10;

begin
  var  O  :  TOut_list;
  var  T  := TStopwatch.Create;
  var tot := 0;
  var run := 0;

  for var k := 1 to N_times do begin
    T.Start;
    for var j := 1 to 1000 do
        for var i := 1 to 10_000 do
             O[i] := CompassDirnByBinary ( data[i] );             // 140 ms
             //O[i] := CompassDirectionOf  ( data[i] );           // 245 ms
             //O[i] := CompassDirectionOf2 ( data[i] );           // 170 ms

    run := T.ElapsedMilliseconds;
    tot := tot + run;
    T.Stop;
    T.Reset;      writeln;      writeln( run:5 );
  end;

  writeln;
  writeln( 'Av time : ', tot/N_times:5:1, ' ms');
  Write_Output( O );
  readln;
end.


