unit Unit1;

interface

{$define USE_STEAM}
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

{$ifdef USE_STEAM}
  CastleSteam,
{$endif}
  Unit2
  // FMX.Layouts
  ;

type
  TCastleForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    GLViewport: TCastleControl;
    TrackBar1: TTrackBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
//    GLViewport: TCastleControl;
{$ifdef USE_STEAM}
    procedure SteamCheck;
{$endif}
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  CastleForm: TCastleForm;

const
  { Here we are using AppID of SteamWorks game example - SpaceWar
    see https://partner.steamgames.com/doc/sdk/api/example
    Note that using this example will add this game to your Steam library }
  AppId = UInt32(2275430);

implementation

{$R *.fmx}

uses Math;

constructor TCastleForm.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TCastleForm.FormCreate(Sender: TObject);
begin
  InitializeLog;
{$ifdef USE_STEAM}
  InitSteam(AppId);
{$endif}
  PrepDone := False;
  Caption := 'IsoTest GUI';
//  GLViewport := TCastleControl.Create(Panel3);
//  GLViewport.Align := TAlignLayout.Client;
  CastleApp := TCastleApp.Create(GLViewport);
  CastleApp.SetGUILogger(Memo1.Lines);
  CastleApp.SetGUILogControl(Memo1);
  GLViewport.Container.View := CastleApp;
  GLViewport.Container.UIScaling := usNone;
{$ifdef USE_STEAM}
  SteamCheck;
{$endif}
end;

{$ifdef USE_STEAM}
procedure TCastleForm.SteamCheck;
begin
  if Steam.Initialized then
      Memo1.Lines.Add('Steam is Loaded')
    else
      Memo1.Lines.Add('Steam is NOT Loaded');
end;
{$endif}

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

procedure TCastleForm.Timer1Timer(Sender: TObject);
begin
{$ifdef USE_STEAM}
  SteamCheck;
{$endif}
end;

procedure TCastleForm.TrackBar1Change(Sender: TObject);
begin
  CastleApp.CamDist := TrackBar1.Value;
  CastleApp.Synch;
end;

end.
