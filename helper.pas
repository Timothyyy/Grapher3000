unit Helper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics;

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

  function CheckVertex(Vertex: TVertex; Verteces: TList): Boolean;

  procedure DrawVertex(Vertex: TVertex; Graph: TImage; Verteces: TList);

  function FindVertex(const X, Y: Integer; Verteces: TList): TVertex;

  procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList; const Weight: Integer = 1);

  function EdgeNotExists(BeginVertex, EndVertex: TVertex; Edges: TList): Boolean;

  function VertecesNotIntersect(Vertex: TVertex; Verteces: TList): Boolean;

  function PointInVertex(Point: TPoint; Vertex: TVertex): Boolean;

  procedure RemoveVertex(Vertex: TVertex; Verteces, Edges: TList; Graph: TImage);

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

//Edge drawing
procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList; const Weight: Integer = 1);
var
  x1, y1, x2, y2: Integer;
begin
  case BeginVertex.Y - EndVertex.Y of
    Low(Integer)..-51:
    begin
      x2 := 0;
      y2 := -10;
      if BeginVertex.X - EndVertex.X >= 150 then
      begin
        x1 := -10;
        y1 := 0;
      end
      else if abs(BeginVertex.X - EndVertex.X) < 150 then
      begin
        x1 := 0;
        y1 := 10;
      end
      else if BeginVertex.X - EndVertex.X <= - 150 then
      begin
        x1 := 10;
        y1 := 0;
      end;
    end;
    -50..50:
    begin
      y1 := 0;
      y2 := 0;
      if BeginVertex.X - EndVertex.X < -50 then
      begin
        x1 := 10;
        x2 := -10;
      end
      else if BeginVertex.X - EndVertex.X > 50 then
      begin
        x1 := -10;
        x2 := 10;
      end
      else
      begin
        x1 := 0;
        x2 := 0;
        if BeginVertex.Y < EndVertex.Y then
        begin
          y1 := 10;
          y2 := -10;
        end
        else
        begin
          y1 := -10;
          y2 := 10;
        end;
      end;
    end;
    51..High(Integer):
    begin
      x1 := 0;
      y1 := -10;
      if BeginVertex.X - EndVertex.X >= 150 then
      begin
        x2 := 10;
        y2 := 0;
      end
      else if abs(BeginVertex.X - EndVertex.X) < 150 then
      begin
        x2 := 0;
        y2 := 10;
      end
      else if BeginVertex.X - EndVertex.X <= - 150 then
      begin
        x2 := -10;
        y2 := 0;
      end;
    end;
  end;
  Edges.Add(TEdge.Create(Edges.Count + 1, Point(BeginVertex.X + x1, BeginVertex.Y + y1),
    Point(EndVertex.X + x2, EndVertex.Y + y2), 1));
  Graph.Canvas.Line(BeginVertex.X + x1, BeginVertex.Y + y1, EndVertex.X + x2, EndVertex.Y + y2);
  Graph.Canvas.TextOut(Round((BeginVertex.X + x1 + EndVertex.X + x2) / 2), Round((BeginVertex.Y + y1 + EndVertex.Y + y2) / 2), IntToStr(Weight));
end;

//Is the Edge already exists?
function EdgeNotExists(BeginVertex, EndVertex: TVertex; Edges: TList): Boolean;
var
  i: integer;
begin
  Result := True;
  for i := 0 to Edges.Count - 1 do
    if (PointInVertex(TEdge(Edges[i]).Start, BeginVertex) and PointInVertex(TEdge(Edges[i]).Finish, EndVertex)) or
      (PointInVertex(TEdge(Edges[i]).Start, EndVertex) and PointInVertex(TEdge(Edges[i]).Finish, BeginVertex)) then
    begin
      Result := False;
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
