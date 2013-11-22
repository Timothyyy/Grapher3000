unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Grids, Menus, Helper;

type

  { TMainForm }

  TMainForm = class(TForm)
    PageControl: TPageControl;
    GraphicalView: TTabSheet;
    Graph: TImage;
    MatrixView: TTabSheet;
    MatrixGrid: TStringGrid;
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
  temp : TEdge;
begin
  Edges := TList.Create;
  Verteces := TList.Create;
  {temp := TEdge.Create(1, 5, 5);
  Edges.Add(temp);
  temp := TEdge.Create(2, 6, 6);
  Edges.Add(temp);
  Edges.Delete(0);
  ShowMessage(IntToStr(TEdge(Edges[0]).Id));}
end;

end.
