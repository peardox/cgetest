program IsoTest;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMXGui in 'FMXGui.pas' {CastleForm},
  View3D in 'View3D.pas',
  castleinternalsteamapi in 'C:\DelphiComponents\castle-engine\src\services\steam\castleinternalsteamapi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCastleForm, CastleForm);
  Application.Run;
end.
