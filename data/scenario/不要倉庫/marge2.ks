/*
・キャラマップ切り替え処理追加
・マクロの統合と簡略化
10/28
*/

;他ページから飛んできたときの処理
[destroy]

[start_keyconfig]

[layopt layer="0" visible="true"  ]
[layopt layer="1" visible="true"  ]

;9マス用(既存)このサイズを起点にマスのサイズを変更するのでウィンドウサイズに合うようになる
[image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.jpg" top="0" left="&1280/2-40" wait="true" ]

;========================マクロ置場
;margeとalphaのmarge。システム変更用にさらにこれで上書きする。
@call storage="mcr/margemp2.ks"

;マクロ呼出 ->効果が被っているので統合。また状況により呼び出すものを変更する？
;@call storage="mcr/margemp.ks"
@call storage="mcr/evt.ks"

;testalpha用マクロ置場。一時整理用。
;@call storage="mcr/testalphamcr.ks"


;========================マクロ置場


;マップごとに置く↓
;リセットポイントの初期化
@eval exp="f.reps=[]" 
;-------------------------------------------

;ttpかfpsかを宣言する(マップ切り替えの度)
@eval exp="f.isfps=false" 
;キャラクターの初期座標(あとで自動化)
@eval exp="f.pc.ps.y=f.sq.y*1,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*0" 

;マップに登場するキャラクター登録(あとで別ファイルにする)
[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]


[renew name="ent1ttp9"]

*return
[clearstack ]
;@eval exp="console.log(f.map.tare.loc)" 使い方思い出すために残してる
[s ]

*ahead
;ttpの時使わない
/*
現在fps切り替えができなくなってる
*/
[A name="ent1ttp9" cond="f.isfps==true"]

;======共通=====
[G]
[E name="ent1ttp9"]
[H name="ent1ttp9"]
[I]
;デベ
    [ptext size="30" bold="true" layer="0" color="red"  name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="400"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="green"  name="c"  text="&'現在位置はX='+f.povx+',Y='+f.povy" x="600" y="450"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="blue"  name="f"  text="&'動く力はX='+f.pc.ps.x+',Y='+f.pc.ps.y" x="600" y="500"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="red"  name="i"  text="&'モード：'+f.ismvb" x="600" y="550"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="green"  name="j"  text="&'端＆現在地：'+tf.eg+'/'+tf.nx" x="600" y="600"  overwrite="true"]
    [ptext layer="0" color="violet" name="g" text="&'前のイベント'+f.ginfo" x="600" y="200" size="50"  overwrite="true"       ]
    [ptext layer="0" color="aqua" name="h" text="&'後のイベント'+f.binfo" x="600" y="300" size="50"  overwrite="true"       ]

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

;==================================================
;==================================================



/*
何を知りたいのか

振り返ったあと、振り返った先に移動しようとすると
マップ移動のとき動かない。+80のはずが0。
その次は360と80に0を足した3600，80になり飛ぶ。


pcpsはため込むので、ため込むpcpsとそうじゃないpcpsに分割する？
nxに渡しても無限増のpcpsを渡すので意味がない

    ;nxは初期値だけで、あとはnx.xyを交互に使えばいいのでpcmpを入れる必要なくない？
    ;そうするとmpはどこにも使われないのでいらなくない？

多分objに入れるのをnx交互にすれば解決すると思うが

pcps,mppsはデータ上のキャラの位置として扱う。
nx.pxmpは画面上の見える位置として扱う。
nxは1番最初の初期値だけpcpsmppsと同じ。
あとは独立して動く。f.ismvbによりnxの種類を切り替えて記録、mvに渡す。

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
ボタンを押すと、pcpsの値が増減し、
pcpsをtf.loc.xに変換、
tf.loc.xでf.pov.xを入れて、
f.povxでf.gbcinfoが決まり、イベントが発生する。
pcpsの値でキャラクターが動く。(絶対値)
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
*/

