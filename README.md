# double-precision-to-enum-perf-test

An examination of / experimentation around taking a double (compass direction reading) and turning it into an enum compass heading, measuring performance.

Tested in Delphi 11 and C++Builder 10.3.3 Community Edition.

tl;dr
			 O[i] = CompassDirnByBinary ( data[i] );            // d 140 ms  // c++ 100 ms
			 O[i] = CompassDirectionOf  ( data[i] );            // d 245 ms  // c++ TBA
			 O[i] = CompassDirectionOf2 ( data[i] );            // d 170 ms  // c++ 100 ms (40 ms)
			 O[i] = CompassDirectionOf3 ( data[i] );            // d 180 ms  // c++  40 ms
       
       
A standout point was that returning an *int-cast-to-enum* was outperformed in c++ by *indexing-into-array-of-enum* ... but little difference in Delphi.

The main files:

**Project_dbl_speed.dpr / double_speed.cpp**
The main project files

**D_Data.pas / D_Data.h**
10,000 doubles in the range [0.0 .. 365.0] for input purposes.  (Data > 360.0 for the purposes of injecting errors)

**U_Comp_Dir.pas / U_Comp_Dir.h**
The functions to process compass heading

**Write_Outfile.pas / Write_Outfile.h**
Record the results of processing

Utility files:

**Project_random_doubles.dpr**
Write 10,000 doubles to a text file

**Project_write_doubles.dpr / Bin_Unit.pas**
Diagnostic program to break doubles down into binary (memory) format


