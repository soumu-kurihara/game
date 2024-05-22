/*
第二工場計量室

スキン強化対象
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
    //どのマップからも移動していない場合初期位置に入れる。これはてきとう。ワープ移動とかに使う
    if(f.maplst===undefined)f.etl='n2l';
    if(f.maplst==='f201_01_01_mac')f.etl='r1b';//洗浄室(N)から
    if(f.maplst==='f201_39_13_ant')f.etl='ag7l';//内階段(E1)から
    if(f.maplst==='f201_35_23_rep')f.etl='ac10l';//冷蔵庫3(E2)から
    if(f.maplst==='f201_01_15_rep')f.etl='a2r';//冷蔵庫2(W))から
    
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_06_15_wgh'

    //範囲XY,位置XY,タイプ
    push(1,1,5,13,1)//柱
    push(1,1,14,13,1)//柱
    push(1,1,24,13,1)//柱
    push(4,5,30,9,1)//冷蔵庫3
    push(2,1,18,0,2)//洗浄室(N)へ
    push(1,1,34,7,2)//内階段(E1)へ
    push(1,2,30,10,2)//冷蔵庫3(E2)へ
    push(1,2,0,2,2)//冷蔵庫2(W)へ

    //モノ配置
    push(7,1,10,1)//掃除用具・棚
    push(3,1,29,1)//真空機
    push(9,2,13,5)//パッケージ機(大)
    push(7,2,11,11)//パッケージ機(中)
    push(4,2,2,5)//パッケージ機(小)
    push(3,2,8,5)//金属探知機
    push(4,2,28,4)//テーブル(東)
    push(3,2,2,11)//テーブル(南1)
    push(3,2,6,11)//テーブル(南2)
    push(4,2,21,11)//テーブル(南3)


    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*211802
@eval exp="tf.mpnm='f201_01_01_mac'"
[jump target="*confirm" ]
*113472
@eval exp="tf.mpnm='f201_39_13_ant'"
[jump target="*confirm" ]
*1230102
@eval exp="tf.mpnm='f201_35_23_rep'"
[jump target="*confirm" ]
*12022
@eval exp="tf.mpnm='f201_01_15_rep'"
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
;[map_smn]

    ;マップに登場するキャラクター・モノ宣言
    [call storage="&'map/'+f.mpnm+'.ks'" target="*dec" cond="!f.isnmp" ]

;マップ読み込み済みの処理(1度だけの処理を行わない)
;@eval exp="f.isnmp=true" 

[return]
[s]