inherited frmXData: TfrmXData
  Left = 273
  Top = 154
  Caption = 'Jabber Form'
  ClientHeight = 416
  ClientWidth = 492
  OldCreateOrder = True
  OnClose = FormClose
  ExplicitWidth = 500
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDockTop: TPanel
    Width = 492
    TabOrder = 2
    ExplicitWidth = 355
    inherited tbDockBar: TToolBar
      Left = 443
      ExplicitLeft = 306
      inherited btnCloseDock: TToolButton
        Visible = False
      end
    end
  end
  inline frameButtons1: TframeButtons
    Left = 0
    Top = 382
    Width = 492
    Height = 34
    Align = alBottom
    TabOrder = 0
    TabStop = True
    ExplicitTop = 247
    ExplicitWidth = 355
    ExplicitHeight = 34
    inherited Panel2: TPanel
      Width = 492
      Height = 34
      ExplicitWidth = 355
      ExplicitHeight = 34
      inherited Bevel1: TBevel
        Width = 492
        ExplicitWidth = 355
      end
      inherited Panel1: TPanel
        Left = 332
        Height = 29
        ExplicitLeft = 195
        ExplicitHeight = 29
        inherited btnOK: TTntButton
          OnClick = frameButtons1btnOKClick
        end
        inherited btnCancel: TTntButton
          OnClick = frameButtons1btnCancelClick
        end
      end
    end
  end
  inline frameXData: TframeXData
    Left = 0
    Top = 32
    Width = 492
    Height = 350
    Align = alClient
    TabOrder = 1
    TabStop = True
    ExplicitTop = 32
    ExplicitWidth = 355
    ExplicitHeight = 215
    inherited Panel1: TPanel
      Width = 492
      Height = 350
      ExplicitWidth = 355
      ExplicitHeight = 215
      inherited ScrollBox1: TScrollBox
        Width = 482
        Height = 340
        ExplicitWidth = 345
        ExplicitHeight = 205
      end
    end
  end
end
