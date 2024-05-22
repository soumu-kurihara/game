/*
第一工場玄関
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
            //f.maplst(移動前のマップ名)に対応する初期位置をf.etlに入れる
            if(f.maplst===undefined)f.etl='c12b';
            if(f.maplst==='f101_50_01_ref')f.etl='a2r';//冷蔵庫(出荷待ち)(N)から
            if(f.maplst==='f101_62_25_hwp')f.etl='d26r';//手洗い前室(S1)から
            //if(f.maplst==='f101_47_25_wbs')f.etl='d26r';//作業靴置場(S2)から
            if(f.maplst==='f101_34_01_pic')f.etl='a11r';//トリミング室(W))から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(2,3,1,25,1)//作業靴置場
            push(1,1,0,2,2)//冷蔵庫(出荷待ち)(N)へ
            push(1,1,3,26,2)//手洗い前室(S1)へ
            push(1,13,0,6,2)//トリミング室(W)へ

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
    *11022
    @eval exp="tf.mpnm='f101_50_01_ref'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *113262
    @eval exp="tf.mpnm='f101_62_25_hwp'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *113062
    @eval exp="tf.mpnm='f101_34_01_pic'"//移動先のマップ名
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


