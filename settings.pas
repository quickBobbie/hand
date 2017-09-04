unit settings;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, mainset, WinAPI.Windows, FMX.Platform.Win,
  Equalizer, tagredactor, IniFiles, BASS;

type
  TForm3 = class(TForm)
    MultiView1: TMultiView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Frame11: TFrame1;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton5: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Frame21: TFrame2;
    Frame31: TFrame3;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    procedure SpeedButton5Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Frame31RadioButton2Change(Sender: TObject);
    procedure Frame31RadioButton1Change(Sender: TObject);
    procedure Frame31Button1Click(Sender: TObject);
    procedure Frame31Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TagClear;
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Frame11Switch1Switch(Sender: TObject);
    procedure Frame21TrackBar1Change(Sender: TObject);
    procedure Frame21TrackBar2Change(Sender: TObject);
    procedure Frame21TrackBar3Change(Sender: TObject);
    procedure Frame21TrackBar4Change(Sender: TObject);
    procedure Frame21TrackBar5Change(Sender: TObject);
    procedure Frame21TrackBar6Change(Sender: TObject);
    procedure Frame21TrackBar7Change(Sender: TObject);
    procedure Frame21TrackBar8Change(Sender: TObject);
    procedure Frame21TrackBar9Change(Sender: TObject);
    procedure Frame21TrackBar10Change(Sender: TObject);
    procedure Frame21Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  FNTag: string;

implementation

{$R *.fmx}

uses addfilefromplaylist, main, addplaylist, about;

procedure TForm3.TagClear;
begin
  with Frame31 do
  begin
    GroupBox1.Enabled:= True;
    Edit1.Text:= '';
    Edit2.Text:= '';
    Edit3.Text:= '';
    Edit4.Text:= '';
    Edit5.Text:= '';
    Edit6.Text:= '';
    Edit7.Text:= '';
    if RadioButton1.IsChecked = True then
    begin
      Edit2.Enabled:= False;
      Button2.Enabled:= False;
    end else
    begin
      Edit1.Enabled:= False;
      Button1.Enabled:= False;
    end;
    GroupBox2.Enabled:= False;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  Ini: TIniFile;
begin
  if Frame11.Visible then
  begin
    if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'settings') = False then
      CreateDir(ExtractFilePath(ParamStr(0)) + 'settings');
    Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings/main.hs');
    with Frame11 do
    begin
      Ini.WriteInteger('main', 'Language', ComboBox1.ItemIndex);
      Ini.WriteBool('main', 'Theme', Switch1.IsChecked);
      Ini.WriteBool('main', 'AutoPlay', CheckBox1.IsChecked);
      Ini.WriteBool('main', 'InfoHead', CheckBox2.IsChecked);
      Ini.WriteBool('main', 'TrackIndex', CheckBox3.IsChecked);
      Ini.WriteBool('main', 'AutoSavePL', CheckBox4.IsChecked);
      Ini.WriteBool('main', 'SaveEqualizer', CheckBox5.IsChecked);
      Ini.WriteBool('main', 'SaveVolume', CheckBox6.IsChecked);
      Ini.WriteBool('main', 'SaveRepeat', CheckBox7.IsChecked);
      Ini.WriteBool('main', 'SaveWinPosition', CheckBox8.IsChecked);
      lang:= ComboBox1.ItemIndex;
      Form1.LoadLanguage;
      ms[1]:= CheckBox1.IsChecked;
      ms[2]:= CheckBox2.IsChecked;
      if Mode = Play then
      begin
        if ms[2] then
          Form1.Label5.Text:= TagName
        else
          Form1.Label5.Text:= 'Hand';
      end;
      ms[3]:= CheckBox3.IsChecked;
      ms[4]:= CheckBox4.IsChecked;
      ms[5]:= CheckBox5.IsChecked;
      ms[6]:= CheckBox6.IsChecked;
      ms[7]:= CheckBox7.IsChecked;
      ms[8]:= CheckBox8.IsChecked;
    end;
    Ini.Destroy;
    Close;
  end;
  if Frame21.Visible then
  begin
    Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings/equalizer.hs');
    with Frame21 do
    begin
      Ini.WriteInteger('Equalizer', 'Eq1', Trunc(TrackBar1.Value));
      Ini.WriteInteger('Equalizer', 'Eq2', Trunc(TrackBar2.Value));
      Ini.WriteInteger('Equalizer', 'Eq3', Trunc(TrackBar3.Value));
      Ini.WriteInteger('Equalizer', 'Eq4', Trunc(TrackBar4.Value));
      Ini.WriteInteger('Equalizer', 'Eq5', Trunc(TrackBar5.Value));
      Ini.WriteInteger('Equalizer', 'Eq6', Trunc(TrackBar6.Value));
      Ini.WriteInteger('Equalizer', 'Eq7', Trunc(TrackBar7.Value));
      Ini.WriteInteger('Equalizer', 'Eq8', Trunc(TrackBar8.Value));
      Ini.WriteInteger('Equalizer', 'Eq9', Trunc(TrackBar9.Value));
      Ini.WriteInteger('Equalizer', 'Eq10', Trunc(TrackBar10.Value));
    end;
    Ini.Destroy;
    Close;
  end;
  if Frame31.Visible then
  begin
    with Frame31 do
    begin
      ID3v2.SetUnicodeText('TPE1', Edit3.Text);
      ID3v2.SetUnicodeText('TIT2', Edit4.Text);
      ID3v2.SetUnicodeText('TALB', Edit5.Text);
      ID3v2.SetUnicodeText('TYAR', Edit6.Text);
      ID3v2.SetUnicodeText('TCON', Edit7.Text);
      ID3v1.Artist:= Edit3.Text;
      ID3v1.Title:= Edit4.Text;
      ID3v1.Album:= Edit5.Text;
      ID3v1.Year:= Edit6.Text;
      ID3v1.Genre:= Edit7.Text;
    end;
    ID3v2.SaveToFile(FNTag);
    ID3v1.SaveToFile(FNTag);
    TagClear;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  if Frame31.Visible then
  begin
    TagClear;
    if Button1.Enabled = False then
      Close;
    Button1.Enabled:= False;
  end else
    Close;
end;

procedure TForm3.Frame11Switch1Switch(Sender: TObject);
begin
  if Frame11.Switch1.IsChecked then
  begin
    Form1.StyleBook:= Form1.StyleBook1;
    Form1.Fill.Color:= $FF222222;
    Form3.StyleBook:= Form1.StyleBook1;
    Form3.Fill.Color:= $FF222222;
    Form2.StyleBook:= Form1.StyleBook1;
    Form2.Fill.Color:= $FF222222;
    Form4.StyleBook:= Form1.StyleBook1;
    Form4.Fill.Color:= $FF222222;
    Form5.StyleBook:= Form1.StyleBook1;
    Form5.Fill.Color:= $FF222222;
  end else
  begin
    Form1.StyleBook:= Form1.StyleBook2;
    Form1.Fill.Color:= $FFE0E0E0;
    Form3.StyleBook:= Form1.StyleBook2;
    Form3.Fill.Color:= $FFE0E0E0;
    Form2.StyleBook:= Form1.StyleBook2;
    Form2.Fill.Color:= $FFE0E0E0;
    Form4.StyleBook:= Form1.StyleBook2;
    Form4.Fill.Color:= $FFE0E0E0;
    Form5.StyleBook:= Form1.StyleBook2;
    Form5.Fill.Color:= $FFE0E0E0;
  end;
end;

procedure TForm3.Frame21Button1Click(Sender: TObject);
begin
  with Frame21 do
  begin
    TrackBar1.Value:= 15;
    TrackBar2.Value:= 15;
    TrackBar3.Value:= 15;
    TrackBar4.Value:= 15;
    TrackBar5.Value:= 15;
    TrackBar6.Value:= 15;
    TrackBar7.Value:= 15;
    TrackBar8.Value:= 15;
    TrackBar9.Value:= 15;
    TrackBar10.Value:= 15;
  end;
end;

procedure TForm3.Frame21TrackBar10Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[10], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar10.Value;
  BASS_FXSetParameters(FX[10], @ParamFX);
end;

procedure TForm3.Frame21TrackBar1Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[1], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar1.Value;
  BASS_FXSetParameters(FX[1], @ParamFX);
end;

procedure TForm3.Frame21TrackBar2Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[2], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar2.Value;
  BASS_FXSetParameters(FX[2], @ParamFX);
end;

procedure TForm3.Frame21TrackBar3Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[3], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar3.Value;
  BASS_FXSetParameters(FX[3], @ParamFX);
end;

procedure TForm3.Frame21TrackBar4Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[4], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar4.Value;
  BASS_FXSetParameters(FX[4], @ParamFX);
end;

procedure TForm3.Frame21TrackBar5Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[5], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar5.Value;
  BASS_FXSetParameters(FX[5], @ParamFX);
end;

procedure TForm3.Frame21TrackBar6Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[6], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar6.Value;
  BASS_FXSetParameters(FX[6], @ParamFX);
end;

procedure TForm3.Frame21TrackBar7Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[7], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar7.Value;
  BASS_FXSetParameters(FX[7], @ParamFX);
end;

procedure TForm3.Frame21TrackBar8Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[8], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar8.Value;
  BASS_FXSetParameters(FX[8], @ParamFX);
end;

procedure TForm3.Frame21TrackBar9Change(Sender: TObject);
begin
  BASS_FXGetParameters(FX[9], @ParamFX);
  ParamFX.fGain:= 15 - Frame21.Trackbar9.Value;
  BASS_FXSetParameters(FX[9], @ParamFX);
end;

procedure TForm3.Frame31Button1Click(Sender: TObject);
var
  j: integer;
begin
  Form4.ListBox1.Items.Clear;
  for j := 0 to Form1.ListBox1.Items.Count - 1 do
    Form4.ListBox1.Items.Add(Form1.ListBox1.Items.Strings[j]);
  Form4.Show;
end;

procedure TForm3.Frame31Button2Click(Sender: TObject);
begin
  OpenDialog1.Filter:= 'MP3|*.mp3|WAV|*.wav';
  if OpenDialog1.Execute = False then Exit;
  FNTag:= OpenDialog1.FileName;
  if FNTag = '' then Exit;
  ID3v1.LoadFromFile(FNTag);
  ID3v2.LoadFromFile(FNTag);
  with Frame31 do
  begin
    Edit2.Text:= FNTag;
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
end;

procedure TForm3.Frame31RadioButton1Change(Sender: TObject);
begin
  Frame31.Edit2.Enabled:= False;
  Frame31.Button2.Enabled:= False;
  Frame31.Edit1.Enabled:= True;
  Frame31.Button1.Enabled:= True;
end;

procedure TForm3.Frame31RadioButton2Change(Sender: TObject);
begin
  Frame31.Edit1.Enabled:= False;
  Frame31.Button1.Enabled:= False;
  Frame31.Edit2.Enabled:= True;
  Frame31.Button2.Enabled:= True;
end;

procedure TForm3.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
  begin
    ReleaseCapture;
    SendMessage(FmxHandleToHWND(Self.Handle), $0112 { WM_SYSCOMMAND }, $F012 { SC_DRAGMOVE }, 0);
  end;
end;

procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
  Frame21.Visible:= False;
  Frame31.Visible:= False;
  Frame11.Visible:= True;
  Button1.Enabled:= True;
end;

procedure TForm3.SpeedButton3Click(Sender: TObject);
begin
  Frame11.Visible:= False;
  Frame31.Visible:= False;
  Frame21.Visible:= True;
  Button1.Enabled:= True;
end;

procedure TForm3.SpeedButton4Click(Sender: TObject);
begin
  Frame11.Visible:= False;
  Frame21.Visible:= False;
  Frame31.Visible:= True;
  Button1.Enabled:= False;
end;

procedure TForm3.SpeedButton5Click(Sender: TObject);
begin
  Close;
end;

end.
