/*
加熱調理室
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
            if(f.maplst===undefined)f.etl='g3b';
            if(f.maplst==='f101_42_28_mcn')f.etl='c1b';//機械室(N1)から
            if(f.maplst==='f101_42_28_mcn')f.etl='k1b';//機械室(N2)から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(2,1,2,0,2)//機械室(N1)へ
            push(4,1,10,0,2)//機械室(N2)へ

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
    *21202
    @eval exp="tf.mpnm='f101_42_28_mcn'"//移動先のマップ名
    ;イベントを挟む場合はconfirm,挟まない場合はgo
    [jump target="*confirm" ]
    *411002
    @eval exp="tf.mpnm='f101_42_28_mcn'"//移動先のマップ名
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


