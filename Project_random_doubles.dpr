program Project_random_doubles;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.IOUtils,
  System.Math,
  D_Data in 'D_Data.pas';

const
  max = 365_000_000;

begin
  var f := Tfile.CreateText('doubles.csv');
  var c := 0;

  for var i := 1 to 10_000 do begin
      f.Write( (randomrange(0,max) / 1_000_000 ).ToString+',   ' );
      inc(c);
      if c=8 then begin
         c:=0;
         f.Write(#13#10);
      end;
  end;
  f.Close;
  f.free;
end.
