unit VertecesHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, CustomClasses;

  function CheckVertex(Vertex: TVertex; Verteces: TList): Boolean;

  procedure DrawVertex(Vertex: TVertex; Graph: TImage; Verteces: TList);

  function VertecesNotIntersect(Vertex: TVertex; Verteces: TList): Boolean;

  function PointInVertex(Point: TPoint; Vertex: TVertex): Boolean;

  function FindVertex(const X, Y: Integer; Verteces: TList): TVertex;

  procedure RemoveVertex(Vertex: TVertex; Verteces, Edges: TList; Graph: TImage);

implementation

//Is click point belongs to vertex?
function CheckVertex(Vertex: TVertex; Verteces: TList): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Verteces.Count - 1 do
    if Vertex = TVertex(Verteces[i]) then
    begin
      Result := True;
      Exit;
    end;
end;

//Vertex drawing
procedure DrawVertex(Vertex: TVertex; Graph: TImage; Verteces: TList);
begin
  Graph.Canvas.Ellipse(Vertex.X - 10, Vertex.Y - 10, Vertex.X + 10, Vertex.Y + 10);
  Graph.Canvas.TextOut(Vertex.X - 6, Vertex.Y - 8, IntToStr(Vertex.Id));
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

//Is point in vertex?
function PointInVertex(Point: TPoint; Vertex: TVertex): Boolean;
begin
  Result := False;
  if sqr(Point.X - Vertex.X) + sqr(Point.Y - Vertex.Y) <= 100 then
    Result := True;
end;

//Find vertex
function FindVertex(const X, Y: Integer; Verteces: TList): TVertex;
var
  i: Integer;
begin
  for i := 0 to Verteces.Count - 1 do
    if PointInVertex(Point(X, Y), TVertex(Verteces[i])) then
    begin
      Result := TVertex(Verteces[i]);
      Exit;
    end;
end;

//Vertex removing
procedure RemoveVertex(Vertex: TVertex; Verteces, Edges: TList; Graph: TImage);
var
  i: Integer;
begin
  Graph.Canvas.Pen.Color := clWhite;
  Graph.Canvas.EllipseC(Vertex.X, Vertex.Y, 10, 10);
  Verteces.Remove(Vertex);
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
  for i := Vertex.Id - 1 to Verteces.Count - 1 do
  begin
    TVertex(Verteces[i]).Id := TVertex(Verteces[i]).Id - 1;
    Graph.Canvas.Ellipse(TVertex(Verteces[i]).X - 10, TVertex(Verteces[i]).Y - 10,
      TVertex(Verteces[i]).X + 10, TVertex(Verteces[i]).Y + 10);
    Graph.Canvas.TextOut(TVertex(Verteces[i]).X - 6, TVertex(Verteces[i]).Y - 8, IntToStr(TVertex(Verteces[i]).Id));
  end;
end;

end.
