/*
イベント管理用
マップの読込もここ
240204現在使用していない
*/

;イベントの位置
; [iscript ]
; f.event=[]
; f.event[0]=[]
; /*
; //入口場所'入口場所'Y9X5
; f.event[0]=[f.sq.x*5,f.sq.y*9]
; //面談'面談'Y5X8
; f.event[1]=[f.sq.x*8,f.sq.y*5]
; //'質問'Y4X2
; f.event[2]=[f.sq.x*2,f.sq.y*4]
; //'ビュー'Y1X5
; f.event[3]=[f.sq.x*5,f.sq.y*1]
; */
; //入口場所'入口場所'Y9X5
; f.event[0]=[5,8]
; //面談'面談'Y5X8
; f.event[1]=[8,4]
; //'質問'Y4X2
; f.event[2]=[2,5]
; //'ビュー'Y1X5
; f.event[3]=[5,2]

; tf.map=`
; 入口-5,8
; 面談-8,4
; 質問-2,5
; ビュー-5,2
; `
; [endscript ]

[iscript ]
f.map=[]
f.map['bsc']=[]
f.map.bsc['loc']=[]

for(i=1;i<=9;i++){
    f.map.bsc.loc[i]=[];
    for(let l=1;l<=9;l++){
        f.map.bsc.loc[i][l]=0 ;//[1,1]~[9,9]を全て0
    }
}
//外枠を埋める
f.map.bsc.loc[0]=[]
f.map.bsc.loc[10]=[]
for(i=0;i<=10;i++){
    f.map.bsc.loc[0][i]=1;
    f.map.bsc.loc[10][i]=1;
}
for(i=1;i<=9;i++){
    f.map.bsc.loc[i][0]=1;
    f.map.bsc.loc[i][10]=1;
}

f.map.bsc['evt']=[]
f.map.bsc.evt[0]=[5,8] //入口
f.map.bsc.evt[1]=[8,4] //面談
f.map.bsc.evt[2]=[2,5] //質問
f.map.bsc.evt[3]=[5,2] //ビュー

for (i=0;i<=3;i++){
let array=f.map.bsc.evt[i]
f.map.bsc.loc[array[0]][array[1]]=3;
}

//入口だけ書き換え
f.map.bsc.loc[5][8]=2;
[endscript ]

[ptext layer="0" color="red"  name="b"  text="&tf.map" x="600" y="100"  overwrite="true"]
/*
[macro name="notic"]
[dialog text="この先イベント0アリ"]
[endmacro ]
*/

/*
1.座標を登録
2.条件により座標が一致した場合走らせる
3.内容は関数化する。

ad:飛ばされる先は固定だがマップごとに座標結果を組み替える
*/



    ;その場で発火するイベント
    [macro name="mindev" ]

        ;[dialog text="直接発火するイベント(移動など)" ]

        ; [iscript ]
        ; if(現在地=true)行先のマップ名;
        ; [endscript ]

        ; [movmap to="行先のマップ名"]
        [layopt layer="0" visible="true"  ]
        [layopt layer="1" visible="true"  ]
        [call storage="evt/ent1.ks" ]


    [endmacro ]

    ;フィールドに仕込むイベント
    [macro name="objev" ]
        [layopt layer="0" visible="true"  ]
        [layopt layer="1" visible="true"  ]
        ;タイトルに戻るボタン これbuttonでfixボタンにして
        ;[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

        ;現在のマップ名から呼び出しを分岐(あとでつけるent1)
        [call storage="evt/ent1.ks" ]


        ;    [dialog text="目の前の進行不可のオブジェの方向を向いてボタンを押すと発火するイベント" ]

        ; [iscript ]
        ; if(現在地+進行方向+1=true)何かしら変数;

        ; - 文字が出るイベント
        ; - リンクへ飛ぶイベント
        ; - マップが変化するイベント(扉を開けるなど)

        ; [endscript ]
    [endmacro ]

[return ]
[s ]
/*
部屋の名前
イベント名
から割り出す。

メッセージを出すだけ
マップを移動する
別のイベントが発生する
*/
/*
*mindev
[dialog text="直接発火するイベント(移動など)" ]


[awakegame ]
[s ]

*objev
;[dialog text="目の前の進行不可のオブジェの方向を向いてボタンを押すと発火するイベント" ]

;画面破壊を行うか否か

;行う(modeadv)
;ADV表示切替(画像+文字)

;行わない
;メッセージのみ表示
;ステ変化(コイン取得など)


;とりあえず壊してADV表示させよう

[destroy]
[start_keyconfig]

[layopt layer="0" visible="true"  ]
[layopt layer="1" visible="true"  ]
;タイトルに戻るボタン これbuttonでfixボタンにして
;[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

[call storage="evt/ent1.ks" ]

[awakegame ]
[s ]
awakegameの連続使用ができないので廃止
*/


/*
1.現在地を座標で表す
2.現在地の四方をf.map.bsc.locで参照する
3.向いている1マスのイベントが2or3のとき、f.map.bsc.evtと参照して発火する

*/

/*
1.座標とイベント番号を登録する
2.イベント番号から処理を分ける
3.座標からイベント内容を発火させる

2.3を別ける必要なにかある？
    その場で発火するのと、フィールドにイベントを仕込むという違いがある。



別ける必要はないので一緒で。

イベント種類

- 移動
- ステータスの変化(コイン取得など)
- 文字の表示(メッセージ)-＞dialogでいいかも。
- 画像+文字の表示
- ハイパーリンク
*/