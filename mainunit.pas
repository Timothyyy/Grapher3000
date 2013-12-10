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
    ToolBar: TToolBar;
    AddVertex: TToolButton;
    AddEdge: TToolButton;
    Devider: TToolButton;
    DeleteVertex: TToolButton;
    DeleteEdge: TToolButton;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure GraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MatrixGridColRowInserted(Sender: TObject; IsColumn: Boolean;
      sIndex, tIndex: Integer);
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

//MouseClick on Graph handler
procedure TMainForm.GraphMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TempVertex: TVertex;
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
  if ToolButton1.Down then
    ShowMessage(IntToStr(Vertices.Count));
  if AddEdge.Down then
  begin
    if BeginVertex <> Nil then
    begin
      if CheckVertex(TempVertex, Vertices) and (BeginVertex <> TempVertex) then
      begin
        if EdgeNotExists(BeginVertex, TempVertex, Edges)then
        begin
          DrawEdge(BeginVertex, TempVertex, Graph, Edges);
          MatrixGrid.Cells[BeginVertex.Id, TempVertex.Id] := '1';
          MatrixGrid.Cells[TempVertex.Id, BeginVertex.Id] := '1';
        end;
        BeginVertex := Nil;
        ShowMessage(IntToStr(Edges.Count));
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

end.
