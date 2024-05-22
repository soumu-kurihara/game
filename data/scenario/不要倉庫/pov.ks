/*
一人称視点
3Dと呼ばれているモノ。
そのマクロのまとめ。
*/

;画像を読み込む
[iscript ]
    tf.pass='data/bgimage/tare/'
    tf.locx=['d','e']
    //tf.locy=[1-9]
    tf.dic=['b','l','r','t']
    tf.prldbg=[]
    for (let i=0;i<=71;i++){
        for (let l=0;l<=1;l++){
            for (let j=1;j<=9;j++){
                for (let k=0;k<=3;k++){
            tf.prldbg[i]=tf.pass+tf.locx[l]+l+tf.dic[k]+'.jpg';
                }
            }
        }
    }

    //初期位置座標向きを登録
    f.povx='d'
    f.povy='1'
    f.povloc='b' //いままでだとtf.faceでtrbl
    tf.imgnm=f.povx+f.povy+f.povloc
[endscript ]

[preload storage="&tf.prldbg"]

;最初に表示させる画像を登録する
[macro name="entbg" ]
    [bg storage="&'tare/'+tf.imgnm+'.jpg'" time="50"]
[endmacro ]
;-------------------------------------------

;タレ倉庫のマップを登録する
[iscript ]
    f.map['tare']=[]
    f.map.tare['loc']=[]

    for(let i=1;i<=6;i++){
        f.map.tare.loc[i]=[];
        for(let l=1;l<=9;l++){
            f.map.tare.loc[i][l]=0; //[1,1]~[6,9]までを0で埋める
        };
    };

    //タレ倉庫の外枠の不可侵領域(1)を設定する。
    //[0,0~10],[0~7,0],[7,0~10],[0~7,10]

    f.map.tare.loc[0]=[];
    f.map.tare.loc[7]=[];

    for (let i=0;i<=10;i++){
    f.map.tare.loc[0][i]=1;
    f.map.tare.loc[7][i]=1;
    };
    for(let i=0;i<=7;i++){
        f.map.tare.loc[i][0]=1;
        f.map.tare.loc[i][10]=1;
    };


    //進行不可の壁を作成(1)
    //オブジェクトのサイズを指定、左上を基準に置き換え

    //szx=3 ; szy=9; lcx=1 ; lcy=1;

    function place(szx,szy,lcx,lcy){
    for(let i=0;i<=szx-1;i++){
        for(let l=0;l<=szy-1;l++){
            f.map.tare.loc[lcx+i][lcy+l]=1;
        };
    }};

    //objのサイズX,Y、配置座標X,Y
    place(3,9,1,1);
    place(1,9,6,1);
[endscript ]
;-------------------------------------------

;ボタンを押したときの動作を切り替える
/*
- 現在地+向いている方向の背景に切り替える
- 上ボタンを押すと前に進む
    -左右を押すと右左に振り向く
    -下ボタンを押すと下がる
*/

;これはただ向いている方向の画像を変えるだけ
[macro name="cngbg" ]
    [iscript ]
    tf.pass='tare/';
    tf.cnga1=[,'a','b','c','d','e','f','g','h','i'];

    //f.povloc=現段階で向いている方向(trbl)
    if(f.povloc==f.dir[0])tf.dir='t';
    if(f.povloc==f.dir[1])tf.dir='r';
    if(f.povloc==f.dir[2])tf.dir='b';
    if(f.povloc==f.dir[3])tf.dir='l';

    if(tf.loc.x===0)tf.loc.x=4;//初期値
    [endscript ]

    ;背景画像切り替え
    [bg storage="&tf.pass+tf.cnga1[tf.loc.x]+tf.loc.y+tf.dir+'.jpg'" time="50"]
    ;出ている画像名の表示(デベ)
    [ptext layer="0" color="red" name="e"  x="600" y="500"   text="&tf.cnga1[tf.loc.x]+tf.loc.y+tf.dir+'.jpg'"   overwrite="true"]

[endmacro ]

;POV用に作る
;T=前RL=左右振り向き(背景切り替え)B=下がる
;画像の切り替えではなく、座標の移動のみ。
[macro name="directionpov" ]
/*
動きだけを考える
R,Lが押されたとき、進行方向が切り替わるが動かない。
T,Bが押されたときに起動。周りの数字により動けるかどうかを判定する。
*/
    [iscript ]
        //Rの時、t->r->b->l->t(右回転)　Lの時左回転にする
        var n
            f.dir=['t','r','b','l'] //これは一度定義しちゃえばいいので別のとこへ
            //現在の配列番号を記録
            for (n=0;n<=3;n++){
                if(f.povloc==f.dir[n])break;
            };
            //右回転と左回転。数字が一定以上以下の時ループさせる。
            if(tf.hoge=='R')n=n+1; if(tf.hoge=='L')n=n-1;
            if(n>=4)n=0; if(n<=-1)n=3;

            //写真呼出パーツの1つ。現段階で向いている方向。(cngbg)
            f.povloc=f.dir[n]

        //ボタンを押したとき、前の位置から動いたかを判定(LRを押したかどうか)
        //f.map.bsc.loc[tf.loc.x][tf.loc.y] //tf.locが現在地座標
        f.ismov=f.thispo==String(tf.loc.x+'.'+tf.loc.y);
        if(!f.ismov)f.thispo=String(tf.loc.x+'.'+tf.loc.y);
        //イベント発火condに使用。
        tf.istrg=tf.hoge=='R'&&f.ismov || tf.hoge=='L'&&f.ismov

        //上か下ボタンを押したときに、マスのサイズ分その方向へ移動する
            //f.dir(n)でボタンを押した後の方角がわかるので、その方角へ移動。(f.povlocに替えた方がいいかもしれない)
            //Tは矢印上ボタンの処理
            if(tf.hoge=='T'&&f.dir[n]=='t'&&f.ginfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y};
            if(tf.hoge=='T'&&f.dir[n]=='r'&&f.ginfo in [0,,2]){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     };
            if(tf.hoge=='T'&&f.dir[n]=='b'&&f.ginfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y};
            if(tf.hoge=='T'&&f.dir[n]=='l'&&f.ginfo in [0,,2]){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     };
            //Bのとき、上の移動向きを逆転させる
            if(tf.hoge=='B'&&f.dir[n]=='t'&&f.binfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y+=f.sq.y};
            if(tf.hoge=='B'&&f.dir[n]=='r'&&f.binfo in [0,,2]){f.pc.ps.x-=f.sq.x ,f.pc.ps.y+=0     };
            if(tf.hoge=='B'&&f.dir[n]=='b'&&f.binfo in [0,,2]){f.pc.ps.x+=0      ,f.pc.ps.y-=f.sq.y};
            if(tf.hoge=='B'&&f.dir[n]=='l'&&f.binfo in [0,,2]){f.pc.ps.x+=f.sq.x ,f.pc.ps.y+=0     };

        //方角を記録
        f.npos=f.dir[n];
    [endscript ]

    ;現在位置を取得(画像中心から左上に位置を修正)
    @eval exp="tf.cpos['x']=f.pc.ps.x;tf.cpos['y']=f.pc.ps.y;" 
    ;現在位置を座標に変換する
    [crimas axis="x"]
    [crimas axis="y"]
    ;座標はtf.loc.x,tf.loc.y
    [ptext layer="0" color="red"  name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="0"  overwrite="true"]
    [ptext layer="0" color="blue"  name="c"  text="&'現在位置はX='+tf.cpos.x+',Y='+tf.cpos.y" x="600" y="50"  overwrite="true"]
    [ptext layer="0" color="yellow"  name="f"  text="&'動く力はX='+f.pc.ps.x+',Y='+f.pc.ps.y" x="600" y="150"  overwrite="true"]
[endmacro ]

[macro name="get_arndpov" ]
        [iscript ]
        //現在地の四方の数値を出す
        tf.loc_t=f.map.tare.loc[tf.loc.x][tf.loc.y-1]
        tf.loc_r=f.map.tare.loc[tf.loc.x+1][tf.loc.y]
        tf.loc_b=f.map.tare.loc[tf.loc.x][tf.loc.y+1]
        tf.loc_l=f.map.tare.loc[tf.loc.x-1][tf.loc.y]

        //進行方向の変数を入れる(f.ginfo)。180度逆も入れる(f.binfo)　==イベント変数0-3
        if(f.npos=='t'){f.ginfo=tf.loc_t,f.binfo=tf.loc_b};
        if(f.npos=='r'){f.ginfo=tf.loc_r,f.binfo=tf.loc_l};
        if(f.npos=='b'){f.ginfo=tf.loc_b,f.binfo=tf.loc_t};
        if(f.npos=='l'){f.ginfo=tf.loc_l,f.binfo=tf.loc_r};
        [endscript ]
    [ptext layer="0" color="green" name="d" text="&'周辺イベント'+tf.loc_t+tf.loc_r+tf.loc_b+tf.loc_l" x="600" y="100" overwrite="true"       ]
    [ptext layer="0" color="violet" name="g" text="&'前のイベント'+f.ginfo" x="600" y="200" size="50"  overwrite="true"       ]
    [ptext layer="0" color="aqua" name="h" text="&'後のイベント'+f.binfo" x="600" y="300" size="50"  overwrite="true"       ]
[endmacro]

[return ]

[s ]

/*
f.ginfo //現在地+1先の座標の数字
f.map.bsc.loc[tf.loc.x][tf.loc.y] //tf.locが現在地座標

初手位置はd1下向き
f.map.bsc.loc[4][1]
で下を向いているから
f.map.bsc.loc[4][1]['b']
でd1b.jpgを召喚できればいい

*/