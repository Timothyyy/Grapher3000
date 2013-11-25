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
  {temp := TVertex.Create(1, 5, 5);
  Vertces.Add(temp);
  temp := TVertex.Create(2, 6, 6);
  Vertces.Add(temp);
  Verteces.Delete(0);
  ShowMessage(IntToStr(TVertex(Verteces[0]).Id));}
end;

end.
