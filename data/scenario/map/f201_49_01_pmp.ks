/*
第二工場ポンプ室

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
    //pushでイベントを記入する
    //どのマップからも移動していない場合初期位置に入れる。これはてきとう。ワープ移動とかに使う
    if(f.maplst===undefined)f.etl='b1b';
    if(f.maplst==='f201_39_01_dmp')f.etl='b1b';//ゴミ置き場(N)から
    
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_49_01_pmp'

    push(1,1,1,1,1)//柱
    push(2,1,2,0,2)//ゴミ置き場(N)へ
    
    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*21202
;飛ぶ先のマップ名
@eval exp="tf.mpnm='f201_39_01_dmp'"
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