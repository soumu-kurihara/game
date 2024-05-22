;一番最初に呼び出されるファイル

[title name="クリハラのゲーム"]

[stop_keyconfig]


;ティラノスクリプトが標準で用意している便利なライブラリ群
;コンフィグ、CG、回想モードを使う場合は必須
@call storage="tyrano.ks"

;ゲームで必ず必要な初期化処理はこのファイルに記述するのがオススメ

;メッセージボックスは非表示
@layopt layer="message" visible=false

;最初は右下のメニューボタンを非表示にする
[hidemenubutton]


;基本動作まとめマクロ
@call storage="mcr/bsc.ks"

;共通JSfunction読み込み
@loadjs storage="../scenario/js/style.js"

;仮テスト
;@jump storage="map/maptemplate.ks" 

;タイトル画面へ移動
;@jump storage="testalpha.ks"

; [s ]
;@jump storage="evt/mngm/mvsp.ks"
;@jump storage="marge1t.ks"
;@jump storage="title.ks"
@eval exp="tf.count=0"
@jump storage="titlever2.ks"
[s]


