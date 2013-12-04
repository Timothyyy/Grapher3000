unit CustomClasses;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  //Vertex class
  TVertex = Class(TObject)
    private
      //Fields of TVertex class
      VertexId: Integer;
      VertexX: Integer;
      VertexY: Integer;
      //Id setter
      procedure SetId(const Id: Integer);
    public
      //Constructor
      constructor Create(const Id: Integer; const X: Integer; const Y: Integer);
      //Properties for read/write data
      property Id: Integer
          read VertexId
          write SetId;
      property X: Integer
          read VertexX;
      property Y: Integer
          read VertexY;
  end;

  //Edge class
  TEdge = Class(TObject)
    private
      //Fields of TEdge
      EdgeId: Integer;
      BeginVertex: TPoint;
      EndVertex: TPoint;
      EdgeWeight: Integer;
      procedure SetId(const Id: Integer);
    public
      //Constructor
      constructor Create(const Id: Integer; Start, Finish: TPoint; const Weight: Integer);
      //Properties for read/write data
      property Id: Integer
          read EdgeId
          write SetId;
      property Start: TPoint
          read BeginVertex;
      property Finish: TPoint
          read EndVertex;
      property Weight: Integer
          read EdgeWeight;
  end;

implementation

//TVertex class constructor
constructor TVertex.Create(const Id: Integer; const X: Integer; const Y: Integer);
begin
  Self.VertexId := Id;
  Self.VertexX := X;
  Self.VertexY := Y;
end;

//Id setter of TVertex
procedure TVertex.SetId(const Id: Integer);
begin
  self.VertexId := Id;
end;

//TEdge class constructor
constructor TEdge.Create(const Id: Integer; Start, Finish: TPoint; const Weight: Integer);
begin
  Self.EdgeId := Id;
  Self.BeginVertex := Start;
  Self.EndVertex := Finish;
  Self.EdgeWeight := Weight;
end;

//Id setter of TEdge
procedure TEdge.SetId(const Id: Integer);
begin
  Self.EdgeId := Id;
end;

end.

