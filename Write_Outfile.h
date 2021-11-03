//---------------------------------------------------------------------------

#ifndef Write_OutfileH
#define Write_OutfileH
//---------------------------------------------------------------------------
#endif

#include "U_Comp_Dir.h"
/*
uses System.IOUtils, System.Math, System.Rtti;
*/
using TOut_list   = TCompassDirection[10000];


void Write_Output (const TOut_list O) {

	//for (int i=0; i < 10000; i++) 	  std::cout << O[i] << " . ";

	std::cout << "\n  done. \n" << O[9000];

/*
  var f := Tfile.CreateText('output_bin.csv');
  var c := 0;

  for var i := 1 to 10_000 do begin
	  f.Write( TRttiEnumerationType.GetName<TCompassDirection>(O[i]) + ',   ' );
	  inc(c);
	  if c=8 then begin  c:=0;  f.Write(#13#10);  end;
  end;

  f.Close;
  f.free;
*/
}


