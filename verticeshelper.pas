unit VerticesHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, CustomClasses;

  function CheckVertex(Vertex: TVertex; Vertices: TList): Boolean;

  procedure DrawVertex(Vertex: TVertex; Graph: TImage; Vertices: TList);

  function VerticesNotIntersect(Vertex: TVertex; Vertices: TList): Boolean;

  function PointInVertex(Point: TPoint; Vertex: TVertex): Boolean;

  function FindVertex(const X, Y: Integer; Vertices: TList): TVertex;

  procedure RemoveVertex(Vertex: TVertex; Vertices, Edges: TList; Graph: TImage);

implementation

//Is click point belongs to vertex?
function CheckVertex(Vertex: TVertex; Vertices: TList): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Vertices.Count - 1 do
    if Vertex = TVertex(Vertices[i]) then
    begin
      Result := True;
      Exit;
    end;
end;

//Vertex drawing
procedure DrawVertex(Vertex: TVertex; Graph: TImage; Vertices: TList);
begin
  Graph.Canvas.Ellipse(Vertex.X - 10, Vertex.Y - 10, Vertex.X + 10, Vertex.Y + 10);
  Graph.Canvas.TextOut(Vertex.X - 6, Vertex.Y - 8, IntToStr(Vertex.Id));
  Vertices.Add(Vertex);
end;

//Are Vertices intersect?
function VerticesNotIntersect(Vertex: TVertex; Vertices: TList): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Vertices.Count - 1 do
    if sqrt(sqr(TVertex(Vertices[i]).X - Vertex.X) + sqr(TVertex(Vertices[i]).Y - Vertex.Y)) <= 20 then
    begin
      Result := False;
      Exit;
    end;
end;

//Is point in vertex?
function PointInVertex(Point: TPoint; Vertex: TVertex): Boolean;
begin
  Result := False;
  if sqr(Point.X - Vertex.X) + sqr(Point.Y - Vertex.Y) <= 100 then
    Result := True;
end;

//Find vertex
function FindVertex(const X, Y: Integer; Vertices: TList): TVertex;
var
  i: Integer;
begin
  for i := 0 to Vertices.Count - 1 do
    if PointInVertex(Point(X, Y), TVertex(Vertices[i])) then
    begin
      Result := TVertex(Vertices[i]);
      Exit;
    end;
end;

//Vertex removing
procedure RemoveVertex(Vertex: TVertex; Vertices, Edges: TList; Graph: TImage);
var
  i: Integer;
begin
  Graph.Canvas.Pen.Color := clWhite;
  Graph.Canvas.EllipseC(Vertex.X, Vertex.Y, 10, 10);
  Vertices.Remove(Vertex);
  i := 0;
  while i <> Edges.Count do
  begin
    if PointInVertex(TEdge(Edges[i]).Start, Vertex) or PointInVertex(TEdge(Edges[i]).Finish, Vertex) then
    begin
      Graph.Canvas.Line(TEdge(Edges[i]).Start.X, TEdge(Edges[i]).Start.Y, TEdge(Edges[i]).Finish.X, TEdge(Edges[i]).Finish.Y);
      Edges.Delete(i);
      i := i -1;
    end;
    Inc(i);
  end;
  Graph.Canvas.Pen.Color := clBlack;
  for i := Vertex.Id - 1 to Vertices.Count - 1 do
  begin
    TVertex(Vertices[i]).Id := TVertex(Vertices[i]).Id - 1;
    Graph.Canvas.Ellipse(TVertex(Vertices[i]).X - 10, TVertex(Vertices[i]).Y - 10,
      TVertex(Vertices[i]).X + 10, TVertex(Vertices[i]).Y + 10);
    Graph.Canvas.TextOut(TVertex(Vertices[i]).X - 6, TVertex(Vertices[i]).Y - 8, IntToStr(TVertex(Vertices[i]).Id));
  end;
end;

end.
