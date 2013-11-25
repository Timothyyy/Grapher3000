unit Helper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

type
  //Vertex class
  TVertex = Class(TObject)
    private
      //Fields of Vertex class
      VertexId : Integer;
      VertexX : Integer;
      VertexY : Integer;
      //Id setter
      procedure SetId(const Id: Integer);
    public
      //Constructor
      constructor Create(const Id : Integer; const X : Integer; const Y : Integer);
      //Properties for read data
      property Id : Integer
          read VertexId
          write VertexId;
      property X : Integer
          read VertexX;
      property Y : Integer
          read VertexY;
  end;
function CheckVertex(X, Y : integer; verteces : TList): boolean;

implementation

//Implementing of TVertex class constructor
constructor TVertex.Create(const Id : Integer; const X : Integer; const Y : Integer);
begin
  self.VertexId := Id;
  self.VertexX := X;
  self.VertexY := Y;
end;

//Id setter of TVertex
procedure TVertex.SetId(const Id : integer);
begin
  self.VertexId := Id;
end;

//Is click point belongs to vertex?
function CheckVertex(X, Y: integer; verteces : TList): Boolean;
var
  res : Boolean;
  i : Integer;
begin
  res:=False;
  for i:=0 to verteces.Count - 1 do
  begin
    if power(X - TVertex(verteces[i]).X, 2) + power(Y - TVertex(verteces[i]).Y, 2) <= 100 then
      res:=True;
  end;
  CheckVertex:=res;
end;

end.
