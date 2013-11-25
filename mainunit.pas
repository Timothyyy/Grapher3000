unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Grids, Menus, Buttons, Helper;

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
    procedure FormCreate(Sender: TObject);
    procedure GraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    Edges : TList;
    Verteces : TList;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  temp : TVertex;
begin
  Verteces := TList.Create;
  Graph.Canvas.Rectangle(Graph.BoundsRect);
  Graph.Canvas.Clear;
  //Graph.Canvas.Ellipse(10,25,30,45);
  //Graph.Canvas.TextOut(17,27,'1');
  {temp := TVertex.Create(1, 5, 5);
  Verteces.Add(temp);
  temp := TVertex.Create(2, 6, 6);
  Verteces.Add(temp);
  Verteces.Delete(0);
  ShowMessage(IntToStr(TVertex(Verteces[0]).Id));}
end;

procedure TMainForm.GraphMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if AddVertex.Down then
    begin
      Graph.Canvas.Ellipse(X - 10, Y - 10, X + 10, Y + 10);
      Graph.Canvas.TextOut(X - 6, Y - 8, IntToStr(Verteces.Count + 1));
      Verteces.Add(TVertex.Create(Verteces.Count + 1, X, Y));
    end;
  if AddEdge.Down then
    ShowMessage(IntToStr(Verteces.Count));
end;

end.
