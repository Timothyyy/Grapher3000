unit Helper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  //Edge class
  TEdge = Class(TObject)
    private
      //Fields of Edge class
      EdgeId : Integer;
      EdgeX : Integer;
      EdgeY : Integer;
      //Id setter
      procedure SetId(const Id: Integer);
    public
      //Constructor
      constructor Create(const Id : Integer; const X : Integer; const Y : Integer);
      //Properties for read data
      property Id : Integer
          read EdgeId
          write SetId;
      property X : Integer
          read EdgeX;
      property Y : Integer
          read EdgeY;
  end;

implementation

//Implementing of TEdge class constructor
constructor TEdge.Create(const Id : Integer; const X : Integer; const Y : Integer);
begin
  self.EdgeId := Id;
  self.EdgeX := X;
  self.EdgeY := Y;
end;

//Id setter of TEdge
procedure TEdge.SetId(const Id : integer);
begin
  self.EdgeId := Id;
end;

end.
