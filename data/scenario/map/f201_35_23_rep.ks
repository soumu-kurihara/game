/*
第二工場冷蔵庫3(右下)

*/
;ADV表示の準備------------------------------
[adv]
;イベントラベル番号f.labelを作成する---------
;[crilbl]
;---------------------------------------------------

;----ここまで全てのマップ共通------


[jump target="&f.label" ]
[s]
*place
[iscript ]
    //pushでイベントを記入する
    //どのマップからも移動していない場合初期位置に入れる。これはてきとう。ワープ移動とかに使う
    if(f.maplst===undefined)f.etl='g3b';
    if(f.maplst==='f201_48_18_vgt')f.etl='m3l';//野菜一時保管室など(E)から
    if(f.maplst==='f101_30_01_cdb')f.etl='c5t';//第一工場段ボール室(S)から
    if(f.maplst==='f201_06_15_wgh')f.etl='a2r';//計量室(W))から
    
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_35_23_rep'

    //範囲XY,位置XY,タイプ
    push(1,1,5,5,1);//柱
    push(1,2,14,2,2);//野菜一時保管室など(E)へ
    push(4,1,1,6,2);//第一工場段ボール室(S)へ
    push(1,2,0,1,2);//計量室(W)へ
    
    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*121422
@eval exp="tf.mpnm='f201_48_18_vgt'"
[jump target="*confirm" ]
[s ]
*12012
;TODO:バグf101_30_01_cbdのIDに関係
*12022
;間に合わせ処置。[crilbl]を見直す。計量室から来て向かうと12022を要求される。
@eval exp="tf.mpnm='f201_06_15_wgh'"
[jump target="*confirm" ]
[s ]
*41162
@eval exp="tf.mpnm='f101_30_01_cdb'"
[jump target="*confirm" ]
[s ]


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