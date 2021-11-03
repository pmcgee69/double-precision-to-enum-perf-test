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

           cp : array [ 0..15 ] of integer
                      = ( $3680, $4680, $50E0, $5680, $5C20, $60E0, $63B0, $6680,
                          $6950, $6C20, $6EF0, $70E0, $7248, $73B0, $7518, $7680  );

            d : array [ TCompassDirection ] of double
                      = (   22.5,  45.0,  67.5,  90.0, 112.5, 135.0, 157.5, 180.0,
                           202.5, 225.0, 247.5, 270.0, 292.5, 315.0, 337.5, 360.0 );

function CompassDirnByBinary(const inBearing : double) : TCompassDirection;
var
  I  : integer;
  Bytes: array[0..7] of Byte absolute inBearing;
//  B  : packed record                //
//       x : array[0..4] of Byte;     //
//       I : word;                    //  slower by 5 ms than doing the Byte calculation
//       z : Byte;                    //
//  end absolute inBearing;           //
//
//  var w : word := $3680;            // for reseach purposes ... stored as 80 36 in Win
begin

//  Result := cdNorth; { edited from original post - Thanks Mark Griffiths }    // 235 ms
//  for var cd := cdNorth to cdNNW do
//      if inBearing < d[cd] then begin
//        Result := cd;
//        Exit;
//      end;

// - - - - - - - - -

  //I := inBearing.Bytes[6] shl 8 + inBearing.Bytes[5];
  I := Bytes[6] shl 8 + Bytes[5];                                               // saves 35 ms

// - - - - - - - - -

//  for var cd := cdNorth to cdNNW do                                           // 175 ms
//      if I < CompPoints[cd] then begin
//        Result := cd;
//        Exit;
//      end;

// - - - - - - - - -

//  for var cd := 0 to 15 do                                                    // 170 ms
//      if I < cp[cd] then begin
//        Result := TCompassDirection(cd);
//        Exit;
//      end;

// - - - - - - - - -

//    if I < CompPoints[ cdNorth] then begin Result := cdNorth; exit; end       // 135 ms
//    else
//    if I < CompPoints[ cdNNE  ] then begin Result := cdNNE  ; exit; end
//    else
//    if I < CompPoints[ cdNE   ] then begin Result := cdNE   ; exit; end
//    else
//    if I < CompPoints[ cdENE  ] then begin Result := cdENE  ; exit; end
//    else
//    if I < CompPoints[ cdEast ] then begin Result := cdEast ; exit; end
//    else
//    if I < CompPoints[ cdESE  ] then begin Result := cdESE  ; exit; end
//    else
//    if I < CompPoints[ cdSE   ] then begin Result := cdSE   ; exit; end
//    else
//    if I < CompPoints[ cdSSE  ] then begin Result := cdSSE  ; exit; end
//    else
//    if I < CompPoints[ cdSouth] then begin Result := cdSouth; exit; end
//    else
//    if I < CompPoints[ cdSSW  ] then begin Result := cdSSW  ; exit; end
//    else
//    if I < CompPoints[ cdSW   ] then begin Result := cdSW   ; exit; end
//    else
//    if I < CompPoints[ cdWSW  ] then begin Result := cdWSW  ; exit; end
//    else
//    if I < CompPoints[ cdWest ] then begin Result := cdWest ; exit; end
//    else
//    if I < CompPoints[ cdWNW  ] then begin Result := cdWNW  ; exit; end
//    else
//    if I < CompPoints[ cdNW   ] then begin Result := cdNW   ; exit; end
//    else
//    if I < CompPoints[ cdNNW  ] then begin Result := cdNNW  ; exit; end

// - - - - - - - - -

    if I < cp[ 0] then begin Result := TCompassDirection( 0); exit; end       // 135 ms
    else
    if I < cp[ 1] then begin Result := TCompassDirection( 1); exit; end
    else
    if I < cp[ 2] then begin Result := TCompassDirection( 2); exit; end
    else
    if I < cp[ 3] then begin Result := TCompassDirection( 3); exit; end
    else
    if I < cp[ 4] then begin Result := TCompassDirection( 4); exit; end
    else
    if I < cp[ 5] then begin Result := TCompassDirection( 5); exit; end
    else
    if I < cp[ 6] then begin Result := TCompassDirection( 6); exit; end
    else
    if I < cp[ 7] then begin Result := TCompassDirection( 7); exit; end
    else
    if I < cp[ 8] then begin Result := TCompassDirection( 8); exit; end
    else
    if I < cp[ 9] then begin Result := TCompassDirection( 9); exit; end
    else
    if I < cp[10] then begin Result := TCompassDirection(10); exit; end
    else
    if I < cp[11] then begin Result := TCompassDirection(11); exit; end
    else
    if I < cp[12] then begin Result := TCompassDirection(12); exit; end
    else
    if I < cp[13] then begin Result := TCompassDirection(13); exit; end
    else
    if I < cp[14] then begin Result := TCompassDirection(14); exit; end
    else
    if I < cp[15] then begin Result := TCompassDirection(15); exit; end

end;


const
  halfpoints  : array [ 0..31 ] of TCompassDirection
					  = (           cdNorth, cdNNE, cdNNE, cdNE, cdNE, cdENE, cdENE,
						     cdEast,  cdEast,  cdESE, cdESE, cdSE, cdSE, cdSSE, cdSSE,
                 cdSouth, cdSouth, cdSSW, cdSSW, cdSW, cdSW, cdWSW, cdWSW,
						     cdWest,  cdWest,  cdWNW, cdWNW, cdNW, cdNW, cdNNW, cdNNW, cdNorth );

const
  DEGREES_PER_DIRECTION_2 = 360 div (Ord(High(TCompassDirection)) + 1) div 2;

function CompassDirectionOf3(const inBearing : double) : TCompassDirection;
begin
  Result := halfpoints[ trunc( inBearing / DEGREES_PER_DIRECTION_2 ) ];
end;




// Courtesy of Scott Sedgwick - ADUG User Forum - https://forums.adug.org.au/t/optimize-this-compass-directions-code/59083/12
function CompassDirectionOf2(const inBearing : double) : TCompassDirection;
const
  DEGREES_PER_DIRECTION = 360 div (Ord(High(TCompassDirection)) + 1);
  ANTI_CLOCKWISE_OFFSET = DEGREES_PER_DIRECTION div 2;
begin
  Result := TCompassDirection((Round(inBearing) + ANTI_CLOCKWISE_OFFSET) div DEGREES_PER_DIRECTION);
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
