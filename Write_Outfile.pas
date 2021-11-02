unit Write_Outfile;

interface
uses U_Comp_Dir;

type
  TOut_list = array [1..10_000] of TCompassDirection;

procedure Write_Output ( O : TOut_list);


implementation
uses System.IOUtils, System.Math, System.Rtti;

procedure Write_Output ( O : TOut_list);
begin
  var f := Tfile.CreateText('output_bin.csv');
  var c := 0;

  for var i := 1 to 10_000 do begin
      f.Write( TRttiEnumerationType.GetName<TCompassDirection>(O[i]) + ',   ' );
      inc(c);
      if c=8 then begin  c:=0;  f.Write(#13#10);  end;
  end;

  f.Close;
  f.free;
end;

end.
