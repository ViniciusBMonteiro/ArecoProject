object frmConfigDb: TfrmConfigDb
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Database Configuration'
  ClientHeight = 286
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 334
    Height = 286
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object edtDb: TLabeledEdit
      Left = 16
      Top = 32
      Width = 300
      Height = 23
      EditLabel.Width = 48
      EditLabel.Height = 15
      EditLabel.Caption = 'Database'
      TabOrder = 0
      Text = 'postgres'
    end
    object edtServer: TLabeledEdit
      Left = 16
      Top = 79
      Width = 300
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Server'
      TabOrder = 1
      Text = 'localhost'
    end
    object edtPort: TLabeledEdit
      Left = 16
      Top = 125
      Width = 300
      Height = 23
      EditLabel.Width = 22
      EditLabel.Height = 15
      EditLabel.Caption = 'Port'
      TabOrder = 2
      Text = '5432'
    end
    object Panel2: TPanel
      Left = 0
      Top = 246
      Width = 334
      Height = 40
      Align = alBottom
      TabOrder = 3
      object btnConfirm: TSpeedButton
        Left = 1
        Top = 1
        Width = 332
        Height = 38
        Align = alClient
        Caption = 'Confirm'
        OnClick = btnConfirmClick
        ExplicitLeft = 0
      end
    end
  end
  object DriverLink: TFDPhysPgDriverLink
    Left = 80
    Top = 136
  end
  object qryCreateTable: TFDQuery
    SQL.Strings = (
      'CREATE SEQUENCE IF NOT EXISTS public."productReg_id_seq"'
      '    INCREMENT 1'
      '    START 1'
      '    MINVALUE 1'
      '    MAXVALUE 2147483647'
      '    CACHE 1;'
      ''
      'CREATE TABLE IF NOT EXISTS public.productreg'
      '('
      
        '    id integer NOT NULL DEFAULT nextval('#39'"productReg_id_seq"'#39'::r' +
        'egclass),'
      
        '    name character varying(100) COLLATE pg_catalog."default" NOT' +
        ' NULL,'
      
        '    description character varying(400) COLLATE pg_catalog."defau' +
        'lt",'
      
        '    created_user character varying(10) COLLATE pg_catalog."defau' +
        'lt" DEFAULT CURRENT_USER,'
      
        '    created_date timestamp without time zone DEFAULT CURRENT_TIM' +
        'ESTAMP,'
      
        '    updated_user character varying(10) COLLATE pg_catalog."defau' +
        'lt" DEFAULT CURRENT_USER,'
      
        '    updated_date timestamp without time zone DEFAULT CURRENT_TIM' +
        'ESTAMP,'
      '    CONSTRAINT "productReg_pkey" PRIMARY KEY (id)'
      ');'
      ''
      'ALTER TABLE IF EXISTS public.productreg'
      '    OWNER to postgres;'
      ''
      'GRANT ALL ON TABLE public.productreg TO postgres;'
      ''
      'ALTER SEQUENCE public."productReg_id_seq"'
      '    OWNED BY public.productreg.id;'
      ''
      'ALTER SEQUENCE public."productReg_id_seq"'
      '    OWNER TO postgres;'
      ''
      'GRANT ALL ON SEQUENCE public."productReg_id_seq" TO postgres;')
    Left = 216
    Top = 128
  end
end
