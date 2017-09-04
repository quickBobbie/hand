unit addplaylist;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, IniFiles;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses main, settings;

procedure TForm2.Button1Click(Sender: TObject);
var
  Ini: TIniFile;
  j: integer;
begin
  if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'playlist') = False then
    CreateDir(ExtractFilePath(ParamStr(0)) + 'playlist');
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'playlist/' + Edit1.Text + '.hpl');
  Ini.WriteInteger('TrackCount', 'Count', Form1.ListBox1.Items.Count - 1);
  Ini.WriteInteger('TrackIndex', 'Index', Form1.ListBox1.ItemIndex);
  Ini.EraseSection('Tracks');
  for j := 0 to Form1.ListBox1.Items.Count - 1 do
    Ini.WriteString('Tracks', 'Track' + IntToStr(j + 1), Form1.ListBox2.Items.Strings[j]);
  Ini.Destroy;
  Form1.ListBox3.Items.Add(Edit1.Text);
  Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
