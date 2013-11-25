unit Helper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

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

end.
