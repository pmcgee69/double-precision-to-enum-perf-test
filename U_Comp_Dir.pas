unit U_Comp_Dir;

interface

type
  TCompassDirection = (cdNorth, cdNNE, cdNE, cdENE,
                       cdEast,  cdESE, cdSE, cdSSE,
                       cdSouth, cdSSW, cdSW, cdWSW,
                       cdWest,  cdWNW, cdNW, cdNNW);

function CompassDirectionOf2(const inBearing : double) : TCompassDirection;
function CompassDirectionOf3(const inBearing : double) : TCompassDirection;
function CompassDirectionOf (const inBearing : double) : TCompassDirection;
function CompassDirnByBinary(const inBearing : double) : TCompassDirection;


implementation
uses System.SysUtils;

const
  CompPoints  : array [ TCompassDirection ] of integer
                      = ( $3680, $4680, $50E0, $5680, $5C20, $60E0, $63B0, $6680,
                          $6950, $6C20, $6EF0, $70E0, $7248, $73B0, $7518, $7680  );

        intcp : array [ 0..15 ] of integer
                      = ( $3680, $4680, $50E0, $5680, $5C20, $60E0, $63B0, $6680,
                          $6950, $6C20, $6EF0, $70E0, $7248, $73B0, $7518, $7680  );

       cardcp : array [ 0..15 ] of integer
                      = ( $368000, $468000, $50E000, $568000, $5C2000, $60E000, $63B000, $668000,
                          $695000, $6C2000, $6EF000, $70E000, $724800, $73B000, $751800, $768000  );


            d : array [ TCompassDirection ] of double
                      = (   22.5,  45.0,  67.5,  90.0, 112.5, 135.0, 157.5, 180.0,
                           202.5, 225.0, 247.5, 270.0, 292.5, 315.0, 337.5, 360.0 );


function CompassDirnByBinary(const inBearing : double) : TCompassDirection;
var
  I  : integer;
  //Bytes: array[0..7] of Byte absolute inBearing;
  Cards: array[0..1] of cardinal absolute inBearing;

begin

//  Result := cdNorth; { edited from original post - Thanks Mark Griffiths }    // 235 ms
//  for var cd := cdNorth to cdNNW do
//      if inBearing < d[cd] then
//          exit( cd );

// - - - - - - - - -

  //I := inBearing.Bytes[6] shl 8 + inBearing.Bytes[5];
  //I := Bytes[6] shl 8 + Bytes[5];                                               // saves 35 ms
  I := (Cards[1] and $00FFFF00);

// - - - - - - - - -

//  for var cd := cdNorth to cdNNW do                                           // 175 ms
//      if I < CompPoints[cd] then
//        exit( cd );

// - - - - - - - - -

//  for var cd := 0 to 15 do                                                    // 170 ms
//      if I < intcp[cd] then
//        exit( TCompassDirection(cd) );                                        // points[cd] = slower

// - - - - - - - - -

//    if I < intcp[ 0] then exit( TCompassDirection( 0) )       // 135 ms
//    else
//    if I < intcp[ 1] then exit( TCompassDirection( 1) )
//    else
//    if I < intcp[ 2] then exit( TCompassDirection( 2) )
//    else
//    if I < intcp[ 3] then exit( TCompassDirection( 3) )
//    else
//    if I < intcp[ 4] then exit( TCompassDirection( 4) )
//    else
//    if I < intcp[ 5] then exit( TCompassDirection( 5) )
//    else
//    if I < intcp[ 6] then exit( TCompassDirection( 6) )
//    else
//    if I < intcp[ 7] then exit( TCompassDirection( 7) )
//    else
//    if I < intcp[ 8] then exit( TCompassDirection( 8) )
//    else
//    if I < intcp[ 9] then exit( TCompassDirection( 9) )
//    else
//    if I < intcp[10] then exit( TCompassDirection(10) )
//    else
//    if I < intcp[11] then exit( TCompassDirection(11) )
//    else
//    if I < intcp[12] then exit( TCompassDirection(12) )
//    else
//    if I < intcp[13] then exit( TCompassDirection(13) )
//    else
//    if I < intcp[14] then exit( TCompassDirection(14) )
//    else
//    if I < intcp[15] then exit( TCompassDirection(15) )

// - - - - - - - - -

    if I < cardcp[ 0] then exit( TCompassDirection( 0) )       // 135 ms
    else
    if I < cardcp[ 1] then exit( TCompassDirection( 1) )
    else
    if I < cardcp[ 2] then exit( TCompassDirection( 2) )
    else
    if I < cardcp[ 3] then exit( TCompassDirection( 3) )
    else
    if I < cardcp[ 4] then exit( TCompassDirection( 4) )
    else
    if I < cardcp[ 5] then exit( TCompassDirection( 5) )
    else
    if I < cardcp[ 6] then exit( TCompassDirection( 6) )
    else
    if I < cardcp[ 7] then exit( TCompassDirection( 7) )
    else
    if I < cardcp[ 8] then exit( TCompassDirection( 8) )
    else
    if I < cardcp[ 9] then exit( TCompassDirection( 9) )
    else
    if I < cardcp[10] then exit( TCompassDirection(10) )
    else
    if I < cardcp[11] then exit( TCompassDirection(11) )
    else
    if I < cardcp[12] then exit( TCompassDirection(12) )
    else
    if I < cardcp[13] then exit( TCompassDirection(13) )
    else
    if I < cardcp[14] then exit( TCompassDirection(14) )
    else
    if I < cardcp[15] then exit( TCompassDirection(15) )

end;


const
  halfpoints  : array [ 0..32 ] of TCompassDirection
					  = (           cdNorth, cdNNE, cdNNE, cdNE, cdNE, cdENE, cdENE,
						     cdEast,  cdEast,  cdESE, cdESE, cdSE, cdSE, cdSSE, cdSSE,          // deliberate, temporary
                 cdSouth, cdSouth, cdSSW, cdSSW, cdSW, cdSW, cdWSW, cdWSW,          // range error hack
						     cdWest,  cdWest,  cdWNW, cdWNW, cdNW, cdNW, cdNNW, cdNNW, cdNorth, cdNorth );

  DEGREES_PER_DIRECTION_2 = 360 / (Ord(High(TCompassDirection)) + 1) / 2;

function CompassDirectionOf3(const inBearing : double) : TCompassDirection;
begin
  Result := halfpoints[ trunc( inBearing / DEGREES_PER_DIRECTION_2 ) ];
end;



const
       points : array [ 0..15 ] of TCompassDirection
                      = ( cdNorth, cdNNE, cdNE, cdENE,
                          cdEast,  cdESE, cdSE, cdSSE,
                          cdSouth, cdSSW, cdSW, cdWSW,
                          cdWest,  cdWNW, cdNW, cdNNW  );

// Courtesy of Scott Sedgwick - ADUG User Forum - https://forums.adug.org.au/t/optimize-this-compass-directions-code/59083/12
function CompassDirectionOf2(const inBearing : double) : TCompassDirection;
const
  DEGREES_PER_DIRECTION = 360 div (Ord(High(TCompassDirection)) + 1);
  ANTI_CLOCKWISE_OFFSET = DEGREES_PER_DIRECTION div 2;
begin
  Result := TCompassDirection((Round(inBearing) + ANTI_CLOCKWISE_OFFSET) div DEGREES_PER_DIRECTION);
  //Result := points[ (Round(inBearing) + ANTI_CLOCKWISE_OFFSET) div DEGREES_PER_DIRECTION ];
end;


// Courtesy of Lachlan Gemmell - ADUG User Forum - https://forums.adug.org.au/t/optimize-this-compass-directions-code/59083/1
function CompassDirectionOf(const inBearing : double) : TCompassDirection;
const
  DEGREES_PER_DIRECTION = 360 / (Ord(High(TCompassDirection)) + 1);
  ANTI_CLOCKWISE_OFFSET = DEGREES_PER_DIRECTION / 2;
  BOUNDARY_MARGIN = 1;
var
  cd : TCompassDirection;
begin

  case Round(inBearing) of

    0
    ..Round(((Ord(cdNorth) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdNorth;

    Round((Ord(cdNNE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdNNE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdNNE;

    Round((Ord(cdNE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdNE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdNE;

    Round((Ord(cdENE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdENE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdENE;

    Round((Ord(cdEast) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdEast) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdEast;

    Round((Ord(cdESE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdESE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdESE;

    Round((Ord(cdSE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdSE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdSE;

    Round((Ord(cdSSE) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdSSE) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdSSE;

    Round((Ord(cdSouth) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdSouth) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdSouth;

    Round((Ord(cdSSW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdSSW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdSSW;

    Round((Ord(cdSW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdSW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdSW;

    Round((Ord(cdWSW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdWSW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdWSW;

    Round((Ord(cdWest) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdWest) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdWest;

    Round((Ord(cdWNW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdWNW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdWNW;

    Round((Ord(cdNW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdNW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdNW;

    Round((Ord(cdNNW) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN
    ..Round(((Ord(cdNNW) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) - BOUNDARY_MARGIN:
      Result := cdNNW;

    Round((Ord(cdNorth) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) + BOUNDARY_MARGIN + 360 { negative degree values converted to almost 360 degree values }
    ..360:
      Result := cdNorth;

  else
    { bearing is between the integer boundary margins, so do
    an exact check against the floating point boundaries }
    Result := cdNorth; { edited from original post - Thanks Mark Griffiths }
    for cd := cdNorth to cdNNW do begin
      if inBearing <= (((Ord(cd) + 1) * DEGREES_PER_DIRECTION) - ANTI_CLOCKWISE_OFFSET) then begin
        Result := cd;
        Exit;
      end;
    end;
  end;
end;


end.
