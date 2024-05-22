/*
第一工場ピッキング室

スキン強化対象
*/

;ADV表示の準備------------------------------
[adv]
;イベントラベル番号f.labelを作成する---------
[crilbl]
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
            if(f.maplst===undefined)f.etl='u10b';
            if(f.maplst==='f101_50_01_ref')f.etl='p2l';//冷蔵庫(出荷待ち)(N)から
            if(f.maplst==='f101_62_01_ent')f.etl='ab5l';//玄関(F1F)(E)から
            if(f.maplst==='f101_62_25_hwp')f.etl='aa24t';//手洗い前室(F1F)(S)から
            if(f.maplst==='f101_34_23_frzp')f.etl='k19t';//冷蔵庫(ピッキング室)(S)から
            if(f.maplst==='f101_30_10_ccr')f.etl='a17r';//コンテナ洗浄室(W))から
            if(f.maplst==='f101_30_01_cdb')f.etl='a8r';//段ボール室(W))から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(12,3,17,1);//冷蔵庫(出荷待ち)
            push(13,4,1,20);//冷蔵庫(ピッキング室)

            //移動先
            push(1,2,17,2,2);//冷蔵庫(出荷待ち)(N)へ
            push(1,4,29,4,2);//玄関(F1F)(E)へ
            push(1,11,27,25,2);//手洗い前室(F1F)(S)へ
            push(1,1,11,20,2);//冷蔵庫(ピッキング室)(S)へ
            push(1,1,0,17,2);//コンテナ洗浄室(W)へ
            push(1,2,0,7,2);//段ボール室(W)へ

            //モノ配置
            push(2,5,1,10)//作業レーン0
            //push(2,11,5,6);//作業レーン1
            //push(2,11,9,6);//作業レーン2
            //push(1,11,13,6);//作業レーン3
            push(10,11,4,6);//作業レーン1-3
            push(1,1,14,10);//柱の根本
            push(7,1,17,7);//作業レーン8
            push(9,1,17,13);//作業レーン7
            push(9,2,17,15);//作業レーン65
            push(9,2,17,19);//作業レーン4
            push(3,2,14,23);//システム管理室


            f.isfps=false//FPSモードの設定
        [endscript ]
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
    *121722
    ;冷蔵庫(出荷待ち)(N)へ
    @eval exp="tf.mpnm='f101_50_01_ref'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]

    *142942
    ;玄関(F1F)(E)へ
    @eval exp="tf.mpnm='f101_62_01_ent'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]

    *11127252
    ;手洗い前室(F1F)(S)へ
    @eval exp="tf.mpnm='f101_62_25_hwp'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]

    *1111202
    ;冷蔵庫(ピッキング室)(S)へ
    @eval exp="tf.mpnm='f101_34_23_frzp'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    
    *110172
    ;コンテナ洗浄室(W)へ
    @eval exp="tf.mpnm='f101_30_10_ccr'"
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]

    *12072
    ;段ボール室(W)へ
    @eval exp="tf.mpnm='f101_30_01_cdb'"
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]

    ;adv的イベント(<3>)
    *1111
    [return]
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


