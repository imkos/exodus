object frmLoginWindow: TfrmLoginWindow
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 527
  ClientWidth = 237
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  Padding.Bottom = 6
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lblStatus: TTntLabel
    AlignWithMargins = True
    Left = 9
    Top = 73
    Width = 219
    Height = 16
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'You are currently disconnected.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 180
  end
  object lblConnect: TTntLabel
    AlignWithMargins = True
    Left = 9
    Top = 89
    Width = 219
    Height = 16
    Cursor = crHandPoint
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Click a profile to connect:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblConnectClick
    ExplicitWidth = 145
  end
  object lstProfiles: TTntListView
    AlignWithMargins = True
    Left = 6
    Top = 117
    Width = 225
    Height = 166
    Margins.Left = 0
    Margins.Top = 12
    Margins.Right = 0
    Margins.Bottom = 12
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Columns = <
      item
        AutoSize = True
      end>
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ParentColor = True
    PopupMenu = popProfiles
    ShowColumnHeaders = False
    SmallImages = frmExodus.ImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lstProfilesClick
    OnDblClick = lstProfilesClick
  end
  object pnlAnimate: TGridPanel
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 225
    Height = 67
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = aniWait
        Row = 0
      end>
    ParentColor = True
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 1
    Visible = False
    DesignSize = (
      225
      67)
    object aniWait: TAnimate
      Left = 98
      Top = 19
      Width = 28
      Height = 28
      Anchors = []
    end
  end
  object pnlBottomInfo: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 295
    Width = 225
    Height = 226
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object pnlInfomercial: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 225
      Height = 160
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 12
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object imgLogo: TImage
        AlignWithMargins = True
        Left = 0
        Top = 89
        Width = 225
        Height = 71
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        AutoSize = True
        Center = True
        Transparent = True
        Visible = False
        ExplicitLeft = -8
        ExplicitTop = -8
      end
      object txtDisclaimer: TExRichEdit
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 225
        Height = 89
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        AutoURLDetect = adDefault
        CustomURLs = <
          item
            Name = 'e-mail'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'http'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'file'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'mailto'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'ftp'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'https'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'gopher'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'nntp'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'prospero'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'telnet'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'news'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end
          item
            Name = 'wais'
            Color = clWindowText
            Cursor = crDefault
            Underline = True
          end>
        LangOptions = [loAutoFont]
        Language = 1033
        ParentColor = True
        ScrollBars = ssVertical
        ShowSelectionBar = False
        TabOrder = 0
        URLColor = clBlue
        URLCursor = crHandPoint
        InputFormat = ifRTF
        OutputFormat = ofRTF
        SelectedInOut = False
        PlainRTF = False
        UndoLimit = 0
        AllowInPlace = False
      end
    end
    object pnlProfileActions: TPanel
      AlignWithMargins = True
      Left = 0
      Top = 172
      Width = 225
      Height = 48
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 6
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object btnNewUser: TExGraphicButton
        Left = 0
        Top = 0
        Width = 225
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        AutoSize = True
        BorderWidth = 0
        Caption = 'Run the New User Wizard'
        Orientation = gboRightOf
        ImageEnabled.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000004E04944415478DA
          AD950B50545518C7BFBBBBC022CB2BB705829511423065100A091891AC9C31C6
          0121B324671AC391C6897C645352802193134E6093158F72CAB2144424131479
          680386BC5F63A23C434060EF73DF7B776FE72EBBCD0ACBE04C7D33DFDC39E73B
          E7FFFBCE771E17E3380E6C6D5DD48B30CFB0796D6E917EB0370E9B0F58304A89
          7198845B4A6CB1E4FE5F4071E6C2618F00EC892D06B0D7BF24C0DEC4C5A04579
          F091C1086D19F950CF77F1F65880A5CAC2C7BE39064776EFCDCB3B733AFFEBAA
          46F2E3CB7F8012E9B076013087B75B530C19FA082C0E2606F40559E0171818F2
          D5D6C4B4A4AB3517DAAA6A6E657C7B01BA50585B7404B8C70658C445870B2AF5
          7C3BFF4092147DF4C7DF85E736C52794443C1B17D8D6DA3475FA97AA83451570
          05C5940860B40B40993D4210B89A33368B7FBE3FD1DCF741E1251EE29FB91B5E
          4ADDB1AB3024E68CEB7CB192CF16DE0D7B7536671EFFC6317DC3D94C73C79442
          09439304545EEF007573D2179987DE3FE0EEEA8C09515ED9F9856715A4B25CEE
          05020F09AC33CDA58AB146683D7C127EC7EC8BE7E291EB43257CF6130A064626
          49B83F3A03F746A740A737407A5803B84B1CC1D911A0ABB79754AB294A22163A
          86063CEDC319F5C019F470B3BBADB5B97F241D9B272EDCF87A6E4B64E41A2F9A
          564A7142E574684F020C98C51FC2F0E804949DFA145A7EDE0C320F2790380B40
          84B166418E9D7392224C751DBD7FB6DC992C469B7FC916208CDB71B4242222C4
          8F66543E048100B3848762161727256F86A1D1492847E297BF8C05A9BB030238
          82C4092D1710C09275E7DD41F2BBEACEEF1935B45F6C801B4893B602041BB667
          EF0D8F08F6A728660541307EB88294218027AD9871532A1E8AD5D4309466061B
          03E452A1D44D041ECB30108B4C20301900270853C5CD9EAEBA8EA95FC7A7A1B5
          7B0006F953855CCD03B0B8D7B223434303E42449FB235FA19825E5244E7A530A
          85544D4C7B68E831D7357E63796F25ADDDF77254A88F873312773081D0C40218
          7570FBCE307DA2ACEFF8D55BF01BD2C3F9CC91EB90B3586C4AA65BE8DA954FE2
          0AC297A418244CC94982943338E1A32267645AFA6FA95E3DBEE7CD2DB02D6367
          C27BBECB2502B11089730624CED75D0B2AB50A4E54769C3B5F6FC89998810924
          ACE24F3F7FF1CC2B484CCBF1A429958CA4E8A76892F66510404BCDF86A94935E
          06F583DCB870F04ADD22CFDA1AFB7CAC93C0083443996A6EFF7537EE19EF206F
          579188637550DB337EBFB26DF6E0B95A68E40148DC643D39E6E76075CC764F8D
          C62853D18CB796C67DB5CA495F8366E23C8A19F7EF84B8948D9105ABFD7C96CF
          E238FB537D776D532F5319B1CA213E355A9E2C7713398DCE90BA92E6E94FD0AD
          2E45731804606D2F9A192295477B6A352A994E35ED65D04CF5F181B02010A66D
          5B96F56ACC86740581EB7EACEBA9E8BAA7ABBAD6021D299B40EEF50484EF8A94
          E6AC74C3243F74E217ABDB8D1F36B6C318BF07D612D9DE0381C849EAC9EA66D5
          963697B70FC2A25605164B5D5CFC4BAFF51C1D7A00FD579AA0DF724AF46F2742
          A09B0B44BF1224CED1B1ACB67A80CD385506D7AD8F9FBD9B2CB0299DB98EB9EF
          C07AA31182FB06A1BFBC0E46F8C916E71F3741F20B200BF083688D16F4373AA0
          158D237938BF0F8BBD45F34D88DCC102E74559CB97B3BE00FC136389F37D063E
          6E6F058B9975556011B0BA6D5298ED987F4FD1523FFDFF6AFF00FFBE81D53A48
          50CA0000000049454E44AE426082}
        ImageDisabled.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000004854944415478DA
          AD556D4C5367147E6F69DA8E7BDBAEB2A8B3633013A13040587469A70243B128
          C1FD74D9CA87987DFC98EE8726B22D1826D930FBB165BA047F6CCB9265894BF6
          65E4633010714E0A05AA85D242A942B1A594D24F08D0AFBBF3DEDC2EB5B90C92
          ED24276FEEFBF13CE73CE79C96A0691A259A4AF50A4A3222E99BDE601F71DD23
          920992ADB9F9A3A6C6C64F9AD0168C23B8FF97E0B513C7FF9D800B6C2302AEFD
          4D09B81E6E44AA1B1AED89C5628EF68EEE478CE0605B22D84C167C363438D27B
          EEDCF9B2D6D656DDFD07865B5353D321C0897112B0EC9C9A1260EC1DE6DEA54B
          1F36DEFB6BE8F3ACACACE3274FBEAE686BBBE9E8E9E9EDD40D8F3AE13872A2EA
          18BD6502169CF7E595AB8DF8FBFDB3673E83255A7EE4D55D6AB5BA4AA9546ED3
          6AB5CBD7AFFFD8353CA2B7C0590808629C0410D913725CBCF8E9C771F0B367DE
          63F6AE5CFD0A937C51527C60B746A3A99877CE0993C18675FA264E028E3DDEA9
          FAD38DDF7EF335B3E1F17890C3318F6EF5F5A11FBEFF6EA0A1E18292A22826C9
          9696CB637EBF7F422A9510229170675C0CDC005DDDBD53041778DDA9FA0B4545
          45021CBDDBED464EE7029A9B9B43B3361B0A854268FB33324492A988CFE72383
          C1B0B6BCBCBC26140A5372140A71241241D168140D6807EC06C3581B91044E00
          F85B8585856430184C85C8F875B5B5C806C03620C0EBB5D66BE8724B33828811
          80320F3160148031B8CFE7A3B583838F4D26F30814DF9C48C0ABA9ADABCACFCF
          97404462004FF57ABDA2A5A5257E656525930106FFA0E13C0279904422460281
          80892A1EF584C9B4D6DEDEA15F5F5F7798CC53B370B41E2720AA6B6AF7E5E5E5
          4903818014C025004E82F64FC12AF40089DBBD844ED7D7C4E472398FA2482412
          89103F25056B8DE00E7DBBBFDFF9C03036EEF707EC0B0B2E2FEE2AF030C182EF
          522814189871009642AA143C4CF541161E8F570012FFA93E7A74BF4AA514C7C1
          717BE3C8C78DC6F55F7FBB71777AFAE124E0ADE2C8B172B8D6C41B6F6A84D9D9
          D9385A318E1E8025E098880270129378BD9E9B7B0BF214D5D51A655A5A1A9108
          1E0E87D1CACA0AFAE9E75FC6C7C68DB703816010478EC70B0F1E93C1DBEFBC2B
          02DD4900C524122C51001C88489FCF7B2723239D2C3E74B0A4ACACEC791EB426
          DCC18574BF989B9B06B5E0E11AE8F5F73D23A3FAAE71A369861D3AFA9FCEC15E
          5C5C220A85C3E47230484107617028B4CF88235129F767949797AB5FC8CC4C85
          A2C7BABAFFB04E5BADE6E7E4F2CC43070FE4C8644FF39D4E67A4FFCEDD3E98EA
          512C517CAA89C416DDB3274BB4BABA4A42845420E077E1831D3BB6132AE5CB25
          C72A2AF6017814C04D8FEDF649ABF5D17C6E4EB6043AEA59382FDD269309EE69
          074D9353969E99199B1FD7202ED11373405162902B1866BFE923874B771614E4
          574925526947E7EFFD1EAFD765B15817D92E89BE54B45706139C9E9BA3288521
          8C98272D9D43BA9187F11F3FAE494ECC8AD1F17059891CDA31CDE55A5C344E98
          7DF831EB580602322141A6F47038129D99B5D9E1DE1A57069BFD3EA5B06B8C75
          9AF57850BC84B7D1C42EDA8A25664627ADC9B54471706663B33FFDFF6A7F0380
          9499C6524E21B20000000049454E44AE426082}
        ImagePushed.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000006E34944415478DA
          9D967B7054D51DC7CFB9CFBDFBDEBBBB8490AC49809054288F0AA6204E750633
          506C25D0B1D0216D47068CC290D0144AD10C2DC843D04D161A5E6A454D054734
          9804190336820F286DC4496A630286843CF67577EFEE26D9ECE3EEBD3DE7DE50
          5AA7ED1FDE9DDF9C7BF7F1FD9CEFEFFCCEEF2C2C2E2E0683C3FEB5E07F5E10FE
          E7B3A2FCF7F7BF7929CAB4E2790DD068B6AD5DB7B98A27090290240A7524B520
          48505351E5D9FF4A7D25414040A0CFF008218102AA01549CA2BD64054CD0812C
          CBE0F2479D6115B0A1AA9AA7C809614A13A628421DB7AFDBE471BF714205E067
          020B63188200EC4181EAA8206377E20EE0426BBB0678BA7A2B8FC5F754FEC6B3
          FB785D2535E18042B05F953FE9F9C35BAF5692EAEC3587D8C1BA156B3CAF369D
          AE04132EFEE5409127000A6869B9A201366FDBCE5334A58AD63C59E539F8DAB1
          4A7A02B069F5139E13EF366850EC0001CA97FFC4E33EF8FD66DA5434C0E7FFB8
          47CD0B848AEA40D61C6410E8DD772E69802D3B9EE5690A0B526AFCFA17159E23
          78D6140D2892D2D235E16A4DE90A4FED0B0B5B2A7EFEE8A32F37347D6CCEDF70
          8E35F2499A66640CC0A9510119199C3A7D41036CADD9C9D3B426CE6008BAA7D1
          48AA2B4AE094431241CA7FF8B8BBE16CED4E32DCB46AF5CAE5B31B5B5A0786E2
          33CF38EE593C64309A249C2C59B90B38F9DA390DB0FDF7BB782C4CD3B41AF89E
          A04888BE4574870C6EFC833C7D7087D1649424F15357A16378CD0325258E4FAF
          FE35F65917D1985BBCAACB66B727298A96EF3AC880E32F356A80D890F8C6BF57
          F01F9B4E5721AF44B7A0771FA87A4C7D6F5BDD7B209B1CFC1D885E2C5A32DF5A
          366BF149DD372BFF52C7D54A1909DF011CAA7F4B03ECDCBF1F39A001CBD0A84C
          29BC5C44C3FBBDEEB6379F51BFEC0B8D825EAF08CE5EFC1CD0BDBBDB36FEECA1
          87AD663D20D1EA3EFF524BBB257BFE17267D06A6467A72D042405CA99CADE8F6
          990BF4272A60F781833CC330B86A2081C44FB5F6EDBB6FFE2C16CF7E383402FA
          BC1170B33F086EF4FB403295061573DA80C5C8008E01A0BDA36B3C8E5E7A1652
          DF9BE6322B991450D229F0E7CEDEFED72F9B5E56017B5F74A32AA2205A5378B6
          6DA0FABB738A4C91C898212C8E52D5EB97831E55DC0F6EF50F83B7EB7781BFFC
          A9144CB2B2C0C8118082922AA8485A88115169FBD2D71726EFFDACE932715905
          3C5F5BC72371E2C36BBED585330AAC622C6E0E85468CC140881382616AC5CA52
          D0DBEF05679078CBA10780C3422300038C2C001440808959B7F7DC1EFFE02BE2
          AA6D52F1406EE1B29BAFBCDEE2D5007575F6CFBBC445537227F391689C0F89A3
          9660503421803EEC0FB0B1A0978E476F8113CF1429D35D0EE83053C0AA874047
          C98090D320248ACAB9BF0D0D7A5305D79D39F3FB73F2670B66B339E53E7CCA87
          01E54F6DDB33D76AB35AA323091EA5C5E60F46AC42206C16FC414334E8E546C2
          B7746B1E9BD63A3737F2E0920585662B87C4691990B284CA2509AE750F263EEA
          9F72216F66D997595993E3D9D9D9094EAF97B6D71C16A0232B6FFD6F773DE71A
          1B972C91D8B84D10A2D64050B485FC823914F09962429F61FDBA95A795C8C5D9
          65258E1FE43A0C50472271258DC471DE13602C3E064E5E4B5C9F51B2F57CC1F4
          EF441D4E470AB7A7CDD50742AA83BD2F7A72C6C6D3A670246E0909518BDF2F58
          05BFD72A06074C4FFC72E507B4EC3359936D4B97DD37B5802532203612533EEC
          F006164EE59C934D24A14849D0D61315E2931F6F9CBB70ED0DA7D399CAA0BEF1
          D4E6E7D47D50FEC2A1C3F64432C3456371932044CC415FC012F0DEB6AC2A2BBD
          AEE3382515BE38FD5EE3D7653373EC7A4114E5E62FA25FA50DF33AA94467E112
          576CB6CB4450FDC288742559F2FEFD8F3C7B05A70895BCBC61D36E6DA3D51EA9
          B7D3240D4746C771D59804949AFB17CCF1E2BDC1313219EE723FB2B4C8FC6028
          12499FEF4A77E89C8BFEEE2A5C320012DDB6D0707BEE2CF9D2D27C83CC9E1D9A
          D451B0A8A6796AD10291D3715245E51E35456B3DC78EA29DCC40D43561548C71
          76BB25CDD00C60753A301EB894630C35FDD4AE03FC2701D779836D96CF35FD21
          2F9A65CA6AB14AC3B73E767CFD8FD6FC49C27BCBD219458AE5AD7F67DEE20DDD
          7A4E7F1770E8E8319E6559D4E84888DA336418DCF42868D01B1416353FEFCDE6
          BCA870C3C959E7F9B25C0BC24EA7236DE379C96830C852260307FB3A4D373A1A
          F3D3329D9932ADF4B633EB9E711DAB939EDEB25703D41D3DCAEB503A34080D75
          08A0A6073960D1489004CCA425DCBD2187D6C46C3266383DA720970AEA9E3099
          4CC2D1B131329948427C28E8392E830FA08D5BF66980DAFA23C8010374AC0661
          19561D39F4CCA0A0F0364781A13A9655704BC7233EDDF0855D6424096010BA47
          0713858F1E6563D5BE303CBE0380E69E8DFFE76FCBB7BF7E34A3BEE19FAB212F
          7CBCFDB0520000000049454E44AE426082}
      end
      object btnCreateProfile: TExGraphicButton
        Left = 0
        Top = 24
        Width = 225
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        AutoSize = True
        BorderWidth = 0
        Caption = 'Create a New Profile'
        Orientation = gboRightOf
        ImageEnabled.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000004D74944415478DA
          DD947F6C535514C7BFEFF5B5DDD6B7755BBB8E31D659AA634E27DB80C99824CA
          062A28F8238464A04C4D662026801862827F9868D028327F203F06A221204413
          A6D1A98CE958045736375960EC57BB6584EE076C7BA35DFBFAFA7E5C6F274C97
          113018FEF126F7BD9373EF3D9F73EE39F7308410DCC9C1FC7F00155B99298B61
          19291C87B941114D9B3F447F44979595C52C7DFE85A8585549E0585DA206D630
          6E0844523545F0EB382123D12C969595915B0214154F163FBAE6C0E95FAB8E9C
          6C10B61EAC42900248E5AB6D9B0299CBB6474EA872184A3800FDC59677577EE0
          789B89D285E1F7AB1E8F47BB25400A63DDAA924D1F9DA9AF3D555D7776C3BE6F
          8DEED3358B7C7A83899BC1DA61B4CEFB6BDF5023DA076B2153D84997F6C0E12A
          933BC87392D7E5D26E0688D2E9E3DF5FBB76CB2BF5F5B53D5F1EABD9B8A6B4E0
          B354BD6CB5CC7C09FAD88C499B655F277CEDBBD12E06B0F93D3E559055815755
          691240565044C57C55458C46C0CC74CE2E7CBCF8A9873BDA5BC78EFC58F38D7D
          86794DBA3901A9B38A614BB91B7C5C2218EA1713F9503362DF0934B96BD0DCC6
          AEDD5719F37D088A7F02B0EB75C6999139674F61E18A223DA767882AA3ABA375
          CC694FE783011F8606AF2025D104120EC2DD7B11B065C199990D8E636982698A
          A919551C81D0F216CE05A66B1BCA6D77699C3A3C01A05E303B3661714C8C7945
          C18345AB329D99164D0983C8216892480D8BE8F37A71A16F10E6D474A4A7D961
          494A80C1A007CB10104D85121AC6987B3FEABDD3F0DAA729F712A8039300F4C7
          AE5F097B9401858B0AE6BEF1C8BC79B3881484268BE8705F44A3C745BDBE0FCE
          7B72618E3320968F06A7D7452A8556930439D085D0603D4E77F1EAC65D69391A
          B4BE493978791B582A726F96A1E499A2259F389293F8919161CDACD7588D9662
          C5292F8A1718909AE680D942BD3799C07211804A132040B9EAC1F1DF09CE7747
          6FD95B297D47C83F22B85E45A37E58526DD6F2E58545CF75F5748FEDF8BA717F
          7E8675E1B37949731A3C026CCE68DC9F6B039F9C025DAC99C64C7D528380EF0A
          3D3C846A97828A2A7EE91F6DF20585C1D01480A6E1A11C67F6E7A190C41EADED
          2CBFD083B6E956A4E53A0C4F2F76C63CD6A14F373CB12C1E31D32CD0C59922B7
          4AE7556AFC327EA80CA0B97BFABA6327865C3EBF7C89E854DF1440B717D1661E
          F3051F8C5FD5A0B5B71FA108B77439936989E7F22D69F38D4B16F2EFE42C88A2
          1170E34D02B48BD41C0DE14C877DFDB19F2E3506447940558810186142530034
          0F114117C9C535F7224F5E8DC82653BC213E29DEB4B3E250BF4CEF7D605880CF
          EF83284A68EB72A3F55475812C9301C260184156ECE969566FF892AF41AE2B26
          DAADD56A65618C331C387838E870A44392658892343EF77C7108674F1ECFA5E6
          FA558D151CC9B1725D5D1DB9692FBAD1D856359BDB595E213B1C76349D6F45DF
          C020C668BB6DEBECC2D95F8EE7D06AF72A7A6DB4B7A54599D4EC6EDAD399BFE1
          8EBC3CEEE3EDBBC701A170782282BD0769043F57CFD618CD0BA3EE6A4F73F3ED
          019CF9F9DC8BAB4BF39A3A7BCF4C28A90963C85FDAE0FAAD99A6CC0B3ECAE769
          68B83D802D3B5BC7AB2C4FC026D30E944055866B4B619A35816199013F94C0E5
          73E7D4DB02AC2E29E1E6143E4C0B944921D02C0C4BA209B5CA68AC488157F40C
          D32F8505FFE868F0DF03FECBB8E3803F019C05753027E670310000000049454E
          44AE426082}
        ImageDisabled.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000004614944415478DA
          DD955F4C5B551CC77FF7B605FA87F1C78E222DB525FC69ABA5330A898844230E
          B255C107F7C01B99F2C2AB2FC6C4C4873D9AF840640FDB740F3EA911A666E064
          58E985019BAEF2E7D2A6504218C84A296B2FFD73EFEDBDFECE0D2CAB283398BD
          789293D3737ACEEF737EDFDFEFFC2E25CB323CC946FD7F005D6F9D39F4672E97
          2BA669BA4A10C48D91D19F38B2E672B9E09D73E7D41AB55AAB52A9B4B8A4DADF
          2EE2FE8C208A69735595D8D7D7273F162049524377F7DB5D636363732CBB74F3
          6E604E4080FCC6EB6D2F3D63AF394D5114088200D96C16A25B5BFED11BE3BFE0
          85723CCF4BCBCBCB8F07E08D9ACE9F7FB793619835BF9F1941C0CE850B1F7F50
          545444575BAAC16AB529FBD6D656E1F6ED5905B612591D5C5C0CEEE424496417
          17E5A3006AAD5677BABFBFBF796262223E34343CE2F59EEDD2EB75BA975B5AE1
          6485296F73F4FE1630CC046C6C6EC2CDF1894FF6F6F6321A8D46CC03A02435F8
          D38CA3862C3B9D4EABD7EBB5B12CCB0F0F5F5B32992A1A2B2B2BC1E3390516F4
          A0B4B414884CA493160CB208F1C3E61F5BDF0602F321948A7F0878D3DB59EE76
          377ADBDBDBED48A6501E585A5AE2ED767B01C771B0BDBD0DE565658A0C914804
          8C272BC0E17000065A01103BA9D41EFC387A1DD299ACFCB38FF9146DA41E0270
          13D5D9D15E535C5CEC686B6B7B160FEB4451540C2A9DE76163630322ABAB6032
          99507F2B949797434141C1414200CA02D3B72621BEFB00FCCCF400AE71790032
          3437BD50A256ABAA5B5B5BDB5A5A5A8CC430016056C0CCEC0C3434388874A0D7
          EB954E3C50725414201ABD0FABE81D4A24319333171190CC8BC1B5EFAE1308FD
          DAABAFB851FB3316B3B920168BC985858514CF6731783EA8AFAF556E4FF4C76C
          5200C4463A9D86586C1BC2E115D889C76F4C4DCD04F33C38C8A24C26ABC34076
          74767478F0D6FC575F7FF36B5D5DADB5B9E9C5AA7078194ACB4AC16EB7A13C4F
          8156A78583B790427952A914844261F87D6EE1CBF5F57B51499653870038B77A
          3C9E6E7C3CD4F8B86F2A8AD12D36184E582C66A7A3A1BE56CC492A8FC70D274A
          4A003D5300994C46012C2CB090E4F6BEBF73E7B7758C47023DC81E02C4E3BB1A
          3C68C143AAF90536BABBFB4024DCE74F351A0D0683B9AEBE5EE5723ADA2DD566
          50ABD5CA198E4B422818864492FB617A7AF61ECAC5A1F10C9618F110603F0E4A
          2CF64779BF5398612AD45E73E9F2E5F7498645A3514824128A07A150086E4D4D
          5DC2D4E4D0669AA2688165FFE125EF430E35A3D148A177AA2FAE5EFD10DF07E0
          3B528CA7B17F7EE50A307EFF45B4C7919857569A249FCF7764A9F8DB160CADD0
          9F0D0E7E64B3D9201008C026960612DC6030A8003026095255712EE515BBA3DA
          412920CDE972D10303030A8054D1473D9864984125F7693A8385EE7880E7DC6E
          BAB7B7F769AC4FEFFDA5F20E610C36D15E42ADD164E7E7E68E07B0D7D4D08558
          1F704D8FD3473F3839EC185C8A438F84C8CACAF1003D3D3D34969042FCB018F0
          AC0E9748AEA22AB480630AC724BE013E994CFE7BC07F694F1CF0276321A4EA01
          A7B9910000000049454E44AE426082}
        ImagePushed.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000006494944415478DA
          B5967B6C537514C7CF7DB76BBBD2BB67D9B3ED80E1268230240B91A1A844C408
          4104E40F039128220F09841804658030D00141360C44A2239001333820E13930
          2E438121C2D8601BB01546C7D6B2766B6F6FEFCBDFEFDE6DEABF26B439F9F536
          CDF7F33BE7F73DE757223737171E7674CE8767F0EA0D062A086BBC63FEC2A5CB
          798A2481A250E82B65044901A97F8756924041EA2B419028083D40C3529AF156
          35E311BD5455855F2FDE0CE88045CB57F234D52F4C1BC2346D080FC0B0B00EC2
          C218862040606D425F354D1B8C01C0D933D70CC0E295AB782C42D3340AB4F68B
          6AA2D7AEF43664981DA3BDACCD15C219E00C11815165D9ACA98A4505A0F0B651
          36320247488A12D06F2455D5B41327EA0CC0D2D56B789AA17551064128140CFA
          1CF555E74F9DE0987BA1F6663D97B1F004671A22310CADE54ABB8A388FE31D9C
          8022C5408E8541EC50CE35681F9F6619564100552309ADEAD82503B0E2F3B53C
          430F6480C41903D0D3FAC3C40F668C9B59535B7FCF278D3D664B7AA17B5CCEE1
          12868D23D3C94CE0120BF47288DD57A0A9B30624046B0ECCDB4A993C5D34C3CA
          9595E7FD3A60D517EB792C8AC5590CC1D9685126FC60DFDBCB16CC7CF9FCA55A
          FF1FADB6AAC92F75CC4B67044B827B2130B6E1FF718C14BA0BA1A6326812C2D0
          D4BB669DCD668F541EA979A203D67CB581C7C2B2FFC27039722F0B5499C14575
          3BEDAED9D38A86DD6A68148FD736FFE574040AB2EC0E481B3105929D39608DE7
          011B69C04D42C759B8D6720EDA7AA75450B6C90D47AB2E3DD6016B376EE24168
          4ECC8CBB317BFAEB45234C0C039A2241C3ED4671A42B830BF786C0DFD5054EDE
          025A2C022D6DED00C9CF8127F779DD6DC85780CDA30801787AA3186E86D3342F
          B9F1CBE3D5B50F75C0FA2D5B789AA408F1C9991164B4357FD258CF8BA373732C
          AA1C034D8A822A0A4858808E478FE0764727D8D3B2202B231312921CC0B20CB2
          2CEE0105E4A81FFA5AF641DDA3546827376C3E79AAAE4D0714976CE351FD09D4
          6884186C75047DF5AE3C67F08D3727E4256B62045449803B2DED70A5F532DA75
          1E78868D017B3C0B36AB199D170504DABE228920859B21DA5907B5CD56F53EB5
          B9A4FA643F60F337DFF21CCBE21E40B902D975B762EC6BB9F2ACE14313B8EE6E
          BFE6E054424556FCFEB74730A59085B40C17D813D0EE2D1620690C50D0013C05
          39D80AA7AF6AE09727FD12650B6E1DADAA31005B4B77F01CC7A2745980D8138B
          F060FF8CB9859E82C6D636F1E065A92E6748D033239FC9B872EF29247BCC903F
          2619AC294EA06C7600DC784A0420D405D0D30D672ECB705F5EB0D7CE7B7C077E
          3AE5D501DB76EDE24D2C072CC740F8F159B79BBAFABE2CC688DF7DCE8B8C35D7
          A7463B1C96E89FA32626768D6C6633A8B7A60D81B8D404A0E22DC8A008004124
          FE044EFD1C86203DAB5222DD0F9C43D37A4A771F325CF4CDEEDDBC89E3009789
          D44426F0F042B624AB741C3FD617674990CC1CA7F506AE27877CD7B3E213DDF4
          C8F486E9A30B4D28031A8C81F418CE1D8E4200DE3B22C8A9ED29A9A9A1A4C4A4
          C8BAE272A30F767CB787674D2CE02C189A21D059235FA8147696D96CD26C569B
          8A0D204B12D51B0E7321912C9650DD7DFEA71042161604111A9B5B60DAF8BCD2
          9494D4507A5A5A382ECE2CAD58BDDDE8E49D7BCA78CE6464A043188A60502F98
          4C26239015F1F9A02148C44491BAE3EDDEEE72658128492088A21EE5072AE0DD
          A2F125E9E9E9A174A7334231B4BA78D9A67E4059B97EC8B84C7AA9D0678E3381
          595F8D671601F106545521AF37794B5DAE4CB876AB013A7C9DD01711A0F16E33
          CC79654249767676CF5067AA80C6BBBA6849B131EC769697A1433681013144F5
          9DE3158962616C0034295143A9647D53BB0E88C6628319ECFDB102E64C2EDCEA
          7267059D292902BA2FD40F976CF81F004D23BD8F7D1925FB0F7D3638E9D09898
          3A7ED441DE6E7BE87667F7A4A42447D100F907B04B2F112E05AA3B6780F09998
          59E35C067A844365C2F765B027C8B579BD36BFDF6F8E49128DE7109A0432CF3B
          84ECACCC90C3E18861972CFAB41FB0A30C6730506F6E300B73BF7559FCCCB0FA
          DCC1C65714C5D4DBD7172F088245516446C1009296CC26AECF6AB58490F34445
          51D58F966E3400A5C8A6FF2E0FC772FD00431CC3B1AB7016CCC0A584025FA1FD
          150255510081419215E37E4083F293E55F0708FCB72527FFD567F2B7A5FAC8EE
          8ABF013536A8C0A55413E90000000049454E44AE426082}
        OnClick = clickCreateProfile
      end
    end
  end
  object popProfiles: TTntPopupMenu
    Left = 16
    Top = 160
    object mnuModifyProfile: TTntMenuItem
      Caption = 'Modify Profile'
      OnClick = mnuModifyProfileClick
    end
    object mnuRenameProfile: TTntMenuItem
      Caption = 'Rename Profile'
      OnClick = mnuRenameProfileClick
    end
    object mnuDeleteProfile: TTntMenuItem
      Caption = 'Delete Profile'
      OnClick = mnuDeleteProfileClick
    end
  end
end
