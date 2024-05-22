/*
第二工場1F
右下
野菜一時保管室など
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
[iscript]
    //このマップと隣接しているマップ名と、対応した出入口の番地を入れる。
    //ここに入る予定

    //どのマップからも移動していない場合初期位置に入れる
    if(f.maplst===undefined)f.etl='d1b';
    if(f.maplst=='f201_48_06_rep')f.etl='d1b';//南冷蔵庫1から
    if(f.maplst=='f201_35_23_rep')f.etl='a7r'//冷蔵庫3から
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_48_18_vgt'
    //イベントの数値を登録(tf.pl12345)
    push(1,1,1,10,1)//柱
    push(1,1,3,10,1)//柱
    push(1,1,12,10,1)//柱
    push(2,1,4,0,2)//冷蔵庫1(N)へ
    push(1,2,0,7,2)//冷蔵庫3(W)へ

    f.iseve=true//イベントが発生するか否か
    f.isfps=false//FPSモードの設定
[endscript ]

[jump storage="&f.pg" target="*rt_bld" ]
[s ]

;マップごとに登場するモノや人を宣言しておく
*dec
;[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]

[return]
[s]

*21402
;飛ぶ先のマップ名
@eval exp="tf.mpnm='f201_48_06_rep'"
[jump target="*confirm" ]
*12072
@eval exp="tf.mpnm='f201_35_23_rep'"
[jump target="*confirm" ]

*confirm
[dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
[knockback]
[return]

*go
;マップ生成に必要な色々を削除する

;マップに登場するキャラクター・モノ削除
[chara_delete name="guard" ]
[iscript ]
f.isnmp=false;


//次に呼び出すマップ名
f.mpnm=tf.mpnm;
//移動前のマップ名
f.maplst=f.maplst;

[endscript ]
[map_smn]
;マップ読み込み済みの処理(1度だけの処理を行わない)
@eval exp="f.isnmp=true" 

[return]
[s]