unit EdgesHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, CustomClasses, VerticesHelper, Math;

  procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList; const Weight: Integer = 1);

  function EdgeNotExists(BeginVertex, EndVertex: TVertex; Edges: TList): Boolean;

  function CursorOnEdge(Cursor, Start, Finish: TPoint): Boolean;

implementation

//Edge drawing
procedure DrawEdge(BeginVertex, EndVertex: TVertex; Graph: TImage; Edges: TList; const Weight: Integer);
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

//Is cursor on edge?
function CursorOnEdge(Cursor, Start, Finish: TPoint): Boolean;
begin
  Result := RoundTo((Cursor.X - Start.X) / (Finish.X - Start.X), -1) =
            RoundTo((Cursor.Y - Start.Y) / (Finish.Y - Start.Y), -1);
end;

end.

