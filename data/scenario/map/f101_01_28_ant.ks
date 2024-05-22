/*
前室(第一工場西)
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
            if(f.maplst===undefined)f.etl='c3r';
            if(f.maplst==='f101_01_24_ctr')f.etl='e1b';//容器倉庫(N)から
            if(f.maplst==='f101_12_25_wap')f.etl='k4l';//計量包装室(E)から
            if(f.maplst==='f101_06_34_suc')f.etl='h6t';//タレ倉庫(S1)から
            if(f.maplst==='f101_01_32_frz')f.etl='d4t';//冷凍庫(左下)(S2)から
            if(f.maplst==='f101_06_43_ptk')f.etl='a2r';//プロパン庫(W)から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(5,2,1,5,1)//冷凍庫
            push(2,1,4,0,2)//容器倉庫(N)へ
            push(1,2,12,4,2)//計量包装室(E)へ
            push(4,1,7,7,2)//タレ倉庫(S1)へ
            push(2,1,3,5,2)//冷凍庫(左下)(S2)へ
            push(1,2,0,2,2)//プロパン庫(W)へ

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
    *21402
    @eval exp="tf.mpnm='f101_01_24_ctr'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *121242
    @eval exp="tf.mpnm='f101_12_25_wap'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *41772
    @eval exp="tf.mpnm='f101_06_34_suc'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *21352
    @eval exp="tf.mpnm='f101_01_32_frz'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *12022
    @eval exp="tf.mpnm='f101_06_43_ptk'"//移動先のマップ名
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


