unit main;


interface

{$i profile.inc}
uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons
  , tstr, tmsg, tapp, tini, tprogress
  ;

type

  TPresetRec = record

    msName    : String;
    miHours,
    miMinutes,
    miSeconds : Integer;
  end;

  TPresetArray = Array of TPresetRec;

  { TfmMain }
  TfmMain = class(TForm)
				cbPresets : TComboBox;
				meHour : TMemo;
				meMin : TMemo;
				meSec : TMemo;
				Panel1 : TPanel;
				ProgressBar : TProgressBar;
				sbStart : TSpeedButton;
				sbStop : TSpeedButton;
				sbReset : TSpeedButton;
				sbSave : TSpeedButton;
    STimer: TTimer;
    Timer: TTimer;
		upHours : TUpDown;
		upMin : TUpDown;
		upSec : TUpDown;
    procedure cbPresetsSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var {%H-}CloseAction: TCloseAction);
		procedure formcreate({%H-}sender: tobject);
    procedure meHourChange(Sender: TObject);
		procedure sbResetClick(Sender : TObject);
		procedure sbSaveClick(Sender : TObject);
		procedure sbStartClick(Sender : TObject);
		procedure sbStopClick(Sender : TObject);
    procedure TimerTimer(Sender: TObject);
    //procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    { Private declarations }
    mblRunning    : Boolean;
    miPresetCount : Integer;
    moPresets     : TPresetArray;
    moIniMgr      : TEasyIniManager;
    moProgressMgr : TEasyProgressBar;
    mlTotalCycles : Longint;
    mlCycle      : Longint;
  public

    { Public declarations }
    procedure clickStart();
    procedure clickReset();
    procedure clickSave();
    procedure Start();
    procedure Stop();
    procedure Display();
    procedure Bell();
    procedure loadPresets();

  end;


type TCountDirection = (cdStraight,cdReverse);

const csName = 'ltimer';

var fmMain       : TfmMain;


implementation


{$R *.lfm}


procedure TfmMain.cbPresetsSelect(Sender: TObject);
begin

  upHours.Position:=moPresets[cbPresets.ItemIndex].miHours;
  upMin.Position:=moPresets[cbPresets.ItemIndex].miMinutes;
  upSec.Position:=moPresets[cbPresets.ItemIndex].miSeconds;
  cbPresets.Text:=moPresets[cbPresets.ItemIndex].msName;
end;

//procedure TfmMain.cbPresetsChange(Sender: TObject);
//begin
//
//  bbtSave.Enabled:=not isEmpty(cbPresets.Text);
//end;



procedure TfmMain.sbStopClick(Sender: TObject);
begin

  Stop();
end;


procedure TfmMain.TimerTimer(Sender: TObject);
begin

  //***** Уменьшим секунды на 1
  if upSec.Position>0 then begin

    upSec.Position:=upSec.Position-1;

    //***** Время еще не вышло?
    if (upSec.Position=0) and
       (upMin.Position=0) and
       (upHours.Position=0) then begin

      //***** Вышло. Остановим таймер и покажем состояние счетчиков
      Stop();
      Display();
      Notify('Ку-ку.','Время вышло!');
    end;
  end else begin

    //***** Если минуты не кончились
    if upMin.Position>0 then
    begin

      //***** уменьшим их на 1
      upMin.Position:=upMin.Position-1
    end else
    begin

      //***** Если часы не кончились,
      if upHours.Position>0 then
      begin

        //***** уменьшим их на 1
        upHours.Position:=upHours.Position-1;
			end;

      //***** Если отсчет не окончен, выставляем минуты
      if mblRunning then
      begin

        upMin.Position:=59;
			end;
		end;

    //***** Если отсчет не окончен, выставляем секунды
    if mblRunning then
    begin

      upSec.Position:=59;
		end;
	end;
  inc(mlCycle);
  Display();
end;


procedure TfmMain.clickStart;
begin

  //***** Если счетчики не нулевые..
  if (upSec.Position>0) or
     (upMin.Position>0) or
     (upHours.Position>0) then begin

    mlTotalCycles := (upHours.Position * 360) + (upMin.Position * 60) + upSec.Position;
    moProgressMgr.setup(mlTotalCycles);
    Start();
  end;
end;


procedure TfmMain.clickReset;
begin

  sbStart.Enabled:=True;
  sbStop.Enabled:=False;
  Timer.Enabled:=False;
  upHours.Position:=0;
  upMin.Position:=0;
  upSec.Position:=0;
  cbPresets.ItemIndex:=-1;
  cbPresets.Text:='';
  moProgressMgr.Reset();
end;


procedure TfmMain.clickSave;
var lsPresetNumber : String;
    lsPresetName   : String;
    liExistPreset  : Integer;
begin

  liExistPreset:=cbPresets.Items.IndexOf(cbPresets.Text);
  if liExistPreset>0 then
  begin

    lsPresetNumber:=IntToStr(liExistPreset+1);

  end else
  begin

    inc(miPresetCount);
  end;
  lsPresetName := cbPresets.Text;
  moIniMgr.write('presets', 'preset'+lsPresetNumber, lsPresetName);
  moIniMgr.write('presets', 'count', miPresetCount);
  moIniMgr.write(lsPresetName,'hours',upHours.Position);
  moIniMgr.write(lsPresetName,'minutes',upMin.Position);
  moIniMgr.write(lsPresetName,'seconds',upSec.Position);
  loadPresets();
end;


procedure TfmMain.Start;
begin

  //***** Переходим в состояние "Таймер запущен"
  sbStart.Enabled:=False;
  sbReset.Enabled:=False;
  sbStop.Enabled:=True;
  Timer.Interval:=1000;
  Timer.Enabled:=True;
  mblRunning:=True;
end;


procedure TfmMain.Stop;
begin

  //***** Переходим в состояние "Таймер остановлен"
  //sbStart.Enabled:=True;
  sbReset.Enabled:=True;
  sbStop.Enabled:=False;
  Timer.Enabled:=False;
  mblRunning:=False;
  moProgressMgr.Finish();
  Display();
end;


procedure TfmMain.Display;
begin

  if mblRunning then begin

    moProgressMgr.step(mlTotalCycles - mlCycle);
    Application.ProcessMessages;
    Caption:=Format('%.2d:%.2d:%.2d',[upHours.Position,upMin.Position,upSec.Position]);
    Application.Title:=Caption;
    //Caption:= IntToStr(ProgressBar.Position);
  end else begin

    Caption:='Остановлен';
    Application.Title:='ltimer';
  end;
  //Application.ProcessMessages;
end;


procedure TfmMain.Bell;
begin

  {$ifdef __WINDOWS__}
  //PlaySound(PChar(g_rConfig.m_sClockWave),0,SND_FILENAME or SND_ASYNC);
  {$endif}

  {$ifdef __LINUX__}
  //FpSystem('aplay /home/username/bell.wav');
  {$endif}
end;


procedure TfmMain.loadPresets;
var liPresetNumber : Integer;
    lsPresetName : String;
begin

  Screen.Cursor := crHourGlass;
  miPresetCount := moIniMgr.read('presets', 'count', 0);
  if miPresetCount>0 then
  begin

    SetLength(moPresets, miPresetCount);
    cbPresets.Items.Clear;
    for liPresetNumber:=1 to miPresetCount do
    begin

      lsPresetName := moIniMgr.read('presets', 'preset' + intToStr(liPresetNumber), '');
      moPresets[liPresetNumber-1].msName:=lsPresetName;
      moPresets[liPresetNumber-1].miHours:=moIniMgr.read(lsPresetName,'hours', 0);
      moPresets[liPresetNumber-1].miMinutes:=moIniMgr.read(lsPresetName,'minutes',1);
      moPresets[liPresetNumber-1].miSeconds:=moIniMgr.read(lsPresetName,'seconds',0);
      cbPresets.Items.Add(moPresets[liPresetNumber-1].msName);
    end;
  end;
  Screen.Cursor:=crArrow;
end;


procedure TfmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  {---< Сохраним в ини-файле позицию формы и состояние счетчиков >---}
  moIniMgr.write(fmMain);
  FreeAndNil(moIniMgr);
  FreeAndNil(moProgressMgr);
  Inherited;
end; {- procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction); -}


procedure TfmMain.formcreate(sender : tobject);
begin

  inherited;
  moProgressMgr := TEasyProgressBar.Create(ProgressBar);
  moIniMgr := TEasyIniManager.Create();
  moIniMgr.read(fmMain);
  loadPresets();
end;


procedure TfmMain.meHourChange(Sender: TObject);
begin

  if Timer.Enabled = False then
  begin

    moProgressMgr.Reset();
    sbStart.Enabled:=(upHours.Position>0) or
                      (upMin.Position>0) or
                      (upSec.Position>0);
  end;
end;


procedure TfmMain.sbResetClick(Sender : TObject);
begin

  clickReset();
end;


procedure TfmMain.sbSaveClick(Sender : TObject);
begin

  clickSave();
end;


procedure TfmMain.sbStartClick(Sender : TObject);
begin

  clickStart();
end;


end.

