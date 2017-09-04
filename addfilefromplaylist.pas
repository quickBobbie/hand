unit addfilefromplaylist;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TForm4 = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure LoadTagFile;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses settings, main;

procedure TForm4.LoadTagFile;
begin
  FNTag:= Form1.ListBox2.Items.Strings[ListBox1.ItemIndex];
  if FNTag = '' then Exit;
  ID3v1.LoadFromFile(FNTag);
  ID3v2.LoadFromFile(FNTag);
  with Form3.Frame31 do
  begin
    Edit1.Text:= FNTag;
    GroupBox2.Enabled:= True;
    GroupBox1.Enabled:= False;
    Edit3.Text:= ID3v2.GetUnicodeText('TPE1');
    Edit4.Text:= ID3v2.GetUnicodeText('TIT2');
    Edit5.Text:= ID3v2.GetUnicodeText('TALB');
    Edit6.Text:= ID3v2.GetUnicodeText('TYAR');
    Edit7.Text:= ID3v2.GetUnicodeText('TCON');
    if (Edit1.Text <> '') or
       (Edit2.Text <> '') then
      Form3.Button1.Enabled:= True;
  end;
  Close;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  LoadTagFile;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm4.ListBox1DblClick(Sender: TObject);
begin
  LoadTagFile;
end;

end.
