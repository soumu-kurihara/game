/*

ver1.ksとtare.ksのマージ。
基本機能とマクロの整理を行う。
最終的に、呼び出す種類をオーダーメイドするとマップを自動作成する仕組みにする。


*/

;他ページから飛んできたときの処理
[destroy]

[start_keyconfig]

[layopt layer="0" visible="true"  ]
[layopt layer="1" visible="true"  ]
;タイトルに戻るボタン
;[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

;-------------------------------------------
;2種の共通事前呼出

;仮マスを表示 ->これを透明な画像に変更しておく
;9マス用(既存)
[image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.jpg" top="0" left="&1280/2-40" wait="true" ]
;12マス用
;[image name="grid" width="&720/12"  time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.jpg" top="0" left="&1280/2-40" wait="true" ]


;マクロ呼出 ->効果が被っているので統合。また状況により呼び出すものを変更する？
; @call storage="mcr/mov.ks"
; @call storage="mcr/evt.ks" 
; @call storage="mcr/pov.ks" 

@call storage="mcr/margemp.ks"
@call storage="mcr/evt.ks"

;firstとかtitleの次とかに置いとく↑


;マップごとに置く↓
;リセットポイントの初期化
@eval exp="f.reps=[]" 
;-------------------------------------------

;ttpかfpsかを宣言する(マップ切り替えの度)
@eval exp="f.isfps=false" 
/*
;統合型
[map_load name="tare"]
[map_bld name="tare"]

;↓キャラ初期位置をどこかに入れる(マップごとに異なる)
;f.sq.x*3.5は正方形としたときの左上初期位置。
;これはタレマップの初期位置
@eval exp="f.pc.ps.y=0,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*3" 
*/
/*
現状
見下ろし型(TTP)の切り替えボタンができていない
*/
/*
[map_load name="ent1"]
[map_bld name="ent1"]

;入口1の初期位置
@eval exp="f.pc.ps.y=f.sq.y*1,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*0" 
;[dialog text="ここまでOK" ]
*/
/*
[map_load name="ent1ttp"]
[map_bld name="ent1ttp"]
*/

;キャラクターの初期座標(あとで自動化)
@eval exp="f.pc.ps.y=f.sq.y*1,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*0" 

;マップに登場するキャラクター登録(あとで別ファイルにする)

[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]


;イベントから戻るときに。sleepgameは連続稼働させると壊れるので使用不可。
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

    ;マップを呼び出す
    [image visible="true"  layer="0" folder="bgimage" storage="&tf.str+'.jpg'" ]

    ;キャラクター(自機)を出現(f.povzの方向で出現させる)
    [chara_show name="player_mt" face="&f.povz+'0'" left="&f.pc.ps.x"  top="&f.pc.ps.y" time="50"]

    ;ボタンを出す
    [crbtn]
[endmacro]

[renew name="ent1ttp9"]

*return
[clearstack ]
;@eval exp="console.log(f.map.tare.loc)" 使い方思い出すために残してる
[s ]
;-------------------------------------------
;-------------------------------------------
;見下ろし型の時の呼出

;マップを呼び出す
[image visible="true"  layer="0" folder="bgimage" storage="testbox2.jpg" ]
;キャラクター(自機)を出現
;このマップでの初期位置
@eval exp="f.pc.ps.y=720-80,f.pc.ps.x=1280/2-40" 
[chara_show name="player_mt" left="&f.pc.ps.x"  top="&f.pc.ps.y" time="50"]

[s]

;-------------------------------------------
/*
↑
状況によって切り替えるし、同じところは統合する。
↓
*/
;-------------------------------------------
;一人称視点型の時の呼出

;pov.ksで登録した最初の画像が表示される(あってもなくてもいいかも)
;[entbg]

;このマップでの初期位置(80は1マス)
;@eval exp="f.pc.ps.y=720-80,f.pc.ps.x=1280/2-40" 
;初期位置は『d1b』(0から数える)
;f.sq.x*3.5は正方形としたときの左上初期位置。
@eval exp="f.pc.ps.y=0,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*3" 

[s]
;-------------------------------------------
;-------------------------------------------

;移動ボタンを押したあとの処理
*ahead
;処理が終わるまでボタンを非表示にする
;[clearfix ]

;あとで機能を統合

/*
[A name="tare"]
[B name="tare"]
[C name="tare"]

[A name="ent1"]
[B name="ent1"]
[C name="ent1"]

[A name="ent1ttp"]
[B name="entttp"]
[C name="ent1ttp"]
*/
[A name="ent1ttp9" cond="f.isfps==true"]

[B name="ent1ttp9"]
[clearstack ]

[C name="ent1ttp9"]
;[dialog text="ここまでOK" ]

; @eval exp="alert((tf.lup)+'//'+(f.sq.x)+'//'+f.pc.ps.x)" 
; @eval exp="alert((tf.lup)+'//'+(f.sq.y)+'//'+f.pc.ps.y)" 

;[return ]
/*
[clearstack ]
[wait_cancel]
[cm]
;ボタン復活
;### 操作ボタンを表示
[arbtn name="arT" gra="arT.png" x="&f.btnTx+0"  y="&f.btnTy+0"     px="'T'"]
[arbtn name="arR" gra="arR.png" x="&f.btnTx+90" y="&f.btnTy+90"    px="'R'"]
[arbtn name="arB" gra="arB.png" x="&f.btnTx+0"  y="&f.btnTy+90+90" px="'B'"]
[arbtn name="arL" gra="arL.png" x="&f.btnTx-90" y="&f.btnTy+90"    px="'L'"]
*/
[jump target="*return" ]
[s ]

;-------------------------------------------
;その他compare
*gotitle
[dialog type="confirm" text="タイトルに戻りますか？" target="*exit"  ]
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

[s ]

*exit
[destroy]
[chara_delete name="player_mt"]
[jump storage="title.ks"]

[s ]


