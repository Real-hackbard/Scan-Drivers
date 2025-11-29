unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  ImageHlp, MMSystem, ShellAPI, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Menus;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    Button4: TButton;
    Edit2: TEdit;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    Update1: TMenuItem;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog2: TOpenDialog;
    Label7: TLabel;
    Clear1: TMenuItem;
    Execute1: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Update1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Execute1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    function StartDriver(const FileName, Params, DefaultDir: string;
                            ShowCmd: Integer; Sender: TObject): THandle;
    procedure MarkLine(Sender: TObject);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  ChoicePath, SysDir, DLLPath : string;
  ChoiceLine, SelectLine      : string;
  ListBoxSel, StartFeX        : Integer;
  ProperName                  : string;

  LibraryDLL : string =   'Shell32.dll';
  RunFunction : string =  'Control_RunDLL';
  Attribute : string =    '';
  DemoString : string =   'SHELL32.DLL,CONTROL_RUNDLL';

  (* Search by version and manufacturer if the driver file
     includes this information.*)
  //Version : string =       'v4.0';
  //License : string =       'Freeware-Tool';
  //Creator : string =       '© Microsoft Corporation';

implementation

{$R *.dfm}
function TForm1.StartDriver(const FileName, Params, DefaultDir: string;
                            ShowCmd: Integer; Sender: TObject): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
(* Rundll32.exe is a legitimate and essential Windows system process used
   to execute functions from Dynamic Link Library (DLL) files. DLL files
   cannot be executed directly; rundll32.exe acts as a host process to
   load and execute these functions when needed.*)
  Result := ShellExecute(Application.MainForm.Handle, nil,
            StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
            StrPCopy(zDir, DefaultDir), ShowCmd);   // DefaultDir), SW_MAXIMIZE);
  StartFeX := Result;
end;
{
function SystemDir: string;
var
  dir: array [0..MAX_PATH] of Char;
begin
  // get C:\Windows\Sytem32\.. path
  GetSystemDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
end;
}

function SystemDir: string;
var
  Dir: string;
  Len: DWord;
begin
  SetLength(Dir,MAX_PATH);
  Len := GetSystemDirectory(PChar(Dir),MAX_PATH);
  if Len > 0 then
  begin
    SetLength(Dir,Len);
    Result := Dir;
  end
  else
    RaiseLastOSError;
end;
procedure DLLAccesses(const FileName: string; StrListe: TStrings);
type
  TTextArray = array [0..$FFFFF] of DWORD;
var
  ImgInfo     : LoadedImage;
  PExpDir     : PImageExportDirectory;
  ListSize    : Cardinal;
  pImSeHe     : PImageSectionHeader;
  i           : Cardinal;
  pNameRVAs   : ^TTextArray;
  InputName   : PChar;
begin
  StrListe.Clear;
  if MapAndLoad(PAnsiChar(AnsiString(FileName)), nil,
                                                 @ImgInfo,  // ImagehlpLib
                                                 True,
                                                 True)
                                                 then
  begin
    try
      PExpDir := ImageDirectoryEntryToData(ImgInfo.MappedAddress,
                                           False,
                                           IMAGE_DIRECTORY_ENTRY_EXPORT,
                                           ListSize);
      if (PExpDir <> nil) then
      begin
        pNameRVAs := ImageRvaToVa(ImgInfo.FileHeader, ImgInfo.MappedAddress,
          DWORD(PExpDir^.AddressOfNames), pImSeHe);

        for i := 0 to PExpDir^.NumberOfNames - 1 do
        begin
          InputName := PChar(ImageRvaToVa(ImgInfo.FileHeader,
                                          ImgInfo.MappedAddress,
                                          pNameRVAs^[i], pImSeHe));
          StrListe.Add(PChar(InputName));
        end;
      end;
    finally
      UnMapAndLoad(@ImgInfo);
    end;
  end;
  ListBoxSel := -1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.Title  := 'Select the DLL file, open it, and display its functions..';
  // search for driver files
  OpenDialog1.Filter := 'Library (*.DLL)|*.DLL';
  // browse to the sys dir sytsem32
  OpenDialog1.InitialDir := SysDir;
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then
  begin
    ChoicePath := OpenDialog1.FileName;

    if FileExists(ChoicePath) then
    begin
     Edit1.Text := ChoicePath;
     ListBox1.Clear;
     Update1Click(Sender);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    Edit4.Text := ExtractFileName(OpenDialog2.FileName);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if UpperCase(Edit2.Text) = DemoString then
  begin
  MessageDlg('The inserted example call starts the function' + (#13) +
             SelectLine + '  the file  ' + UpperCase(ExtractFileName(Edit1.Text)) + (#13#13) +
             'Using the command line' + (#13) +
             'rundll32.exe ' + Edit2.Text + (#13) +
             'The Windows regional setting will be displayed..'+(#13#13)+
             'You can find more examples under INFO. !',
             mtInformation, [mbOk], 0);
  end else begin
      if MessageDlg('Starting functions in DLL files happens' + (#13) +
             'at your own risk and should only be done with careful attention to detail' + (#13) +
             'Knowledge of the DLL file and its function is required..' + (#13#13) +
             'Faulty and critical calls can lead to instability.' + (#13) +
             'operating system settings, or basic settings.' + (#13#13) +
             'Do you really want to use the command line now?:' + (#13) +
             'rundll32.exe ' + Edit2.Text + (#13) +
             'start ?',
             mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  end;;

  { ========> Calling the function...Problems can arise here !!! <=========== }
  // Generally, rundll32.exe is located under windows\sytsem32\..
  // But on a 64-bit system, that has changed drastically.
  // The file is now located everywhere. Therefore, search problems can occur.

 (* pathes of (rundll32.exe) :

 > C:\Windows\Prefetch\..
 > C:\Users\User\AppData\Local\CrashDumps\..
 > C:\Windows\SysWOW64\..
 > C:\Windows\WinSxS\wow64_microsoft-windows-rundll32_31bf3856ad364e35_10.0.19041.4355_none_57141bab94858b76\r
 > C:\Windows\System32\..
 > C:\Windows\System32\en-US\..

   The program usually finds the file, but it can also fail.
   The problem is fixed by compiling multiple times.*)

  StartDriver(Edit4.Text, Edit2.Text, ExtractFileDir(Edit1.Text), SW_SHOW, Sender);

  if StartFeX < 33 then
  begin
    MessageDlg('STARTING ERROR NUMBER  ' + IntToStr(StartFeX) + ' ' + (#13#13) +
               'The function of the file  ' + UpperCase(ExtractFileName(Edit1.Text)) +
               'using the command line ' + (#13) +
               'rundll32.exe ' + Edit2.Text + (#13) +
               'could not be started.',
               mtError, [mbOk], 0);
  end;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ListBox1.Clear;
  StatusBar1.Panels[1].Text := '';
  Edit1.Text := '';
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

  case ComboBox1.ItemIndex of
  0 : begin
        // execute file
        Edit4.Text := 'rundll32.exe';
        // load dll
        Edit1.Text := SysDir + LibraryDLL;
        // function to execute from driver
        Edit3.Text := 'Control_RunDLL';
        ListBox1.Clear;
        // update driver information list
        Update1Click(Sender);
        // give function to command line
        ChoiceLine := Edit3.Text;
        // mark the function in list
        MarkLine(Sender);
      end;

  1 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'ShellAboutA';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
      end;

  2 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'OpenAs_RunDLL';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
      end;

  3 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Options_RunDLL';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
      end;

  4 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL timedate.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL timedate.cpl';
      end;

  5 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL desk.cpl,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL desk.cpl,,0';
      end;

  6 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'devmgr.dll DeviceManager_Execute';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'devmgr.dll DeviceManager_Execute';
      end;

  7 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'sysdm.cpl,EditEnvironmentVariables';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'sysdm.cpl,EditEnvironmentVariables';
      end;

  8 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'SHHelpShortcuts_RunDLL FontsFolder';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,SHHelpShortcuts_RunDLL FontsFolder';
      end;

  9 : begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL joy.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL joy.cpl';
      end;

  10: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL srchadmin.dll';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL srchadmin.dll';
      end;

  11: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL inetcpl.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL inetcpl.cpl';
      end;

  12: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL main.cpl @1';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL main.cpl @1';
      end;

  13: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL main.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL main.cpl';
      end;

  14: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL ncpa.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL ncpa.cpl';
      end;

  15: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL odbccp32.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL odbccp32.cpl';
      end;

  16: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL cscui.dll,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL cscui.dll,,0';
      end;

  17: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL powercfg.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL powercfg.cpl';
      end;

  18: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Printui.dll,PrintUIEntry /?';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'Printui.dll,PrintUIEntry /?';
      end;

  19: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL appwiz.cpl,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL appwiz.cpl,,0';
      end;

  20: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL Intl.cpl,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL Intl.cpl,,0';
      end;

  21: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL Intl.cpl,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL Intl.cpl,,1';
      end;

  22: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL wscui.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL wscui.cpl';
      end;

  23: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL NetSetup.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL NetSetup.cpl';
      end;

  24: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL Mmsys.cpl,,0';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL Mmsys.cpl,,0';
      end;

  25: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Options_RunDLL 3';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Options_RunDLL 3';
      end;

  26: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Options_RunDLL 1';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Options_RunDLL 1';
      end;

  27: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}';
      end;

  28: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'Control_RunDLL firewall.cpl';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'shell32.dll,Control_RunDLL firewall.cpl';
      end;

  29: begin
        Edit4.Text := 'rundll32.exe';
        Edit3.Text := 'InetCpl.cpl,ClearMyTracksByProcess 2';
        Edit1.Text := SysDir + LibraryDLL;
        ListBox1.Clear;
        Update1Click(Sender);
        ChoiceLine := Edit3.Text;
        MarkLine(Sender);
        Edit2.Text := 'InetCpl.cpl,ClearMyTracksByProcess 2';
      end;

  end;

  if ListBoxSel > -1 then
  begin
   Edit2.Text := ExtractFileName(Edit1.Text) + ',' +
                 ListBox1.Items.Strings[ListBoxSel] + Attribute;
   SelectLine := ListBox1.Items.Strings[ListBoxSel];
  end;;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if FileExists(Edit1.Text) then
  begin
    StatusBar1.Panels[1].Text := ExtractFileDir(Edit1.Text);
  end else begin
    StatusBar1.Panels[1].Text := 'No DLL file entered.';
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  IF Edit2.Text = '' then
  begin
    Button4.Enabled := False;
    Button4.Hint := 'Select a function of the DLL, add to it, and start it... ';
  end else begin
    Button4.Enabled := True;

    if UpperCase(Edit2.Text) = DemoString then
    begin
     Button4.Hint := 'The inserted example of the DLL function call' + (#13) +
                     'rundll32.exe '+Edit2.Text+' ' + (#13) +
                     'just start ! ';
    end else begin
     Button4.Hint := 'The command line DLL function call' + (#13) +
                     'rundll32.exe '+Edit2.Text+' ' + (#13) +
                     'start ! ';
    end;
  end;
end;

procedure TForm1.Execute1Click(Sender: TObject);
begin
  Button4.Click;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // get application exe path and give it to the variable
  //ProperName := ExtractFileName(ParamStr(0));
  // set the hint hide off
  Application.HintPause := 0;
  // set hint pause to 50 second
  Application.HintHidePause := 50000;

  Button1.Hint := 'Open the driver file; '+(#13)+
                  'the driver must be located in the same folder as the executable file.';
  Button2.Hint := 'Open the executable file; '+(#13)+
                  'the executable must be located in the same folder as the driver file.';
  Button4.Hint := 'Select a function of the DLL, add to it, and start it... ';

  SysDir := SystemDir;

  //if Copy(SysDir, Length(SysDir), Length(SysDir)) <> '\' then
  SysDir := SysDir + '\';

  Sleep(100);  // Important to scan and create driver content
  Edit1.Text := SysDir + LibraryDLL;



  StatusBar1.Panels[1].Text  := SysDir;
  Update1.OnClick(self);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  ListBoxSel := ListBox1.ItemIndex;
  if ListBoxSel > -1 then
  begin
    Edit2.Text := ExtractFileName(Edit1.Text) + ',' + ListBox1.Items.Strings[ListBoxSel];
    SelectLine := ListBox1.Items.Strings[ListBoxSel];
  end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Button4.Click;
end;

procedure TForm1.MarkLine(Sender: TObject);
begin
  if SendMessage(ListBox1.Handle, lb_selectstring, - 1,
                 Longint(PChar(ChoiceLine))) <> LB_ERR then
    ListBoxSel := ListBox1.ItemIndex
  else
    ListBoxSel := -1;
end;

procedure TForm1.Update1Click(Sender: TObject);
var
  StrList: TStrings;
  i: Integer;
  NumberText : string;
begin
  ListBox1.Clear;
  DLLPath := Edit1.Text;
  StrList := TStringList.Create;

  try
    DLLAccesses(DLLPath, StrList);
    NumberText := IntToStr(StrList.Count);
    for i := 0 to StrList.Count - 1 do
              // string; to change unicode
      ListBox1.Items.Add(PAnsiChar(StrList[i]));
  finally
    StrList.Free
  end;

  StatusBar1.Panels[1].Text := 'The file  ' + UpperCase(ExtractFileName(Edit1.Text)) +
                '  contains ' + NumberText + ' Features.';
end;

end.
