/*
マップ切り替えテスト用

イベントはマクロで繋げる

・マップで発生するイベントの登録(place)
・キャラクターモノの登録

call中にjumpできたし、returnで呼び出し元に戻れる

*/



;place(イベント発生マス)の登録
;登場初期位置も登録
*place
[iscript]
    //このマップと隣接しているマップ名と、対応した出入口の番地を入れる。
    //ここに入る予定

    //どのマップからも移動していない場合初期位置に入れる
    if(f.maplst===undefined)f.etl='i6t';
    //f.povxyzにそれぞれ入る
    split(f.etl);
    f.maplst=='ent1ttp'
    //イベントの数値を登録(tf.pl12345)
    push(1,1,6,2,2);

    f.iseve=true//イベントが発生するか否か
    f.isfps=false//FPSモードの設定
[endscript ]

[jump storage="mcr/testalphamcr.ks" target="*rt_bld" ]
[s ]

;マップごとに登場するモノや人を宣言しておく
*dec
[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]

[return]
[s]