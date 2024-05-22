/*
rpgのようにキャラクターを操作する
*/
[cm  ]
[clearfix]
[start_keyconfig]

[freeimage layer="base"]

;操作ボタン(あとでキーに割り当てる)
@eval exp="tf.hoge=''" 
[macro name="arbtn" ]
[button name="%name" graphic="%gra" x="%x" y="%y" width="90" height="90" exp="tf.hoge=preexp" preexp="%px" fix="true" target="*ahead"  ]
[endmacro ]

[arbtn name="arT" gra="arT.png" x="153.6697" y="414.9908" px="'T'"]
[arbtn name="arR" gra="arR.png" x="&153.6697+90" y="&414.9908+90" px="'R'"]
[arbtn name="arB" gra="arB.png" x="&153.6697+0" y="&414.9908+90+90" px="'B'"]
[arbtn name="arL" gra="arL.png" x="&153.6697-90" y="&414.9908+90" px="'L'"]

;タイトルに戻るボタン
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]


;1マスのサイズ
[iscript]
f.sq=[]
f.sq['x']=$(window).width()/19.5555691358119//65.4545
f.sq['y']=$(window).height()/11.0000076388942//65.4545

//現在位置用の変数宣言
tf.cpos=[]
//前後左右の位置の変数宣言
tf.adps=[]
//現在座標の変数宣言
tf.loc=[]
tf.loc['x']=0
tf.loc['y']=0
[endscript ]

;マスの座標作成
;XとYが特定の数値の範囲内だったら座標を名付ける
;※ただし現在、100%表示でないと不具合発生。
[macro name="crimas" ]
[iscript ]
if(mp.axis=='x')tf.lup=$(window).width()*0.21875 //280; //正方形マップなので左上のX初期位置
if(mp.axis=='y')tf.lup=0; //左上のY初期位置

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
    case tf.lup+f.sq[mp.axis]*9<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*9+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=10;    break;
    case tf.lup+f.sq[mp.axis]*10<=tf.cpos[mp.axis] && tf.cpos[mp.axis]<=tf.lup+f.sq[mp.axis]*10+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=11;    break;
        default:
        alert('X該当なし:'+(tf.lup+f.sq[mp.axis]*5)+'//'+tf.cpos[mp.axis]); break;
}
[endscript ]
[endmacro]

;操作キャラ登録(チップ)
[chara_config effect="jswing" ]
[chara_new name="player" storage="../image/arB.png" jname="プレイヤー" ]
[chara_face name="player" face="T" storage="../image/arT.png" ]
[chara_face name="player" face="R" storage="../image/arR.png" ]
[chara_face name="player" face="B" storage="../image/arB.png" ]
[chara_face name="player" face="L" storage="../image/arL.png" ]

;キャラの方向
[macro name="direction" ]
    [iscript ]
    if(tf.hoge=='T') {tf.face='T' ,tf.drctT='-='+f.sq.y ,tf.drctL='+='+0};
    if(tf.hoge=='R') {tf.face='R' ,tf.drctT='+='+0 ,tf.drctL='+='+f.sq.x};
    if(tf.hoge=='B') {tf.face='B' ,tf.drctT='+='+f.sq.y ,tf.drctL='+='+0};
    if(tf.hoge=='L') {tf.face='L' ,tf.drctT='+='+0 ,tf.drctL='-='+f.sq.x};
    [endscript ]

    [chara_mod name="player" face="&tf.face" time="50" wait="false" ]
    [chara_move name="player" top="&tf.drctT" left="&tf.drctL"  anim="true" time="200"  ]
[endmacro ]

;イベントの位置
[iscript ]
f.event=[]
f.event[0]=[]
/*
//入口場所'入口場所'Y9X5
f.event[0]=[f.sq.x*5,f.sq.y*9]
//面談'面談'Y5X8
f.event[1]=[f.sq.x*8,f.sq.y*5]
//'質問'Y4X2
f.event[2]=[f.sq.x*2,f.sq.y*4]
//'ビュー'Y1X5
f.event[3]=[f.sq.x*5,f.sq.y*1]
*/
//入口場所'入口場所'Y9X5
f.event[0]=[6,10]
//面談'面談'Y5X8
f.event[1]=[9,6]
//'質問'Y4X2
f.event[2]=[3,5]
//'ビュー'Y1X5
f.event[3]=[6,2]

tf.map=`
入口-6,10
面談-9,6
質問-3,5
ビュー-6,2
`
[endscript ]

[ptext layer="0" name="b"  text="&tf.map" x="600" y="100"  overwrite="true"]

[macro name="notic"]
[dialog text="この先イベント0アリ"]
[endmacro ]

;--------------------------ここから画面表示

[chara_show name="player" top="&720-90" time="50" ]
[s ]

*ahead
[direction]
;現在位置を取得
[iscript ]
//tf.cpos['x']=$('.player').offset().left-$('.player').width()/2;
//tf.cpos['y']=$('.player').offset().top-$('.player').height()/2;
tf.cpos['x']=$('.player').position().left-$('.player').width()/2;
tf.cpos['y']=$('.player').position().top-$('.player').height()/2;
//前後左右の位置も取得
//今これ使ってない
/*
tf.adps['T']=tf.cpos.y+f.sq.y
tf.adps['R']=tf.cpos.x+f.sq.x
tf.adps['B']=tf.cpos.y-f.sq.y
tf.adps['L']=tf.cpos.x-f.sq.x
*/


//これらの位置とイベントの位置がないか調べる
//if(tf.adps.T<=f.event[0][1]+f.sq.y/2&&tf.adps.T>f.event[0][1]-f.sq.y/2)alert("次のX軸にイベントがあるよ");

//上ボタンが押されたとき、その上にイベントがあるか調べる
//イベントの数だけループして調べる。
//if(Math.round(tf.adps.T)==Math.round(f.event[1][1]))alert('イベント1はこの次');
//if(Math.floor(tf.adps.T*Math.pow(10,-1))/Math.pow(10,-1)==Math.floor(f.event[1][1]*Math.pow(10,-1))/Math.pow(10,-1))alert('イベント1はこの次');
/*
for (let i=0; i < 4; i++){

if(Math.round(tf.adps.T)==Math.round(f.event[i][1])){
    alert("次のX軸にイベントがあるよ");
    break;
    }
alert(i);
}
*/

//alert(Math.floor(tf.adps.T*Math.pow(10,-1))/Math.pow(10,-1)+'//'+Math.floor(f.event[1][1]*Math.pow(10,-1))/Math.pow(10,-1));


//alert(JSON.stringify(tyrano.plugin.kag.tag.chara_move.player))
[endscript ]
;現在座標を取得
[crimas axis="x"]
[crimas axis="y"]
[ptext layer="0" name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="0"  overwrite="true"]

;進行方向にイベントがある場合処理


[iscript ]

for(let i=0 ;i<4;i++){
//上ボタンが押されたときの処理
if(tf.hoge=='T')if(tf.loc.y-1==f.event[i][1]&&tf.loc.x==f.event[i][0]){alert('上にイベント'+i+'があるよ');break;}// notic;//
//右ボタンが押されたときの処理
if(tf.hoge=='R')if(tf.loc.x+1==f.event[i][0]&&tf.loc.y==f.event[i][1]){alert('右にイベント'+i+'があるよ');break;}// notic;//
//下ボタンが押されたときの処理
if(tf.hoge=='B')if(tf.loc.y+1==f.event[i][1]&&tf.loc.x==f.event[i][0]){alert('下にイベント'+i+'があるよ');break;}// notic;//
//左ボタンが押されたときの処理
if(tf.hoge=='L')if(tf.loc.x-1==f.event[i][0]&&tf.loc.y==f.event[i][1]){alert('左にイベント'+i+'があるよ');break;}// notic;//
};


[endscript ]


[return ]
[s ]


*gotitle
[dialog type="confirm" text="タイトルに戻りますか？" target="*exit"  ]
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

[s ]

*exit
[cm ]
[clearfix ]
[clearstack ]
[freeimage layer="0"]
[chara_hide_all time="50"]
[chara_delete name="player"]
[jump storage="title.ks"]

[s ]

作業メモ
・ボタンを押してキャラの向きをfaceで変更。
・向きを変えた時、1マス分その方向に向かう
・画面端の場合移動はしない。

・現在位置を確認する
