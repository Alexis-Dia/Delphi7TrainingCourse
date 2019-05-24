object FormGraphic: TFormGraphic
  Left = 192
  Top = 166
  Width = 956
  Height = 636
  Caption = 'FormGraphic'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = -8
    Width = 105
    Height = 105
  end
  object Chart1: TChart
    Left = 8
    Top = 48
    Width = 913
    Height = 465
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Gradient.EndColor = clSilver
    Gradient.Visible = True
    LeftWall.Color = 16744576
    Title.Text.Strings = (
      #1043#1088#1072#1092#1080#1082' '#1088#1072#1079#1083#1086#1078#1077#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1085#1086#1075#1086' '#1087#1088#1086#1094#1077#1089#1089#1072' '#1074' '#1090#1088#1080#1075#1086#1085#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1080#1081' '#1088#1103#1076)
    View3D = False
    TabOrder = 0
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = #1055#1088#1080' w=1'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
      object TeeFunction1: TAddTeeFunction
        Period = 0.500000000000000000
        PeriodAlign = paFirst
        PeriodStyle = psRange
      end
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = #1087#1088#1080' w=3'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16744576
      Title = #1087#1088#1080' w=5'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 776
    Top = 536
    Width = 137
    Height = 49
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 536
    Width = 169
    Height = 49
    Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1080' w=1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337333733373
      3373337F3F7F3F7F3F7F33737373737373733F7F7F7F7F7F7F7F770000000000
      000077777777777777773303333333333333337FF333333F33333709333333C3
      333337773F3FF373F333330393993C3C33333F7F7F77F7F7FFFF77079797977C
      77777777777777777777330339339333C333337FF73373F37F33370C333C3933
      933337773F3737F37FF33303C3C33939C9333F7F7F7FF7F777FF7707C7C77797
      7C97777777777777777733033C3333333C33337F37F33333373F37033C333333
      33C3377F37333333337333033333333333333F7FFFFFFFFFFFFF770777777777
      7777777777777777777733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 536
    Width = 177
    Height = 49
    Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1080' w=3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337333733373
      3373337F3F7F3F7F3F7F33737373737373733F7F7F7F7F7F7F7F770000000000
      000077777777777777773303333333333333337FF333333F33333709333333C3
      333337773F3FF373F333330393993C3C33333F7F7F77F7F7FFFF77079797977C
      77777777777777777777330339339333C333337FF73373F37F33370C333C3933
      933337773F3737F37FF33303C3C33939C9333F7F7F7FF7F777FF7707C7C77797
      7C97777777777777777733033C3333333C33337F37F33333373F37033C333333
      33C3377F37333333337333033333333333333F7FFFFFFFFFFFFF770777777777
      7777777777777777777733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 384
    Top = 536
    Width = 193
    Height = 49
    Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1080' w=5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn3Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337333733373
      3373337F3F7F3F7F3F7F33737373737373733F7F7F7F7F7F7F7F770000000000
      000077777777777777773303333333333333337FF333333F33333709333333C3
      333337773F3FF373F333330393993C3C33333F7F7F77F7F7FFFF77079797977C
      77777777777777777777330339339333C333337FF73373F37F33370C333C3933
      933337773F3737F37FF33303C3C33939C9333F7F7F7FF7F777FF7707C7C77797
      7C97777777777777777733033C3333333C33337F37F33333373F37033C333333
      33C3377F37333333337333033333333333333F7FFFFFFFFFFFFF770777777777
      7777777777777777777733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn4: TBitBtn
    Left = 584
    Top = 536
    Width = 161
    Height = 49
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn4Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
  end
  object XPManifest1: TXPManifest
    Left = 504
  end
end
