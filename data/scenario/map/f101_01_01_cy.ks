/*
第一工場中庭
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
            if(f.maplst===undefined)f.etl='j13b';
            if(f.maplst==='f101_20_01_set')f.etl='s7l';//セット室(E)から
            if(f.maplst==='f101_07_07_cref')f.etl='q8r';//コンテナ冷蔵庫(w1)から
            if(f.maplst==='f101_01_01_frz')f.etl='q3r';//冷凍庫(左上)(W2))から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(16,5,1,1,1)//冷凍庫(左上)
            push(10,3,7,7,1)//コンテナ冷蔵庫
            push(7,5,13,11,1)//冷凍庫
            push(11,4,1,24,1)//容器倉庫
            push(1,3,20,6,2)//セット室(E)へ
            push(1,1,16,8,2)//コンテナ冷蔵庫(w1)へ
            push(1,3,16,2,2)//冷凍庫(左上)(W)2へ

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
    *132062
    @eval exp="tf.mpnm='f101_20_01_set'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *111682
    @eval exp="tf.mpnm='f101_07_07_cref'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *131622
    @eval exp="tf.mpnm='f101_01_01_frz'"
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


