program IsoTest;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMXGui in 'FMXGui.pas' {CastleForm},
  View3D in 'View3D.pas',
  CastleInternalSteamApi in 'C:\DelphiComponents\steam\CastleInternalSteamApi.pas',
  castleinternalsteamcallback in 'C:\DelphiComponents\steam\castleinternalsteamcallback.pas',
  castleinternalsteamconstantsandtypes in 'C:\DelphiComponents\steam\castleinternalsteamconstantsandtypes.pas',
  castlesteam in 'C:\DelphiComponents\steam\castlesteam.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCastleForm, CastleForm);
  Application.Run;
end.
