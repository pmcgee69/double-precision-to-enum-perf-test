program Project_write_doubles;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Bin_Unit in 'Bin_Unit.pas';

const
  N = 16;  // array size

type
  Darr = array [ 1..N ] of double;

const
//  d : Darr = ( 0.005, 0.25, 0.125, 0.0625, 00.03125, 0.5, 1.0, 1.5, 1.00001,  2.00, 4.000, 8.0000, 16.00000, 256.0, 512.0, 1024.0, 2048.0, 4096.0, 1.5, 0.25 );
//  d : Darr = (  4.0,   8.0,   6.0,     12.0,   4.5,   8.5,  4.25,  8.25, 4.125, 8.125,
//              100.0, 100.5, 100.75, 10.075, 220.0, 250.0, 280.0, 320.0, 340.0, 360.0);
  d : Darr = (   22.5,  45.0,  67.5,  90.0, 112.5, 135.0, 157.5, 180.0,
                202.5, 225.0, 247.5, 270.0, 292.5, 315.0, 337.5, 360.0);

begin
    var b : TBytes;
    setlength(b,8);
    writeln;

    for var i := 1 to N do begin
        Move( d[i], Pointer(b)^, 8);

        write( format('%e', [ d[i] ] ):10,'  ' );

      //write( bin7 ( b[7]        ), '  ');
      //write( bin40( b[6] and $F0), '  ');
      //write( bin04( b[6] and $0F), '  ');
      //write( hex40( b[6] and $F0), '  ');
      //write( hex04( b[6] and $0F), '  ');
        write( hex8 ( b[6]        ), '  ');
        write( hex8 ( b[5]        ), '  ');
        for var j := 7 downto 0 do
            write( bin8( b[j] ), '  ');
        writeln;
        writeln;
    end;

    readln;
end.
