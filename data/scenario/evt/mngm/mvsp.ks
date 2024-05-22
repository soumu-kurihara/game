/*

手洗いミニゲーム1

1.映像が流れる
2.30秒のカウントダウンが始まる
3.10秒経過で「SKIP」の表示
4A.30秒待ち続けるとTrue
4B.SKIPを押すとFalse


*/



[cm  ]
[clearfix]
[start_keyconfig]

;タイトルに戻るボタン
;[glink text="タイトルに戻る" target="*gotitle" x="&1280-300" y="0" color="btn_01_white" fix="true"]
[button graphic="config/c_btn_back.png" x="&1280-100" y="0" target="*titlego" fix="true" ]


[bg storage="room.jpg" time="100"]

;メニューボタンの表示
@showmenubutton

;メッセージウィンドウの設定
[position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=true]
[current layer="message0" ]

;文字が表示される領域を調整
[position layer=message0 page=fore margint="45" marginl="50" marginr="70" marginb="60"]


;メッセージウィンドウの表示
@layopt layer=message0 visible=true

;キャラクターの名前が表示される文字領域
[ptext name="chara_name_area" layer="message0" color="white" size=28 bold=true x=180 y=510]

;上記で定義した領域がキャラクターの名前表示であることを宣言（これがないと#の部分でエラーになります）
[chara_config ptext="chara_name_area"]

;このゲームで登場するキャラクターを宣言
;akane
[chara_new  name="akane" storage="chara/akane/normal.png" jname="あかね"  ]
;キャラクターの表情登録
[chara_face name="akane" face="angry" storage="chara/akane/angry.png"]
[chara_face name="akane" face="doki" storage="chara/akane/doki.png"]
[chara_face name="akane" face="happy" storage="chara/akane/happy.png"]
[chara_face name="akane" face="sad" storage="chara/akane/sad.png"]


;yamato
[chara_new  name="yamato"  storage="chara/yamato/normal.png" jname="やまと" ]


;[glink  text="button" target="*next"  color="red" fix="true"]
;[glink target="*Part2.1" text="恋人を助ける" y="110" color="green" size="24" x="220" width="440"]

;[call target="*Sub_CountDownFive"]

;[wait time="5000" ]


;-----------------------------------------------------------------------
;-----------------------------------------------------------------------


[html top=100 left=300]

<iframe width="560" height="315" src="https://www.youtube.com/embed/CbnZlB5pv1A?si=QhHYnjrcxbkLDQ1U&amp;controls=0&autoplay=1&mute=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
[endhtml]

@eval exp="tf.hoge='途中でやめた' "

[wait time="15000"]
[glink target="*next" text="SKIP" name="skip" x="1000" y="60" color="btn_12_black"]


[wait time="15000"]

@eval exp="tf.hoge='最後まで見た' "

;見終わったのボタンを出す

[free layer="fix" name="skip"  ]
[glink target="*next" text="見終わった" x="1000" y="60" color="btn_12_blue"]

[s]
*next
[cm ]

#
[emb exp="tf.hoge" ][r]
おわり。
[p]
[s]
;-----------------------------------------------------------------------
;-----------------------------------------------------------------------











;-------------------------------------------------------------------------------------

; == 08_wait_cancel.ks =====================================
 
; [wait_cancel]の解説を行います。
 
; ==========================================================
 
 
 
; [set_default_view]
; これは独自マクロです(→macro.ks)。
; 解説画面を作成します。
;[set_default_view]
 
 
 
;-----------------------------------------------------------
*Part1
;-----------------------------------------------------------
 
#akane
最近追加されたタグに［wait_cancel］があるの![p]
これは文字通り［wait］をキャンセルするタグ。[p]
［wait］中に別のシナリオに飛ぶ可能性がある、というときに活躍するよーー!![p]
具体的に言うと……[]とか、[]とか……。[p]
そういう演出が組めるね。[p]
じゃあ早速やってみよう！[p]
私がクイズを出すから、直観で答えてね！[p]
#akane:doki
どきどき２択クイ～～ズ!![p]
;-----------------------------------------------------------
*Part2
;-----------------------------------------------------------
#akane:default
[][p]
[][l]
; [glink]×3
; 選択肢を3個出します。
[glink target="*Part2.1" text="恋人を助ける" y="110" color="green" size="24" x="220" width="440"]
[glink target="*Part2.2" text="母親を助ける" y="190" color="green" size="24" x="220" width="440"]
[glink target="*Part2.3" text="あかねを助ける" y="270" color="green" size="24" x="220" width="440"]
; [call]
; カウントダウン画像つきで5秒ウェイトするサブルーチンを呼びます。
[call target="*Sub_CountDownFive"]
; [glink]
; サブルーチンから帰ってきたら（5秒待ったら）、新たな選択肢を提示します。
[glink target="*Part2.4" text="どちらも助ける!!" y="350" color="red" size="24" x="220" width="440"]
; [wait]
; さらに｢5秒待て｣という[wait]命令を出す
[wait time="5000"]
; [jump]
; 5秒待ったら*Part3へ
[jump target="*Part3"]
;-----------------------------------------------------------
*Part2.1
;-----------------------------------------------------------
; 恋人を助ける。
; [clearstack]
; サブルーチンラベルを読んでいる最中にジャンプしてくる可能性があります。
; その場合、callスタックが残ったままになりますので、
; callスタックを空にしておきます。
[clearstack]
; [free]
; タイマーを消します。
[free layer="1" name="timer"]
; [wait_cancel]
; [wait]命令が生きている場合（すなわち[wait]での待機中にボタンをクリックしてジャンプしてきた場合）、
; 何も対策をしないと「ジャンプ先で勝手にテキストが進む」現象が発生します。
; それを避けるために、[wait]命令を[wait_cancel]によって殺しておく必要があります。
; [wait]命令がすでに死んでいる場合は何も起こりません。
[wait_cancel]
; [cm]
; ボタンなどを消します。
[cm]
#akane:
そう……君は恋人を選ぶんだ……。[p]
#akane:doki
クイズの場が場なら、あなたは死んでるよ！[p]
もっかい!![p]
[jump target="*Part2"]
;-----------------------------------------------------------
*Part2.2
;-----------------------------------------------------------
; 母親を助ける。
[clearstack]
[free layer="1" name="timer"]
[wait_cancel]
[cm]
#akane
そう……君は母親を選ぶんだ……。[p]
#akane:doki
クイズの場が場なら、あなたは死んでるよ！[p]
もっかい!![p]
[jump target="*Part2"]
;-----------------------------------------------------------
*Part2.3
;-----------------------------------------------------------
; あかねを助ける。
[clearstack]
[free layer="1" name="timer"]
[wait_cancel]
[cm]
#akane:doki
そ、そういうのはいいからっ![p]
#akane:default
ちゃんと答えてね!![p]
[jump target="*Part2"]
;-----------------------------------------------------------
*Part2.4
;-----------------------------------------------------------
; どちらも助ける。
[wait_cancel]
[cm]
#akane:angry
どっちかって言ったでしょー。[p]
#akane:happy
ヒントは、[]!![p]
[jump target="*Part2"]
;-----------------------------------------------------------
*Part3
;-----------------------------------------------------------
; 10秒待つと飛ばされるラベルです。
; [cm]
; ボタンを消します(フリーレイヤーの解放)。
; ここに飛んできたということは、もう[wait]は残っていないので、
; [wait_cancel]は不要です。
[cm]
#akane:default
……正解。[p]
#akane:happy
そう、答えは[]!!!　それが正しい答えなの。[p]
#akane:default
……ふふ、なんてね。[p]
このセリフ、言ってみたかったんだ～。[p]
#akane:happy
付き合ってくれて、ありがとー!![p]
[jump storage="select.ks"]
;-----------------------------------------------------------
*Sub_CountDownFive
;-----------------------------------------------------------
; 5秒カウントダウンしてからリターンする、サブルーチンラベルです。
; [keyframe]～[endkeyframe]
; 拡縮するキーフレームアニメーション。
[keyframe name="kanim_timer"]
[frame p=" 0%" scale="1.2"]
[frame p=" 20%" scale="1"]
[endkeyframe]
; [image]
; 吹き出し画像を出します。
[image name="timer" layer="1" storage="timer.png" x="440" y="25" width="100"]
; [ptext]
; 吹き出し画像の上に文字を出します。
[ptext name="timer,timer_text" layer="1" text="5" size="38" x="480" y="33" color="0x000000" bold="bold" edge="0x000000"]
; [wait]
; 文字を出す処理と画像を出す処理の完了を確実に待つため、1ミリ秒待ちます。
; 深い意味はないです。
[wait time="1"]
; [kanim]
; 1ループあたり長さ1秒で、永久にループするキーフレームアニメーションを適用します。
[kanim name="timer" time="1000" keyframe="kanim_timer" count="infinite"]
; [wait][ptext]×4
; 1秒待つ→ptextでテキストを書き換えることを繰り返します。
; name="timer_text" overwrite="true" に着目してください！
; これを指定することで、新規のptextオブジェクトの作成を行わず、
;「既存のptextオブジェクトの内容の書き換え」が行えます。
[wait time="1000"]
[ptext text="4" overwrite="true" name="timer_text" layer="1" x="0" y="0"]
[wait time="1000"]
[ptext text="3" overwrite="true" name="timer_text" layer="1" x="0" y="0"]
[wait time="1000"]
[ptext text="2" overwrite="true" name="timer_text" layer="1" x="0" y="0"]
[wait time="1000"]
[ptext text="1" overwrite="true" name="timer_text" layer="1" x="0" y="0"]
[wait time="1000"]
; [free]
; 5秒待ちましたので、[image][ptext]で出した画像とテキストを削除します。
[free layer="1" name="timer"]
; [return]
; このラベルはサブルーチンとして呼ばれますので、
; 最後にリターンでもとの場所に帰ります。
[return]