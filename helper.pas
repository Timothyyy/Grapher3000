unit Helper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls;

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
      BeginVertex: TVertex;
      EndVertex: TVertex;
      EdgeWeight: Integer;
      procedure SetId(const Id: Integer);
    public
      //Constructor
      constructor Create(const Id: Integer; Start, Finish: TVertex; const Weight: Integer);
      //Properties for read/write data
      property Id: Integer
          read EdgeId
          write SetId;
      property Start: TVertex
          read BeginVertex;
      property Finish: TVertex
          read EndVertex;
      property Weight: Integer
          read EdgeWeight;
  end;

  function CheckVertex(Vertex: TVertex; Verteces: TList): Boolean;

  procedure DrawVertex(Vertex: TVertex; Graph: TImage; Verteces: TList);

  function FindVertex(const X, Y: Integer; Verteces: TList): TVertex;

  procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList);

  function EdgeNotExists(BeginVertex, EndVertex: TVertex; Edges: TList): Boolean;

  function VertecesNotIntersect(Vertex: TVertex; Verteces: TList): Boolean;

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
constructor TEdge.Create(const Id: Integer; Start, Finish: TVertex; const Weight: Integer);
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

//Is click point belongs to vertex?
function CheckVertex(Vertex: TVertex; Verteces: TList): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Verteces.Count - 1 do
    if sqr(Vertex.X - TVertex(Verteces[i]).X) + sqr(Vertex.Y - TVertex(Verteces[i]).Y) <= 100 then
    begin
      Result := True;
      Exit;
    end;
end;

//Vertex drawing
procedure DrawVertex(Vertex: TVertex; Graph: TImage; Verteces: TList);
begin
  graph.Canvas.Ellipse(Vertex.X - 10, Vertex.Y - 10, Vertex.X + 10, Vertex.Y + 10);
  graph.Canvas.TextOut(Vertex.X - 6, Vertex.Y - 8, IntToStr(Verteces.Count + 1));
  Verteces.Add(Vertex);
end;

//Are verteces intersect?
function VertecesNotIntersect(Vertex: TVertex; Verteces: TList): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Verteces.Count - 1 do
    if sqrt(sqr(TVertex(Verteces[i]).X - Vertex.X) + sqr(TVertex(Verteces[i]).Y - Vertex.Y)) <= 20 then
    begin
      Result := False;
      Exit;
    end;
end;

//Find vertex
function FindVertex(const X, Y: Integer; Verteces: TList): TVertex;
var
  i: Integer;
begin
  for i := 0 to Verteces.Count - 1 do
    if sqr(X - TVertex(Verteces[i]).X) + sqr(Y - TVertex(Verteces[i]).Y) <= 100 then
    begin
      Result := TVertex(Verteces[i]);
      Exit;
    end;
end;

//Edge drawing
procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList);
begin
  Edges.Add(TEdge.Create(Edges.Count + 1, BeginVertex, EndVertex, 1));
  Graph.Canvas.Line(BeginVertex.X, BeginVertex.Y, EndVertex.X, EndVertex.Y);
end;

//Is the Edge already exists?
function EdgeNotExists(BeginVertex, EndVertex: TVertex; Edges: TList): Boolean;
var
  i: integer;
begin
  Result := True;
  for i := 0 to Edges.Count - 1 do
    if ((TEdge(Edges[i]).Start = BeginVertex) and (TEdge(Edges[i]).Finish = EndVertex)) or
    ((TEdge(Edges[i]).Start = EndVertex) and (TEdge(Edges[i]).Finish = BeginVertex)) then
    begin
      Result := False;
      Exit;
    end;
end;

end.
