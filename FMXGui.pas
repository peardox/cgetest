unit FMXGui;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo,

  Fmx.CastleControl, CastleGLUtils, CastleControls, CastleUIControls,

  CastleShapes, CastleScene, CastleTransform,
  CastleViewport, CastleCameras, X3DNodes, X3DFields,
  CastleImages, CastleGLImages, CastleApplicationProperties,
  CastleLog, CastleTimeUtils, CastleKeysMouse,

  // FMX.Layouts
  View3D
  ;

type
  TCastleForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GUIMemo: TMemo;
    GLViewport: TCastleControl;
    TrackBar1: TTrackBar;
    SteamPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
//    GLViewport: TCastleControl;
    procedure AddToLog(Sender: TObject; const AValue: String);
    procedure AddCheckbox(Sender: TObject; const Index: Integer; const AString: String; const AValue: Boolean);
  public
    { Public declarations }
  end;

var
  CastleForm: TCastleForm;

implementation

{$R *.fmx}

uses Math;

procedure TCastleForm.FormCreate(Sender: TObject);
begin

  InitializeLog;
  PrepDone := False;
  Caption := 'IsoTest GUI';
//  GLViewport := TCastleControl.Create(Panel3);
//  GLViewport.Align := TAlignLayout.Client;
  CastleApp := TCastleApp.Create(GLViewport);
  CastleApp.OnLogString :=  AddToLog;
  CastleApp.OnCheckBoxCreate := AddCheckBox;
  GLViewport.Container.View := CastleApp;
  GLViewport.Container.UIScaling := usNone;

end;

procedure TCastleForm.AddToLog(Sender: TObject; const AValue: String);
begin
  GUIMemo.Lines.Add(AValue);
end;

procedure TCastleForm.AddCheckbox(Sender: TObject; const Index: Integer; const AString: String; const AValue: Boolean);
var
  CB: TCheckBox;
begin
  CB := TCheckBox.Create(Self);
  CB.Parent := SteamPanel;
  CB.Width := SteamPanel.Width;
  CB.Height := 16;
  CB.Position.Y := CB.Height * Index;
  CB.Text := AString;
  CB.IsChecked := AValue;
end;

procedure TCastleForm.FormResize(Sender: TObject);
var
  GLBox: Single;
  GLWidth: Single;
begin
// Resize LHS + GL Window
  Panel1.Align := TAlignLayout.Client;
  Panel2.Position.X := 0;
  Panel2.Position.Y := 0;
  Panel2.Width := 200;
  Panel2.Height := Panel1.Height;

  GLWidth := Panel1.Width - Panel2.Width;
  GLBox := Min(GLWidth, Panel1.Height);

  Panel3.Position.X := ((GLWidth - GLBox) / 2) + Panel2.Width;
  Panel3.Position.Y := ((Panel1.Height - GLBox) / 2);
  Panel3.Width := GLBox;
  Panel3.Height := GLBox;
end;

procedure TCastleForm.TrackBar1Change(Sender: TObject);
begin
  CastleApp.CamDist := TrackBar1.Value;
  CastleApp.Synch;
end;

end.
