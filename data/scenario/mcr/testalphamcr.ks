/*
現状と、alphaのマクロを統合するために使用。
240204現在使用中
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
    ;[layopt layer="0" visible="true"  ]
    [image layer="0"  storage="../bgimage/mntsz.png" name="mnt" wait="true" time="500"  ]

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
        f.msz['x']=$(".mnt").width();f.msz['y']=$(".mnt").height();
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
        //f.gridx=[,'a','b','c','d','e','f','g','h','i','j','k','l']//x軸用a=1にした方が都合がいい
        f.gridx=[, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z','aa','ab','ac','ad','ae','af','ag','ah'];

    //操作キャラクターの登録
        f.pc=[];
        //チップのサイズ
        f.pc['sz']=[];f.pc.sz['x']=80;f.pc.sz['y']=80;
        //位置
        f.pc['ps']=[];f.pc.ps['x']=0;f.pc.ps['y']=0;
        //キャラ登録用pass
        tf.pass='chara/tip/1341/'

    //modeのラベル配列初期値
        f.arlbl=[];

    //カセット用
        //画像追加確認用配列
        f.mod_image=[];

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
                    //tf.locx=[,'a','b','c','d','e','f','g','h','i','j','k','l'];//最大で69(a~bq)、a=1にした
                    //f.gridx内容同じなのでこっちをつかう
  
                if(mp.name=='f101_01_01_cy'  ){pass='none',x0='1',x1='19',y0='1',y1='27'};
                if(mp.name=='f101_01_01_frz' ){pass='none',x0='1',x1='17',y0='1',y1='5 '};
                if(mp.name=='f101_01_24_ctr' ){pass='none',x0='1',x1='11',y0='1',y1='4 '};
                if(mp.name=='f101_01_28_ant' ){pass='none',x0='1',x1='11',y0='1',y1='6 '};
                if(mp.name=='f101_01_32_frz' ){pass='none',x0='1',x1='5 ',y0='1',y1='13'};
                if(mp.name=='f101_06_34_suc' ){pass='none',x0='1',x1='6 ',y0='1',y1='9 '};
                if(mp.name=='f101_06_43_ptk' ){pass='none',x0='1',x1='6 ',y0='1',y1='2 '};
                if(mp.name=='f101_07_07_cref'){pass='none',x0='1',x1='11',y0='1',y1='3 '};
                if(mp.name=='f101_12_25_wap' ){pass='none',x0='1',x1='30',y0='1',y1='20'};
                if(mp.name=='f101_13_11_frz' ){pass='none',x0='1',x1='7 ',y0='1',y1='5 '};
                if(mp.name=='f101_20_01_set' ){pass='none',x0='1',x1='10',y0='1',y1='24'};
                if(mp.name=='f101_30_01_cdb' ){pass='none',x0='1',x1='4 ',y0='1',y1='9 '};
                if(mp.name=='f101_30_10_ccr' ){pass='none',x0='1',x1='4 ',y0='1',y1='15'};
                if(mp.name=='f101_34_01_pic' ){pass='none',x0='1',x1='28',y0='1',y1='24'};
                if(mp.name=='f101_34_23_frzp'){pass='none',x0='1',x1='13',y0='1',y1='4 '};
                if(mp.name=='f101_36_28_ref' ){pass='none',x0='1',x1='8 ',y0='1',y1='4 '};
                if(mp.name=='f101_36_34_ref' ){pass='none',x0='1',x1='6 ',y0='1',y1='6 '};
                if(mp.name=='f101_36_40_ref' ){pass='none',x0='1',x1='6 ',y0='1',y1='5 '};
                if(mp.name=='f101_42_28_mcn' ){pass='none',x0='1',x1='20',y0='1',y1='17'};
                if(mp.name=='f101_44_37_hac' ){pass='none',x0='1',x1='13',y0='1',y1='8 '};
                if(mp.name=='f101_47_25_wbs' ){pass='none',x0='1',x1='15',y0='1',y1='3 '};
                if(mp.name=='f101_50_01_ref' ){pass='none',x0='1',x1='12',y0='1',y1='3 '};
                if(mp.name=='f101_57_37_ref' ){pass='none',x0='1',x1='5 ',y0='1',y1='8 '};
                if(mp.name=='f101_62_01_ent' ){pass='none',x0='1',x1='8 ',y0='1',y1='27'};
                if(mp.name=='f101_62_25_hwp' ){pass='none',x0='1',x1='3 ',y0='1',y1='12'};
                if(mp.name=='f101_62_37_ref' ){pass='none',x0='1',x1='13',y0='1',y1='8 '};
                if(mp.name=='f201_01_01_mac' ){pass='none',x0='1',x1='28',y0='1',y1='14'};
                if(mp.name=='f201_01_15_rep' ){pass='none',x0='1',x1='5 ',y0='1',y1='13'};
                if(mp.name=='f201_06_15_wgh' ){pass='none',x0='1',x1='33',y0='1',y1='13'};
                if(mp.name=='f201_29_01_trm' ){pass='none',x0='1',x1='19',y0='1',y1='14'};
                if(mp.name=='f201_35_23_rep' ){pass='none',x0='1',x1='13',y0='1',y1='5 '};
                if(mp.name=='f201_39_01_dmp' ){pass='none',x0='1',x1='7 ',y0='1',y1='5 '};
                if(mp.name=='f201_39_13_ant' ){pass='none',x0='1',x1='9 ',y0='1',y1='10'};
                if(mp.name=='f201_46_01_ent' ){pass='none',x0='1',x1='17',y0='1',y1='5 '};
                if(mp.name=='f201_48_06_rep' ){pass='none',x0='1',x1='12',y0='1',y1='12'};
                if(mp.name=='f201_48_18_vgt' ){pass='none',x0='1',x1='12',y0='1',y1='10'};
                if(mp.name=='f201_49_01_pmp' ){pass='none',x0='1',x1='4 ',y0='1',y1='4 '};

                    //数字に変換
                    x0=x0*1;x1=x1*1;y0=y0*1;y1=y1*1;

                    locxl=x0;
                    locxr=x1;

                    x0=f.gridx[x0];
                    x1=f.gridx[x1];
                    //locxl=tf.locx.indexOf(x0);
                    //locxr=tf.locx.indexOf(x1);
                    //tf.locy=[1-9]

            //マップごとに設定を呼び出す
            //最終的にf.locxとf.mapszができればよい
            /*
                画像の縦横のサイズを80で割る。
            */

            //画像が存在する範囲を作成する
            //preloadを使う場合はこれを有効にする。
            if(f.isfps){
                tf.dic=['b','l','r','t'];
                tf.prldbg=[];

                let i=0
                for (let l=locxl;l<=locxr;l++){
                    for (let j=y0;j<=y1;j++){
                        for (let k=0;k<=3;k++){
                    tf.prldbg[i]=tf.pass+f.gridx[l]+j+tf.dic[k]+'.jpg';
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

        ;placeの引数を取得する(f.povxyz,tf.pl12345)(*rt_bldに戻る)
        [jump storage="&'map/'+mp.name+'.ks'" target="*place" cond="!f.isnmp"]
        ;[jump storage="&'map/'+f.mpnm+'.ks'" target="*place" ]
*rt_bld
        ;ここでmode01.ksの追加イベントも読み込む(*rt_bld2に戻る)
        [jump storage="&'mcr/mode/'+f.mode+'.ks'" target="*place" cond="f.mode!='none'&&!f.isnmp"]
*rt_bld2
        [iscript ]
            f.map[mp.name]=[];
            f.map[mp.name]['loc']=[];

            //マップ上にあるイベントを登録する。
            function place(szx,szy,lcx,lcy,n){
                if(isNaN(n) || n === "")n=1;//nが何も入ってない場合1にする
                for(let i=0;i<=szx-1;i++){
                    //f.map[mp.name].loc[lcx+i]=[]; //消す意味がない(起動順番が入れ替わったので)やっぱり残す。
                    for(let l=0;l<=szy-1;l++){
                        //ここ
                        f.map[mp.name].loc[lcx+i][lcy+l]=n;
                    }
                }
                //alert(n);
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
            //呼び出す部屋名で必要入力を行う
                let a=tf.pl1,b=tf.pl2,c=tf.pl3,d=tf.pl4,e=tf.pl5;

                for(let n=0;n<=a.length-1;n++){
                    place(a[n],b[n],c[n],d[n],e[n]);
                };
            /*

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
                        place(1,1,6,2,2);//ちょっとあとで
                    };
                    if(mp.name=='ent1ttp9'){
                        posx='a';posy='2';posz='r'
                        place(1,2,7,4,3);
                        place(1,2,9,4,3);
                        place(1,1,9,9);
                        place(1,1,6,2,2);
                        place(1,1,6,8,2);
                    };
                */

            
            //リセットポイントが設定されている場合こちらを優先に上書き
            //if(typeof f.reps.x!=="undefined"){posx=f.reps.x,posy=f.reps.y,posz=f.reps.z}
            //原因：移動の時にリセットボタンが発生しているため。
            if(typeof f.reps.x!=="undefined"){f.posx=f.reps.x,f.posy=f.reps.y,f.posz=f.reps.z,f.povz=f.posz}

            //初期位置座標向きを登録
            //f.povx=posx
            //f.povy=posy
            //f.povz=posz //いままでだとtf.faceでtrbl
            tf.imgnm=f.povx+f.povy+f.povz //f.povlocから変更
            f.locx=[locxl,locxr]
        [endscript ]

        ;最初に表示させる画像を表示
        [bg storage="&mp.name+'/'+tf.imgnm+'.jpg'" time="50" cond="f.isfps"]
    [endmacro ]

    ;マップを呼び出す
    [macro name="map_smn"]
        ;リセットポイントの初期化
        @eval exp="f.reps=[]" 

        ;-------------------------------------------
        ;mpを渡す
        /*
        [iscript ]
            //マップの名前
            f.mpnm=mp.nm;
            //;ttpかfpsかを宣言する(マップ切り替えの度)
            (mp.fps=='t')?f.isfps=true:f.isfps=false;
        [endscript ]
        */

        ;マップに登場するキャラクター・モノ宣言
        [call storage="&'map/'+f.mpnm+'.ks'" target="*dec" cond="!f.isnmp" ]

        ;renew,mpload,mpbldで使用
        ;全体創造
        [renew name="&f.mpnm"]
                ;キャラクターの初期座標(あとで自動化)
        /*
            f.povxyから割り出せない？

            povx=a, ==0
            povy=1, ==0

            この時点でまだmapbld通ってないからそらないわ
            */
            /*
            [iscript ]
            let n,m;
                n=f.gridx.indexOf(f.povx)*1-1;
                m=f.povy*1-1;
                alert(n+'//'+m)

                f.pc.ps.y=0           +f.sq.y*m;//m
                f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*n;//n
                alert(f.pc.ps.x+'//'+f.pc.ps.y);

            [endscript ]
        */
        ;@eval exp="f.pc.ps.y=f.sq.y*1,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*0" 
    [endmacro ]
    ;イベント復帰用のリカバリ(直前に[destroy]を使用)
    [macro name="renew" ]
        ;[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]
            /*
            ここにミニマップを入れる。
            第一段階：全マップへのワープボタンがあるページを表示するやつ
            第二段階：現在地のマップで自分がどこにいるのかを縮小表示
            
            第一段階はメニューとする。
            タイトルに戻るボタンもその中に収納する。
            sleepgameが使えないのでjumpで代行
            */

        ;画面左上に現在地の名前を出す
            [free layer="1" name="roomname" ]
            [ptext layer="1" x=200 y=200 name="roomname" text="&f.mprnm[f.mpnm]" color="brack" size="50" ]
            [iscript ]
                $(".roomname").css("background-color","#fff");
                $(".roomname").animate({'top':'0px','left':'0px'},1000);
            [endscript ]
        ;/画面左上に現在地の名前を出す

        ;MENUボタン表示
            ;[glink name="mapmenu" text="MENU" x="&1280-300" y="0" exp="TYRANO.kag.ftag.startTag('sleepgame',{storage:'menu.ks'});" ]
            [glink text="MENU" target="*gotitle2" x="&1280-300" y="0" color="btn_01_white"]

            [iscript ]
                //引数で渡す内容を変更
                //if(mp.name='ent1ttp9'){tf.name=mp.name;tf.str='map_9';};
                //if(mp.name='ent1ttp'){tf.name=mp.name;tf.str='map_12a';};

                //tf.str=mp.name
                //alert(tf.str);
                tf.name=mp.name;
                //初期化(place)
                tf.o=-1
            [endscript ]
        ;/MENUボタン表示

        ;マップ切り替え時のみ。mapload以前に。
        [ignore exp="f.isnmp" ]
            [iscript ]
                //マップイベント登録
                tf.pl1=[];
                tf.pl2=[];
                tf.pl3=[];
                tf.pl4=[];
                tf.pl5=[];
            [endscript ]
        [endignore ]

        ;全mapサイズなどを読込,locx,mapszを更新
        [map_load name="&tf.name"]
        ;呼び出しmapの全座標にイベント設定,キャラ初期位置(POV)更新
        [map_bld name="&tf.name"]

        ;初期位置
        ;nxで引き継がれないので×。最初の一度目だけ通るようにする。

        ;マップ切り替え時に変更==========1回目のみ読み込む
            [trace exp="f.isnmp+'<--f.isnmp 初回ではない判定(True)'"]
            [ignore exp="f.isnmp" ]
                [iscript]
                    //＃マップごとの初期位置を入れる(これはマップごとに切り替える)
                        let n,m;
                            n=f.gridx.indexOf(f.povx)*1-1;
                            m=f.povy*1-1;

                            f.nx.pc.y=f.pc.ps.y=0           +f.sq.y*m;//m
                            f.nx.pc.x=f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*n;//n
                            if(m>=9)f.nx.pc.y=0           +f.sq.y*8;
                            if(n>=9)f.nx.pc.x=(f.sq.x*3.5)+f.sq.x*8;
                            
                            //map初期値は0でいいのか問題
                            /*
                                povxがaのとき、xは0
                                pvxがlの時、xはlnが右端に来るマス位置
                                povyが1のとき、yは0
                                povyが12のとき、yは12マス目が画面端

                                端の場合は四方の角を画面端と合わせる
                                それ以外はそれが画面中央にくるようにする。

                                
                                現在、0,0を基準に作成されている。
                                画像が00にあるとしてイベントが作成されている。

                                f.map.hoge.loc[x][y]にイベントが収容されているが
                                
                                現在地は
                                f.map.hoge.loc[povx][povy]でイベントを計算する。
                                なのでオフセットを用意して計算をずらす必要がある
                                ずらす単位はマスサイズf.sq.xy

                                B1に書き加える

                                fpovx位置とf.pcps位置をずらす
                                pcpsはイベントの基準値。永遠に動く
                                nxpcは画面内位置。
                            */
                            f.mp.ps.y=f.nx.mp.y=f.sq.y*0;
                            f.mp.ps.x=f.nx.mp.x=f.sq.x*0;
                            //たぶん12マスのとき9+3だから成り立ってる
                            //合計17でやってみる
                            //つまり、読み込むマップのマス数を9+Xで成り立たせるようにする。
                            //alert((f.locx[1]-9)+' '+(f.mapsz[3]-9));//8 -4
                            //最大値というより9マス以上の置きたい部分に置くようにする。
                            //f.povxとf.povyの数値と等しくする
                            /*
                                最大値-9で最大値にピントが合う
                                X      でf.povxにピントが合うようにする
                                要は9マスから飛び出した分までマイナスにするという処理。
                                q>nのとき、9>12で対応した。
                                q=17,n=14
                                9de
                                8>5
                                f.gridx[x0]

                                たぶんX位置を右にずらしている画像を使用してるので-2が必要なんだと思う

                                f.locxはx部位の最小値と最大値。[1]は右端の数値

                                -2ではなく、初期位置の数値で補う。
                                entは-2だったけどね。
                                初期位置はf.povxxz。

                                例えば、右1のとき右側から数えて9番目のマスが左端に来るようにする

                                マップ最大値-初期位置
                            */
                            //if(m>=9)f.nx.mp.y=f.sq.y*-(f.mapsz[3]-(f.povy-2));
                            //if(n>=9)f.nx.mp.x=f.sq.x*-(f.locx[1]-(f.gridx.indexOf(f.povx)-2));//19-19
                            /*
                            掛け値を変数に入れる。
                            マップ移動時にも使用。
                            */
                            var px0=0,py0=0,px1,py1;//掛け算のproduct
                            //ここは別に無理にpxy0に当てはめる必要はない。
                            if(m>=9){py0=f.povy-9                 ;f.nx.mp.y=f.sq.y*-py0;};//alert('変換y');};
                            if(n>=9){px0=f.gridx.indexOf(f.povx)-9;f.nx.mp.x=f.sq.x*-px0;};//alert('変換x');};
                            //px1=px0+1;py1=py0+1;
                            //f.pxy=[px0,px1,py0,py1];


                            let ar=f.mapsz,x=f.gridx.indexOf(ar[1]),y=ar[3];

                            /*
                                ここで、f.nx.mpxyと、f.nx.pcxyをオフセットする。
                                条件
                                1.画面中央十字線に合わせる
                                2.1.のとき、マップが画面内2マスを超えないようにする。

                                280+80*(x-1)==最大移動値
                                0+80*(y-1)==最大移動値

                            */
                            //alert(f.nx.pc.x+'//'+f.nx.pc.y+'//'+x+'//'+y);//520--0
                            /*X=280~1160(0-880)(12のとき) Y=0~720(10のとき)*/
                            /*
                            let maxX=80*(x-1),maxY=80*(y-1);
                            let CX=maxX/2+280,CY=maxY/2+0;
                            */
                            let CX=80*5+280,CY=80*5+0;
                            let ofsX=CX-f.nx.pc.x,ofsY=CY-f.nx.pc.y;
                            //alert(CX+'//'+CY);//680,400
                            //alert(ofsX+'//'+ofsY);//200,360<-中央からずれている0になるようにする。160,400
                            //f.nx.pc.x=CX;
                            
                            /*
                                5-1 ofsX=4
                                1を5に修正するには
                                1+ofsX

                                5-6 ofsX=-1
                                6を5に修正するには
                                6+ofsX
                            
                            */
                                f.nx.pc.x+=ofsX;
                                f.nx.mp.x+=ofsX;
                                f.nx.pc.y+=ofsY;
                                f.nx.mp.y+=ofsY;




                            /*
                            if(Math.sign(ofsX)==1){
                                f.nx.pc.x+=ofsX;
                                f.nx.mp.x+=ofsX;
                            }else{
                                f.nx.pc.x-=ofsX;
                                f.nx.mp.x-=ofsX;

                            };
                            */



                            /*
                                m,nはあくまで初期位置なのでマップサイズと関係ない。
                            */
                            //let h=TG.config.scHeight*1,w=TG.config.scWidth*1;
                            //let ar=f.mapsz,x0=0,x1=f.gridx.indexOf(ar[1])*80-1*+w,y0=0,y1=ar[3]*-1+h;

                            //alert(x+'//'+y);
                            if(x>=9)px0=x-9;
                            if(y>=9)py0=y-9;
                            px1=px0+1;py1=py0+1;
                            f.pxy=[px0,px1,py0,py1];
                            //alert(f.pxy);


                [endscript ]
            [endignore ]
        ;/マップ切り替え時に変更=========

            [trace exp="tf.piyo5='field通過'"]
        ;画像らの初期位置
            ;マップを呼び出す(nameを追加)
            ;[image name="field" visible="true" layer="0" folder="bgimage" storage="&tf.str+'.jpg'" x="&f.nx.mp.x" y="&f.nx.mp.y"  ]
            ;背景(壁)を追加する
            [image name="fieldb" visible="true" layer="0" folder="bgimage" storage="&'map/'+f.mpnm+'b.png'" x="&f.nx.mp.x-f.pc.sz.x" y="&f.nx.mp.y-f.pc.sz.y"  wait="false" cond="f.isma"]
            [image name="field" visible="true" layer="0" folder="bgimage" storage="&'map/'+f.mpnm+'.png'" x="&f.nx.mp.x" y="&f.nx.mp.y"  wait="false" ]
           ;[wait time="1000" ]
           
    ;呼び出す画像をa.pngにするか01.pngにするかの判定==================
                ;カセット有無及びマップに追加要素がある場合storageを変化させる。
                    [iscript ]
                        (typeof tf.hasmdimg==="undefined")?tf.cntnmn=tf.stmap:tf.cntnmn=tf.mpnm;
                        tf.tail='a'
                        for(let l=0;l<=f.mod_image.length-1;l++){
                                if(f.mod_image[l]==tf.cntnmn)tf.tail=f.mode;
                        }
                        (typeof tf.hasmdimg==="undefined")?tf.hasmdimg=tf.stmap:tf.hasmdimg=tf.mpnm;
                    [endscript ]
                                [trace exp="tf.tail+'<----tf.tail'"]

    ;/呼び出す画像をa.pngにするか01.pngにするかの判定==================    
            [trace exp="f.mod_image+'<---f.mod_image'"]
            [image name="field" visible="true" layer="1" folder="bgimage" storage="&'map/'+f.mpnm+tf.tail+'.png'" x="&f.nx.mp.x" y="&f.nx.mp.y"  wait="false" cond="f.isma"]
            ;[image name="field" visible="true" layer="1" folder="bgimage" storage="&'map/'+f.mpnm+'a.png'" x="&f.nx.mp.x" y="&f.nx.mp.y"  wait="false" cond="f.isma"]
                  [trace exp="f.mpnm+tf.tail+'<---呼び出し画像名'"]

            ;[layermode mode="multiply" name="field" visible="true" layer="1" folder="bgimage" storage="&'map/'+f.mpnm+'a.png'" x="&f.nx.mp.x" y="&f.nx.mp.y"  wait="false" cond="f.isma"]
            ;キャラクター(自機)を出現(f.povzの方向で出現させる)
            [chara_show name="player_mt" face="&f.povz+'0'" left="&f.nx.pc.x"  top="&f.nx.pc.y" time="50" wait="true" ]
            @eval exp="f.isma=false" cond="f.isnmp"
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
        //alert('ここかな');
        let n,m,x0,x1,y0,y1;
        
        if(f.povx===undefined){
            //alert('わかんねえ');
            n=0;
        }else{
            n=f.gridx.indexOf(f.povx)*1;
        }
        
        //n=f.gridx.indexOf(f.povx)*1;
            m=f.povy*1;

        //f.povzは現在キャラクターが向いている向き
        if(f.povz=='t'){x0=x1=n ,y0=m-1 ,y1=m+1 };
        if(f.povz=='r'){x0=n+1  ,x1=n-1 ,y0=y1=m};
        if(f.povz=='b'){x0=x1=n ,y0=m+1 ,y1=m-1 };
        if(f.povz=='l'){x0=n-1  ,x1=n+1 ,y0=y1=m};

        //alert(f.povx+'//'+f.locx[1]);
        //ボタンを押したときキャラが向いている方角の前後編集
        if(f.povx===undefined||f.gridx.indexOf(f.povx)>f.locx[1]){//左端と右端
        f.ginfo=1;//進行予定1マスの変数
        }else{
        f.ginfo=f.map[mp.name].loc[x0][y0];//進行予定1マスの変数
        }
        //ここ。x1が9のはずが-2になる。つぎここ2回目のとき。
        //alert(x1+'/'+y1)
       // alert(f.povx+'/'+f.povy)
        //ここのx1y1
        f.binfo=f.map[mp.name].loc[x1][y1];//後退予定1マスの変数

        f.cinfo=f.map[mp.name].loc[n][m];//現在地の変数
        [endscript ]
    [endmacro]

    ;ここのnで端範囲を切り替える
    ;pcps.xyの数値でf.ismvbのT/Fを切り替える。
    ;Eから切り離し。
 ;   [macro name="G"]
        ;引数を変数に変換
 ;       @eval exp="tf.name=mp.name" 

        ;条件によってf.ismvbを切り替える
        ;1.画面上の中央十字線をキャラクターが踏んだ時、マップ操作に切り替える。(True)
        ;2.マップの端周辺をキャラクターが踏んだ時、キャラ操作に切り替える。(False)
        ;3.画面上外へキャラクターが移動が可能な時、マップ操作に切り替える。(True)
        ;4.端から中央へ移動する場合、画面上中央十字線までキャラ操作に切り替える。(False)
        ;5.マップの移動を端から2マスまでに抑える。(True)
    [macro name="GA"]
        ;1.C enterラインを踏んだかどうかf.ismvb=T
        [iscript]
        //これは9マスマップのときだけしか適用しない。
        //マスではなく、画面上の中央十字線で判定する。

        //f.pc.ps.xyがマップ上の絶対値の位置。
        //tf.nxことf.nx.pc.xyが画面上キャラ画像の表示位置。
            let CX = f.nx.pc.x==eval(f.sq.x*3.5+f.sq.x*5);
            let CY = f.nx.pc.y==eval(f.sq.y*0+f.sq.y*5);

            (CX||CY)?f.ismvb=true:f.ismvb=false;
        [endscript]
        /*
        [iscript ]

            let CX = f.pc.ps.x==eval(f.sq.x*3.5+f.sq.x*4);
            let CY = f.pc.ps.y==eval(f.sq.y*0+f.sq.y*4);

            (CX||CY)?f.ismvb=true:f.ismvb=false;

        [endscript ]
        */
    [endmacro]
    [macro name="GB" ]
        ;nはここ
        ;2.端のマスの数nの位置にキャラクターがいるとき、f.ismvb=Fにする。
        [iscript]
            /*
                L X初期値<=80*4
                R X最大値>=X最大サイズ-80*4
                T Y初期値<=80*4
                B Y最大値>=Y最大サイズ-80*4

                f.pc.ps.xyがこれらに含まれるかどうかで判定する。
                pcpsxyはマップ画像の絶対値

                f.obj.xyでキャラマップの表示絶対値
            */
            let ar=f.mapsz,psx=f.pc.ps.x,psy=f.pc.ps.y;
            //psx=f.obj.x;psy=f.obj.y;
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

            //4.向けに現在端にいるかを判定しておく
            //if(L) f.isedge='L';
            var v;
            switch (true) {
                case L:v='L';break;
                case R:v='R';break;
                case T:v='T';break;
                case B:v='B';break;
                default : v='';break;
            };
            f.isedge=v;
        [endscript ]
    [endmacro]
    [macro name="GC" ]
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
            ;画面端で画面端向きにボタンが入った時に起動
            ;×一度でもnxmpが変化している必要あり
            [iscript ]
                //alert(f.povz+'/povz//'+f.vec+'/vec')
                //nxpc.xyが画面上の端にいるときに、ginfoが0,2のときismvb=Tにする。
                let 画面端T=0+f.sq.y,画面端B=f.msz.y-f.sq.y;
                let 画面端L=0+f.sq.x,画面端R=f.msz.x-f.sq.x;
                let egT=(画面端T>=f.nx.pc.y&&f.vec=='T')?true:false;
                let egB=(画面端B<=f.nx.pc.y&&f.vec=='B')?true:false;
                let egL=(画面端L>=f.nx.pc.x&&f.vec=='L')?true:false;
                let egR=(画面端R<=f.nx.pc.x&&f.vec=='R')?true:false;
                let eg;
                (egT||egR||egB||egL)?eg=true:eg=false;
                
                //たぶんここ今のマップだから通じてるとこある。
                //mpが初期値のときは発動しない
                /*
                let tf1=f.nx.mp.x==0,tf2=f.nx.mp.y==0;
                let tf;(tf1&&tf2)?tf=true:tf=false;
                */
                //if(eg&&f.ginfo in [0,,2]&&!tf)f.ismvb=true;

                if(eg&&f.ginfo in [0,,2])f.ismvb=true;


                tf.eg=egT+'/'+egR+'/'+egB+'/'+egL;
                tf.nx=f.nx.pc.x+'/'+f.nx.pc.y;
                                        //alert(f.ismvb);
                //これが画面端にTにならない これが1280/720
                //alert(f.msz.x+'/'+f.msz.y)
                //alert(egB);

            [endscript ]
        ;//3---
    [endmacro ]
    [macro name="GD" ]
        ;4.画面上の端にいるとき、中央に向けて移動のときf.ismvb=Fにする。
        [iscript ]
            /*
                左右端にいる場合、上下は無効、中央向けのときキャラを動かす
                上下端にいる場合、左右は無効、中央向けのときキャラを動かす
            */
            //端にいる場合はTRBL、いない場合は空白。
            var v=f.isedge;

            switch (true) {
                case v=='T'&&f.vec=='B'&&f.povz=='b':f.ismvb=false;break;
                case v=='R'&&f.vec=='L'&&f.povz=='l':f.ismvb=false;break;
                case v=='B'&&f.vec=='T'&&f.povz=='t':f.ismvb=false;break;
                case v=='L'&&f.vec=='R'&&f.povz=='r':f.ismvb=false;break;
                default : break;

            };
        [endscript ]
    [endmacro ]
    [macro name="GE" ]
        ;5.マップ移動の最大値を制限(上下左右2マス内側まで)f.ismvb=Fにする。
        [iscript ]
            /*
                マップの移動値を制限する。
                Xの最小値を0-160
                Yの最小値を0-160
                最大値をそれぞれ最大から0-160
                例えばマップが右に動く(キャラが左に動く)時、マップのX値が160を超える場合f.ismvb=Fに切り替える。

                f.obj.xとf.obj.yで絶対値で入れる。ismvb=Tのときのf.obj。764
                f.nx.mp.xが160を超えないようにする。-最大値-160を超えないようにする。
                f.nx.mp.yが``
                nx.mpをobjに変更を中断

                nxmpはマップ画像の絶対値。
                基本は0,0で-80~-160のxyの間でキャラ移動に切り替わる。
                最大値+80~+160のXY間で切り替わる。



            */
            /*
            let 画面端T=0+f.sq.y*2,画面端B=f.msz.y-f.sq.y*2;
            let 画面端L=0+f.sq.x*2,画面端R=f.msz.x-f.sq.x*2;

            if(f.nx.mp.x>=画面端L||f.nx.mp.x<=-(画面端R))f.ismvb=false;
            if(f.nx.mp.y>=画面端T||f.nx.mp.y<=-(画面端B))f.ismvb=false;

            マップの上は0
            マップの下は画像高さサイズ-画面高さサイズ
            */
            let h=TG.config.scHeight*1,w=TG.config.scWidth*1;
            //Xはアルファベット変換されてるので再変換する。
            
            let ar=f.mapsz,x0=0,x1=f.gridx.indexOf(ar[1])*80-1*+w,y0=0,y1=ar[3]*-1+h;

            //console.log(x1);
            //alert(ar[1]+'//'+x1+'//'+y1);//-1268//-710=>1292//730=>-320//-710
        /*        
                if(f.vec=='T'&&f.povz=='t')if(f.nx.mp.y<=y0+80&&f.nx.mp.y>=y0+160)f.ismvb=false;
                if(f.vec=='R'&&f.povz=='r')if(f.nx.mp.x<=x1-80&&f.nx.mp.x>=x1-160)f.ismvb=false;
                if(f.vec=='B'&&f.povz=='b'){
                    //if(f.nx.mp.y<=y1-80&&f.nx.mp.y>=y1-160)f.ismvb=false;//y1==710(630～550)
                    if(f.nx.mp.y<-80&&f.nx.mp.y>=-160-1)f.ismvb=false;
                    //if(f.nx.mp.y<f.sq.x*-1*1&&f.nx.mp.y>=f.sq*-1*2-1)f.ismvb=false;
                    //alert('下へ向かってる/nmpy=>'+f.nx.mp.y);
                }
                if(f.vec=='L'&&f.povz=='l')if(f.nx.mp.x<=x0+80&&f.nx.mp.x>=x0+160)f.ismvb=false;

        */
            //var px0=1,py0=1,px1,py1;//掛け算のproduct
            let px0=f.pxy[0],px1=f.pxy[1],py0=f.pxy[2],py1=f.pxy[3];
            /*
            alert(f.isnmp);
            //map読み込み一度のみ。
            if(!f.isnmp){
                if(0<=f.povx-9)px0=f.povx-9;
                if(0<=f.povy-9)py0=f.povy-9;
                alert('通った？');
            };


            px1=px0+1;py1=py0+1
            */
            if(f.vec=='T'&&f.povz=='t')if(f.nx.mp.y> 80&&f.nx.mp.y<= 160+1)f.ismvb=false;//これは据え置き
            if(f.vec=='R'&&f.povz=='r'){if(f.nx.mp.x<=-80-80*px0&&f.nx.mp.x>=(-80-80*px1-1))f.ismvb=false;};//alert((-80-80*px0)+'~'+(-80-80*px1-1)+'f.nx.mp.x=>'+f.nx.mp.x);};
            if(f.vec=='B'&&f.povz=='b'){if(f.nx.mp.y<=-80-80*py0&&f.nx.mp.y>=(-80-80*py1-1))f.ismvb=false;};//alert((-80-80*py0)+'~'+(-80-80*py1-1)+'f.nx.mp.y=>'+f.nx.mp.y);};
            if(f.vec=='L'&&f.povz=='l')if(f.nx.mp.x> 80&&f.nx.mp.x<= 160+1)f.ismvb=false;//これは据え置き
            
            /*
            最初から左上のマップではこれでOK
            右から出てくる、下から出てくるではまた別処理が必要。
            つまり、スタート位置ですでにこれら基準を超えている場合は稼働しない。

            背中の方向
            X=12のとき、160～240(80*2~80*3)
            X＝19のとき、800～880(80*10~80*11)

            Xが9を超えるとき、超えた分だけ80がそれぞれ追加される感じ。

            px1が2なんだけどなんで

            */
            
           
            


        [endscript ]
    [endmacro ]

;    [endmacro ]
    [macro name="G"]
        ;引数を変数に変換
        @eval exp="tf.name=mp.name" 
        ;画面中央十字線を踏んだらマップ移動(T)それ以外キャラ移動(F)
        ;[GA]
        ;ゲーム内画面端nマスにキャラがいるときキャラ移動(F)それ以外のときマップ移動(T)
        ;[GB]
        ;画面外に移動できるときマップ移動(T)に切り替える。(Fなし)マップ端1マスにいるときに発動。
        ;[GC]
        ;ゲーム内端にいて内側に歩くとき、キャラ移動(F)にする。(Tなし)
        ;[GD]
        ;マップ絶対値が画面端2マスより内側にいかないように制限する。行くときはキャラ移動(F)にする。
        ;[GE]
        /*
            動作まとめ。
            0.基本的にキャラ移動(F)
            1.画面中央十字線にキャラコマが重なったらマップ移動(T)[GA]
            2.画面端2コマまでマップが引き寄せられたらキャラ移動(F)[GE]

            このまとめで再構成する。無駄が多い。

            f.obj.xyでマップの移動を制限できる

            例外)
            2.の時、壁側ではない方向へ行こうとするとFのままなので画面外にキャラクターが移動する。
            中央線を通らせないとTにならない。
            初期位置がマップの右下なのが問題。画面中央十字線に近い位置に出すようにしたい。
            また、マップの黒が２マス分の間を取るようにする。

        */
        @eval exp="f.ismvb=true"
        [GA] 
        ;[GB]
        ;[GC]
        ;[GD]
        [GE]
    [endmacro ]
    ;C->D->Eで改造。
    ;B1,B,E1を発動
    ;F,crimas2を発動
    ;振り返る場合画像切り替え、移動する場合キャラかマップを移動する。
    [macro name="E"]
        ;色々変数を変更する処置            
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
                    [anim name="fieldb" left="&(f.obj.x===0)?f.pc.sz.x*-1:f.obj.x-f.pc.sz.x" top="&(f.obj.y===0)?f.pc.sz.y*-1:f.obj.y-f.pc.sz.y"  time="200" ]
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
            //超える場合tf.loc.x==0で存在しない
            //エラー出てるのはこれの下の2回目のB1
            //if(tf.loc.x===undefined)tf.loc.x=0;
                f.povx=f.gridx[tf.loc.x];
                //if(tf.loc.x==0)alert(f.povx);
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
    /*
    - 0…通過可能、何も発生しない。　処理済
    - 1…通行不可。現在値に隣接している場合そちらの方向へ動けない。 処理済
    - 2…イベント発生0。通過したときに発生する　動きは処理済
    - 3…イベント発生1。現在値に隣接している場合、そちらを向いてボタンで発生。1と合わせる
    - 4…メニューのマップワープ移動専用。
    */

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

        ;!callの不具合回避のため、条件を圧縮する。
        [iscript ]
            //床踏み込みイベントが発生するか否か(1歩先が3(主観),2,4)
            tf.ismvev=false;
            if(f.eveid===3||f.cinfo===2||f.cinfo===4)tf.ismvev=true;
            //現在地が0、またはその場で回転したとき。
            tf.ismvev_not=false;
            if(f.cinfo===0&&f.istrs||f.cinfo===2&&!f.istrs||f.cinfo===4&&!f.istrs)tf.ismvev_not=true;
        [endscript ]
        [if exp="tf.ismvev" ]
                ;現在座標を記録する(ignoreのエンジンエラーのためここに記述)
                    [iscript ]
                        //これだと同じマスのイベントが発生しなくなる
                        if(!f.istrs)f.cinfo=0;
                        f.reps.x=f.povx
                        f.reps.y=f.povy
                        f.reps.z=f.povz
                    [endscript ]
                    
            ;床が0且移動したときは無視する
            [ignore exp="tf.ismvev_not" ]

                    ; ;現在座標を記録する
                    ;     [iscript ]
                    ;         //これだと同じマスのイベントが発生しなくなる
                    ;         if(!f.istrs)f.cinfo=0;
                    ;         f.reps.x=f.povx
                    ;         f.reps.y=f.povy
                    ;         f.reps.z=f.povz
                    ;     [endscript ]
                ;全体破壊　その場回転(!f.istrs)の時、2を発生させず、destroyも発生させない
                ;[destroy]
                ;2の時ADVモードに入るかわからんのでcmでいいかも。
                [cm]
                ;infokey作成箇所を1つにまとめ、[crilbl]でイベントラベル番号f.labelを作成しておく。
                [iscript ]
                    switch(true){
                        case f.cinfo===2:f.infokey=f.cinfo;break;
                        case f.cinfo===4:f.infokey=f.cinfo;break;
                        case f.eveid===3:f.infokey=f.eveid;break;
                    }
                    //マスイベント以外の発火を初期値にする
                    f.ismdeve=false
                [endscript ]
                ;イベントラベル番号f.labelを作成
                [crilbl]
                ;call先にラベル名が存在するかチェック
                [iscript ]
                    for(let i=0;i<f.arlbl.length;i++){
                        tf.istn=f.label==f.arlbl[i]
                        if(tf.istn)break;
                    }
                [endscript ]
        ;     [endignore]
        ; [endif ]
            ;callをするためにIF+ignoreを分割。
                ;上書きするイベントがあればf.ismdeve=T
                [call storage="&'./mcr/mode/'+f.mode+'.ks'" target="&f.label"  cond="tf.istn&&tf.ismvev&&tf.ismvev_not!=true" ]
        
        ; [if exp="tf.ismvev" ]
        ;     [ignore exp="tf.ismvev_not" ]
                [ignore exp="f.ismdeve" ]
                    ;2を優先して発動させる
                    ;[mindev cond="f.cinfo==2"]
                    ;動作が被らないように共通キーを作成する。
                    ;@eval exp="if(f.cinfo===2)f.infokey=f.cinfo;"
                    [if exp="f.infokey===2"]
                        ;これが発生するときボタンを消す
                        [free name="ar" layer="fix"  cond="f.infokey===2"]
                        ;[call storage="evt/ent1.ks"  cond="f.infokey===2"]
                        [call storage="&'map/'+f.mpnm+'.ks'"  cond="f.infokey===2"]

                    [elsif exp="f.infokey===4" ]
                        ;4を発動させる。4はマップ移動専用。
                        ;@eval exp="if(f.cinfo===4)f.infokey=f.cinfo;"
                        ;これが発生するときボタンを消す
                        [free name="ar" layer="fix"  cond="f.infokey===4"]
                        ;移動先で2か4か区別のために入れる。
                        @eval exp="tf.warp=true" 
                        [call storage="&'map/'+f.mpnm+'.ks'"  cond="f.infokey===4"]
                        @eval exp="tf.warp=false" 

                    [elsif exp="f.infokey===3" ]
                        ;[objev cond="f.eveid==3"]
                        ;@eval exp="if(f.eveid===3)f.infokey=f.eveid;"
                        [destroy cond="f.infokey===3"]
                        [call storage="&'map/'+f.mpnm+'.ks'"  cond="f.infokey===3"]
                    
                    [endif ]
                [endignore ]

                [ignore exp="f.infokey===0"]
                    ;もっかい破壊
                    [destroy]
                    ;マップに登場するキャラクター・モノ宣言
                        [call storage="&'map/'+f.mpnm+'.ks'" target="*dec" cond="!f.isnmp" ]
                        [trace exp="tf.log='alpha.ks renew前'" ]
                    ;全体創造。レイヤー1読込処理をtrueに戻す(処理後falseになる)
                    @eval exp="f.isma=true"
                    [renew name="&f.mpnm"]
                    ;マップ読み込み済みの処理(1度だけの処理を行わない)
                    @eval exp="f.isnmp=true" 
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
                    if(f.ginfo==2){rt=0;break;}//画面外へマップ移動する時
                    if(f.binfo==2&&f.fps){rt=1;break;}
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
                [anim name="fieldb" left="&(f.obj.x===0)?f.pc.sz.x*-1:f.obj.x-f.pc.sz.x" top="&(f.obj.y===0)?f.pc.sz.x*-1:f.obj.y-f.pc.sz.y"  time="200" ]
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

    [macro name="noenter"]
        [iadv]
        #
        そっちに用はないね[l]戻ろう[p]
        [endadv]
        [mask time="50" graphic="./keepout.png" ]
        [knockback]
        [mask_off time="50"]
    [endmacro]
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

;進行先のイベントラベル番号と一致するf.labelを作成する。
    [macro name="crilbl"]
        [iscript ]
            //進んだと仮定したXY座標をZの向きから算出する
            //3の時はこれでいいが、2の時は発火してはいけない
            let x=f.reps.x, y=f.reps.y*1, z=f.reps.z, n=0;
            let axisX=f.gridx;
            if(f.infokey==3){
                if(z=='r'||z=='l'){
                    n=axisX.indexOf(x);
                    (z=='r')? n++ :n--;
                    x=axisX[n];     
                }
                if(z=='t'||z=='b'){
                    (z=='t')?y--:y++;
                }
            };

                x=axisX.indexOf(x);//アルファベットにしないパターン
            //これで発生中のイベントはxyの座標。
            /*
                xyがイベント範囲に含まれるものへジャンプする
                placeで設定した5つの数値と同じラベル名へジャンプ。

                マップ上に3の場所をスキャンして表す
                tf.thismap[0n][1~5]
                objのサイズX,Y、配置座標X,Y,イベントナンバー(ない場合1)
                例)
                tf.thismap[n][5]==3のnを求める
                X==3+0～1
                Y==4+0～2
                に一致するXYのとき、*&tf.thismap[n] に飛ぶ
            */
            if(x==-1)x=0;//X軸がAより左のときの処理1->0に修正(240430)
            //--------------ここまで全マップ共通-------------------

                n=[];//初期化

                var tm=tf.thismap;//長いので組みなおし    
                let a=tm.length-1;//tmの配列が何個あるのか調べる

                //f.eveid(2or3)の配列インデックスのみ取得
                for (let i=0;i<=a;i++){
                    if(tm[i][5]===f.infokey)n.push(i);
                    };
                  //alert(n);//234567正しい
                    
                    //1,1,0,9,2と一致させる
                    //現在は21722か21182が出る
                //XY座標と一致するイベント番号を算出する。
                let l=0,s;
                for (let i=0;i<=n.length-1;i++){
                    for (let l=0;l<=10;l++){
                        //3は配置座標X+1はモノのXサイズマス数
                        //例：横2縦1の横2部分に触れた時、横の1番目を割り出す。
                        if(x==tm[n[i]][3]+(tm[n[i]][1])-l){//後ろのは1まで減る 
                        //joinのundefinedエラーはここの数字を大きくする
                            for (let b=0;b<=20;b++){
                                if(y==tm[n[i]][4]+(tm[n[i]][2])-b)s=i;                 
                                if((tm[n[i]][2])-b===0)break ;
                            };
                        };
                        //1-1===0
                        if((tm[n[i]][1])-l===0) break ;
                    };
                };
                //2のときs==3にならなければならない
                //合ってる。nの0番目だから
                //alert(n)//undifinde
                //alert(n[s]);//0 undifinde
                //alert(tm[n[s]])//11622

                //tm[n[s]]==11092となるはずなんだよなあ<--21182になる
                f.label=tm[n[s]].join('');
            
        [endscript ]
    [endmacro]
[return ]