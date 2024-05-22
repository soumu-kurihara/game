/*
自機操作に関するマクロ
call呼び出し
*/


;操作ボタン(あとでキーに割り当てる)-------------------------------------------
[iscript ]
tf.hoge=''
f.btnsz=90 //正方形ボタンのWHサイズ
f.btnTx=153.6697 //TボタンのX位置
f.btnTy=414.9908 //TボタンのY位置
[endscript ]

[macro name="arbtn" ]
[button name="%name" graphic="%gra" x="%x" y="%y" width="&f.btnsz" height="&f.btnsz" exp="tf.hoge=preexp" preexp="%px" fix="true" target="*ahead"  ]
[endmacro ]

[arbtn name="arT" gra="arT.png" x="&f.btnTx+0"  y="&f.btnTy+0"     px="'T'"]
[arbtn name="arR" gra="arR.png" x="&f.btnTx+90" y="&f.btnTy+90"    px="'R'"]
[arbtn name="arB" gra="arB.png" x="&f.btnTx+0"  y="&f.btnTy+90+90" px="'B'"]
[arbtn name="arL" gra="arL.png" x="&f.btnTx-90" y="&f.btnTy+90"    px="'L'"]

;-------------------------------------------------------
;1マスのサイズ-------------------------------------------
;マスのサイズにより数値を変える

;window幅を変更する度に再変更させる
[iscript]
$(window).resize(function(){
f.sq=[]
f.sq['x']=$(".grid").width();
f.sq['y']=$(".grid").width();


//現在値も走らせた方がいいかも

});


[endscript]


;初回読み込ませ箇所
[iscript ]
f.sq=[]
f.sq['x']=$(".grid").width();
f.sq['y']=$(".grid").height();

//現在位置用の変数宣言
tf.cpos=[]
//前後左右の位置の変数宣言
tf.adps=[]
//現在座標の変数宣言
tf.loc=[]
tf.loc['x']=0
tf.loc['y']=0
[endscript ]

;マスの座標作成-------------------------------------------
;XとYが特定の数値の範囲内だったら座標を名付ける
;※ただし現在、100%表示でないと不具合発生。ウィンドウサイズは固定。
[macro name="crimas" ]
[iscript ]
if(mp.axis=='x')tf.lup=f.sq.x*3.5 //280; //正方形マップなので左上のX初期位置
if(mp.axis=='y')tf.lup=0 //左上のY初期位置


//case 初期値(左上)から数えてN番目のマス <＝ 現在値 ||でありさらに|| 現在値 <= 初期値から数えてN+1番目-1pxのマスの間である
switch (true){
    case tf.lup+f.sq[mp.axis]*0<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*0+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=1;    break;
    case tf.lup+f.sq[mp.axis]*1<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*1+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=2;    break;
    case tf.lup+f.sq[mp.axis]*2<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*2+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=3;    break;
    case tf.lup+f.sq[mp.axis]*3<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*3+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=4;    break;
    case tf.lup+f.sq[mp.axis]*4<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*4+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=5;    break;
    case tf.lup+f.sq[mp.axis]*5<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*5+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=6;    break;
    case tf.lup+f.sq[mp.axis]*6<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*6+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=7;    break;
    case tf.lup+f.sq[mp.axis]*7<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*7+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=8;    break;
    case tf.lup+f.sq[mp.axis]*8<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*8+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=9;    break;
    // case tf.lup+f.sq[mp.axis]*9<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*9+f.sq[mp.axis]-1:
    //     tf.loc[mp.axis]=10;    break;
    // case tf.lup+f.sq[mp.axis]*10<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*10+f.sq[mp.axis]-1:
    //     tf.loc[mp.axis]=11;    break;
        default:
        alert('X該当なし:'+(tf.lup)+'//'+(f.sq[mp.axis]*0)+'//'+tf.cpos[mp.axis]); break;
}
[endscript ]
[endmacro]
;-------------------------------------------------------
;-------------------------------------------------------

;操作キャラ登録(チップ)-------------------------------------------
[iscript ]
//操作キャラの色々を登録
f.pc=[]
//チップのサイズ
f.pc['sz']=[]
f.pc.sz['x']=80,f.pc.sz['y']=80
//位置
f.pc['ps']=[]
f.pc.ps['x']=0,f.pc.ps['y']=0

tf.pass='chara/tip/1341/'
[endscript ]
[chara_config effect="jswing" ]
[chara_new name="player_mt" height="&f.pc.sz.y" width="&f.pc.sz.x" storage="&tf.pass+'1.png'" ]
[chara_face name="player_mt" face="b0" storage="&tf.pass+'0.png'"]
[chara_face name="player_mt" face="b1" storage="&tf.pass+'1.png'"]
[chara_face name="player_mt" face="b2" storage="&tf.pass+'2.png'"]
[chara_face name="player_mt" face="l0" storage="&tf.pass+'3.png'"]
[chara_face name="player_mt" face="l1" storage="&tf.pass+'4.png'"]
[chara_face name="player_mt" face="l2" storage="&tf.pass+'5.png'"]
[chara_face name="player_mt" face="r0" storage="&tf.pass+'6.png'"]
[chara_face name="player_mt" face="r1" storage="&tf.pass+'7.png'"]
[chara_face name="player_mt" face="r2" storage="&tf.pass+'8.png'"]
[chara_face name="player_mt" face="t0" storage="&tf.pass+'9.png'"]
[chara_face name="player_mt" face="t1" storage="&tf.pass+'10.png'"]
[chara_face name="player_mt" face="t2" storage="&tf.pass+'11.png'"]

;キャラの方向-------------------------------------------
[macro name="direction" ]
    [iscript ]
    if(tf.hoge=='T'){tf.face='t1'; if(tf.face==tf.facedic&&f.ginfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y}};
    if(tf.hoge=='R'){tf.face='r1'; if(tf.face==tf.facedic&&f.ginfo in [0,,2]){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     }};
    if(tf.hoge=='B'){tf.face='b1'; if(tf.face==tf.facedic&&f.ginfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y}};
    if(tf.hoge=='L'){tf.face='l1'; if(tf.face==tf.facedic&&f.ginfo in [0,,2]){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     }};
    [endscript ]

    ;現在値+進行方向1マスの情報を取得する
    ;現在位置を取得(画像中心から左上に位置を修正)
    @eval exp="tf.cpos['x']=f.pc.ps.x;tf.cpos['y']=f.pc.ps.y;" 
    ;現在位置を座標に変換する
    [crimas axis="x"]
    [crimas axis="y"]
    ;座標はtf.loc.x,tf.loc.y

    ;tf.faceが前回と異なる場合は振り向くだけ
    ;tf.faceが前回と同じ場合は以下の通り動く
    [eval exp="tf.istn=tf.face!=tf.facedic" ]
    [chara_mod cond="tf.istn" name="player_mt" face="&tf.face" time="50" wait="false" ]
    [chara_move cond="!tf.istn" name="player_mt" left="&(f.pc.ps.x===0)?'0':f.pc.ps.x" top="&(f.pc.ps.y===0)?'0':f.pc.ps.y" anim="true" time="200"  ]
/*

    [dialog text="&tf.istn+''" ]
    [if exp="tf.face!=tf.facedic" ]
    [chara_mod name="player_mt" face="&tf.face" time="50" wait="false" ]
    ;進行先が進行不可の場合移動しない
    [elsif exp="f.ginfo===1 || f.ginfo===3" ]
    ;進行できないSEを入れる
        [if exp="f.ginfo===3" ]
        [dialog text="進行方向が3なので表示" ]
        [else]
        [dialog text="進行方向が1。壁。"]
        [endif ]
    [else ]
    [chara_move name="player_mt" left="&(f.pc.ps.x===0)?'0':f.pc.ps.x" top="&(f.pc.ps.y===0)?'0':f.pc.ps.y" anim="true" time="200"  ]
    [endif ]
            */

    ;[dialog text="&tf.facedic+'//'+tf.face" ]
    @eval exp="tf.facedic=tf.face"

[endmacro ]
;-------------------------------------------------------
;-------------------------------------------------------


;ボタンを押したあとの動作-------------------------------------------
[macro name="get_loc"]

;現在位置を取得(画像中心から左上に位置を修正)
@eval exp="tf.cpos['x']=f.pc.ps.x;tf.cpos['y']=f.pc.ps.y;" 
;現在座標を取得
[crimas axis="x"]
[crimas axis="y"]
[ptext layer="0" color="red"  name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="0"  overwrite="true"]
[ptext layer="0" color="blue"  name="c"  text="&'現在位置はX='+tf.cpos.x+',Y='+tf.cpos.y" x="600" y="50"  overwrite="true"]
[endmacro]

;現在地を取得
;-------------------------------------------------------
;イベント実行

[macro name="trgev" ]
/*
進行方向にイベントがある場合処理
f.ginfoが0-3のときそれぞれの効果を変更する。
  - 0…通過可能、何も発生しない。　処理済
  - 1…通行不可。現在値に隣接している場合そちらの方向へ動けない。 処理済
  - 2…イベント発生0。通過したときに発生する　動きは処理済
  - 3…イベント発生1。現在値に隣接している場合、そちらを向いてボタンで発生。1と合わせる
*/

;このとき、向きを変えただけの時は発火しない

;前のときと後ろの時で2パターン用意
;現在地と一致するイベントが発火する。
[mindev cond="f.ginfo===2&&!tf.istn&&!tf.istrg&&tf.hoge=='T'"]
[mindev cond="f.binfo===2&&!tf.istn&&!tf.istrg&&tf.hoge=='B'"]
;現在地+進行予定方向+1の座標と一致するイベントがボタンを押すと発火する。
[objev cond="f.ginfo===3&&!tf.istn&&!tf.istrg&&tf.hoge=='T'"]
[objev cond="f.binfo===3&&!tf.istn&&!tf.istrg&&tf.hoge=='B'"]
[endmacro ]

;イベント実行
;-------------------------------------------------------
;現在地の周辺を取得、進行方向を取得
[macro name="get_arnd" ]

[iscript ]
//現在地の四方の数値を出す
tf.loc_t=f.map.bsc.loc[tf.loc.x][tf.loc.y-1]
tf.loc_r=f.map.bsc.loc[tf.loc.x+1][tf.loc.y]
tf.loc_b=f.map.bsc.loc[tf.loc.x][tf.loc.y+1]
tf.loc_l=f.map.bsc.loc[tf.loc.x-1][tf.loc.y]

//進行方向の変数を入れる
if(tf.hoge=='T')f.ginfo=tf.loc_t;
if(tf.hoge=='R')f.ginfo=tf.loc_r;
if(tf.hoge=='B')f.ginfo=tf.loc_b;
if(tf.hoge=='L')f.ginfo=tf.loc_l;

[endscript ]
[ptext layer="0" color="green" name="d" text="&'周辺イベント'+tf.loc_t+tf.loc_r+tf.loc_b+tf.loc_l" x="600" y="100" overwrite="true"       ]
;[dialog text="&'周辺イベント'+tf.loc_t+tf.loc_r+tf.loc_b+tf.loc_l" ]
/*
現在は、移動した先で現在値の進行方向先にイベントがあるかを判定している。
現在値+進行方向＝＝イベント設定座標の場合起動

機能を4つ作る
  - 0…通過可能、何も発生しない。
  - 1…通行不可。現在値に隣接している場合そちらの方向へ動けない。
  - 2…イベント発生0。通過したときに発生する
  - 3…イベント発生1。現在値に隣接している場合、そちらを向いてボタンで発生。1と合わせる

ボタンを押したあとの動作を増やす
0.現在値の四方のイベントを調べる
1.押したボタンの方向を向いていない場合はそちらへ向く　OK
    .進行しようとしている方向に進行不可イベントがある場合ボタンを表示しない
    .進行ボタンの代わりに「調べる」ボタンが表示される
2.押したボタンと同じ方向を向いている場合は1歩前に進む
    .進んで踏んだら発火するイベントを進行
3.0に戻る
*/

[endmacro ]

[return]
