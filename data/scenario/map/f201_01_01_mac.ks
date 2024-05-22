/*
第二工場洗浄室(左上)(カット室)

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
    if(f.maplst===undefined)f.etl='n8b';
    if(f.maplst==='f201_29_01_trm')f.etl='ab10l';//トリミング室(E)から
    if(f.maplst==='f201_06_15_wgh')f.etl='w14t';//計量室(S)から
    
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst='f201_01_01_mac'

    //範囲XY,位置XY,タイプ
    push(1,1,1,1,1)//柱
    push(1,1,10,1,1)//柱
    push(1,1,19,1,1)//柱
    push(1,1,1,14,1)//柱
    push(1,1,10,14,1)//柱
    push(1,1,19,14,1)//柱
    push(1,3,29,10,2)//トリミング室(E)へ
    push(2,1,23,15,2)//計量室(S)へ

    //モノ配置
//    ここで、5番目のプロパティがないとエラー吐かれる
    push(3,1,4,1)//製氷機
    push(3,1,11,1)//ダイススライサー
    push(2,1,17,1)//千切りスライサー
    push(1,1,1,3)//白髪スライサー
    push(7,3,5,4)//洗浄ゾーン
    push(1,1,2,9)//脱水機A
    push(1,1,5,9)//脱水機B
    push(5,2,6,11)//バブラー
    push(4,2,15,13)//コンテナ洗浄機
    push(2,1,18,4)//スライサー1
    push(2,1,18,6)//スライサー2
    push(2,1,18,9)//スライサー3
    push(4,2,23,2)//テーブル1
    push(4,2,23,6)//テーブル2

    //f.iseve=true//イベントが発生するか否かfalseにすることないよ(マップ移動のため)
    f.isfps=false//FPSモードの設定

[endscript ]
[jump storage="&f.pg" target="*rt_bld" ]
[s ]
;マップごとに登場するモノや人を宣言しておく
*dec
[return]
[s]

*1329102
@eval exp="tf.mpnm='f201_29_01_trm'"
[jump target="*confirm" ]
*2123152
@eval exp="tf.mpnm='f201_06_15_wgh'"
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