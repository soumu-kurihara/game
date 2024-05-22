/*
第一工場段ボール室
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
            //f.maplst(移動前のマップ名)に対応する初期位置をf.etlに入れる
            if(f.maplst===undefined)f.etl='b3b';
            if(f.maplst==='f201_35_23_rep')f.etl='b1b';//第二工場(冷蔵庫2)(N)から
            if(f.maplst==='f101_20_01_set')f.etl='a2r';//セット室(W))から
            if(f.maplst==='f101_34_01_pic')f.etl='d7l';//生産管理室(E))から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(2,1,2,0,2);//第二工場(冷蔵庫2)(N)へ
            push(1,1,0,2,2);//セット室(W)へ
            push(1,2,5,7,2);//生産管理室(E)へ

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
    @eval exp="tf.mpnm='f201_35_23_rep'"
    [jump target="*confirm" ]
    [s ]
    *11022
    *12012
    ;ごり押し修正
    @eval exp="tf.mpnm='f101_20_01_set'"
    [jump target="*confirm" ]

    *12572
    @eval exp="tf.mpnm='f101_34_01_pic'"
    [jump target="*confirm" ]

    [s ]

    ;移動のときにイベントを挟む場合
    *confirm
    [dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
    [knockback]
    [return]
    [s ]

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


