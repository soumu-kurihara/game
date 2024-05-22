/*
基本動作を作成。
1.自機をボタンで動かす
2.自機を中心に置いて背景を動かす
3.自分のマップ立ち位置で1と2を切り替える

*/

;他ページから飛んできたときの処理
[destroy]

[start_keyconfig]


;タイトルに戻るボタン
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

;-------------------------------------------
;仮マスを表示
[image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.jpg" top="0" left="&1280/2-40" wait="true" ]

;マクロ呼出
@call storage="mcr/mov.ks"
@call storage="mcr/evt.ks" 

;背景(動可)を出現
[image visible="true"  layer="0" folder="bgimage" storage="testbox2.jpg" ]
;キャラクター(自機)を出現
;このマップでの初期位置
@eval exp="f.pc.ps.y=720-80,f.pc.ps.x=1280/2-40" 
[chara_show name="player_mt" left="&f.pc.ps.x"  top="&f.pc.ps.y" time="50"]
[s]

;-------------------------------------------

*ahead
;キャラの画像を切り替える
[direction]

;現在位置を取得、座標取得、イベント処理
;[dialog text="なう" ]
;現在地を取得
[get_loc]
;イベント発火
[trgev]
;周辺4マスの数値を取得、向いている方向を取得
[get_arnd]
;[testmcr]
[return ]
[s ]

;-------------------------------------------

*gotitle
[dialog type="confirm" text="タイトルに戻りますか？" target="*exit"  ]
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

[s ]

*exit
[destroy]
[chara_delete name="player_mt"]
[jump storage="title.ks"]

[s ]
