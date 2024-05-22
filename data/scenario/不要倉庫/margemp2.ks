/*
現状と、alphaのマクロを統合するために使用。
*/

;最優先==========================

    ;ウィンドウサイズを変更に対応する。
    ;変更のたびにこれが走る。
    [iscript]
        $(window).resize(function(){
        f.sq=[]
        f.sq['x']=$(".grid").width();
        f.sq['y']=$(".grid").width();

        //(現在値も走らせた方がいいかも)

        });
    [endscript]

;/最優先=========================

;準優先==========================
    ;変則する画面サイズ あとでmakeとかに突っ込む
    [image storage="../bgimage/mntsz.png" name="mnt" ]

;/準優先=========================


;===============================
;宣言
;===============================

;一度だけ宣言====================
[iscript ]
    //操作ボタン情報登録
        f.vec='' //力を加えるベクトル(Tを押したらT方向に曲げる力)
        f.btnsz=90 //正方形ボタンのWHサイズ
        f.btnTx=153.6697 //TボタンのX位置
        f.btnTy=414.9908 //TボタンのY位置

    //座標登録
        f.sq=[];
        f.sq['x']=$(".grid").width();f.sq['y']=$(".grid").height();

    //現在位置用の変数宣言
        tf.cpos=[];
    //前後左右の位置の変数宣言
        tf.adps=[];
    //現在座標の変数宣言
        tf.loc=[];
        tf.loc['x']=0;tf.loc['y']=0;
    //イベント発生用にplace内容を記録
        tf.thismap=[]

    //マップ用変数の宣言
        f.mp=[];f.mp['ps']=[];
        f.mp.ps['x']=0;f.mp.ps['y']=0;
        f.msz=[]
        f.msz['x']=$("mnt").width();f.msz['y']=$("mnt").height();
        f.msz['c']=[];
        f.msz.c['x']=f.msz.x/2;f.msz.c['y']=f.msz.y/2;

    //中心点からいくつ外れているかの計測用。使ってないのであとで消す候補
        f.ofst=[];f.ofst['x']=0;f.ofst['y']=0;

    //キャラ<->マップ切り替え時の値記録用の初期登録
        f.nx=[];f.nx['pc']=[];f.nx['mp']=[];
    
    //オブジェクト(キャラかマップ)の最終的な画面上の絶対値(~1280,~720)
        f.obj=[];f.obj['x']=0;f.obj['y']=0;

    //力を加えるE1などで。
    //pmプラスマイナスを収納する。
        f.pm=[];f.pm['x']='';f.pm['y']='';
    //mppsに入れる量
        f.sft=[];f.sft['x']=0;f.sft['y']=0;
    //場合により変化するsftに入れる中身
        f.arsft=['0*1',f.sq.x,f.sq.y];
    //mapbldや方向など
        f.dir=['t','r','b','l']
        f.vec=f.povz //キャラからみて正面にする方角(ベクトル)初期値。
        f.gridx=[,'a','b','c','d','e','f','g','h','i']//x軸用a=1にした方が都合がいい
    //操作キャラクターの登録
        f.pc=[];
        //チップのサイズ
        f.pc['sz']=[];f.pc.sz['x']=80;f.pc.sz['y']=80;
        //位置
        f.pc['ps']=[];f.pc.ps['x']=0;f.pc.ps['y']=0;
        //キャラ登録用pass
        tf.pass='chara/tip/1341/'

[endscript ]
    ;## 操作キャラクターの登録
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

;/一度だけ宣言===================

;マップ切り替え時に変更==========
[iscript]
    //＃マップごとの初期位置を入れる(これはマップごとに切り替える)
        f.nx.pc['x']=f.sq.x*3.5;f.nx.pc['y']=80;
        f.nx.mp['x']=0         ;f.nx.mp['y']=0;

    f.iseve=true//イベントが発生するか否か
    f.isfps=false//FPSモードの設定

[endscript ]

;/マップ切り替え時に変更=========

;===============================
;===============================

;===============================
;マクロ
;===============================

    ;操作ボタンを表示
    [macro name="arbtn" ]
        [button name="%name" graphic="%gra" x="%x" y="%y" width="&f.btnsz" height="&f.btnsz" exp="f.vec=preexp" preexp="%px" fix="true" target="*ahead"  ]
    [endmacro ]
    [macro name="crbtn" ]
        [arbtn name="arT,ar" gra="arT.png" x="&f.btnTx+0"  y="&f.btnTy+0"     px="'T'"]
        [arbtn name="arR,ar" gra="arR.png" x="&f.btnTx+90" y="&f.btnTy+90"    px="'R'"]
        [arbtn name="arB,ar" gra="arB.png" x="&f.btnTx+0"  y="&f.btnTy+90+90" px="'B'"]
        [arbtn name="arL,ar" gra="arL.png" x="&f.btnTx-90" y="&f.btnTy+90"    px="'L'"]
    [endmacro ]

    ;マップ情報(大きさ・画像)を読み込む
    [macro name="map_load" ]
        [iscript ]
            var pass,x0,x1,y0,y1;
            var locxl,locxr;
            //マップごとのxyの大きさを呼び出す
            if(mp.name=='tare'){pass='tare',x0='a',x1='f',y0=1,y1=9};
            if(mp.name=='ent1'){pass='ent1',x0='a',x1='c',y0=1,y1=12};
            if(mp.name=='ent1ttp'){pass='none',x0='a',x1='l',y0=1,y1=12};
            if(mp.name=='ent1ttp9'){pass='none',x0='a',x1='i',y0=1,y1=9};
                tf.pass='data/bgimage/'+pass+'/';
                tf.locx=[,'a','b','c','d','e','f','g','h','i','j','k','l'];//最大で69(a~bq)、a=1にした
                locxl=tf.locx.indexOf(x0);
                locxr=tf.locx.indexOf(x1);
                //tf.locy=[1-9]
                tf.dic=['b','l','r','t'];
                tf.prldbg=[];

            //画像が存在する範囲を作成する
            //preloadを使う場合はこれを有効にする。
            if(f.isfps){
                let i=0
                for (let l=locxl;l<=locxr;l++){
                    for (let j=y0;j<=y1;j++){
                        for (let k=0;k<=3;k++){
                    tf.prldbg[i]=tf.pass+tf.locx[l]+j+tf.dic[k]+'.jpg';
                    i++;
                        }
                    }
                }
            };
                f.locx=[locxl,locxr]
                f.mapsz=[x0,x1,y0,y1]
        [endscript ]
        ;fpsモードの時、指定した画像を読み込ませる
        [preload storage="&tf.prldbg" cond="f.isfps"]
    [endmacro ]

    ;マップイベントを書き込む
    [macro name="map_bld" ]

        [iscript ]
            f.map[mp.name]=[];
            f.map[mp.name]['loc']=[];

            //マップ上にあるイベントを登録する。
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
                let tm=tf.thismap
                //イベント用にここでも使う
                    tm[o]=[] ; tm[o][1]= szx ; tm[o][2]= szy ; tm[o][3]= lcx ; tm[o][4]= lcy ; tm[o][5]= n ;
            };


            //マップ座標に変数を入れる。[0~3]
                var locxl=f.locx[0],locxr=f.locx[1]//a,fなので1,6
                var x0=f.mapsz[0],x1=f.mapsz[1],y0=f.mapsz[2],y1=f.mapsz[3]//a,f,1,9
                
                //マップの範囲全てに0を入れる。
                for(let i=locxl;i<=locxr;i++){
                    f.map[mp.name].loc[i]=[];
                    for(let l=y0;l<=y1;l++){
                        f.map[mp.name].loc[i][l]=0; //[1,1]~[6,9]までを0で埋める
                    };
                };

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
            //

            //部屋ごとのイベントをplaceを使って作成する。
                let posx,posy,posz
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
            f.locx=[locxl,locxr]
        [endscript ]

        ;最初に表示させる画像を表示
        [bg storage="&mp.name+'/'+tf.imgnm+'.jpg'" time="50" cond="f.isfps"]
    [endmacro ]

    ;イベント復帰用のリカバリ
    [macro name="renew" ]
        [glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

        [iscript ]
            //引数で渡す内容を変更
            if(mp.name='ent1ttp9')tf.name=mp.name;tf.str='map_9';
            //初期化
            tf.o=-1
        [endscript ]

        [map_load name="&tf.name"]
        [map_bld name="&tf.name"]

        ;画像らの初期位置
            ;マップを呼び出す(nameを追加)
            [image name="field" visible="true" layer="0" folder="bgimage" storage="&tf.str+'.jpg'" x="&f.nx.mp.x" y="&f.nx.mp.y"  ]
            ;キャラクター(自機)を出現(f.povzの方向で出現させる)
            [chara_show name="player_mt" face="&f.povz+'0'" left="&f.nx.pc.x"  top="&f.nx.pc.y" time="50"]

        ;ボタンを出す
        [crbtn]
    [endmacro]

    ;人と地図の方角を取得
    ;fpsのときは下が下がる、左右が回転ボタン。
    [macro name="A" ]
        [iscript ]
            if(!f.isfps){
            //ttpのとき、f.vec=>f.povzにする。
                //f.povz=f.vec.toLowerCase()
            }else{
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
            };
        [endscript ]

    [endmacro ]

    ;その時のf.ginfo,f.binfoを求める
    [macro name="B1" ]
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

    ;ここのnで端範囲を切り替える
    ;pcps.xyの数値でf.ismvbのT/Fを切り替える。
    ;Eから切り離し。
    [macro name="G"]
        ;条件によってf.ismvbを切り替える
        ;1.画面上の中央十字線をキャラクターが踏んだ時、マップ操作に切り替える。(True)
        ;2.マップの端周辺をキャラクターが踏んだ時、キャラ操作に切り替える。(False)
        ;3.画面上外へキャラクターが移動が可能な時、マップ操作に切り替える。(True)

        ;1.C enterラインを踏んだかどうかf.ismvb=T
        [iscript]
            let CX = f.pc.ps.x==eval(f.sq.x*3.5+f.sq.x*4);
            let CY = f.pc.ps.y==eval(f.sq.y*0+f.sq.y*4);

            (CX||CY)?f.ismvb=true:f.ismvb=false;
        [endscript]

        ;nはここ
        ;2.端のマスの数nの位置にキャラクターがいるとき、f.ismvb=Fにする。
        [iscript]
            /*
                L X初期値<=80*4
                R X最大値>=X最大サイズ-80*4
                T Y初期値<=80*4
                B Y最大値>=Y最大サイズ-80*4

                f.pc.ps.xyがこれらに含まれるかどうかで判定する。
            */
            let ar=f.mapsz,psx=f.pc.ps.x,psy=f.pc.ps.y;
            let X初期値=f.sq.x*3.5,Y初期値=0,X最大値=ar[1]*f.sq.x+X初期値,Y最大値=ar[3]*f.sq.y+Y初期値;
            //上下左右4マスの間を踏んだ時の場合、3にする。
            var n=3;n=n-1;

            let L,L0=X初期値<=psx,L1=X初期値+f.sq.x*n>=psx;
            let R,R0=X最大値>=psx,R1=X最大値-f.sq.x*n<=psx;
            let T,T0=Y初期値<=psy,T1=Y初期値+f.sq.y*n>=psy;
            let B,B0=Y最大値>=psy,B1=Y最大値-f.sq.y*n<=psy;

            (L0&&L1)?L=true:L=false;
            (R0&&R1)?R=true:R=false;
            (T0&&T1)?T=true:T=false;
            (B0&&B1)?B=true:B=false;

            (T||R||B||L)?f.ismvb=false:f.ismvb=true;
        [endscript ]

        ;3.進行先が0,2で、nxの位置が画面端の場合、f.ismvb=Tにする。
            ;gbcinfoを更新
            [B1 name="&tf.name"]
            ;f.iseveが発生するかを判定。
            [iscript]
                //B共通
                //TTPの場合、前に進むだけ-＞f.povz->f.ginfoを参照
                //FPSの場合、前と後ろに進む->f.vec＝Tのときginfo,Bのときbinfo
                (f.vec=='T'&&f.ginfo in [0,,2]||f.vec=='B'&&f.binfo in [0,,2])?f.iseve=true:f.iseve=false;
                //ttpのとき、TBは関係ない。後ろに歩かないのでf.binfoもいらない。
                (f.isfps==false&&f.ginfo in [0,,2])?f.iseve=true:f.iseve=false;
            [endscript ]
            ;一度でもnxmpが変化している必要あり
            [iscript ]
                //nxpc.xyが画面上の端にいるときに、ginfoが0,2のときismvb=Tにする。
                let 画面端T=0+f.sq.y,画面端B=f.msz.y-f.sq.y;
                let 画面端L=0+f.sq.x,画面端R=f.msz.x-f.sq.x;
                let egT=(画面端T>=f.nx.pc.y)?true:false;
                let egB=(画面端B<=f.nx.pc.y)?true:false;
                let egL=(画面端L>=f.nx.pc.x)?true:false;
                let egR=(画面端R<=f.nx.pc.x)?true:false;
                let eg;
                (egT||egR||egB||egL)?eg=true:eg=false;
                
                //たぶんここ今のマップだから通じてるとこある。
                //mpが初期値のときは発動しない
                let tf1=f.nx.mp.x==0,tf2=f.nx.mp.y==0;
                let tf;(tf1&&tf2)?tf=true:tf=false;
                
                if(eg&&f.ginfo in [0,,2]&&!tf)f.ismvb=true;


                tf.eg=egT+'/'+egR+'/'+egB+'/'+egL;
                tf.nx=f.nx.pc.x+'/'+f.nx.pc.y;
            [endscript ]
    [endmacro ]

    ;C->D->Eで改造。
    ;B1,B,E1を発動
    ;F,crimas2を発動
    ;振り返る場合画像切り替え、移動する場合キャラかマップを移動する。
    [macro name="E"]
        ;色々変数を変更する処置
            ;引数を変数に変換
            @eval exp="tf.name=mp.name" 

            ;マップの移動処理

            ;f.ginfoとf.binfoを更新
            [B1 name="&tf.name"]
            
            ;力を与える(f.iseve=T/F)
            ;pcps.xyにボタンと状況により力を加える
            [iscript ]
                    //TTPの場合、前に進むだけ-＞f.povz->f.ginfoを参照
                    //FPSの場合、前と後ろに進む->f.vec＝Tのときginfo,Bのときbinfo
                    (f.vec=='T'&&f.ginfo in [0,,2]||f.vec=='B'&&f.binfo in [0,,2])?f.iseve=true:f.iseve=false;
                    //ttpのとき、TBは関係ない。後ろに歩かないのでf.binfoもいらない。
                    (f.isfps==false&&f.ginfo in [0,,2])?f.iseve=true:f.iseve=false;
            [endscript ]

            ;イベントを発生(iseve)させない場合、以下は無視する＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            ;pcpsの値を更新(力を加える)
            [sftpw md="pc"]
            ;mppsを更新(力を加える)
            [sftpw md="mp"]
            ;nxを記録、objに記入(ismvbと同じ入れ物に力が入る。)
            ;＝＝＝!iseveでもobjは更新する＝＝＝
            [sftpw md="nx"]

        ;ここまで下準備処理

        ;ここから実際に画像を動かす処理
        
            ;振り返るとき(!T=t)キャラ画像を向けた方向に切り替える。
            [eval exp="tf.istf=f.vec.toUpperCase()!=f.povz.toUpperCase()" ]
            [chara_mod cond="tf.istf" name="player_mt" face="&f.vec.toLowerCase()+'0'" time="50" wait="false" ]

            ;objでマップかキャラクターを動かす。
            [if exp="f.vec==f.povz.toUpperCase()" ]
            [if exp="f.ismvb" ]

                    ;マップを動かす
                    ;[anim name="field" left="&(f.mp.ps.x===0)?'0':f.mp.ps.x" top="&(f.mp.ps.y===0)?'0':f.mp.ps.y"  time="200" ]
                    [anim name="field" left="&(f.obj.x===0)?'0':f.obj.x" top="&(f.obj.y===0)?'0':f.obj.y"  time="200" ]
                [else ]

                    ;キャラクターを動かす
                    ;[chara_move cond="!tf.istf" name="player_mt" left="&(f.pc.ps.x===0)?'0':f.pc.ps.x" top="&(f.pc.ps.y===0)?'0':f.pc.ps.y" anim="true" time="200"  ]
                    [chara_move cond="!tf.istf" name="player_mt" left="&(f.obj.x===0)?'0':f.obj.x" top="&(f.obj.y===0)?'0':f.obj.y" anim="true" time="200"  ]

            [endif ]
            [endif ]
    [endmacro ]

    ;画像変更後処理。現在地povxyをcrimas2で導き出す。povzを現在の値へ更新。イベント用にf.istrs判定。
    ;Eから切り離し
    [macro name="H"]
        ;引数を変数に変換
        @eval exp="tf.name=mp.name" 

        ;処理後の座標を更新する
            ;現在位置を座標に変換する
            ;crimas2はcrimasを圧縮しただけ、機能的変更なし。
            ;tf.loc.xyを出力する。
            [crimas2 axis="x"]
            [crimas2 axis="y"]

            ;povx,povyにそれぞれ入れる
            ;イベント用、前回から位置移動したか判定変数作成(f.istrs)
            [iscript ]
                f.povx=f.gridx[tf.loc.x];
                f.povy=tf.loc.y;
                //前回から移動したとき、イベント用位置記憶を初期化
                if(tf.istrs!=f.povx+f.povy)f.reps.x=f.reps.y=f.reps.z=0;
                (tf.istrs!=f.povx+f.povy)?f.istrs=true:f.istrs=false;//移動t,移動してないf
                //移動したかどうかを記録
                tf.istrs=f.povx+f.povy
            [endscript ]
        ;---------------

        ;背景を切り替える(fps)
            [cngbg name="&tf.name" cond="f.isfps"]
        ;向いている方向を更新する(ttp)
            [eval exp="f.povz=f.vec.toLowerCase()" cond="!f.isfps"]

        ;振り向き終わり止まったあとのginfoとbinfoを更新する。
            [B1 name="&tf.name"]
    [endmacro]

    ;イベント発生処理
    ;Eから切り離し
    [macro name="I"]

        ;イベントの発生
        ;進行方向が2か3のときに発生
            ;ginfoかbinfoどちらを参照にするのかを決める
            [iscript ]
                if(f.isfps){
                    if(f.vec=='T')f.eveid=f.ginfo;if(f.vec=='B')f.eveid=f.binfo;
                }else{
                    f.eveid=f.ginfo;
                };
            [endscript ]

        ;座標から何のイベントなのか叩き出す
        ;3はf.gbinfoから、2はf.cinfoと一致するかを調べる
        ;[if exp="f.eveid in [,,2,3]" ]
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

    [endmacro ]

    ;ただcrimasを読みやすくしただけ
    [macro name="crimas2" ]
        [iscript ]
            //if(mp.name=='ent1ttp9'){pass='none',x0='a',x1='i',y0=1,y1=9}

            if(mp.axis=='x')tf.lup=f.sq.x*3.5 //280; //正方形マップなので左上のX初期位置
            if(mp.axis=='y')tf.lup=0 //左上のY初期位置
            let ar1;ar1=f.pc.ps;
            let zr=tf.lup,sq=f.sq[mp.axis]//,ps=f.pc.ps[mp.axis];
            let ar2=mp.axis,ps = ar1[ar2];
            let rt;

            for(let i=0;i<=69;i++){
                if(zr+ sq*i  <= ps && ps <= zr+ sq*i  +sq-1){ rt=i+1  ;    break;};
                if(i==69){
                    alert('f.pc.ps.x=='+f.pc.ps.x+'//f.pc.ps.y=='+f.pc.ps.y)
                    alert('X該当なし:'+(zr)+'//'+(sq)+'//'+ps)
                    alert(zr+sq+'*n<='+ps+'であり、'+ps+'<='+zr+sq+'*n+'+sq+'-1のである。がない。');break;
                }
            }
            tf.loc[mp.axis]=rt;
            
        [endscript ]
    [endmacro]

    ;pov用、背景の切り替え(視点変更)
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

    ;nxに変える
    ;入ってきた方向にベクトルを与える
    [macro name="knockback"]
        [iscript ]
            //pc,mp,nx全てに入れる
            var pm=['+','-'];
                if(f.povz=='t'){f.pc.ps.y+=eval(pm[0]+1*f.sq.y);};
                if(f.povz=='r'){f.pc.ps.x+=eval(pm[1]+1*f.sq.x);};
                if(f.povz=='b'){f.pc.ps.y+=eval(pm[1]+1*f.sq.y);};
                if(f.povz=='l'){f.pc.ps.x+=eval(pm[0]+1*f.sq.x);};
            var pm=['-','+'];
                if(f.povz=='t'){f.mp.ps.y+=eval(pm[0]+1*f.sq.y);};
                if(f.povz=='r'){f.mp.ps.x+=eval(pm[1]+1*f.sq.x);};
                if(f.povz=='b'){f.mp.ps.y+=eval(pm[1]+1*f.sq.y);};
                if(f.povz=='l'){f.mp.ps.x+=eval(pm[0]+1*f.sq.x);};
            var pm=(f.ismvb)?['-','+']:['+','-'];
            let nx=[];
            nx['x']=(f.ismvb)?f.nx.mp.x:f.nx.pc.x;
            nx['y']=(f.ismvb)?f.nx.mp.y:f.nx.pc.y;
                if(f.povz=='t'){nx.y+=eval(pm[0]+1*f.sq.y);};
                if(f.povz=='r'){nx.x+=eval(pm[1]+1*f.sq.x);};
                if(f.povz=='b'){nx.y+=eval(pm[1]+1*f.sq.y);};
                if(f.povz=='l'){nx.x+=eval(pm[0]+1*f.sq.x);};

            f.obj.x=nx.x;f.obj.y=nx.y;

            //nx.pcmp.xyに適用する
            if(f.ismvb){
                f.nx.mp.x=nx.x;f.nx.mp.y=nx.y;
            }else{
                f.nx.pc.x=nx.x;f.nx.pc.y=nx.y;
            };

        [endscript ]
        ;キャラかマップを動かす
        [if exp="!f.ismnb" ]
                ;キャラクターを動かす
                [chara_move name="player_mt" left="&(f.obj.x===0)?'0':f.obj.x" top="&(f.obj.y===0)?'0':f.obj.y" anim="true" time="200"  ]
            [else ]
                ;マップを動かす
                [anim name="field" left="&(f.obj.x===0)?'0':f.obj.x" top="&(f.obj.y===0)?'0':f.obj.y"  time="200" ]
        [endif ]
        
        ;移動させた位置を更新
        [crimas2 axis="x"]
        [crimas2 axis="y"]
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
;===============================
;===============================

;ボタンを押すとpc,mp,nxそれぞれの場合で1マス分力を加える。
    [macro name="sftpw"]
        [iscript ]
            let mv=[];mv['x']=0;mv['y']=0; 
            if(mp.md=='nx'){
                if(f.ismvb){
                    mv.x=f.nx.mp.x;mv.y=f.nx.mp.y;
                }else{
                    mv.x=f.nx.pc.x;mv.y=f.nx.pc.y;
                        };
            };

            let pm=[];
                if(mp.md=='pc')pm=['+','-'];
                if(mp.md=='mp')pm=['-','+'];
                if(mp.md=='nx')(!f.ismvb)? pm=['+','-'] :pm=['-','+']; 

                if(f.iseve){
                    if(!f.isfps){//ttpのとき
                        if(f.vec=='T'&&f.povz=='t'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[1] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='R'&&f.povz=='r'){f.pm.x=pm[0] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                        if(f.vec=='B'&&f.povz=='b'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='L'&&f.povz=='l'){f.pm.x=pm[1] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                    }
                    if(f.isfps){//fpsのとき
                        if(f.vec=='T'&&f.povz=='t'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[1] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='T'&&f.povz=='r'){f.pm.x=pm[0] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                        if(f.vec=='T'&&f.povz=='b'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='T'&&f.povz=='l'){f.pm.x=pm[1] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                        //Bのとき、上の移動向きを逆転させる
                        if(f.vec=='B'&&f.povz=='t'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='B'&&f.povz=='r'){f.pm.x=pm[1] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                        if(f.vec=='B'&&f.povz=='b'){f.pm.x=pm[0] ,f.sft.x=f.arsft[0] ,f.pm.y=pm[1] ,f.sft.y=f.arsft[2]};
                        if(f.vec=='B'&&f.povz=='l'){f.pm.x=pm[0] ,f.sft.x=f.arsft[1] ,f.pm.y=pm[0] ,f.sft.y=f.arsft[0]};
                    }
                }

                //上で新しく変数が加わった時のみ変更する(T=t)
                if(f.vec==f.povz.toUpperCase()&&f.iseve){
                        //nxのときは起動しないようにする。
                        if(mp.md!='nx'){
                        f[mp.md].ps.x+=eval((f.pm.x)+f.sft.x);
                        f[mp.md].ps.y+=eval((f.pm.y)+f.sft.y);
                        };

                        if(mp.md=='nx'){
                            f.obj.x=eval(mv.x+f.pm.x+f.sft.x);
                            f.obj.y=eval(mv.y+f.pm.y+f.sft.y);
                            if(f.ismvb){
                                f.nx.mp.x=f.obj.x;f.nx.mp.y=f.obj.y;
                            }else{
                                f.nx.pc.x=f.obj.x;f.nx.pc.y=f.obj.y;
                            };
                        };
                    }else{
                        //別のnxが入ることがあるので、
                        //objをismvbにあわせてnxをそのまま入れる
                        if(mp.md=='nx'){f.obj.x=mv.x;f.obj.y=mv.y;};
                };
        [endscript ]
    [endmacro ]

[return ]