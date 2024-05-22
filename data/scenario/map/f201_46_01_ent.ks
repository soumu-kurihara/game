/*
第二工場玄関
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
;部屋に入った最初の１回のみ
;イベントを覚えさせてそれで呼び出すのはできる。01より速い。
/*
    [dialog text="placeを通ったよ" ]
    [wait time="1000" ]
[iscript]
        f.isfps=false//FPSモードの設定
    //マップイベント
        //ファイル名を入れる
        if(f.mpnm===undefined)f.mpnm='f201_46_01_ent';
        //初期立ち位置
        let bsc='n2l'
        //適用する出口と入口を設定
        var 出口=[];
        //出口の数だけ[]を増やしてOK[イベント場所と規模,初期位置,移動先]
        出口[0]=[[2,1,3,6,2],'c6t','f201_48_06_rep'];  
        出口[1];

        //マップに入った時の初期位置の登録
        f.etl='';
        for(let n=0;n<=出口.length-1;n++){//出口[]の数だけ繰り返す
            var ar=出口[n];
            if(f.maplst===undefined)f.etl=bsc;//最初からこのマップをはじめる場合これ
            if(f.maplst==ar[2]&&f.etl=='')f.etl=ar[1];

            //イベントの数値を登録(tf.pl12345)
            var br=ar[0]
            push(br[0],br[1],br[2],br[3],br[4]);
        };
        //f.povxyzにそれぞれ入る
        split(f.etl);
        f.maplst=f.mpnm;//このファイル名を入れる

    //マップ移動以外のイベント
        push(1,1,14,1,1)//柱
        push(4,4,4,1,1)//別の部屋    

[endscript ]
*/

[iscript]
    //このマップと隣接しているマップ名と、対応した出入口の番地を入れる。
    //ここに入る予定

    //どのマップからも移動していない場合初期位置に入れる
    if(f.maplst===undefined)f.etl='n2l';
    if(f.maplst=='f201_48_06_rep')f.etl='c5t';//南冷蔵庫から
    if(f.maplst=='f201_39_13_ant')f.etl='j2r';//内階段から
    //f.povxyzにそれぞれ入る
    split(f.etl);
    //f.maplst='f201_46_01_ent';
    f.maplst=f.mpnm;//呼び出した(この)マップ名に中身を更新。
    //イベントの数値を登録(tf.pl12345)
    push(1,1,14,1,1);//柱
    push(1,1,5,5,1);//見えない壁
    push(4,4,4,1,1);//別の部屋
    push(2,1,3,6,2);//次のエリアへ
    push(1,3,9,1,1);//階段の裏
    push(1,3,10,1,2);//内階段へ繋げる(後に2Fへ)
/*
    //mode01の時これを作成・中身を変更する
    if(f.mode=='01'){
    push(1,3,10,1,2);//内階段へ繋げる
    push(6,1,8,4,2)
    };
    */
    f.iseve=true//イベントが発生するか否か
    f.isfps=false//FPSモードの設定
[endscript ]

[jump storage="&f.pg" target="*rt_bld" ]
[s ]

;マップごとに登場するモノや人を宣言しておく
*dec
[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]

[return]
[s]

*21362
@eval exp="tf.mpnm='f201_48_06_rep'"
[jump target="*confirm" ]

; ;階段移動
; *131012
; [iscript ]
; tf.mpnm='f201_39_13_ant'
; if(f.mode='01')tf.mpnm='f201_39_13_ant';
; [endscript ]
; [jump target="*confirm" ]



*confirm
[dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
[knockback]
[return]

;*21362
;[dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
;[knockback]
;[return]

*go
;マップ生成に必要な色々を削除する

;マップに登場するキャラクター・モノ削除
[chara_delete name="guard" ]
[iscript ]
f.isnmp=false;


//次に呼び出すマップ名
//f.mpnm='f201_48_06_rep';
f.mpnm=tf.mpnm;

//移動前のマップ名
//f.maplst='f201_46_01_ent';

[endscript ]
[map_smn]

[trace exp="'f2entのmap_smnを使用'"]
;マップ読み込み済みの処理(1度だけの処理を行わない)
@eval exp="f.isnmp=true" 

[return]
[s]

;*131012
;[dialog text="2Fはまだできてないので立ち入り禁止です。" ]
;[knockback]
;[return]
;[s]

; *61842
; [noenter]
; [return]
; [s]