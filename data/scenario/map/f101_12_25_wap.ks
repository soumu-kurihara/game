/*
計量包装室(セット室)
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
            if(f.maplst===undefined)f.etl='x8l';
            if(f.maplst==='f101_20_01_set')f.etl='k1b';//セット室(セット準備室)(N1)から
            if(f.maplst==='f101_30_10_ccr')f.etl='u1b';//コンテナ洗浄室(N2)から
            if(f.maplst==='f101_36_28_ref')f.etl='x6l';//冷蔵庫(計量機械室間最上)(E1)から
            if(f.maplst==='f101_42_28_mcn')f.etl='ad8l';//機械室(E2)から
            if(f.maplst==='f101_36_34_ref')f.etl='x12l';//冷蔵庫(計量機械室間下2)(E3)から
            if(f.maplst==='f101_36_40_ref')f.etl='x17l';//冷蔵庫(計量機械室間最下)(E4)から
            if(f.maplst==='f101_01_28_ant')f.etl='a7r';//前室(第一工場西)(W)から


            //f.etlを分解収納するsplitをかける
            split(f.etl);//f.povxyzにそれぞれ入る
            f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

            //pushで範囲位置タイプを登録する
            push(8,2,23,1,1);//冷蔵庫(ピッキング室)
            push(6,4,25,4,1);//冷蔵庫(計量機械室間最上)
            push(6,6,25,10,1);//冷蔵庫(計量機械室間下2)
            push(6,5,25,16,1);//冷蔵庫(計量機械室間最下)
            push(8,3,1,1,1);//品管置場

            push(4,1,10,0,2);//セット室(セット準備室)(N1)へ
            push(2,1,20,0,2);//コンテナ洗浄室(N2)へ
            push(1,1,25,6,2);//冷蔵庫(計量機械室間最上)(E1)へ
            push(1,2,31,8,2);//機械室(E2)へ
            push(1,1,25,12,2);//冷蔵庫(計量機械室間下2)(E3)へ
            push(1,1,25,17,2);//冷蔵庫(計量機械室間最下)(E4)へ
            push(1,2,0,7,2);//前室(第一工場西)(W)へ

            //モノ配置
            push(5,1,16,3);//包装ライン(小)
            push(3,6,16,12);//包装ライン(大)
            push(2,1,5,10);//真空機
            push(2,4,2,15);//パッケージ機
            push(2,1,6,16);//テーブル1
            push(3,1,5,20);//テーブル2
/*
            //モノ配置
            push(5,2,16,2)//包装ライン(小)
            push(3,7,16,11)//包装ライン(大)
            push(3,1,4,10)//真空機
            push(2,4,2,15)//パッケージ機
            push(2,1,6,16)//テーブル1
            push(1,2,6,19)//テーブル2
*/
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
    *411002
    @eval exp="tf.mpnm='f101_20_01_set'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    [s ]
    *212002
    @eval exp="tf.mpnm='f101_30_10_ccr'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    [s ]
    *112562
    @eval exp="tf.mpnm='f101_36_28_ref'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *123182
    @eval exp="tf.mpnm='f101_42_28_mcn'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *1125122
    @eval exp="tf.mpnm='f101_36_34_ref'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *1125172
    @eval exp="tf.mpnm='f101_36_40_ref'"
    ;イベントを挟む場合はconfirm挟まない場合はgo
    [jump target="*confirm" ]
    *12072
    @eval exp="tf.mpnm='f101_01_28_ant'"
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


