program Hand;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {Form1},
  addplaylist in 'addplaylist.pas' {Form2},
  settings in 'settings.pas' {Form3},
  mainset in 'mainset.pas' {Frame1: TFrame},
  Equalizer in 'Equalizer.pas' {Frame2: TFrame},
  tagredactor in 'tagredactor.pas' {Frame3: TFrame},
  addfilefromplaylist in 'addfilefromplaylist.pas' {Form4},
  about in 'about.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
