unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, WinAPI.Windows, FMX.Platform.Win, FMX.MultiView,
  FMX.Layouts, FMX.ListBox, FMX.Objects, BASS, ID3v1Library, ID3v2Library, IniFiles,
  FMX.Menus;

type
  TPlayer = (Stop, Play, Pause);
  TForm1 = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StyleBook1: TStyleBook;
    MultiView1: TMultiView;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ListBox1: TListBox;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    ListBox2: TListBox;
    Label5: TLabel;
    SpeedButton5: TSpeedButton;
    SizeGrip1: TSizeGrip;
    SpeedButton8: TSpeedButton;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    TrackBar1: TTrackBar;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    SpeedButton9: TSpeedButton;
    StyleBook2: TStyleBook;
    SpeedButton15: TSpeedButton;
    ListBox3: TListBox;
    Timer2: TTimer;
    Panel7: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SpeedButton4Click(Sender: TObject);
    procedure TagNameCreate(Item: string);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure PlayTrack;
    procedure ListBox1DblClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure TrackRepeat;
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure OpenTrackWithExp;
    procedure ReadMainSet;
    procedure SpeedButton15Click(Sender: TObject);
    procedure SaveAllPlayList;
    procedure OpenAllPlayList;
    procedure ListBox3DblClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SaveConfig;
    procedure LoadConfig;
    procedure LoadPlayList(PL: string);
    procedure SavePlayList;
    procedure SpeedButton13MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure SpeedButton13MouseLeave(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Equalizer;
    procedure ReadEqualizer;
    procedure SpeedButton7Click(Sender: TObject);
    procedure SetEqualizer;
    procedure LoadLanguage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  chan: DWORD;
  ID3v1: TID3v1Tag;
  ID3v2: TID3v2Tag;
  TagName, title, artist, FileName: string;
  i, MCount: integer;
  Mode: TPlayer;
  Rep: 1..3;
  lang: 0..1;
  ms: array[0..8] of boolean;
  vol: byte;
  FX: array [1..10] of integer;
  ParamFX: BASS_DX8_PARAMEQ;
  s: array[1..4] of string;

implementation

{$R *.fmx}

uses addplaylist, settings, addfilefromplaylist, about;

procedure TForm1.LoadLanguage;
begin
  case lang of
    0:begin
      SpeedButton3.Text:= 'Меню';
      SpeedButton4.Text:= 'Добавить';
      SpeedButton6.Text:= 'Настройки';
      SpeedButton7.Text:= 'О программе';
      SpeedButton9.Text:= 'Очистить плей лист';
      SpeedButton5.Text:= 'Создать плей лист';
      s[1]:= 'Плей лист ';
      s[2]:= 'Без повтора';
      s[3]:= 'Повторять все';
      s[4]:= 'Повторять одну';
      with Form2 do
      begin
        Label1.Text:= 'Добавление нового плей листа';
        Button1.Text:= 'Добавить';
        Button2.Text:= 'Отмена';
      end;
      with Form3 do
      begin
        Label1.Text:= 'Настройки';
        SpeedButton1.Text:= 'Меню';
        SpeedButton2.Text:= 'Основные';
        SpeedButton3.Text:= 'Эквалайзер';
        SpeedButton4.Text:= 'Редактор тегов';
        Button1.Text:= 'Сохранить';
        Button2.Text:= 'Отмена';
        with Frame11 do
        begin
          Label1.Text:= 'Язык интерфейса';
          Label2.Text:= 'Тема';
          Label3.Text:= 'Светлая';
          Label4.Text:= 'Темная';
          CheckBox1.Text:= 'Автовоспроизведение';
          CheckBox2.Text:= 'Информация о треке в заголовке';
          CheckBox3.Text:= 'Сохранять текущий трек';
          CheckBox4.Text:= 'Сохранять плей лист';
          CheckBox5.Text:= 'Сохранять эквалайзер';
          CheckBox6.Text:= 'Сохранять уровень громкости';
          CheckBox7.Text:= 'Сохранять режим повтора';
          CheckBox8.Text:= 'Сохранять настройки главного окна';
        end;
        Frame21.Button1.Text:= 'Сброс';
        with Frame31 do
        begin
          GroupBox1.Text:= 'Выбор';
          RadioButton1.Text:= 'Из текущего плей листа';
          RadioButton2.Text:= 'Из проводника';
          GroupBox2.Text:= 'Редактирование';
          Label1.Text:= 'Исполнитель';
          Label2.Text:= 'Название';
          Label3.Text:= 'Альбом';
          Label4.Text:= 'Год';
          Label5.Text:= 'Жанр';
        end;
      end;
      Form4.Button1.Text:= 'Выбрать';
      Form4.Button2.Text:= 'Отмена';
      Form5.Label1.Text:= 'О программе';
      Form5.Memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'rus.txt');
    end;
    1:begin
      SpeedButton3.Text:= 'Menu';
      SpeedButton4.Text:= 'Add';
      SpeedButton6.Text:= 'Settings';
      SpeedButton7.Text:= 'About';
      SpeedButton9.Text:= 'Clear play list';
      SpeedButton5.Text:= 'Create play list';
      s[1]:= 'Play list ';
      s[2]:= 'Without repeat';
      s[3]:= 'Repeat all';
      s[4]:= 'Repeat one';
      with Form2 do
      begin
        Label1.Text:= 'Add new play list';
        Button1.Text:= 'Add';
        Button2.Text:= 'Cancel';
      end;
      with Form3 do
      begin
        Label1.Text:= 'Settings';
        SpeedButton1.Text:= 'Menu';
        SpeedButton2.Text:= 'Main';
        SpeedButton3.Text:= 'Equalizer';
        SpeedButton4.Text:= 'Tag Editor';
        Button1.Text:= 'Save';
        Button2.Text:= 'Cancel';
        with Frame11 do
        begin
          Label1.Text:= 'Interface language';
          Label2.Text:= 'Theme';
          Label3.Text:= 'Light';
          Label4.Text:= 'Dark';
          CheckBox1.Text:= 'Autoplay';
          CheckBox2.Text:= 'Information about the track title';
          CheckBox3.Text:= 'Save playing track';
          CheckBox4.Text:= 'Save play list';
          CheckBox5.Text:= 'Save equalizer';
          CheckBox6.Text:= 'Save volume';
          CheckBox7.Text:= 'Save repeat';
          CheckBox8.Text:= 'Save main window settings';
        end;
        Frame21.Button1.Text:= 'Drop';
        with Frame31 do
        begin
          GroupBox1.Text:= 'Switch';
          RadioButton1.Text:= 'From this play list';
          RadioButton2.Text:= 'From explorer';
          GroupBox2.Text:= 'Editing';
          Label1.Text:= 'Artist';
          Label2.Text:= 'Title';
          Label3.Text:= 'Album';
          Label4.Text:= 'Year';
          Label5.Text:= 'Genre';
        end;
      end;
      Form4.Button1.Text:= 'Switch';
      Form4.Button2.Text:= 'Cancel';
      Form5.Label1.Text:= 'About';
      Form5.Memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'eng.txt');
    end;
  end;
end;

procedure TForm1.SetEqualizer;
begin
  BASS_FXGetParameters(FX[1], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar1.Value;
  BASS_FXSetParameters(FX[1], @ParamFX);
  BASS_FXGetParameters(FX[2], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar2.Value;
  BASS_FXSetParameters(FX[2], @ParamFX);
  BASS_FXGetParameters(FX[3], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar3.Value;
  BASS_FXSetParameters(FX[3], @ParamFX);
  BASS_FXGetParameters(FX[4], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar4.Value;
  BASS_FXSetParameters(FX[4], @ParamFX);
  BASS_FXGetParameters(FX[5], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar5.Value;
  BASS_FXSetParameters(FX[5], @ParamFX);
  BASS_FXGetParameters(FX[6], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar6.Value;
  BASS_FXSetParameters(FX[6], @ParamFX);
  BASS_FXGetParameters(FX[7], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar7.Value;
  BASS_FXSetParameters(FX[7], @ParamFX);
  BASS_FXGetParameters(FX[8], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar8.Value;
  BASS_FXSetParameters(FX[8], @ParamFX);
  BASS_FXGetParameters(FX[9], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar9.Value;
  BASS_FXSetParameters(FX[9], @ParamFX);
  BASS_FXGetParameters(FX[10], @ParamFX);
  ParamFX.fGain:= 15 - Form3.Frame21.Trackbar10.Value;
  BASS_FXSetParameters(FX[10], @ParamFX);
end;

procedure TForm1.ReadEqualizer;
var
  Ini: TIniFile;
begin
  if ms[5] = False then
  begin
    with Form3.Frame21 do
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
    Exit;
  end;
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings/equalizer.hs');
  with Form3.Frame21 do
  begin
    TrackBar1.Value:= Ini.ReadInteger('Equalizer', 'Eq1', 15);
    TrackBar2.Value:= Ini.ReadInteger('Equalizer', 'Eq2', 15);
    TrackBar3.Value:= Ini.ReadInteger('Equalizer', 'Eq3', 15);
    TrackBar4.Value:= Ini.ReadInteger('Equalizer', 'Eq4', 15);
    TrackBar5.Value:= Ini.ReadInteger('Equalizer', 'Eq5', 15);
    TrackBar6.Value:= Ini.ReadInteger('Equalizer', 'Eq6', 15);
    TrackBar7.Value:= Ini.ReadInteger('Equalizer', 'Eq7', 15);
    TrackBar8.Value:= Ini.ReadInteger('Equalizer', 'Eq8', 15);
    TrackBar9.Value:= Ini.ReadInteger('Equalizer', 'Eq9', 15);
    TrackBar10.Value:= Ini.ReadInteger('Equalizer', 'Eq10', 15);
  end;
  Ini.Destroy;
end;

procedure TForm1.Equalizer;
begin
  FX[1]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[2]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[3]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[4]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[5]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[6]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[7]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[8]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[9]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  FX[10]:= BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
  ParamFX.fGain:= 0;
  ParamFX.fBandwidth:= 18;
  ParamFX.fCenter:= 32;
  BASS_FXSetParameters(FX[1], @ParamFX);
  ParamFX.fCenter:= 64;
  BASS_FXSetParameters(FX[2], @ParamFX);
  ParamFX.fCenter:= 125;
  BASS_FXSetParameters(FX[3], @ParamFX);
  ParamFX.fCenter:= 250;
  BASS_FXSetParameters(FX[4], @ParamFX);
  ParamFX.fCenter:= 500;
  BASS_FXSetParameters(FX[5], @ParamFX);
  ParamFX.fCenter:= 1000;
  BASS_FXSetParameters(FX[6], @ParamFX);
  ParamFX.fCenter:= 2000;
  BASS_FXSetParameters(FX[7], @ParamFX);
  ParamFX.fCenter:= 4000;
  BASS_FXSetParameters(FX[8], @ParamFX);
  ParamFX.fCenter:= 8000;
  BASS_FXSetParameters(FX[9], @ParamFX);
  ParamFX.fCenter:= 16000;
  BASS_FXSetParameters(FX[10], @ParamFX);
end;

procedure TForm1.SavePlayList;
var
  Ini: TIniFile;
  j: integer;
begin
  if ListBox1.Items.Count = 0 then
  begin
    if FileExists(ExtractFilePath(ParamStr(0)) + 'playlist.hpl') then
      DeleteFile('playlist.hpl');
    Exit;
  end;
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'playlist.hpl');
  Ini.WriteInteger('TrackCount', 'Count', Form1.ListBox1.Items.Count - 1);
  Ini.WriteInteger('TrackIndex', 'Index', Form1.ListBox1.ItemIndex);
  Ini.EraseSection('Tracks');
  for j := 0 to Form1.ListBox1.Items.Count - 1 do
    Ini.WriteString('Tracks', 'Track' + IntToStr(j + 1), Form1.ListBox2.Items.Strings[j]);
  Ini.Destroy;
end;

procedure TForm1.LoadPlayList(PL: string);
var
  Ini: TIniFile;
  j, count: integer;
begin
  Ini:= TiniFile.Create(PL);
  count:= Ini.ReadInteger('TrackCount', 'Count', 0);
  if ms[3] then
    i:= Ini.ReadInteger('TrackIndex', 'Index', 0)
  else
    i:= 0;
  for j := 0 to count do
    ListBox2.Items.Add(Ini.ReadString('Tracks', 'Track' + IntToStr(j + 1), 'err'));
  Ini.Free;
  for j := 0 to ListBox2.Items.Count - 1 do
    ListBox1.Items.Add(TagName);
  ListBox1.ItemIndex:= i;
  FileName:= ListBox2.Items.Strings[i];
  if ms[1] = False then Exit;
  PlayTrack;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  j: integer;
begin
  j:= ListBox1.ItemIndex;
  ListBox2.Items.Delete(j);
  ListBox1.Items.Delete(j);
end;

procedure TForm1.LoadConfig;
var
  Ini: TIniFile;
begin
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config/config.cfg');
  if ms[6] then
    TrackBar1.Value:= Ini.ReadInteger('Volume', 'Value', 100)
  else
    TrackBar1.Value:= 100;
  if ms[7] then
    Rep:= Ini.ReadInteger('Replay', 'Value', 1)
  else
    Rep:= 1;
  if ms[8] then
  begin
    Form1.Top:= Ini.ReadInteger('MainWindow', 'Top', 0);
    Form1.Left:= Ini.ReadInteger('MainWindow', 'Left', 0);
    Form1.Width:= Ini.ReadInteger('MainWindow', 'Width', 532);
    Form1.Height:= Ini.ReadInteger('MainWindow', 'Height', 494);
  end;
  Ini.Destroy;
end;

procedure TForm1.SaveConfig;
var
  Ini: TIniFile;
begin
  if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'config') = False then
    CreateDir(ExtractFilePath(ParamStr(0)) + 'config');
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config/config.cfg');
  Ini.WriteInteger('Volume', 'Value', Trunc(TrackBar1.Value));
  Ini.WriteInteger('Replay', 'Value', Rep);
  Ini.WriteInteger('MainWindow', 'Top', Form1.Top);
  Ini.WriteInteger('MainWindow', 'Left', Form1.Left);
  Ini.WriteInteger('MainWindow', 'Width', Form1.Width);
  Ini.WriteInteger('MainWindow', 'Height', Form1.Height);
  Ini.Destroy;
end;

procedure TForm1.OpenAllPlayList;
var
  Ini: TIniFile;
  j, count: integer;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'config/playlist.cfg') = False then Exit;
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config/playlist.cfg');
  count:= Ini.ReadInteger('PlayListCount', 'Count', 0);
  for j := 0 to count do
    ListBox3.Items.Add(Ini.ReadString('Files', 'File' + IntToStr(j + 1), 'Err'));
  Ini.Destroy;
end;

procedure TForm1.SaveAllPlayList;
var
  Ini: TIniFile;
  j: integer;
begin
  if ListBox3.Items.Count = 0 then Exit;
  if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'config') = False then
    CreateDir(ExtractFilePath(ParamStr(0)) + 'config');
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config/playlist.cfg');
  Ini.WriteInteger('PlayListCount', 'Count', ListBox3.Items.Count - 1);
  Ini.EraseSection('Files');
  for j := 0 to ListBox3.Items.Count - 1 do
    Ini.WriteString('Files', 'File' + IntToStr(j + 1), ListBox3.Items.Strings[j]);
  Ini.Destroy;
end;

procedure TForm1.ReadMainSet;
var
  Ini: TIniFile;
begin
  Ini:= TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings/main.hs');
  lang:= Ini.ReadInteger('main', 'Language', 0);
  ms[0]:= Ini.ReadBool('main', 'Theme', True);
  ms[1]:= Ini.ReadBool('main', 'AutoPlay', True);
  ms[2]:= Ini.ReadBool('main', 'InfoHead', False);
  ms[3]:= Ini.ReadBool('main', 'TrackIndex', False);
  ms[4]:= Ini.ReadBool('main', 'AutoSavePL', True);
  ms[5]:= Ini.ReadBool('main', 'SaveEqualizer', False);
  ms[6]:= Ini.ReadBool('main', 'SaveVolume', True);
  ms[7]:= Ini.ReadBool('main', 'SaveRepeat', True);
  ms[8]:= Ini.ReadBool('main', 'SaveWinPosition', False);
  Ini.Destroy;
end;

procedure TForm1.OpenTrackWithExp;
var
  j: integer;
begin
  if ParamCount <> 0 then
  begin
    for j := 1 to ParamCount do
    begin
      if (ExtractFileExt(ParamStr(j)) = '.mp3') or
         (ExtractFileExt(ParamStr(j)) = '.wav') then
      begin
        ListBox2.Items.Add(ParamStr(j));
      end;
    end;
    for j := 0 to ListBox2.Items.Count - 1 do
    begin
      TagNameCreate(ListBox2.Items.Strings[j]);
      ListBox1.Items.Add(TagName);
    end;
    FileName:= ListBox2.Items.Strings[i];
    ListBox1.ItemIndex:= i;
    if ms[1] = False then Exit;
    Mode:= Stop;
    PlayTrack;
  end;
end;

procedure TForm1.TrackRepeat;
begin
  if BASS_ChannelIsActive(chan) = BASS_ACTIVE_STOPPED then
  begin
    case Rep of
      1: begin
        if i < ListBox1.Items.Count - 1 then
        begin
          inc(i);
          FileName:= ListBox2.Items.Strings[i];
          ListBox1.ItemIndex:= i;
          Mode:= Stop;
          PlayTrack;
        end;
      end;
      2: begin
        if i < ListBox1.Items.Count - 1 then
        begin
          inc(i);
          FileName:= ListBox2.Items.Strings[i];
          ListBox1.ItemIndex:= i;
          Mode:= Stop;
          PlayTrack;
        end else
        begin
          i:= 0;
          FileName:= ListBox2.Items.Strings[i];
          ListBox1.ItemIndex:= i;
          Mode:= Stop;
          PlayTrack;
        end;
      end;
      3: begin
        FileName:= ListBox2.Items.Strings[i];
        ListBox1.ItemIndex:= i;
        Mode:= Stop;
        PlayTrack;
      end;
    end;
  end;
end;

procedure TForm1.PlayTrack;
begin
  if Mode <> Pause then
  begin
    if FileExists(FileName) = False then
    begin
      ShowMessage('Отсутствует Файл в плей листе');
      Exit;
    end;
    BASS_ChannelStop(chan);
    BASS_StreamFree(chan);
    chan:= BASS_StreamCreateFile(False, PChar(FileName), 0, 0, BASS_UNICODE);
    if chan = 0 then
    begin
      ShowMessage('Не возможно создать поток');
      Exit;
    end;
  end;
  TagNameCreate(FileName);
  Label1.Text:= title;
  Label2.Text:= artist;
  ProgressBar1.Max:= BASS_ChannelGetLength(chan, BASS_POS_BYTE);
  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, TrackBar1.Value / 100);
  Equalizer;
  SetEqualizer;
  BASS_ChannelPlay(chan, False);
  Mode:= Play;
  SpeedButton10.StyleLookup:= 'pausetoolbutton';
  if ms[2] then
    Label5.Text:= TagName
  else
    Label5.Text:= 'Hand';
end;

procedure TForm1.TagNameCreate(Item: string);
begin
  ID3v1.LoadFromFile(Item);
  Id3v2.LoadFromFile(Item);
  if ID3v2.GetUnicodeText('TPE1') <> '' then
    artist:= ID3v2.GetUnicodeText('TPE1')
  else if ID3v1.Artist <> '' then
    artist:= ID3v1.Artist
  else
    artist:= 'Не известный исполнитель';
  if ID3v2.GetUnicodeText('TIT2') <> '' then
    title:= ID3v2.GetUnicodeText('TIT2')
  else if ID3v1.Title <> '' then
    title:= ID3v1.Title
  else
    title:= ExtractFileName(Item);
  if artist <> 'Не известный исполнитель' then
    TagName:= artist + ' - ' + title
  else
    TagName:= title;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  TimeLen, TimePos: Double;
begin
  TrackRepeat;
  if Mode <> Play then Exit;
  ProgressBar1.Value:= BASS_ChannelGetPosition(chan, BASS_POS_BYTE);
  TimeLen:= BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetLength(chan, 0));
  TimePos:= BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetPosition(chan, 0));
  Label3.Text:= FormatDateTime('nn:ss', TimePos / (24 * 3600));
  Label4.Text:= FormatDateTime('nn:ss', TimeLen / (24 * 3600));
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  LoadLanguage;
  with Form3.Frame11 do
  begin
    ComboBox1.ItemIndex:= lang;
    Switch1.IsChecked:= ms[0];
    CheckBox1.IsChecked:= ms[1];
    CheckBox2.IsChecked:= ms[2];
    CheckBox3.IsChecked:= ms[3];
    CheckBox4.IsChecked:= ms[4];
    CheckBox5.IsChecked:= ms[5];
    CheckBox6.IsChecked:= ms[6];
    CheckBox7.IsChecked:= ms[7];
    CheckBox8.IsChecked:= ms[8];
  end;
  ReadEqualizer;
  if (ms[4]) and
     (FileExists(ExtractFilePath(ParamStr(0)) + 'playlist.hpl')) then
  begin
    if ParamCount <> 0 then Exit;
    LoadPlayList(ExtractFilePath(ParamStr(0)) + 'playlist.hpl');
  end;
  OpenTrackWithExp;
  Timer2.Enabled:= False;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, TrackBar1.Value / 100);
  Label7.Text:= IntToStr(Trunc(TrackBar1.Value));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ID3v1:= TID3v1Tag.Create;
  ID3v2:= TID3v2Tag.Create;
  BASS_Init(-1, 44100, 0, 0, nil);
  ReadMainSet;
  LoadConfig;
  OpenAllPlayList;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  i:= ListBox1.ItemIndex;
  FileName:= ListBox2.Items.Strings[i];
  Mode:= Stop;
  PlayTrack;
end;

procedure TForm1.ListBox3DblClick(Sender: TObject);
var
  Ini: TIniFile;
begin
  if ListBox3.Items.Count = 0 then Exit;
  ListBox1.Clear;
  ListBox2.Clear;
  LoadPlayList(ExtractFilePath(ParamStr(0)) + 'playlist/' + ListBox3.Items.Strings[ListBox3.ItemIndex] + '.hpl');
  PlayTrack;
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
  begin
    ReleaseCapture;
    SendMessage(FmxHandleToHWND(Self.Handle), $0112 { WM_SYSCOMMAND }, $F012 { SC_DRAGMOVE }, 0);
  end;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  if Mode <> Play then
  begin
    PlayTrack;
  end else
  begin
    SpeedButton10.StyleLookup:= 'playtoolbutton';
    BASS_ChannelPause(chan);
    Mode:= Pause;
  end;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
  if i <> 0 then
    dec(i)
  else
    i:= ListBox1.Items.Count - 1;
  FileName:= ListBox2.Items.Strings[i];
  ListBox1.ItemIndex:= i;
  Mode:= Stop;
  PlayTrack;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
  if i < ListBox1.Items.Count - 1 then
    inc(i)
  else
    i:= 0;
  FileName:= ListBox2.Items.Strings[i];
  ListBox1.ItemIndex:= i;
  Mode:= Stop;
  PlayTrack;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
  case Rep of
    1:begin
      Rep:= 2;
      Label5.Text:= s[3];
    end;
    2:begin
      Rep:= 3;
      Label5.Text:= s[4];
    end;
    3:begin
      Rep:= 1;
      Label5.Text:= s[2];
    end;
  end;
end;

procedure TForm1.SpeedButton13MouseLeave(Sender: TObject);
begin
  if ms[2] then
    Label5.Text:= TagName
  else
    Label5.Text:= 'Hand';
end;

procedure TForm1.SpeedButton13MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  case Rep of
    1: Label5.Text:= s[2];
    2: Label5.Text:= s[3];
    3: Label5.Text:= s[4];
  end;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
  if Panel3.Visible = False then
    Panel3.Visible:= True
  else
    Panel3.Visible:= False;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
  if TrackBar1.Value <> 0 then
  begin
    vol:= Trunc(TrackBar1.Value);
    TrackBar1.Value:= 0;
  end else
  begin
    TrackBar1.Value:= vol;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  SaveAllPlayList;
  SaveConfig;
  SavePlayList;
  Close;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Form1.WindowState:= TWindowState.wsMinimized;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  j: integer;
begin
  OpenDialog1.Filter:= 'MP3|*.mp3|WAV|*.wav';
  if OpenDialog1.Execute = False then Exit;
  MCount:= ListBox1.Items.Count;
  if i <> ListBox1.Items.Count - 1 then
    i:= ListBox1.Items.Count
  else
    i:= 0;
  for j := 0 to OpenDialog1.Files.Count - 1 do
    ListBox2.Items.Add(OpenDialog1.Files.Strings[j]);
  for j := Mcount to ListBox2.Items.Count - 1 do
  begin
    TagNameCreate(ListBox2.Items.Strings[j]);
    ListBox1.Items.Add(TagName);
  end;
  if Mode <> Play then
  begin
    FileName:= ListBox2.Items.Strings[i];
    ListBox1.ItemIndex:= i;
    if ms[1] = False then Exit;
    Mode:= Stop;
    PlayTrack;
  end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
  j: integer;
begin
  j:= ListBox3.Items.Count;
  Form2.Edit1.Text:= s[1] + IntToStr(j + 1);
  Form2.ShowModal;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  if Form1.WindowState = TWindowState.wsNormal then
  begin
    Form1.WindowState:= TWindowState.wsMaximized;
    SpeedButton8.StyleLookup:= 'arrowdowntoolbuttonborderedright';
    SizeGrip1.Visible:= False;
  end else
  begin
    Form1.WindowState:= TWindowState.wsNormal;
    SpeedButton8.StyleLookup:= 'arrowuptoolbuttonborderedleft';
    SizeGrip1.Visible:= True;
  end;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
end;

end.
