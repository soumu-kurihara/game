/*
第一工場セット室
厳密にはセット準備室

スキン強化対象
*/

;ADV表示の準備------------------------------
[adv]
;イベントラベル番号f.labelを作成する---------
;[crilbl]
;---------------------------------------------------
;ラベルへ飛ぶ
[jump target="&f.label" cond="!tf.warp"]
;移動イベント(tf.warp==true)のとき、confirmに飛ぶようにする。
[jump target="*confirm" ]

[s]
;----ここまで全てのマップ共通------




;===呼び出して値を登録するゾーン(一度通ればOK)======================
    *place
        [iscript ]
            //レイヤー1を使用するなら宣言
             f.isma=true;

            //f.maplst(移動前のマップ名)に対応する初期位置をf.etlに入れる
            if(f.maplst===undefined)f.etl='f9b';
            if(f.maplst==='f101_30_01_cdb')f.etl='j2l';//段ボール室(E1)から
            if(f.maplst==='f101_30_10_ccr')f.etl='j11l';//コンテナ洗浄室(E2)から
            if(f.maplst==='f101_12_25_wap')f.etl='c24t';//計量包装(S)から
            if(f.maplst==='f101_01_01_cy')f.etl='a7r';//中庭(W))から

            //mode01のとき
            /*
            if(f.mode=='01'){
                if(f.maplst==='f201_29_01_trm')f.etl='j2l';//トリミング室から(E1)
            }
            */

            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(1,1,11,2,2);//段ボール室(E1)へ
            push(1,2,11,11,2);//コンテナ洗浄室(E2)へ
            push(4,1,2,25,2);//計量包装(S)へ
            push(1,3,0,6,2);//中庭(W)へ

            //モノ配置
            push(5,2,3,1,3);//北の棚
            push(1,6,10,4,3);//東の棚
            push(3,4,5,11,3);//中央テーブル
            push(2,4,7,18,3);//南テーブル

            f.isfps=false//FPSモードの設定
        [endscript ]
        ;mcr/testalphamcr.ksへ
        [jump storage="&f.pg" target="*rt_bld" ]
    [s ]

    ;マップごとに登場するモノや人を宣言しておく
    *dec
        ;[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]
        [return]
    [s]
;==================================================================

;イベント内容(何度も呼び出す)===============

    ;pushで記入した引数を文字列結合したラベルと内容(移動イベント<2>)
    *111122
    @eval exp="tf.mpnm='f101_30_01_cdb'"
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]
    [s ]
    *1211112
    @eval exp="tf.mpnm='f101_30_10_ccr'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    [s ]
    *412252
    @eval exp="tf.mpnm='f101_12_25_wap'"
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]
    [s ]
    *13062
    @eval exp="tf.mpnm='f101_01_01_cy'"
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]
    [s ]

    ;モノを調べた時のイベント
    *52313
    ;北の棚の写真と説明
    [dialog text="写真がでてるよ"]
    [jump target="*common" ]
    [s ]
    *161043
    ;東の棚の写真と説明
    [dialog text="写真がでてるよ"]
    [jump target="*common" ]
    [s ]

    *345113
    ;中央テーブルの写真と説明
    [dialog text="写真がでてるよ"]
    [jump target="*common" ]
    [s ]

    *247183
    ;南テーブルの写真と説明
    [jump target="*common" ]
    [s ]

    *common
    [return ]
    [s]
    

    ;移動のときにイベントを挟む場合
    *confirm
    [dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
    [knockback]
    [return]

    ;マップ移動専用。このマップで追加したものを削除する。
    *go
        [chara_hide_all time="50" ]
        ;[chara_delete name="guard" ]
        [iscript ]
            //マップの既存読込をOFF
            f.isnmp=false;
            //次に呼び出すマップ名
            f.mpnm=tf.mpnm;
        [endscript ]
        ;マップ新読込
        [map_smn]
        ;マップ既存読込をON(1度だけの処理を行わない)
        @eval exp="f.isnmp=true" 
        [return]
    [s]

;=============================


