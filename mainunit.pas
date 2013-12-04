unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Grids, Menus, Buttons, VertecesHelper, EdgesHelper, CustomClasses;

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
  private
    { private declarations }
    Edges: TList;
    Verteces: TList;
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
  Verteces := TList.Create;
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
  TempVertex := TVertex.Create(Verteces.Count + 1, X, Y);
  if AddVertex.Down and VertecesNotIntersect(TempVertex, Verteces) then
  begin
    DrawVertex(TempVertex, Graph, Verteces);
    MatrixGrid.ColCount := Verteces.Count + 1;
    MatrixGrid.RowCount := Verteces.Count + 1;
    //ShowMessage(IntToStr(MatrixGrid.ColCount));
    MatrixGrid.Cells[0, TempVertex.Id] := IntToStr(TempVertex.Id);
    MatrixGrid.Cells[TempVertex.Id, 0] := IntToStr(TempVertex.Id);
  end;
  TempVertex := FindVertex(X, Y, Verteces);
  if ToolButton1.Down then
    ShowMessage(IntToStr(Verteces.Count));
  if AddEdge.Down then
  begin
    if BeginVertex <> Nil then
    begin
      if CheckVertex(TempVertex, Verteces) and (BeginVertex <> TempVertex) then
      begin
        if EdgeNotExists(BeginVertex, TempVertex, Edges)then
          DrawEdge(BeginVertex, TempVertex, Graph, Edges);
        BeginVertex := Nil;
        ShowMessage(IntToStr(Edges.Count));
      end;
    end
    else if CheckVertex(TempVertex, Verteces) then
        BeginVertex := TempVertex;
  end;
  if DeleteVertex.Down then
    if CheckVertex(TempVertex, Verteces) then
    begin
      RemoveVertex(TempVertex, Verteces, Edges, Graph);
    end;
end;

end.
