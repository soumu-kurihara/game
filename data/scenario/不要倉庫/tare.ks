/*
あとでver1と動作を統合する

*/

;他ページから飛んできたときの処理
[destroy]

[start_keyconfig]

[layopt layer="0" visible="true"  ]
;タイトルに戻るボタン
[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white"]

;-------------------------------------------
;仮マスを表示
[image name="grid" time="50"   visible="true" layer="1" folder="bgimage" storage="sq80.jpg" top="0" left="&1280/2-40" wait="true" ]

;マクロ呼出
@call storage="mcr/mov.ks"
@call storage="mcr/evt.ks" 
@call storage="mcr/pov.ks" 

;pov.ksで登録した最初の画像が表示される(あってもなくてもいいかも)
;[entbg]

;このマップでの初期位置(80は1マス)
;@eval exp="f.pc.ps.y=720-80,f.pc.ps.x=1280/2-40" 
;初期位置は『d1b』(0から数える)
;f.sq.x*3.5は正方形としたときの左上初期位置。
@eval exp="f.pc.ps.y=0,f.pc.ps.x=(f.sq.x*3.5)+f.sq.x*3" 

[dialog text="方向キーを押してください"]
[s]

;-------------------------------------------
;ボタンを押すと飛ぶ先
*ahead
;[dialog text="ボタンを押したよ" ]
;現在地を取得
[get_loc]

;向きと座標移動
[directionpov]

;イベント発火
[trgev]

;背景切り替え
[cngbg]

;移動判定後の現在値の四方の変数を算出、前後1マスの変数を取得(f.ginfo,f.binfo)
[get_arndpov]

[return ]
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