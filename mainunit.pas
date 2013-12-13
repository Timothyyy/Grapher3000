unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Grids, Menus, Buttons, VerticesHelper, EdgesHelper, CustomClasses;

type

  { TMainForm }

  TMainForm = class(TForm)
    ImageList: TImageList;
    PageControl: TPageControl;
    GraphicalView: TTabSheet;
    Graph: TImage;
    MatrixView: TTabSheet;
    MatrixGrid: TStringGrid;
    DirectionType: TRadioGroup;
    Devider2: TToolButton;
    ClearGraph: TToolButton;
    ToolButton1: TToolButton;
    WeightType: TRadioGroup;
    ToolBar: TToolBar;
    AddVertex: TToolButton;
    AddEdge: TToolButton;
    Devider1: TToolButton;
    DeleteVertex: TToolButton;
    DeleteEdge: TToolButton;
    procedure ClearGraphClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GraphMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure MatrixGridColRowInserted(Sender: TObject; IsColumn: Boolean;
      sIndex, tIndex: Integer);
    procedure ToolButton1Click(Sender: TObject);
  private
    { private declarations }
    Edges: TList;
    Vertices: TList;
    BeginVertex: TVertex;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

//Setting of all requirements
procedure TMainForm.FormCreate(Sender: TObject);
begin
  Vertices := TList.Create;
  Edges := TList.Create;
  Graph.Canvas.Rectangle(Graph.BoundsRect);
  Graph.Canvas.Clear;
  BeginVertex := Nil;
end;

procedure TMainForm.ClearGraphClick(Sender: TObject);
begin
  Graph.Canvas.Clear;
  Vertices.Clear;
  Edges.Clear;
  MatrixGrid.ColCount := 1;
  MatrixGrid.RowCount := 1;
  BeginVertex := Nil;
end;

//MouseClick on Graph handler
procedure TMainForm.GraphMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TempVertex: TVertex;
  Weight: Integer;
begin
  TempVertex := TVertex.Create(Vertices.Count + 1, X, Y);
  if AddVertex.Down and VerticesNotIntersect(TempVertex, Vertices) then
  begin
    DrawVertex(TempVertex, Graph, Vertices);
    MatrixGrid.ColCount := Vertices.Count + 1;
    MatrixGrid.RowCount := Vertices.Count + 1;
    MatrixGrid.Cells[0, TempVertex.Id] := IntToStr(TempVertex.Id);
    MatrixGrid.Cells[TempVertex.Id, 0] := IntToStr(TempVertex.Id);
  end;
  TempVertex := FindVertex(X, Y, Vertices);
  if AddEdge.Down then
  begin
    if BeginVertex <> Nil then
    begin
      if CheckVertex(TempVertex, Vertices) and (BeginVertex <> TempVertex) then
      begin
        if EdgeNotExists(BeginVertex, TempVertex, Edges)then
        begin
          Weight := 1;
          if WeightType.ItemIndex = 1 then
            Weight := StrToInt(InputBox('Grapher3000', 'Input edge weight:', '1'));
          DrawEdge(BeginVertex, TempVertex, Graph, Edges, Weight);
          MatrixGrid.Cells[BeginVertex.Id, TempVertex.Id] := IntToStr(Weight);
          MatrixGrid.Cells[TempVertex.Id, BeginVertex.Id] := IntToStr(Weight);
        end;
        BeginVertex := Nil;
      end;
    end
    else if CheckVertex(TempVertex, Vertices) then
        BeginVertex := TempVertex;
  end;
  if DeleteVertex.Down then
    if CheckVertex(TempVertex, Vertices) then
    begin
      RemoveVertex(TempVertex, Vertices, Edges, Graph);
    end;
end;

procedure TMainForm.GraphMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i: Integer;
begin
  Graph.Cursor := crDefault;
  if DeleteEdge.Down then
    for i := 0 to Edges.Count - 1 do
      if CursorOnEdge(Point(X, Y), TEdge(Edges[i]).Start, TEdge(Edges[i]).Finish) then
      begin
        Graph.Cursor := crHandPoint;
        Break;
      end;
end;

procedure TMainForm.MatrixGridColRowInserted(Sender: TObject;
  IsColumn: Boolean; sIndex, tIndex: Integer);
var
  i: Integer;
begin
  if IsColumn then
    for i := 1 to Vertices.Count - 1 do
      MatrixGrid.Cells[Vertices.Count, i] := '0'
  else
    for i := 1 to Vertices.Count do
      MatrixGrid.Cells[i, Vertices.Count] := '0';
end;

procedure TMainForm.ToolButton1Click(Sender: TObject);
begin
  ShowMessage('Vertices: ' + IntToStr(Vertices.Count) + Char(#10) + 'Edges: ' + IntToStr(Edges.Count));
end;

end.
