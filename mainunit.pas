unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Grids, Menus, Buttons, Helper, Math;

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
  TempVertex := TVertex.Create(Verteces.Count, X, Y);
  if AddVertex.Down and VertecesNotIntersect(TempVertex, Verteces) then
    DrawVertex(TempVertex, Graph, Verteces);
  if ToolButton1.Down then
    ShowMessage(IntToStr(Verteces.Count));
  if AddEdge.Down then
  begin
    if BeginVertex <> Nil then
    begin
      if CheckVertex(TempVertex, Verteces) and (BeginVertex <> FindVertex(X, Y, Verteces)) then
      begin
        if EdgeNotExists(BeginVertex, FindVertex(X, Y, Verteces), Edges)then
          DrawEdge(BeginVertex, FindVertex(X, Y, Verteces), Graph, Edges);
        BeginVertex := Nil;
        ShowMessage(IntToStr(Edges.Count));
      end;
    end
    else
      if CheckVertex(TempVertex, Verteces) then
        BeginVertex := FindVertex(X, Y, Verteces);
  end;
end;

end.
