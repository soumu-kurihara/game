/*
基本動作
全てのページで使うようなものをまとめたマクロ
ベーシック

おかしくなったら
f.map.bsc['loc']をコメントから起動する(240204)
*/

    ;文字変換

    [iscript ]
        f.mprnm=[];
        f.mprnm['f101_01_01_cy'  ]='第一工場中庭';
        f.mprnm['f101_01_01_frz' ]='第一工場冷凍庫(北西1)';
        f.mprnm['f101_01_24_ctr' ]='第一工場容器倉庫';
        f.mprnm['f101_01_28_ant' ]='第一工場西前室';
        f.mprnm['f101_01_32_frz' ]='第一工場冷凍庫(南西)'
        f.mprnm['f101_06_34_suc' ]='タレ倉庫';
        f.mprnm['f101_06_43_ptk' ]='第一工場プロパン庫';
        f.mprnm['f101_07_07_cref']='第一工場コンテナ冷凍庫';
        f.mprnm['f101_12_25_wap' ]='セット室';
        f.mprnm['f101_13_11_frz' ]='第一工場冷凍庫(北西2)';
        f.mprnm['f101_20_01_set' ]='セット準備室';
        f.mprnm['f101_30_01_cdb' ]='ダンボール室';
        f.mprnm['f101_30_10_ccr' ]='コンテナ洗浄室';
        f.mprnm['f101_34_01_pic' ]='生産管理室';
        f.mprnm['f101_34_23_frzp']='冷凍庫(生産管理室)';
        f.mprnm['f101_36_28_ref' ]='冷蔵庫1(セット室)';
        f.mprnm['f101_36_34_ref' ]='冷蔵庫2(セット室)';
        f.mprnm['f101_36_40_ref' ]='冷蔵庫3(セット室)';
        f.mprnm['f101_42_28_mcn' ]='機械室(廊下)';
        f.mprnm['f101_44_37_hac' ]='加熱調理室';
        f.mprnm['f101_47_25_wbs' ]='第一工場階段前作業靴置場';
        f.mprnm['f101_50_01_ref' ]='冷蔵庫(出荷待ち)';
        f.mprnm['f101_57_37_ref' ]='冷蔵庫(機械室)';
        f.mprnm['f101_62_01_ent' ]='第一工場玄関';
        f.mprnm['f101_62_25_hwp' ]='第一工場東前室';
        f.mprnm['f101_62_37_ref' ]='第一工場冷蔵庫(南東)';
        f.mprnm['f201_01_01_mac' ]='カット室';
        f.mprnm['f201_01_15_rep' ]='第二工場冷蔵庫(南西)';
        f.mprnm['f201_06_15_wgh' ]='計量室';
        f.mprnm['f201_29_01_trm' ]='トリミング室';
        f.mprnm['f201_35_23_rep' ]='第二工場冷蔵庫(南東)';
        f.mprnm['f201_39_01_dmp' ]='ゴミ捨て場';
        f.mprnm['f201_39_13_ant' ]='第二工場前室';
        f.mprnm['f201_46_01_ent' ]='第二工場玄関';
        f.mprnm['f201_48_06_rep' ]='第二工場冷蔵庫(東)';
        f.mprnm['f201_48_18_vgt' ]='野菜一時保管庫';
        f.mprnm['f201_49_01_pmp' ]='ポンプ室';
    [endscript ]


    ;---------------------------------------------------

    [macro name="destroy"]
        [cm  ]
        [clearfix]

        [freeimage layer="base"]
        [freeimage layer="0"]
        [freeimage layer="1"]
        [layopt layer=message0 visible=false]
        [chara_hide_all time="50"]

    [endmacro ]

    [macro name="adv"]
        ;ADV表示の準備------------------------------

        ;メッセージウィンドウの設定
        [position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=true]
        [current layer="message0" ]

        ;文字が表示される領域を調整
        [position layer=message0 page=fore margint="45" marginl="50" marginr="70" marginb="60"]

        ;メッセージウィンドウの表示
        @layopt layer=message0 visible=true

        ;キャラクターの名前が表示される文字領域
        [ptext name="chara_name_area" layer="message0" color="white" size=28 bold=true x=180 y=510]

        ;上記で定義した領域がキャラクターの名前表示であることを宣言（これがないと#の部分でエラーになります）
        [chara_config ptext="chara_name_area"]

        ;---------------------------------------------------

    [endmacro]

    ;ADVモードの時の共通コード
    [macro name="iadv"]
    ;ボタン非表示
        [clearfix ]
        [adv ]
        [cm]
        ;十字ボタンを無効化
        [iscript ]
            window.__tyrano_key_config.key.ArrowUp   ="";
            window.__tyrano_key_config.key.ArrowDown ="";
            window.__tyrano_key_config.key.ArrowLeft ="";
            window.__tyrano_key_config.key.ArrowRight="";
        [endscript ]
    [endmacro ]

    [macro name="endadv"]
    ;メッセージウィンドウ削除&ボタン再表示
        [layopt layer=message0 visible=false]
        [crbtn]
        [glink text="MENU" target="*gotitle2" x="&1280-300" y="0" color="btn_01_white"] 
        [layopt layer="message0" visible="false" ]
        ;十字ボタン有効化
        [iscript ]
            window.__tyrano_key_config.key.ArrowUp=function () {
                TYRANO.kag.stat.f['vec']='T';
                TYRANO.kag.ftag.startTag("jump",{target:"*ahead"});
            };
            window.__tyrano_key_config.key.ArrowDown=function () {
                TYRANO.kag.stat.f['vec']='B';
                TYRANO.kag.ftag.startTag("jump",{target:"*ahead"});
            };
            window.__tyrano_key_config.key.ArrowLeft=function () {
                TYRANO.kag.stat.f['vec']='L';
                TYRANO.kag.ftag.startTag("jump",{target:"*ahead"});
            };
            window.__tyrano_key_config.key.ArrowRight=function () {
                TYRANO.kag.stat.f['vec']='R';
                TYRANO.kag.ftag.startTag("jump",{target:"*ahead"});
            };
        [endscript ]
    [endmacro ]



    ;フィールド作成マクロ==========================

    [macro name="crimap" ]
        ;他ページから飛んできたときの処理
        [destroy]
        ;マップを初期化
        @eval exp="f.isnmp=false" 

        [start_keyconfig]

        [layopt layer="0" visible="true"  ]
        [layopt layer="1" visible="true"  ]

        ;9マス用(既存)このサイズを起点にマスのサイズを変更するのでウィンドウサイズに合うようになる
        [image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.png" top="0" left="&1280/2-40" wait="true" ]

        ;========================マクロ置場

        ;マクロ呼出 ->効果が被っているので統合。また状況により呼び出すものを変更する？
        @call storage="mcr/testalphamcr.ks"
        ;@call storage="mcr/evt.ks"
        [iscript ]
        //mcr/evtから必要なものを抜いた
            f.map=[]
            f.map['bsc']=[]
            //f.map.bsc['loc']=[] //これも多分いらない
        [endscript ]
        ;[ivt_fst]系列の読込用
        @call storage="&'mcr/mode/'+f.mode+'.ks'"
        ;========================マクロ置場

        ;スタートだけの暫定処置.ここで最初に飛ぶマップを決めている
        @eval exp="f.mpnm=mp.st;f.isfps=false;" cond="f.isnmp==false"
        ;fpsはマップごとに記載箇所があるのでここで宣言いらないかも。

        ;マップ呼び出し(マップに必要なものを読み込ませてrenew)
        [map_smn]
        ;[map_smn nm="&f.mpnm" fps="f"]
        ;マップ読み込み済みの処理(1度だけの処理を行わない)
        @eval exp="f.isnmp=true" 
    [endmacro ]

    [macro name="evemap" ]
        ;ttpの時使わない
        /*
        現在fps切り替えができなくなってる
        */
        [A cond="f.isfps==true"]

        ;======共通=====
        ;Gの中のB1に使用
        [G name="&f.mpnm"]
        [E]
        ;Hのなかのcngbg(fps用),B1に使用
        [H name="&f.mpnm"]
        [I name="&f.mpnm"]
    [endmacro ]
[return ]