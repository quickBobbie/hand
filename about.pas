unit about;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, WinAPI.Windows, FMX.Platform.Win, FMX.ScrollBox,
  FMX.Memo;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

uses main;

procedure TForm5.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
  begin
    ReleaseCapture;
    SendMessage(FmxHandleToHWND(Self.Handle), $0112 { WM_SYSCOMMAND }, $F012 { SC_DRAGMOVE }, 0);
  end;
end;

end.
