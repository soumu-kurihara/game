/*
機械室
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
            if(f.maplst===undefined)f.etl='p5b';
            if(f.maplst==='f101_62_25_hwp')f.etl='t6l';//手洗い前室(E)から
            if(f.maplst==='f101_57_37_ref')f.etl='q9t';//冷蔵庫(機械室)(S1)から
            if(f.maplst==='f101_44_37_hac')f.etl='n9t';//加熱調理室(S2)から
            if(f.maplst==='f101_44_37_hac')f.etl='e9t';//加熱調理室(S3)から
            if(f.maplst==='f101_36_40_ref')f.etl='a15r';//冷蔵庫最下(W1)から
            if(f.maplst==='f101_36_34_ref')f.etl='a10r';//冷蔵庫下2(W2)から
            if(f.maplst==='f101_12_25_wap')f.etl='a5r';//計量包装室(W3)から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(5,8,16,10,1)//冷蔵庫(機械室)
            push(13,8,3,10,1)//加熱調理室
            push(2,4,1,1,1)//冷蔵庫最上
            push(1,2,21,6,2)//手洗い前室(E)へ
            push(1,1,17,10,2)//冷蔵庫(機械室)(S1)へ
            push(4,1,12,10,2)//加熱調理室(S2)へ
            push(2,1,4,10,2)//加熱調理室(S3)へ
            push(1,1,0,15,2)//冷蔵庫最下(W1)へ
            push(1,1,0,10,2)//冷蔵庫下2(W2)へ
            push(1,2,0,5,2)//計量包装室(W3)へ

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
    *122162
    @eval exp="tf.mpnm='f101_62_25_hwp'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *1117102
    @eval exp="tf.mpnm='f101_57_37_ref'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *4112102
    @eval exp="tf.mpnm='f101_44_37_hac'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *214102
    @eval exp="tf.mpnm='f101_44_37_hac'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *110152
    @eval exp="tf.mpnm='f101_36_40_ref'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *110102
    @eval exp="tf.mpnm='f101_36_34_ref'"//移動先のマップ名
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *12052
    @eval exp="tf.mpnm='f101_12_25_wap'"//移動先のマップ名
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


