unit AWItem;

{
    Copyright 2003, Peter Millard

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

{$ifdef VER150}
    {$define INDY9}
{$endif}

interface

uses
    Unicode,
    Windows,
    SysUtils,
    Classes,
    Controls,
    Forms,
    StdCtrls,
    ComCtrls,
    TntStdCtrls,
    ExtCtrls,
    ExFrame,
    ExGradientPanel,
    Graphics, Menus, TntMenus, SClrRGrp;

type
    TfAWItem = class(TExFrame)
    pnlAWItemGPanel: TExGradientPanel;
    lblName: TTntLabel;
    lblCount: TTntLabel;
    imgPresence: TImage;
    LeftSpacer: TBevel;
    RightLBLSpacer: TBevel;
    AWItemPopupMenu: TTntPopupMenu;
    mnuCloseWindow: TTntMenuItem;
    mnuFloatWindow: TTntMenuItem;
    mnuDockWindow: TTntMenuItem;
    FarRightSpacer: TBevel;
    FarLeftSpacer: TBevel;
    AWItemBevel: TColorBevel;
    procedure imgPresenceClick(Sender: TObject);
    procedure lblNameClick(Sender: TObject);
    procedure lblCountClick(Sender: TObject);
    procedure pnlAWItemGPanelClick(Sender: TObject);
    procedure TntFrameClick(Sender: TObject);
    procedure AWItemPopupMenuPopup(Sender: TObject);
    procedure mnuCloseWindowClick(Sender: TObject);
    procedure mnuDockWindowClick(Sender: TObject);
    procedure mnuFloatWindowClick(Sender: TObject);
    private
        { Private declarations }
        _count: integer;
        _imgIndex: integer;
        _priorityStartColor: TColor;
        _priorityEndColor: TColor;
        _newWindowStartColor: TColor;
        _newWindowEndColor: TColor;
        _activeStartColor: TColor;
        _activeEndColor: TColor;
        _startColor: TColor;
        _endColor: TColor;
        _docked: boolean;
        _active: boolean;
        _priority: boolean;
        _newWindowHighlight: boolean;
        _activity_window_selected_font_color: TColor;
        _activity_window_non_selected_font_color: TColor;
        _activity_window_unread_msgs_font_color: TColor;
        _activity_window_high_priority_font_color: TColor;
        _activity_window_unread_msgs_high_priority_font_color: TColor;
        _activity_window_bevel_shadow_color: TColor;
        _activity_window_bevel_highlight_color: TColor;
        _timNewItemTimer: TTimer;
        _flashcnt: integer;

        procedure _setCount(val:integer);
        function _getName(): widestring;
        procedure _setName(val:widestring);
        procedure _setImgIndex(val: integer);
        procedure _setPnlColors(startColor, endColor: TColor);
        procedure _timNewItemTimerTimer(Sender: TObject);
        procedure _stopTimer();
    protected
        { Protected declarations }
    public
        { Public declarations }
        constructor Create(AOwner: TComponent); reintroduce;
        destructor Destroy(); reintroduce;

        procedure activate(setActive:boolean);
        procedure priorityFlag(setPriority:boolean);

        property name: WideString read _getName write _setName;
        property count: integer read _count write _setCount;
        property imgIndex: integer read _imgIndex write _setImgIndex;
        property priorityStartColor: TColor read _priorityStartColor write _priorityStartColor;
        property priorityEndColor: TColor read _priorityEndColor write _priorityEndColor;
        property activeStartColor: TColor read _activeStartColor write _activeStartColor;
        property activeEndColor: TColor read _activeEndColor write _activeEndColor;
        property docked: boolean read _docked write _docked;
        property active: boolean read _active;
        property priority: boolean read _priority;
        property defaultStartColor: TColor read _startColor write _startColor;
        property defaultEndColor: TColor read _endColor write _endColor;
        property newWindowHighlight: boolean read _newWindowHighlight;
    published
        { published declarations }
    end;

implementation

uses
    Jabber1, ActivityWindow, Session,
    XMLTag, StateForm, ExUtils;


{$R *.dfm}

{---------------------------------------}
{---------------------------------------}
{---------------------------------------}
procedure TfAWItem.AWItemPopupMenuPopup(Sender: TObject);
begin
    inherited;
    if (_docked) then begin
        mnuDockWindow.Visible := false;
        mnuFloatWindow.Visible := true;
    end
    else begin
        mnuDockWindow.Visible := true;
        mnuFloatWindow.Visible := false;
    end;
end;

{---------------------------------------}
constructor TfAWItem.Create(AOwner: TComponent);
var
    tag: TXMLTag;
begin
    inherited;

    try
        // Set defaults
        _startColor := pnlAWItemGPanel.GradientProperites.startColor;
        _endColor := pnlAWItemGPanel.GradientProperites.endColor;
        _priorityStartColor := $000000ff;
        _priorityEndColor := $000000ff;
        _newWindowStartColor := $0000ffff;
        _newWindowEndColor := $0000aaaa;
        _activeStartColor := $0000ff00;
        _activeEndColor := $0000ff00;
        _activity_window_selected_font_color := $00000000;
        _activity_window_non_selected_font_color := $00000000;
        _activity_window_unread_msgs_font_color := $000000ff;
        _activity_window_high_priority_font_color := $00000000;
        _activity_window_unread_msgs_high_priority_font_color := $00000000;
        _activity_window_bevel_shadow_color := AWItemBevel.Shadow;
        _activity_window_bevel_highlight_color := AWItemBevel.HighLight;


        // Set from prefs
        tag := MainSession.Prefs.getXMLPref('activity_window_default_color');
        if (tag <> nil) then begin
            _startColor := TColor(StrToInt(tag.GetFirstTag('start').Data));
            _endColor := TColor(StrToInt(tag.GetFirstTag('end').Data));
            pnlAWItemGPanel.GradientProperites.startColor := _startColor;
            pnlAWItemGPanel.GradientProperites.endColor := _endColor;
        end;
        FreeAndNil(tag);
        tag := MainSession.Prefs.getXMLPref('activity_window_selected_color');
        if (tag <> nil) then begin
            _activeStartColor := TColor(StrToInt(tag.GetFirstTag('start').Data));
            _activeEndColor := TColor(StrToInt(tag.GetFirstTag('end').Data));
        end;
        FreeAndNil(tag);
        tag := MainSession.Prefs.getXMLPref('activity_window_high_priority_color');
        if (tag <> nil) then begin
            _priorityStartColor := TColor(StrToInt(tag.GetFirstTag('start').Data));
            _priorityEndColor := TColor(StrToInt(tag.GetFirstTag('end').Data));
        end;
        FreeAndNil(tag);
        tag := MainSession.Prefs.getXMLPref('activity_window_new_window_color');
        if (tag <> nil) then begin
            _newWindowStartColor := TColor(StrToInt(tag.GetFirstTag('start').Data));
            _newWindowEndColor := TColor(StrToInt(tag.GetFirstTag('end').Data));
        end;
        FreeAndNil(tag);
        tag := MainSession.Prefs.getXMLPref('activity_window_bevel_color');
        if (tag <> nil) then begin
            _activity_window_bevel_shadow_color := TColor(StrToInt(tag.GetFirstTag('shadow').Data));
            _activity_window_bevel_highlight_color := TColor(StrToInt(tag.GetFirstTag('highlight').Data));
            AWItemBevel.Shadow := _activity_window_bevel_shadow_color;
            AWItemBevel.HighLight := _activity_window_bevel_highlight_color;
        end;
        FreeAndNil(tag);
        _activity_window_selected_font_color := TColor(MainSession.Prefs.GetInt('activity_window_non_selected_font_color'));
        _activity_window_non_selected_font_color := TColor(MainSession.Prefs.GetInt('activity_window_selected_font_color'));
        _activity_window_unread_msgs_font_color := TColor(MainSession.Prefs.GetInt('activity_window_unread_msgs_font_color'));
        _activity_window_high_priority_font_color := TColor(MainSession.Prefs.GetInt('activity_window_high_priority_font_color'));
        _activity_window_unread_msgs_high_priority_font_color := TColor(MainSession.Prefs.GetInt('activity_window_unread_msgs_high_priority_font_color'));

        // Set timer for new window notification
        if (not StateForm.restoringDesktopFlag) then begin
            _timNewItemTimer := TTimer.Create(Self);
            if (_timNewItemTimer <> nil) then begin
                _timNewItemTimer.Enabled := true;
                _timNewItemTimer.Interval := 500;
                _timNewItemTimer.OnTimer := _timNewItemTimerTimer;
                _flashcnt := 0;
                _newWindowHighlight := true;
            end;
        end
        else begin
            _timNewItemTimer := nil;
        end;

        AssignUnicodeFont(lblCount.Font);
        AssignUnicodeFont(lblName.Font);
    except
    end;
end;

{---------------------------------------}
destructor TfAWItem.Destroy();
begin
    if (_timNewItemTimer <> nil) then begin
        _timNewItemTimer.Enabled := false;
    end;

    _timNewItemTimer.Free;
end;

{---------------------------------------}
procedure TfAWItem._timNewItemTimerTimer(Sender: TObject);
begin
    Inc(_flashcnt);
    if (_flashcnt >= 6) then begin
        _setPnlColors(_newWindowStartColor, _newWindowEndColor);
        _stopTimer();
    end
    else begin
        if ((_flashcnt mod 2) = 0) then begin
            _setPnlColors(_newWindowStartColor, _newWindowEndColor);
        end
        else begin
            _setPnlColors(_startColor, _endColor);
        end;
    end;
end;

{---------------------------------------}
procedure TfAWItem._stopTimer();
begin
    if (_timNewItemTimer <> nil) then begin
        _timNewItemTimer.Enabled := false;
        _timNewItemTimer.Free();
        _timNewItemTimer := nil;
    end;
end;

{---------------------------------------}
procedure TfAWItem._setCount(val:integer);
begin
    _count := val;
    if (_count >= 0) then begin
        lblCount.Caption := IntToStr(_count);
        if (_count > 0) then begin
            if (_priority) then begin
                lblCount.Font.Color := _activity_window_unread_msgs_high_priority_font_color;
            end
            else begin
                lblCount.Font.Color := _activity_window_unread_msgs_font_color;
            end;
            lblCount.Font.Style := lblCount.Font.Style + [fsBold];
        end
        else begin
            if (_active) then begin
                lblCount.Font.Color := _activity_window_selected_font_color;
            end
            else begin
                lblCount.Font.Color := _activity_window_non_selected_font_color;
            end;
            lblCount.Font.Style := lblCount.Font.Style - [fsBold];
        end;
    end
    else begin
        // Count < 0, thus hide count indicator
        lblCount.Caption := ' ';
    end;
end;

{---------------------------------------}
procedure TfAWItem.imgPresenceClick(Sender: TObject);
begin
    inherited;
    Self.OnClick(Self);
end;

{---------------------------------------}
procedure TfAWItem.lblCountClick(Sender: TObject);
begin
    inherited;
    Self.OnClick(Self);
end;

{---------------------------------------}
procedure TfAWItem.lblNameClick(Sender: TObject);
begin
    inherited;
    Self.OnClick(Self);
end;

{---------------------------------------}
procedure TfAWItem.mnuCloseWindowClick(Sender: TObject);
var
    aw: TfrmActivityWindow;
    item: TAWTrackerItem;
begin
    inherited;

    aw := GetActivityWindow();

    if (aw <> nil) then begin
        item := aw.findItem(self);
        if (item <> nil) then begin
            item.frm.Close();
        end;
    end;
end;

{---------------------------------------}
procedure TfAWItem.mnuDockWindowClick(Sender: TObject);
var
    aw: TfrmActivityWindow;
    item: TAWTrackerItem;
begin
    inherited;

    aw := GetActivityWindow();

    if (aw <> nil) then begin
        item := aw.findItem(self);
        if (item <> nil) then begin
            ShowWindow(item.frm.Handle, SW_RESTORE);
            item.frm.DockForm();
            aw.activateItem(Self);
            _docked := true;
        end;
    end;
end;

{---------------------------------------}
procedure TfAWItem.mnuFloatWindowClick(Sender: TObject);
var
    aw: TfrmActivityWindow;
    item: TAWTrackerItem;
begin
    inherited;

    aw := GetActivityWindow();

    if (aw <> nil) then begin
        item := aw.findItem(self);
        if (item <> nil) then begin
            item.frm.FloatForm();
            aw.activateItem(Self);
            _docked := false;
        end;
    end;
end;

{---------------------------------------}
function TfAWItem._getName(): widestring;
begin
    Result := lblName.Caption;
end;

{---------------------------------------}
procedure TfAWItem._setName(val:widestring);
begin
    lblName.Caption := val;
    Hint := val;
end;

{---------------------------------------}
procedure TfAWItem._setImgIndex(val: Integer);
begin
    if ((val >= 0) and
        (val < frmExodus.ImageList2.Count)) then begin
        _imgIndex := val;
        frmExodus.ImageList2.GetIcon(_imgIndex, imgPresence.Picture.Icon);
      end;
end;

{---------------------------------------}
procedure TfAWItem.activate(setActive: boolean);
begin
    _active := setActive;
    if (setActive) then begin
        _newWindowHighlight := false;
        _priority := false;
        _stopTimer();                
        _setPnlColors(_activeStartColor, _activeEndColor);
        lblName.Font.Color := _activity_window_selected_font_color;
        lblCount.Font.Color := _activity_window_selected_font_color;
    end
    else begin
        _setPnlColors(_startColor, _endColor);
        lblName.Font.Color := _activity_window_non_selected_font_color;
        lblCount.Font.Color := _activity_window_non_selected_font_color;
    end;
end;

{---------------------------------------}
procedure TfAWItem.pnlAWItemGPanelClick(Sender: TObject);
begin
    inherited;
    Self.OnClick(Self);
end;

{---------------------------------------}
procedure TfAWItem.priorityFlag(setPriority:boolean);
begin
    _priority := setPriority;
    if (setPriority) then begin
        _setPnlColors(_priorityStartColor, _priorityEndColor);
        lblName.Font.Color := _activity_window_high_priority_font_color;
    end
    else begin
        if ((pnlAWItemGPanel.GradientProperites.startColor = _priorityStartColor) and
            (pnlAWItemGPanel.GradientProperites.startColor = _priorityStartColor)) then begin
            // This clears out Priority color only if it is showing
            // If the color is something else (like the selected color, then
            // color will be left alone.
            _setPnlColors(_startColor, _endColor);
        end;
    end;
end;

{---------------------------------------}
procedure TfAWItem.TntFrameClick(Sender: TObject);
begin
    inherited;
    Self.OnClick(Self);
end;

{---------------------------------------}
procedure TfAWItem._setPnlColors(startColor, endColor: TColor);
begin
    pnlAWItemGPanel.GradientProperites.startColor := startColor;
    pnlAWItemGPanel.GradientProperites.endColor := endColor;
    pnlAWItemGPanel.Invalidate;
end;


end.
