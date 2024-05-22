/*
第二工場1F玄関となりの冷蔵庫1
*/
;ADV表示の準備------------------------------
[adv]
;イベントラベル番号f.labelを作成する---------
[crilbl]
;---------------------------------------------------

;----ここまで全てのマップ共通------


[jump target="&f.label" ]
[s]
*place
[iscript ]
    //レイヤー1を使用するなら宣言
    f.isma=true;
    //pushでイベントを記入する
    //どのマップからも移動していない場合初期位置に入れる。これはてきとう
    if(f.maplst===undefined)f.etl='e5b';
    if(f.maplst==='f201_46_01_ent')f.etl='a1b';//第二工場玄関(N)から
    if(f.maplst==='f201_48_18_vgt')f.etl='d12t';//野菜一時保管室など(S)から
    if(f.maplst==='f201_29_01_trm')f.etl='a4r';//トリミング室(W)から
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_48_06_rep'

    push(1,1,2,9,1)//柱
    push(1,1,12,9,1)//柱
    push(2,1,1,0,2)//第二工場玄関(N)へ
    push(2,1,4,13,2)//野菜一時保管室など(S)へ
    push(1,2,0,4,2)//トリミング室(W)へ
    
    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*21102
;飛ぶ先のマップ名
@eval exp="tf.mpnm='f201_46_01_ent'"
[jump target="*confirm" ]
*214132
@eval exp="tf.mpnm='f201_48_18_vgt'"
[jump target="*confirm" ]
*12042
@eval exp="tf.mpnm='f201_29_01_trm'"
[jump target="*confirm" ]


*confirm
[dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
[knockback]
[return]

*go
;マップ生成に必要な色々を削除する

;マップに登場するキャラクター・モノ削除

[iscript ]
f.isnmp=false;


//次に呼び出すマップ名
f.mpnm=tf.mpnm;
//移動前のマップ名
//f.maplst=f.maplst;

[endscript ]
[map_smn]
;マップ読み込み済みの処理(1度だけの処理を行わない)
@eval exp="f.isnmp=true" 

[return]
[s]