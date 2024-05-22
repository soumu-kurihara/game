/*
mov.ksとpov.ksの統合



movの中にpovとtpp(三人称視点)があるイメージ
mov
┗pov
┗tpp

*/

;window幅を変更する度に再変更させる
[iscript]
$(window).resize(function(){
f.sq=[]
f.sq['x']=$(".grid").width();
f.sq['y']=$(".grid").width();


//現在値も走らせた方がいいかも

});
[endscript]
;-------------------------------------------
;-------------------------------------------
;# 共通

;## 操作ボタン-------------------------------------------

;###操作ボタン情報を登録
[iscript ]
f.vec='' //力を加えるベクトル(Tを押したらT方向に曲げる力)
f.btnsz=90 //正方形ボタンのWHサイズ
f.btnTx=153.6697 //TボタンのX位置
f.btnTy=414.9908 //TボタンのY位置
[endscript ]
[macro name="arbtn" ]
[button name="%name" graphic="%gra" x="%x" y="%y" width="&f.btnsz" height="&f.btnsz" exp="f.vec=preexp" preexp="%px" fix="true" target="*ahead"  ]
[endmacro ]

;### 操作ボタンを表示
[macro name="crbtn" ]
    [arbtn name="arT,ar" gra="arT.png" x="&f.btnTx+0"  y="&f.btnTy+0"     px="'T'"]
    [arbtn name="arR,ar" gra="arR.png" x="&f.btnTx+90" y="&f.btnTy+90"    px="'R'"]
    [arbtn name="arB,ar" gra="arB.png" x="&f.btnTx+0"  y="&f.btnTy+90+90" px="'B'"]
    [arbtn name="arL,ar" gra="arL.png" x="&f.btnTx-90" y="&f.btnTy+90"    px="'L'"]
[endmacro ]
;## 座標の登録-------------------------------------------

;### 1マスのサイズ

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
//↑sleepgameで消える

//イベント発生用にplace内容を記録
tf.thismap=[]
[endscript ]

;### マスの座標作成
;XとYが特定の数値の範囲内だったら座標を名付ける
[macro name="crimas" ]
[iscript ]
if(mp.axis=='x')tf.lup=f.sq.x*3.5 //280; //正方形マップなので左上のX初期位置
if(mp.axis=='y')tf.lup=0 //左上のY初期位置

//alert('ok');

//Y(f.pc.ps.y)が720のとき一致しないのはなんで？
//f.sqはいまんとこ両方80

//case 初期値(左上)から数えてN番目のマス <＝ 現在値 ||でありさらに|| 現在値 <= 初期値から数えてN+1番目-1pxのマスの間である
switch (true){
    case tf.lup+f.sq[mp.axis]*0<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*0+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=1;    break;
    case tf.lup+f.sq[mp.axis]*1<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*1+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=2;    break;
    case tf.lup+f.sq[mp.axis]*2<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*2+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=3;    break;
    case tf.lup+f.sq[mp.axis]*3<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*3+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=4;    break;
    case tf.lup+f.sq[mp.axis]*4<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*4+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=5;    break;
    case tf.lup+f.sq[mp.axis]*5<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*5+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=6;    break;
    case tf.lup+f.sq[mp.axis]*6<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*6+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=7;    break;
    case tf.lup+f.sq[mp.axis]*7<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*7+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=8;    break;
    case tf.lup+f.sq[mp.axis]*8<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*8+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=9;    break;
    case tf.lup+f.sq[mp.axis]*9<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*9+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=10;    break;
    case tf.lup+f.sq[mp.axis]*10<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*10+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=11;    break;
    case tf.lup+f.sq[mp.axis]*11<=f.pc.ps[mp.axis] && f.pc.ps[mp.axis]<=tf.lup+f.sq[mp.axis]*11+f.sq[mp.axis]-1:
        tf.loc[mp.axis]=12;    break;

        default:
        alert('f.pc.ps.x=='+f.pc.ps.x+'//f.pc.ps.y=='+f.pc.ps.y)
        alert('X該当なし:'+(tf.lup)+'//'+(f.sq[mp.axis])+'//'+f.pc.ps[mp.axis]); break;
        //f.sqが80(グリッドサイズ固定)、f.pc.psが0
}
[endscript ]
[endmacro]

;## 画像読み込み-------------------------------------------

;## マップ作製-------------------------------------------

;### マップ画像読み込み/初期位置登録

;画像名の生成ルールが定まっていないので改変するかも。
[macro name="map_load" ]
    [iscript ]
        var pass,x0,x1,y0,y1;
        var locxl,locxr;
        //マップごとのxyの大きさを呼び出す
        if(mp.name=='tare'){pass='tare',x0='a',x1='f',y0=1,y1=9};
        if(mp.name=='ent1'){pass='ent1',x0='a',x1='c',y0=1,y1=12}
        if(mp.name=='ent1ttp'){pass='none',x0='a',x1='l',y0=1,y1=12}
        if(mp.name=='ent1ttp9'){pass='none',x0='a',x1='i',y0=1,y1=9}
            tf.pass='data/bgimage/'+pass+'/';
            tf.locx=[,'a','b','c','d','e','f','g','h','i','j','k','l']//最大で69(a~bq)、a=1にした
            locxl=tf.locx.indexOf(x0);
            locxr=tf.locx.indexOf(x1);
            //tf.locy=[1-9]
            tf.dic=['b','l','r','t'];
            tf.prldbg=[];

        //画像が存在する範囲を作成する
/*
        でもこれ場所によってちぐはぐするだろうからなくてもいいかも。

        let i=0
            for (let l=locxl;l<=locxr;l++){
                for (let j=y0;j<=y1;j++){
                    for (let k=0;k<=3;k++){
                tf.prldbg[i]=tf.pass+tf.locx[l]+j+tf.dic[k]+'.jpg';
                i++;
                    }
                }
            }
*/
            f.locx=[locxl,locxr]
            f.mapsz=[x0,x1,y0,y1]
    [endscript ]
    ;指定した画像を読み込ませる
    ;[preload storage="&tf.prldbg"]
[endmacro ]

;### マップの形を登録

[macro name="map_bld" ]

    [iscript ]
        f.map[mp.name]=[];
        f.map[mp.name]['loc']=[];

    function place(szx,szy,lcx,lcy,n){
        if(isNaN(n) || n === "")n=1;//nが何も入ってない場合1にする
        for(let i=0;i<=szx-1;i++){
            //f.map[mp.name].loc[lcx+i]=[]; 消す意味がない(起動順番が入れ替わったので)
            for(let l=0;l<=szy-1;l++){
                f.map[mp.name].loc[lcx+i][lcy+l]=n;
            }
        }
        //(isNaN(tf.o) || tf.o === "")? tf.o=0*1: tf.o=tf.o+1;
        tf.o=tf.o+1;
        var o=tf.o
         //イベント用にここでも使う
            tf.thismap[o]=[];
            tf.thismap[o][1]=szx;
            tf.thismap[o][2]=szy;
            tf.thismap[o][3]=lcx;
            tf.thismap[o][4]=lcy;
            tf.thismap[o][5]=n;
            
        };


    //マップ座標に変数を入れる。[0~3]
        var locxl=f.locx[0],locxr=f.locx[1]//a,fなので1,6
        var x0=f.mapsz[0],x1=f.mapsz[1],y0=f.mapsz[2],y1=f.mapsz[3]//a,f,1,9
        
        for(let i=locxl;i<=locxr;i++){
            f.map[mp.name].loc[i]=[];
            for(let l=y0;l<=y1;l++){
                f.map[mp.name].loc[i][l]=0; //[1,1]~[6,9]までを0で埋める
            };
        };

        //alert(locxl+'//'+locxr)

        //マップの外枠の不可侵領域(1)で埋める。
        //[0,0~10],[0~7,0],[7,0~10],[0~7,10]
        let fx0,fx1,fy0,fy1;
        fx0=locxl-1;fx1=locxr+1;fy0=y0-1;fy1=y1+1;//0,7,0,10
        f.map[mp.name].loc[fx0]=[];//0(x)
        f.map[mp.name].loc[fx1]=[];//7(x)

        for (let i=fy0;i<=fy1;i++){
            f.map[mp.name].loc[fx0][i]=1;
            f.map[mp.name].loc[fx1][i]=1;
        };
        
        for(let i=fx0;i<=fx1;i++){
            f.map[mp.name].loc[i][fy0]=1;
            f.map[mp.name].loc[i][fy1]=1;
        };


    let posx,posy,posz
    //ここで部屋ごとの設定
        if(mp.name=='tare'){
            //初期位置
            posx='d';posy='1';posz='b';
            //オブジェクトのサイズを指定、左上を基準に置き換え

            //objのサイズX,Y、配置座標X,Y,イベントナンバー(ない場合1)
            place(3,9,1,1);
            place(1,9,6,1);
        };
        if(mp.name=='ent1'){
            posx='a';posy='2';posz='r'
            place(1,3,1,4);
            place(1,3,3,4);
            place(1,1,3,12);
        };
        if(mp.name=='ent1ttp'){
            posx='a';posy='2';posz='r'
            place();//ちょっとあとで
        };
        if(mp.name=='ent1ttp9'){
            posx='a';posy='2';posz='r'
            place(1,2,7,4,3);
            place(1,2,9,4,3);
            place(1,1,9,9);
            place(1,1,6,2,2);
            place(1,1,6,8,2);
        };

        //リセットポイントが設定されている場合こちらを優先
        if(typeof f.reps.x!=="undefined"){posx=f.reps.x,posy=f.reps.y,posz=f.reps.z}


        //初期位置座標向きを登録
        f.povx=posx
        f.povy=posy
        f.povz=posz //いままでだとtf.faceでtrbl
        tf.imgnm=f.povx+f.povy+f.povz //f.povlocから変更
/*
        //キャラの立ち位置
        f.pc.ps.x=tf.locx.indexOf(posx)
        f.pc.ps.y=posy
*/
        f.locx=[locxl,locxr]
        //f.mapsz=[x0,x1,y0,y1]

    [endscript ]

    ;最初に表示させる画像を表示
    [bg storage="&mp.name+'/'+tf.imgnm+'.jpg'" time="50" cond="f.isfps"]
[endmacro ]
/*
[iscript ]    
    //進行不可の壁を作成(1)
    //オブジェクトのサイズを指定、左上を基準に置き換え
    //nm='tare' ;szx=3 ; szy=9; lcx=1 ; lcy=1;

    var place = (nm,szx,szy,lcx,lcy)=>{
    for(let i=0;i<=szx-1;i++){
        for(let l=0;l<=szy-1;l++){
            f.map[nm].loc[lcx+i][lcy+l]=1;
        };
    }};
    
        function place(nm,szx,szy,lcx,lcy){
    for(let i=0;i<=szx-1;i++){
        for(let l=0;l<=szy-1;l++){
            f.map[nm].loc[lcx+i][lcy+l]=1;
        };
    }};
    
[endscript ]
*/
;## 方向制御-------------------------------------------



; [macro name="drc" ]
; TTPの方

; 方向ボタンを押すと、顔が切り替わる力を与える。
; 顔画像が依然と同じ+向いている1歩前の変数が0か2のとき以下が発生
; その方向へ移動の力を与える。
; その後
; キャラ画像の位置の左上の画面位置を取得
; 画面位置から座標に変換
; 顔の向きが前回と異なるか判定
; T：顔の向きが変わる
; F：向いている方向へ移動する
; その後、現在の顔の向きを登録する。

; FPSの方

; RLボタンが押されたとき、画像を切り替えるkeyを発行
; 前回から移動していないかを判定
; F：現在座標を登録
; T+RLが押された：イベント発火TFを登録
; その後
; TかBを押す+向いている方向1歩前または1歩後ろの変数が0，2のとき
; 向いている方向へ進む力を得る
; 向いている方角を記録
; その後
; イマジナリーキャラ画像の位置の左上の画面位置を取得
; 座標に変換

; 画像の切り替えは[cngbg]で。

; -----
; これら方法を統合する

; 1.マクロを細かく切り分ける

; A:人と地図の方角を取得
;     1.方向ボタンを押したときに発火
;     2.どのボタンが押されたのか検知
;     3.リアルキャラクター(RC)がその方向を正面にする。正面にした方向を取得。(chardir)
;     4.正面にした結果、マップ上ではどの方向を向いているのかをイマジナリーキャラクター(IC)が取得。(mapdir)

; B:力を与える
;     力を与えない判定をする。
;         現在座標の上下左右の変数を取得。
;         進行予定の1歩前の変数が0,2以外のとき(FPSの場合は後ろも)
;         このときBの処理は終了する。
;         このとき、イベントが発火しない判定を取得。(iseve)

;     TTPのとき、chardirが前回と同じ場合、mapdirの方向へ力を与える
;     FPSのとき、chardirで背景keyを取得、さらに分岐する。
;         RLが押されたとき、力は与えない
;         TBが押されたとき、mapdirの方向へ力を与える。
;     このとき、条件を満たす場合イベントが発火する判定を取得。(iseve)

; C:結果を反映
;     C-1:画像を切り替える
;         chardirで示す方角にキャラクター画像を変更
;         すでにその方向の場合は無視できる。
;     C-2:動かす
;         mapdirで取得した動力をキャラクターに与える。
;         取得していない場合は動かない。
;         処理後の座標を取得。
;     C-3:イベントの発生
;         発生しない判定をする
;             移動していない場合発生しない(iseve)
;         背景keyを用いて[imgbg]で画像を切り替え

; [endmacro ]

;ボタンを押したあとの処理

[iscript ]
    f.dir=['t','r','b','l']
    f.vec=f.povz //キャラからみて正面にする方角(ベクトル)初期値。
    //f.povz//北が上とした地図でキャラが進もうとしている方角
    f.gridx=[,'a','b','c','d','e','f','g','h','i']//x軸用a=1にした方が都合がいい
    f.iseve=true//イベントが発生するか否か
    f.isfps=false//FPSモードの設定
[endscript ]

;人と地図の方角を取得
[macro name="A" ]
    [iscript ]
    // if(f.isfps==false){
    // //ttpのとき、f.vec=>f.povzにする。
    //     f.povz=f.vec.toLowerCase()
    // }else{
    //fpsのとき以下の処理をする
    //vecのベクトルによりpovzの方向を変える
        //現在の配列番号を記録
        let n;
        for (n=0;n<=3;n++){
            if(f.povz==f.dir[n])break;
        };
        //右回転と左回転。数字が一定以上以下の時ループさせる。
        if(f.vec=='R')n=n+1; if(f.vec=='L')n=n-1;
        if(n>=4)n=0; if(n<=-1)n=3;

        //写真呼出パーツの1つ。現段階で向いている方角。(cngbg)
        f.povz=f.dir[n]
    //};

        //上はFPSのときのみ。TTPの時は愚直に方向を同じにする
    [endscript ]

[endmacro ]

[macro name="B1" ]
;その時のf.ginfo,f.binfoを求める
    [iscript ]
    let n,m,x0,x1,y0,y1;
        n=f.gridx.indexOf(f.povx)*1;
        m=f.povy*1;

    //f.povzは現在キャラクターが向いている向き
    if(f.povz=='t'){x0=x1=n ,y0=m-1 ,y1=m+1 };
    if(f.povz=='r'){x0=n+1  ,x1=n-1 ,y0=y1=m};
    if(f.povz=='b'){x0=x1=n ,y0=m+1 ,y1=m-1 };
    if(f.povz=='l'){x0=n-1  ,x1=n+1 ,y0=y1=m};

    //ボタンを押したときキャラが向いている方角の前後編集
    f.ginfo=f.map[mp.name].loc[x0][y0];//進行予定1マスの変数
    f.binfo=f.map[mp.name].loc[x1][y1];//後退予定1マスの変数
    f.cinfo=f.map[mp.name].loc[n][m];//現在地の変数
    [endscript ]
[endmacro]

;力を与える mp.name
[macro name="B" ]
    @eval exp="tf.name=mp.name" 
;力を与えない判定をする。
    ;現在座標==f.povx,f.povy
    ;現在座標の変数==f.map.tare.loc[i][fy0]
    ;f.ginfoとf.binfoを更新
    [B1 name="&tf.name"]
    /*
    [iscript ]
    let n,m,x0,x1,y0,y1;
        //var locxl=f.gridx[0],locxr=f.gridx[1]
        //f.mapszはそのマップの全体サイズを表すので下のは違う。
        //var x0=f.mapsz[0],x1=f.mapsz[1],y0=f.mapsz[2],y1=f.mapsz[3]

        //n=f.gridx.indexOf(f.povx)*1;
        n=f.gridx.indexOf(f.povx)*1;
        m=f.povy*1;

        //alert('元々いるとこ('+n+','+m+')');
        //alert('座標'+f.povx+f.povy)

        //f.povzは現在キャラクターが向いている向き
        if(f.povz=='t'){x0=x1=n ,y0=m-1 ,y1=m+1 };
        if(f.povz=='r'){x0=n+1  ,x1=n-1 ,y0=y1=m};
        if(f.povz=='b'){x0=x1=n ,y0=m+1 ,y1=m-1 };
        if(f.povz=='l'){x0=n-1  ,x1=n+1 ,y0=y1=m};

        //このとき、y0=2,y1=0のため、0番目を作っていないのでエラーになる。
        //というか登録してるxは数字。1～マップ最大まで。


        //f.map[mp.name].loc[x0]=[];f.map[mp.name].loc[x1]=[];

        //alert('x0='+x0+'//x1='+x1+'//y0='+y0+'//y1='+y1);
        
        //ボタンを押したときキャラが向いている方角の前後編集
        f.ginfo=f.map[mp.name].loc[x0][y0];//進行予定1マスの変数
        f.binfo=f.map[mp.name].loc[x1][y1];//後退予定1マスの変数
        //↑f.binfoが0のはずなのに1が入る
        //突き当りの壁が1のはずだがundefineになる

        //移動前の四方向の座標
        //alert('x前='+x0+'//x後='+x1+'//y前='+y0+'//y後='+y1);

        //alert('g='+f.ginfo+'//b='+f.binfo);
*/
    [iscript ]
//力を与える
        //TTPの場合、前に進むだけ-＞f.povz->f.ginfoを参照
        //FPSの場合、前と後ろに進む->f.vec＝Tのときginfo,Bのときbinfo
        (f.vec=='T'&&f.ginfo in [0,,2]||f.vec=='B'&&f.binfo in [0,,2])?f.iseve=true:f.iseve=false;
       //ttpのとき、TBは関係ない。後ろに歩かないのでf.binfoもいらない。
        (f.isfps==false&&f.ginfo in [0,,2])?f.iseve=true:f.iseve=false;
        //alert(f.iseve+'//'+f.ginfo)
        //イベントを発生させない場合、以下は無視する
        if(f.iseve){
            //進む方向へ動力を与える
            //f.pc.psはキャラの現在位置,f.sqはマスのサイズ
            //tareのときの初期値はｘ600ｙ640
            if(!f.isfps){//ttpのとき
                if(f.vec=='T'&&f.povz=='t'){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y};
                if(f.vec=='R'&&f.povz=='r'){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     };
                if(f.vec=='B'&&f.povz=='b'){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y};
                if(f.vec=='L'&&f.povz=='l'){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     };
            }
            if(f.isfps){//fpsのとき
                if(f.vec=='T'&&f.povz=='t'){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y};
                if(f.vec=='T'&&f.povz=='r'){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     };
                if(f.vec=='T'&&f.povz=='b'){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y};
                if(f.vec=='T'&&f.povz=='l'){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     };
                //Bのとき、上の移動向きを逆転させる
                if(f.vec=='B'&&f.povz=='t'){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y};
                if(f.vec=='B'&&f.povz=='r'){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     };
                if(f.vec=='B'&&f.povz=='b'){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y};
                if(f.vec=='B'&&f.povz=='l'){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     };
            }
        }
        //f.mapsz=[x0,x1,y0,y1]
    [endscript ]
;デベ
    ;[ptext layer="0" color="green" name="d" text="&'周辺イベント'+tf.loc_t+tf.loc_r+tf.loc_b+tf.loc_l" x="600" y="100" overwrite="true"       ]
    ;[ptext layer="0" color="violet" name="g" text="&'前のイベント'+f.ginfo" x="600" y="200" size="50"  overwrite="true"       ]
    ;[ptext layer="0" color="aqua" name="h" text="&'後のイベント'+f.binfo" x="600" y="300" size="50"  overwrite="true"       ]

[endmacro]

;結果を反映
[macro name="C" ]
    @eval exp="tf.name=mp.name" 
    ;画像を切り替える
        ;キャラクターの画像変更,既にその方向の場合は無視する
        ;大文字小文字を区別しないで判定する(異なる場合True)
        [eval exp="tf.istf=f.vec.toUpperCase()!=f.povz.toUpperCase()" ]
        [chara_mod cond="tf.istf" name="player_mt" face="&f.vec.toLowerCase()+'0'" time="50" wait="false" ]

        ;既に向いているのにtrueになる
        ;[dialog text="&tf.istf+'//'+f.vec+'//'+f.povz" ]

    ;キャラクターを動かす
        [chara_move cond="!tf.istf" name="player_mt" left="&(f.pc.ps.x===0)?'0':f.pc.ps.x" top="&(f.pc.ps.y===0)?'0':f.pc.ps.y" anim="true" time="200"  ]
        ;処理後の座標を更新する
        ;現在位置を座標に変換する

        [crimas axis="x"]
        [crimas axis="y"]

        ;povx,povyにそれぞれ入れる
        [iscript ]
            f.povx=f.gridx[tf.loc.x];
            f.povy=tf.loc.y;
            //前回から移動したとき、イベント用位置記憶を初期化
            if(tf.istrs!=f.povx+f.povy)f.reps.x=f.reps.y=f.reps.z=0;
            (tf.istrs!=f.povx+f.povy)?f.istrs=true:f.istrs=false;//移動t,移動してないf
            //移動したかどうかを記録
            tf.istrs=f.povx+f.povy
        [endscript ]



    ;背景を切り替える

        [cngbg name="&tf.name" cond="f.isfps"]
    ;ttpの場合、ここで向いている方向を更新する
        [eval exp="f.povz=f.vec.toLowerCase()" cond="f.isfps==false"]

    ;振り向き終わり止まったあとのginfoとbinfoを更新する。
    [B1 name="&tf.name"]

    ;イベントの発生
    ;進行方向が2か3のときに発生
        [iscript ]
        //ginfoかbinfoを参照にするのかを決める
            if(f.isfps){
                if(f.vec=='T')f.eveid=f.ginfo;if(f.vec=='B')f.eveid=f.binfo;
            }else{
                f.eveid=f.ginfo;
            };
        [endscript ]


    ;座標から何のイベントなのか叩き出す
    ;3はf.gbinfoから、2はf.cinfoと一致するかを調べる
    ;[if exp="f.eveid in [,,2,3]" ]
    ;床から離れるときも発生している。なんとかして。
    [if exp="f.eveid===3||f.cinfo===2" ]
        ;床が0且移動したときは無視する
        [ignore exp="f.cinfo===0&&f.istrs||f.cinfo===2&&!f.istrs" ]
            ;現在座標を記録する
            [iscript ]
                //これだと同じマスのイベントが発生しなくなる
                if(!f.istrs)f.cinfo=0;
                f.reps.x=f.povx
                f.reps.y=f.povy
                f.reps.z=f.povz
            [endscript ]
            ;全体破壊　その場回転(!f.istrs)の時、2を発生させず、destroyも発生させない
            ;[destroy]
            ;2の時ADVモードに入るかわからんのでcmでいいかも。
            [cm]
            ;2を優先して発動させる
            ;[mindev cond="f.cinfo==2"]
            ;動作が被らないように共通キーを作成する。
            @eval exp="if(f.cinfo===2)f.infokey=f.cinfo;"
            ;これが発生するときボタンを消す
            [free name="ar" layer="fix"  cond="f.infokey===2"]
            [call storage="evt/ent1.ks"  cond="f.infokey===2"]



            ;[objev cond="f.eveid==3"]
            @eval exp="if(f.eveid===3)f.infokey=f.eveid;"
            [destroy cond="f.infokey===3"]
            [call storage="evt/ent1.ks"  cond="f.infokey===3"]

            [ignore exp="f.infokey===0"]
                ;もっかい破壊
                [destroy]
                ;全体創造
                [renew]
            [endignore ]
            ;初期化
            @eval exp="f.infokey=0"; 

        [endignore ]
    [endif ]
/*
      [iscript ]
      //移動後のginfobinfoを表示するために存在
            let n,m,x0,x1,y0,y1;

            n=f.gridx.indexOf(f.povx)*1;
            m=f.povy*1;

            //f.povzは現在キャラクターが向いている向き
            if(f.povz=='t'){x0=x1=n ,y0=m-1 ,y1=m+1 };
            if(f.povz=='r'){x0=n+1  ,x1=n-1 ,y0=y1=m};
            if(f.povz=='b'){x0=x1=n ,y0=m+1 ,y1=m-1 };
            if(f.povz=='l'){x0=n-1  ,x1=n+1 ,y0=y1=m};
            
            //ボタンを押したときキャラが向いている方角の前後編集
            f.ginfo=f.map[mp.name].loc[x0][y0];//進行予定1マスの変数
            f.binfo=f.map[mp.name].loc[x1][y1];//後退予定1マスの変数
        [endscript ]
*/
;デベ
    [ptext size="30" bold="true" layer="0" color="red"  name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="400"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="green"  name="c"  text="&'現在位置はX='+f.povx+',Y='+f.povy" x="600" y="450"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="blue"  name="f"  text="&'動く力はX='+f.pc.ps.x+',Y='+f.pc.ps.y" x="600" y="500"  overwrite="true"]
    [ptext layer="0" color="violet" name="g" text="&'前のイベント'+f.ginfo" x="600" y="200" size="50"  overwrite="true"       ]
    [ptext layer="0" color="aqua" name="h" text="&'後のイベント'+f.binfo" x="600" y="300" size="50"  overwrite="true"       ]

[endmacro ]

;-------------------------------------------
;-------------------------------------------
;# TPP

;## 操作キャラクターの登録

[iscript ]
    //操作キャラの色々を登録
    f.pc=[];
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
;ボタンを押しっぱなしにすると画像が切り替わるとかそういうのがあればつけたい

;-------------------------------------------
;-------------------------------------------
;# POV

;## 視点変更による背景変更

[macro name="cngbg" ]
    [iscript ]
        let pass;
        if(mp.name=='tare')pass='tare';//部屋名とフォルダ名が異なる場合のクッション
        if(mp.name=='ent1')pass='ent1';
        tf.pass=pass+'/';
    [endscript ]

    ;背景画像切り替え
    [bg storage="&tf.pass+f.povx+f.povy+f.povz+'.jpg'" time="50"]
    ;出ている画像名の表示(デベ)
    [ptext layer="0" size="35" bold="true" color="red" name="e"  x="600" y="600"   text="&f.povx+f.povy+f.povz+'.jpg'"   overwrite="true"]

[endmacro ]


;-------------------------------------------
;-------------------------------------------
;イベント用マクロ
;-------------------------------------------
;-------------------------------------------

[macro name="knockback"]
    [iscript ]
    //入ってきた方向にベクトルを与える
        if(f.povz=='t')f.pc.ps.y=f.pc.ps.y+1*f.sq.y;
        if(f.povz=='r')f.pc.ps.x=f.pc.ps.x-1*f.sq.x;
        if(f.povz=='b')f.pc.ps.y=f.pc.ps.y-1*f.sq.y;
        if(f.povz=='l')f.pc.ps.x=f.pc.ps.x+1*f.sq.x;
    [endscript ]
    ;キャラクターを動かす
    [chara_move name="player_mt" left="&(f.pc.ps.x===0)?'0':f.pc.ps.x" top="&(f.pc.ps.y===0)?'0':f.pc.ps.y" anim="true" time="200"  ]
    ;移動させた位置を更新
    [crimas axis="x"]
    [crimas axis="y"]
    [iscript ]
        f.povx=f.gridx[tf.loc.x];
        f.povy=tf.loc.y;
        //f.povzは前のまま。
            f.reps.x=f.povx
            f.reps.y=f.povy
            f.reps.z=f.povz
            //移動判定用を更新
            tf.istrs=f.reps.x+f.reps.y
    [endscript ]
[endmacro ]


[return ]
[s ]

/*
作成したマクロ
[arbtn name="arT" gra="arT.png" x="&f.btnTx+0"  y="&f.btnTy+0"     px="'T'"]
[crimas axis="xory"]
[map_load name="部屋名(tare)"]
[map_bld name="部屋名(tare)"]

[a name="tare"]
[b name="tare"]
[c name="tare"]
あとで統合。ボタンを押した後の処理一覧。

[cngbg name="部屋名(tare)"]

[knockback]
移動してきた方向に1マス戻す

*/