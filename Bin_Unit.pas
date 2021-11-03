unit Bin_Unit;

interface

function bin8 ( X : integer ) : string;
function bin7 ( X : integer ) : string;
function bin04( X : integer ) : string;
function bin40( X : integer ) : string;
function hex40( X : integer ) : string;
function hex04( X : integer ) : string;
function hex8 ( X : integer ) : string;

implementation
uses System.SysUtils;

function bin8( X : integer ) : string;
begin
  var s:='';
  for var i := 7 downto 0 do
      if (X and (1 shl i))>0 then s:=s+'1' else s:=s+'0';
  result := s;
end;

function bin7( X : integer ) : string;
begin
  var s:='';
  for var i := 6 downto 0 do
      if (X and (1 shl i))>0 then s:=s+'1' else s:=s+'0';
  result := s;
end;

function bin04( X : integer ) : string;
begin
  var s:='';
  for var i := 3 downto 0 do
      if (X and (1 shl i))>0 then s:=s+'1' else s:=s+'0';
  result := s;
end;

function bin40( X : integer ) : string;
begin
  var s:='';
  for var i := 7 downto 4 do
      if (X and (1 shl i))>0 then s:=s+'1' else s:=s+'0';
  result := s;
end;

function hex40( X : integer ) : string;
begin
  var s:='';
  X := X shr 4;
  result := format('%x', [ X ] );
end;

function hex04( X : integer ) : string;
begin
  var s:='';
  result := format('%x', [ X ] );
end;

function hex8( X : integer ) : string;
begin
  var  s :='';
  var  Y := X shr 4;
       X := X and $0F;
  result := format('%x', [ Y ] ) + format('%x', [ X ] );
end;

end.
