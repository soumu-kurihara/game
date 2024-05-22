/*
第二工場トリミング室

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
    if(f.maplst===undefined)f.etl='k9b';
    if(f.maplst==='f201_39_01_dmp')f.etl='n6b';//ゴミ置き場(N)から
    if(f.maplst==='f201_48_06_rep')f.etl='s9l';//冷蔵庫1(E)から
    if(f.maplst==='f201_39_13_ant')f.etl='l12t';//内階段(S)から
    if(f.maplst==='f201_01_01_mac')f.etl='a11r';//機械洗浄(W))から
    
    //f.povxyzにそれぞれ入る
    split(f.etl);
    //f.maplst='f201_29_01_trm'
    f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。

    //範囲XY,位置XY,タイプ
    push(1,1,1,1,1)//柱
    push(1,1,1,14,1)//柱
    push(9,5,11,1,1)//ゴミ捨て場
    push(2,2,11,13,1)//内階段
    push(3,1,13,5,2)//ゴミ置き場(N)へ
    push(1,2,20,9,2)//冷蔵庫1(E)へ
    push(2,1,15,15,2)//内階段(S)へ
    push(1,3,0,10,2)//機械洗浄(W)へ

    //モノ配置
    push(2,4,1,3)//テーブル1
    push(4,3,5,3)//テーブル2
    push(3,1,1,13)//テーブル3
    push(3,1,6,13)//テーブル4
    
    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*311352
;飛ぶ先のマップ名
@eval exp="tf.mpnm='f201_39_01_dmp'"
[jump target="*confirm" ]
*122092
@eval exp="tf.mpnm='f201_48_06_rep'"
[jump target="*confirm" ]
*2115152
[iscript ]
tf.mpnm='f201_39_13_ant';
//mode01の時セット準備室にワープする
//if(f.mode=='01')tf.mpnm='f101_20_01_set';
[endscript ]
[jump target="*confirm" ]
*130102
@eval exp="tf.mpnm='f201_01_01_mac'"
[jump target="*confirm" ]




;===================
;以下はいじらなくてよい

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