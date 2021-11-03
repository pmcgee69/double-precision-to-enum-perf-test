#pragma hdrstop
#pragma argsused

#include <iostream>
#include <System.Diagnostics.hpp>
#include "D_Data.h"
#include "Write_Outfile.h"
//#include "U_Comp_Dir.h"

const int N_times = 10;

int main()
{
  TOut_list O;
  auto T = System::Diagnostics::TStopwatch::Create();
  int tot = 0;
  int run = 0;

  for (int k = 0; k < N_times; ++k) {
	T.Start();
	for (int j =0; j < 1000; ++j)   {
		for (int i = 0; i < 10000; ++i) {
			 //O[i] = CompassDirnByBinary ( data[i] );            // d 140 ms  // c++ 100 ms
			 //O[i] = CompassDirectionOf  ( data[i] );            // d 245 ms
			 //O[i] = CompassDirectionOf2 ( data[i] );            // d 170 ms  // c++ 100 ms (40 ms)
			 //O[i] = CompassDirectionOf3 ( data[i] );            // d 180 ms  // c++  40 ms
		}
	}
	run = T.ElapsedMilliseconds;
	tot = tot + run;
	T.Stop();
	T.Reset();
	std::cout << "\n"  << run;
  }

  std::cout << "\n Av time : " << tot/N_times << " ms";
  Write_Output( O );
  getchar();
  return 0;
}
