/*
上手くできたらmenu.ksに名前を変更する。

ボタンを押す
黒背景にマップが浮き出る
マップの部屋が栗ボタンで移動できる

■2種のボタンそれぞれで処理を変更する

240204現在使用中
*/

/*
全マップの名前、最大XY、WHを配列で記録する
名前からxtを割り出す
*/
[iscript ]
    //name,mxW,mxH
    f.arymp=[];
    f.arymp[0] =['f101_01_01_cy'  ,19 ,27]
    f.arymp[1] =['f101_01_01_frz' ,17 ,5 ]
    f.arymp[2] =['f101_01_24_ctr' ,11 ,4 ]
    f.arymp[3] =['f101_01_28_ant' ,11 ,6 ]
    f.arymp[4] =['f101_01_32_frz' ,5  ,13]
    f.arymp[5] =['f101_06_34_suc' ,6  ,9 ]
    f.arymp[6] =['f101_06_43_ptk' ,6  ,2 ]
    f.arymp[7] =['f101_07_07_cref',11 ,3 ]
    f.arymp[8] =['f101_12_25_wap' ,30 ,20]
    f.arymp[9] =['f101_13_11_frz' ,7  ,5 ]
    f.arymp[10]=['f101_20_01_set' ,10 ,24]
    f.arymp[11]=['f101_30_01_cdb' ,4  ,9 ]
    f.arymp[12]=['f101_30_10_ccr' ,4  ,15]
    f.arymp[13]=['f101_34_01_pic' ,28 ,24]
    f.arymp[14]=['f101_34_23_frzp',13 ,4 ]
    f.arymp[15]=['f101_36_28_ref' ,8  ,4 ]
    f.arymp[16]=['f101_36_34_ref' ,6  ,6 ]
    f.arymp[17]=['f101_36_40_ref' ,6  ,5 ]
    f.arymp[18]=['f101_42_28_mcn' ,20 ,17]
    f.arymp[19]=['f101_44_37_hac' ,13 ,8 ]
    f.arymp[20]=['f101_47_25_wbs' ,15 ,3 ]
    f.arymp[21]=['f101_50_01_ref' ,12 ,3 ]
    f.arymp[22]=['f101_57_37_ref' ,5  ,8 ]
    f.arymp[23]=['f101_62_01_ent' ,8  ,27]
    f.arymp[24]=['f101_62_25_hwp' ,3  ,12]
    f.arymp[25]=['f101_62_37_ref' ,13 ,8 ]
    f.arymp[26]=['f201_01_01_mac' ,28 ,14]
    f.arymp[27]=['f201_01_15_rep' ,5  ,13]
    f.arymp[28]=['f201_06_15_wgh' ,33 ,13]
    f.arymp[29]=['f201_29_01_trm' ,19 ,14]
    f.arymp[30]=['f201_35_23_rep' ,13 ,5 ]
    f.arymp[31]=['f201_39_01_dmp' ,7  ,5 ]
    f.arymp[32]=['f201_39_13_ant' ,9  ,10]
    f.arymp[33]=['f201_46_01_ent' ,17 ,5 ]
    f.arymp[34]=['f201_48_06_rep' ,12 ,12]
    f.arymp[35]=['f201_48_18_vgt' ,12 ,10]
    f.arymp[36]=['f201_49_01_pmp' ,4  ,4 ]

[endscript ]

[bg storage="../image/frame.png" time="500" ]
[layopt visible="true" layer="0" ]

[ptext text="&'現在地:'+f.mpnm" size="40"  layer="0" x="86" y="64" ]
[glink text="タイトルに戻る" target="*gotitle" x="635" y="40" color="btn_01_white"]
[glink text="[X]閉じる" target="*return" x="1035" y="40" color="btn_27_purple" ]
[ptext text="マップワープ" color="black"  size="60" width="500"  layer="0" x="&1280/2-200" y="200" ]

;37(26+11)


;ボタンによりワープボタンを表示させる
;最初のボタン2種
@eval exp="tf.wpnm='map101.jpg'"

[button graphic="&tf.wpnm" width="&1280*0.3" height="&720*0.3" x="200" y="300"  target="*mpslct" exp="tf.wpnm=preexp" preexp="tf.wpnm" ]

@eval exp="tf.wpnm='map201.jpg'"

[button graphic="&tf.wpnm" width="&1280*0.3" height="&720*0.3" x="&200+50+1280*0.3" y="300"  target="*mpslct" exp="tf.wpnm=preexp" preexp="tf.wpnm" ]

[s ]
;ここまで初期画面
;===========================
    ;ここからマップを押したときの画面

    *mpslct
    ;fixとかcmとかする
    [cm ]


    [clickable color="black" width="1280" height="720" opacity="100"    ]
    [button graphic="&tf.wpnm" width="&1280*0.9" height="&720*0.9" x="64" y="36"   ]
    ;閉じるボタン
    [glink text="X" width="80" height="80" x="1136" y="36" color="btn_30_red"  ]

    /*
    計算式
    １マスサイズ：14.7386＝E20(たぶんF011限定)
    122.0529/36はマップ左上の原点XY
    X
    122.0529+E20*(mxW-1)
    Y
    36+E20*(mxH-1)
    */

    @eval exp="tf.n=0" 
*repeat
    ;buttonの形、場所、ワープ先を条件により変更する。
    [iscript ]
        //選んだマップボタンで定義する正規表現を変更する。
        if(tf.wpnm=='map101.jpg'){
            var regex =new RegExp('^(f1)(01)*');
        }else{
            var regex =new RegExp('^(f2)(01)*');
        };

        let tgt=f.arymp[tf.n][0];
        //初期化
        tf.sq=0;tf.oX=0;tf.oY=0;

        //trueのときだけボタン作成表示の処理を行う
        tf.istf=false;
            if(regex.test(tgt)){
                //F101のときのみ
                if(tf.wpnm=='map101.jpg'){
                    var sq=14.7386;
                    var oX=122.0529;
                    var oY=36;
                };
                //F201のときのみ
                if(tf.wpnm!='map101.jpg'){
                    var sq=18.5887;
                    var oX=64;
                    var oY=109.3024;
                };

                tf.istf=true;
            };

            if(tf.istf){
                let W=sq*f.arymp[tf.n][1];
                let H=sq*f.arymp[tf.n][2];
                let X=oX+sq*(tgt.split('_')[1]-1);
                let Y=oY+sq*(tgt.split('_')[2]-1);
                let preexp;
                
                //橋渡し
                tf.wi=W;tf.he=H;tf.xx=X;tf.yy=Y;tf.tgt=tgt;
            };
    [endscript ]

    ;ここでボタンを配置(preexpはtyranoタグじゃないと無理)
    ;tf.istfがtrueのときだけボタンを表示する。
    [button graphic="a0.png" enterimg="a1.png" width="&tf.wi" height="&tf.he" x="&tf.xx" y="&tf.yy" target="*warp" exp="tf.wmn=preexp;" preexp="tf.tgt" cond="tf.istf"]
    

    @eval exp="tf.n++" 
    ;[jump target="*repeat" cond="tf.n!=25" ]
[jump target="*repeat" cond="tf.n!=f.arymp.length" ]
[s ]

;========================//ここまでマップボタンを押したあとのマップ移動画面

[dialog text="MENUに来たから戻るよ" ]
[wait time="1000" ]
[p]

[jump storage="&f.pghr" target="*remenu" ]
;[awakegame variable_over="true" ]

[s]

*warp
;そのマップにワープ。
[dialog type="confirm" storage_cancel="menu.ks"  text="&tf.wmn+'に移動します。よろしいですか?'" ]
[cm ]

    [chara_hide_all time="50" ]
    ;[chara_delete name="guard" ]
    [iscript ]
        //マップの既存読込をOFF
        f.isnmp=false;
        //次に呼び出すマップ名
        f.mpnm=tf.mpnm=tf.wmn;
        //ワープ用の初期位置にする
        f.maplst=undefined;
    [endscript ]
    ;マップ新読込
    [map_smn]
    ;マップ既存読込をON(1度だけの処理を行わない)
    @eval exp="f.isnmp=true" 

*return
;ただ閉じるだけならここから
[jump storage="&f.pghr" target="*remenu" ]

[s ]

*gotitle
[dialog type="confirm" text="タイトルに戻りますか？" target="*exit"  ]
[jump]
[s ]

*exit
[destroy]
[chara_delete name="player_mt"]
[jump storage="title.ks"]

[s ]
