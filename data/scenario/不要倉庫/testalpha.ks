/*
9マス以上のマップの処理方法の模索


キャラクターは中央に固定、
キャラクターの位置情報は常に変化
マップ画像は位置情報が中央にくるようにする

草案

9マスの枠を作る
E5位置に常にキャラがいるようにする
マップの端で9マス枠が進めない場合のみ、キャラがE5から動く

要は見た目は移動せず、データは移動しているという状態にする
map_loadはiまでなので、aqまで上げれば全ていける。
というか、アルファベットを数字に変更するのを作れば行ける。

んでもってE5ではなく、1980/2,720/2のE5範囲の数値内


*/

;テスト用というか、jumpで戻ってくる用変数
@eval exp="f.pg='mcr/testalphamcr.ks';f.pghr='testalpha.ks';" 

;他ページから飛んできたときの処理
[destroy]
;マップを初期化
@eval exp="f.isnmp=false" 

[start_keyconfig]

[layopt layer="0" visible="true"  ]
[layopt layer="1" visible="true"  ]

;9マス用(既存)このサイズを起点にマスのサイズを変更するのでウィンドウサイズに合うようになる
[image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.png" top="0" left="&1280/2-40" wait="true" ]

;========================マクロ置場

;マクロ呼出 ->効果が被っているので統合。また状況により呼び出すものを変更する？
@call storage="mcr/testalphamcr.ks"
@call storage="mcr/evt.ks"

;========================マクロ置場

;スタートだけの暫定処置.ここで最初に飛ぶマップを決めている
@eval exp="f.mpnm='f201_48_18_vgt';f.isfps=false;" cond="f.isnmp==false"
;fpsはマップごとに記載箇所があるのでここで宣言いらないかも。


;マップ呼び出し(マップに必要なものを読み込ませてrenew)
[map_smn]
;[map_smn nm="&f.mpnm" fps="f"]
;マップ読み込み済みの処理(1度だけの処理を行わない)
@eval exp="f.isnmp=true" 

*return
[start_keyconfig ]
[clearstack ]
;@eval exp="console.log(f.map.tare.loc)" 使い方思い出すために残してる
[s ]

*ahead
[stop_keyconfig ]
;ttpの時使わない
/*
現在fps切り替えができなくなってる
*/
[A cond="f.isfps==true"]

;======共通=====
;Gの中のB1に使用
[G name="&f.mpnm"]
[E]
;Hのなかのcngbg(fps用),B1に使用
[H name="&f.mpnm"]
[I name="&f.mpnm"]
;デベ
    [ptext size="30" bold="true" layer="0" color="red"  name="a"  text="&'現在位置はX='+tf.loc.x+',Y='+tf.loc.y" x="600" y="400"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="green"  name="c"  text="&'現在位置はX='+f.povx+',Y='+f.povy" x="600" y="450"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="blue"  name="f"  text="&'動く力はX='+f.pc.ps.x+',Y='+f.pc.ps.y" x="600" y="500"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="red"  name="i"  text="&'モード：'+f.ismvb" x="600" y="550"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="green"  name="j"  text="&'端＆PC現在地：'+tf.eg+'/@/'+tf.nx" x="600" y="600"  overwrite="true"]
    [ptext layer="0" color="violet" name="g" text="&'前のイベント'+f.ginfo" x="600" y="200" size="50"  overwrite="true"       ]
    [ptext layer="0" color="aqua" name="h" text="&'後のイベント'+f.binfo" x="600" y="300" size="50"  overwrite="true"       ]

    [ptext size="30" bold="true" layer="0" color="red"  name="l"  text="&'現在マップ内部数値はX='+f.nx.mp.x+',Y='+f.nx.mp.y" x="600" y="100"  overwrite="true"]
    [ptext size="30" bold="true" layer="0" color="blue"  name="m"  text="&'オブジェ絶対値はX='+f.obj.x+',Y='+f.obj.y" x="600" y="80"  overwrite="true"]

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

*gotitle2
    ;現在座標を記録する
        [iscript ]
            //これだと同じマスのイベントが発生しなくなる
            if(!f.istrs)f.cinfo=0;
            f.reps.x=f.povx
            f.reps.y=f.povy
            f.reps.z=f.povz
        [endscript ]
        [destroy]

        [jump storage="menu.ks" ]
        ;新機能用にこっちに一時変更
        ;[jump storage="menuver2.ks" ]
        [s ]
*remenu
    ;menuから戻ってきたとき
        ;もっかい破壊
        [destroy]
        ;全体創造
        [renew name="&f.mpnm"]
        ;[map_smn]
        

;[dialog text="menuを開く予定" ]
;[jump]

[s]

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

