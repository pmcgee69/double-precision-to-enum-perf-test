program Project_dbl_speed;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Diagnostics,
  D_Data in 'D_Data.pas',
  U_Comp_Dir in 'U_Comp_Dir.pas',
  Write_Outfile in 'Write_Outfile.pas';

begin
  var O : TOut_list;
  for var i := 1 to 10_000 do O[i] := CompassDirnByBinary ( data[i] );  /// warm up array data

  var T := TStopwatch.Create;

  for var k := 1 to 10 do begin
    T.Start;
    for var j := 1 to 1000 do
        for var i := 1 to 10_000 do
             O[i] := CompassDirnByBinary ( data[i] );             // 140 ms
             //O[i] := CompassDirectionOf ( data[i] );            // 245 ms
             //O[i] := CompassDirectionOf2 ( data[i] );           // 180 ms
    T.Stop;
    writeln;
    writeln(T.ElapsedMilliseconds);
    T.Reset;
  end;

  Write_Output( O );
  readln;
end.
