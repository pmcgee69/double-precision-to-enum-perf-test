//---------------------------------------------------------------------------

#ifndef U_Comp_DirH
#define U_Comp_DirH
//---------------------------------------------------------------------------
#endif

#include <System.SysUtils.hpp>

const int TCD = 16;
enum  TCompassDirection { cdNorth, cdNNE, cdNE, cdENE,
						  cdEast,  cdESE, cdSE, cdSSE,
						  cdSouth, cdSSW, cdSW, cdWSW,
						  cdWest,  cdWNW, cdNW, cdNNW };

//   CompassDirectionOf (const double inBearing) -> TCompassDirection;
auto CompassDirectionOf2(const double inBearing) -> TCompassDirection;
auto CompassDirectionOf3(const double inBearing) -> TCompassDirection;
auto CompassDirnByBinary(const double inBearing) -> TCompassDirection;


const int CompPoints[ TCD ]
					  = { 0x3680, 0x4680, 0x50E0, 0x5680, 0x5C20, 0x60E0, 0x63B0, 0x6680,
						  0x6950, 0x6C20, 0x6EF0, 0x70E0, 0x7248, 0x73B0, 0x7518, 0x7680  };

const int         cp[ TCD ]
					  = { 0x3680, 0x4680, 0x50E0, 0x5680, 0x5C20, 0x60E0, 0x63B0, 0x6680,
						  0x6950, 0x6C20, 0x6EF0, 0x70E0, 0x7248, 0x73B0, 0x7518, 0x7680  };

const double       d[ TCD ]
					  = {   22.5,  45.0,  67.5,  90.0, 112.5, 135.0, 157.5, 180.0,
						   202.5, 225.0, 247.5, 270.0, 292.5, 315.0, 337.5, 360.0 };

const TCompassDirection halfpoints [ TCD*2 ]
					  = {          cdNorth, cdNNE, cdNNE, cdNE, cdNE, cdENE, cdENE,
						  cdEast,  cdEast,  cdESE, cdESE, cdSE, cdSE, cdSSE, cdSSE,
						  cdSouth, cdSouth, cdSSW, cdSSW, cdSW, cdSW, cdWSW, cdWSW,
						  cdWest,  cdWest,  cdWNW, cdWNW, cdNW, cdNW, cdNNW, cdNNW, cdNorth };

auto CompassDirnByBinary(const double inBearing) -> TCompassDirection
{
  int I;
  //Bytes: array[0..7] of Byte absolute inBearing;
//  B  : packed record                //
//       x : array[0..4] of Byte;     //
//       I : word;                    //  slower by 5 ms than doing the Byte calculation
//       z : Byte;                    //
//  end absolute inBearing;           //
//
//  var w : word := 0x3680;            // for reseach purposes ... stored as 80 36 in Win


  //auto result = cdNorth; // { edited from original post - Thanks Mark Griffiths }    // d   235 ms
//  for (auto cd = 0; cd < TCD; ++cd)                                                  // c++ 170 ms
//	   if ( inBearing < d[cd] )   return TCompassDirection(cd);

// - - - - - - - - -

  //I := inBearing.Bytes[6] shl 8 + inBearing.Bytes[5];
//  I := Bytes[6] shl 8 + Bytes[5];                                                    // d saves 35 ms
  const auto Bytes = (std::byte*)(&inBearing);

  I = ( (int)Bytes[6] << 8 ) + (int)Bytes[5];

// - - - - - - - - -

//  for var cd := cdNorth to cdNNW do                                                  // d 175 ms
//	  if I < CompPoints[cd] then begin
//		Result := cd;
//		Exit;
//	  end;

// - - - - - - - - -

  for (int cd = 0; cd < 15; ++cd)                                                      // d   170 ms
	  if ( I < cp[cd] )  return TCompassDirection(cd);                                 // c++ 100 ms

// - - - - - - - - -

//    if I < CompPoints[ cdNorth] )  { return cdNorth; }                               // d   135 ms
//    else
//    if I < CompPoints[ cdNNE  ] )  { return cdNNE  ; exit; end
//    else
//    if I < CompPoints[ cdNE   ] )  { return cdNE   ; exit; end
//    else
//    if I < CompPoints[ cdENE  ] )  { return cdENE  ; exit; end
//    else
//    if I < CompPoints[ cdEast ] )  { return cdEast ; exit; end
//    else
//    if I < CompPoints[ cdESE  ] )  { return cdESE  ; exit; end
//    else
//    if I < CompPoints[ cdSE   ] )  { return cdSE   ; exit; end
//    else
//    if I < CompPoints[ cdSSE  ] )  { return cdSSE  ; exit; end
//    else
//    if I < CompPoints[ cdSouth] )  { return cdSouth; exit; end
//    else
//    if I < CompPoints[ cdSSW  ] )  { return cdSSW  ; exit; end
//    else
//    if I < CompPoints[ cdSW   ] )  { return cdSW   ; exit; end
//    else
//    if I < CompPoints[ cdWSW  ] )  { return cdWSW  ; exit; end
//    else
//    if I < CompPoints[ cdWest ] )  { return cdWest ; exit; end
//    else
//    if I < CompPoints[ cdWNW  ] )  { return cdWNW  ; exit; end
//    else
//    if I < CompPoints[ cdNW   ] )  { return cdNW   ; exit; end
//    else
//    if I < CompPoints[ cdNNW  ] )  { return cdNNW  ; exit; end

// - - - - - - - - -

//	if ( I < cp[ 0] )  { return TCompassDirection( 0); }                               // d   135 ms
//	else                                                                               // c++ 100 ms
//	if ( I < cp[ 1] )  { return TCompassDirection( 1); }
//	else
//	if ( I < cp[ 2] )  { return TCompassDirection( 2); }
//	else
//	if ( I < cp[ 3] )  { return TCompassDirection( 3); }
//	else
//	if ( I < cp[ 4] )  { return TCompassDirection( 4); }
//	else
//	if ( I < cp[ 5] )  { return TCompassDirection( 5); }
//	else
//	if ( I < cp[ 6] )  { return TCompassDirection( 6); }
//	else
//	if ( I < cp[ 7] )  { return TCompassDirection( 7); }
//	else
//	if ( I < cp[ 8] )  { return TCompassDirection( 8); }
//	else
//	if ( I < cp[ 9] )  { return TCompassDirection( 9); }
//	else
//	if ( I < cp[10] )  { return TCompassDirection(10); }
//	else
//	if ( I < cp[11] )  { return TCompassDirection(11); }
//	else
//	if ( I < cp[12] )  { return TCompassDirection(12); }
//	else
//	if ( I < cp[13] )  { return TCompassDirection(13); }
//	else
//	if ( I < cp[14] )  { return TCompassDirection(14); }
//	else
//	if ( I < cp[15] )  { return TCompassDirection(15); }

}



// Courtesy of Scott Sedgwick - ADUG User Forum - https://forums.adug.org.au/t/optimize-this-compass-directions-code/59083/12
auto CompassDirectionOf2(const double inBearing) -> TCompassDirection
{
  const auto DEGREES_PER_DIRECTION = 360 / TCD;
  const auto ANTI_CLOCKWISE_OFFSET = DEGREES_PER_DIRECTION / 2;

  //return TCompassDirection( int(inBearing) / DEGREES_PER_DIRECTION);
  return TCompassDirection( ( int(inBearing) + ANTI_CLOCKWISE_OFFSET ) / DEGREES_PER_DIRECTION);
}


auto CompassDirectionOf3(const double inBearing) -> TCompassDirection
{
  const auto DEGREES_PER_DIRECTION = 360 / TCD /2;

  return TCompassDirection( inBearing  / DEGREES_PER_DIRECTION );
}
