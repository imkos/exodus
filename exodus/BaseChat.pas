unit BaseChat;
{
    Copyright 2002, Peter Millard

    This file is part of Exodus.

    Exodus is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Exodus is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Exodus; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

interface

uses
    Dockable, ActiveX, ComObj, BaseMsgList,
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls, ExRichEdit, RichEdit2,
    TntStdCtrls, TntMenus;

const
    WM_THROB = WM_USER + 5400;

type

  TfrmBaseChat = class(TfrmDockable)
    pnlMsgList: TPanel;
    Splitter1: TSplitter;
    pnlInput: TPanel;
    Panel1: TPanel;
    popMsgList: TTntPopupMenu;
    popOut: TTntPopupMenu;
    MsgOut: TExRichEdit;
    timWinFlash: TTimer;
    Clear1: TTntMenuItem;
    CopyAll1: TTntMenuItem;
    Copy1: TTntMenuItem;
    emot_sep: TTntMenuItem;
    Emoticons2: TTntMenuItem;
    N2: TTntMenuItem;
    Paste2: TTntMenuItem;
    Copy3: TTntMenuItem;
    Copy2: TTntMenuItem;

    procedure Emoticons1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MsgOutKeyPress(Sender: TObject; var Key: Char);
    procedure MsgOutKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure CopyAll1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Copy3Click(Sender: TObject);
    procedure MsgOutKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure timWinFlashTimer(Sender: TObject);
    procedure FormEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure MsgOutEnter(Sender: TObject);
    procedure MsgOutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    _msgHistory : TStringList;
    _lastMsg : integer;

  protected
    _embed_returns: boolean;        // Put CR/LF's into message
    _wrap_input: boolean;           // Wrap text input
    _scroll: boolean;               // Should we scroll
    _esc: boolean;                  // Does ESC close
    _close_key: Word;               // Normal Hot-key to use to close
    _close_shift: TShiftState;
    _msgframe: TObject;

    procedure _scrollBottom();
    procedure WMVScroll(var msg: TMessage); message WM_VSCROLL;
    function getMsgList(): TfBaseMsgList;

  public
    { Public declarations }
    AutoScroll: boolean;

    procedure SetEmoticon(msn: boolean; imgIndex: integer);
    procedure SendMsg(); virtual;
    procedure HideEmoticons();
    procedure Flash;
    procedure pluginMenuClick(Sender: TObject); virtual; abstract;

    property MsgList: TfBaseMsgList read getMsgList;

  end;

var
  frmBaseChat: TfrmBaseChat;

implementation

{$R *.dfm}
uses
    RTFMsgList, IEMsgList, ClipBrd, Session, MsgDisplay, ShellAPI, Emoticons, Jabber1;

{---------------------------------------}
procedure TfrmBaseChat.Emoticons1Click(Sender: TObject);
var
    r: TRect;
    m, w, h, l, t: integer;
    cp: TPoint;
begin
  inherited;
    // Show the emoticons form
    GetCaretPos(cp);
    l := MsgOut.ClientOrigin.x + cp.X;
    m := Screen.MonitorFromWindow(Self.Handle).MonitorNum;

    r := Screen.Monitors[m].WorkAreaRect;
    w := Abs(r.Right - r.Left);
    h := Abs(r.Bottom - r.Top);

    if ((l + frmEmoticons.Width) > w) then
        l := w - frmEmoticons.Width - 5;

    frmEmoticons.Left := l + 10;

    if (Self.Docked) then begin
        t := frmExodus.Top + frmExodus.ClientHeight - 10;
    end
    else begin
        t := Self.Top + Self.ClientHeight - 10;
    end;

    if ((t + frmEmoticons.Height) > h) then
        t := h - frmEmoticons.Height;

    frmEmoticons.Top := t;
    frmEmoticons.ChatWindow := Self;
    frmEmoticons.Show;
end;

{---------------------------------------}
procedure TfrmBaseChat.SetEmoticon(msn: boolean; imgIndex: integer);
var
    l, i, m: integer;
    eo: TEmoticon;
begin
    // Setup some Emoticon
    m := -1;

    if (emoticon_list.Count = 0) then
        ConfigEmoticons();

    // XXX: PGM: TEmoticon needs to go away, when you are done.
    for i := 0 to emoticon_list.Count - 1 do begin
        eo := TEmoticon(emoticon_list.Objects[i]);
        if (((msn) and (eo.il = frmExodus.imgMSNEmoticons)) or
        ((not msn) and (eo.il = frmExodus.imgYahooEmoticons))) then begin
            // the image lists match
            if (eo.idx = imgIndex) then begin
                m := i;
                break;
            end;
        end;
    end;

    if (m >= 0) then begin
        l := length(MsgOut.Text);
        if ((l > 0) and ((MsgOut.Text[l]) <> ' ')) then
            MsgOut.SelText := ' ';
        MsgOut.SelText := emoticon_list[m];
    end;
end;

{---------------------------------------}
procedure TfrmBaseChat.FormActivate(Sender: TObject);
begin
    inherited;

    if (timWinFlash.Enabled) then
        timWinFlash.Enabled := false;

    frmExodus.ActiveChat := Self;
    if (_msgframe <> nil) then
        MsgList.invalidate();

    if ((frmEmoticons <> nil) and (frmEmoticons.Visible)) then
        frmEmoticons.Hide;
end;

{---------------------------------------}
procedure TfrmBaseChat.MsgOutKeyPress(Sender: TObject; var Key: Char);
begin
    // I don't agree with this hotkey... it can be "bad"
    {
    if ( Key = #27 ) then
        Close();
    }
    if (key <> #0) then
        inherited;
end;

{---------------------------------------}
procedure TfrmBaseChat.MsgOutKeyUp(Sender: TObject;
                                   var Key: Word;
                                   Shift: TShiftState);
var
    m : string;
begin
    // for now.
    // TODO: use the message history that's in MsgList
    if ((Key = VK_UP) and (Shift = [ssCtrl])) then begin
        dec(_lastMsg);
        if (_lastMsg < 0) then begin
            _lastMsg := 0;
            exit;
        end;
        m := _msgHistory[_lastMsg];
        MsgOut.Text := m;
        MsgOut.SelStart := length(m);
        MsgOut.SetFocus();
    end
    else if ((Key = VK_DOWN) and (Shift = [ssCtrl])) then begin
        if (_lastMsg = _msgHistory.Count) then exit;
        inc(_lastMsg);
        if (_lastMsg >= _msgHistory.Count) then begin
            _lastMsg := _msgHistory.Count - 1;
            exit;
        end;
        m := _msgHistory[_lastMsg];
        MsgOut.Text := m;
        MsgOut.SelStart := length(m);
        MsgOut.SetFocus();
    end
    else
        inherited;
end;

{---------------------------------------}
procedure TfrmBaseChat.MsgOutKeyDown(Sender: TObject; var Key: Word;
                                     Shift: TShiftState);
begin
    if (Key = 0) then exit;

    // handle Ctrl-Tab to switch tabs
    if ((Key = VK_TAB) and (ssCtrl in Shift) and (self.Docked))then begin
        Self.TabSheet.PageControl.SelectNextPage(not (ssShift in Shift));
        Key := 0;
    end

    // handle Ctrl-W to close tab
    else if ((Key = _close_key) and (Shift = _close_shift)) then
        Self.Close()

    else if ((_esc) and (Key = 27)) then
        Self.Close()

    // handle Ctrl-ENTER and ENTER to send msgs
    else if (Key = VK_RETURN) then begin
        if ((Shift = []) and (not _embed_returns)) then begin
            Key := 0;
            SendMsg();
        end
        else if (Shift = [ssCtrl]) then begin
            Key := 0;
            SendMsg()
        end;
    end;
end;

{---------------------------------------}
procedure TfrmBaseChat.SendMsg();
begin
    _msgHistory.Add(MsgOut.Text);
    _lastMsg := _msgHistory.Count;

    MsgOut.Lines.Clear();
    MsgOut.SetFocus;
end;

{---------------------------------------}
procedure TfrmBaseChat.FormCreate(Sender: TObject);
var
    ms, ht: integer;
    sc: TShortcut;
begin
    AutoScroll := true;

    _msgHistory := TStringList.Create();
    _lastMsg := -1;
    _esc := false;

    // Pick which frame to build
    ms := MainSession.prefs.getInt('msglist_style');
    if (ms = 0) then
        _msgframe := TfRTFMsgList.Create(Self)
    else if (ms = 1) then
        _msgframe := TfIEMsgList.Create(Self)
    else
        assert(false);

    with MsgList do begin
        Name := 'msg_list_frame';
        Parent := pnlMsgList;
        Align := alClient;
        Visible := true;
        setContextMenu(popMsgList);
    end;

    inherited;

    if (MainSession <> nil) then begin
        ht := MainSession.Prefs.getInt('chat_textbox');
        if (ht <> 0) then
            pnlInput.Height := ht
        else
            MainSession.prefs.setInt('chat_textbox', pnlInput.Height);
        _esc := MainSession.Prefs.getBool('esc_close');

        sc := TextToShortcut(MainSession.Prefs.getString('close_hotkey'));
        ShortCutToKey(sc, _close_key, _close_shift);
    end;

    _scroll := true;
end;

{---------------------------------------}
procedure TfrmBaseChat.FormDestroy(Sender: TObject);
begin
    frmExodus.ActiveChat := nil;
    TfBaseMsgList(_msgframe).Free();
    _msgHistory.Free();
    inherited;
end;

{---------------------------------------}
procedure TfrmBaseChat.Splitter1Moved(Sender: TObject);
begin
  inherited;
    // save the new position to use on all new windows
    MainSession.prefs.setInt('chat_textbox', pnlInput.Height);
end;

{---------------------------------------}
procedure TfrmBaseChat.CopyAll1Click(Sender: TObject);
begin
  inherited;
    MsgList.CopyAll();
end;

{---------------------------------------}
procedure TfrmBaseChat.Clear1Click(Sender: TObject);
begin
    inherited;
    MsgList.Clear();
    _msgHistory.Clear();
end;

{---------------------------------------}
procedure TfrmBaseChat.Copy1Click(Sender: TObject);
begin
    inherited;
    MsgList.Copy();
end;

{---------------------------------------}
procedure TfrmBaseChat.Paste1Click(Sender: TObject);
begin
    inherited;
    MsgOut.PasteFromClipboard();
end;

{---------------------------------------}
procedure TfrmBaseChat.FormResize(Sender: TObject);
begin
  inherited;
    if (timWinFlash.Enabled) then
        timWinFlash.Enabled := false;

    if (_msgframe <> nil) then
        MsgList.Invalidate();
end;

{---------------------------------------}
procedure TfrmBaseChat.HideEmoticons();
begin
    if frmEmoticons.Visible then
        frmEmoticons.Hide();
end;

{---------------------------------------}
procedure TfrmBaseChat.Copy2Click(Sender: TObject);
begin
  inherited;
    MsgOut.CopyToClipboard();
    MsgOut.SelText := '';
end;

{---------------------------------------}
procedure TfrmBaseChat.Copy3Click(Sender: TObject);
begin
  inherited;
    MsgOut.CopyToClipboard();
end;

{---------------------------------------}
procedure TfrmBaseChat._scrollBottom();
begin
    MsgList.ScrollToBottom();
end;

{---------------------------------------}
procedure TfrmBaseChat.timWinFlashTimer(Sender: TObject);
begin
    // Flash the window
    OutputDebugString('timWinFlashTimer');
    FlashWindow(Self.Handle, true);
end;

{---------------------------------------}
procedure TfrmBaseChat.Flash;
begin
    if Self.Active then exit;

    OutputDebugString('Flash');
    if MainSession.Prefs.getBool('notify_flasher') then begin
        timWinFlash.Enabled := true;
    end
    else begin
        timWinFlash.Enabled := false;
        timWinFlashTimer(Self);
    end;
end;

{---------------------------------------}
procedure TfrmBaseChat.FormEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  inherited;
    if timWinFlash.Enabled then
        timWinFlash.Enabled := false;
end;

{---------------------------------------}
procedure TfrmBaseChat.WMVScroll(var msg: TMessage);
begin
    //
end;

{---------------------------------------}
procedure TfrmBaseChat.MsgOutEnter(Sender: TObject);
begin
    if (frmExodus.ActiveChat <> Self) then
        Self.FormActivate(Self);
  inherited;
end;

{---------------------------------------}
procedure TfrmBaseChat.MsgOutMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if (frmExodus.ActiveChat <> Self) then
        Self.FormActivate(Self);
  inherited;
end;

{---------------------------------------}
function TfrmBaseChat.getMsgList(): TfBaseMsgList;
begin
    Result := TfBaseMsgList(_msgframe);
end;

end.
