[cm  ]
[clearfix]
[start_keyconfig]


;[bg storage="room.jpg" time="100"]

;メニューボタンの表示
;@showmenubutton

;メッセージウィンドウの設定
[position layer="message1" left=160 top=500 width=1000 height=200 page=fore visible=true]

;文字が表示される領域を調整
;[position layer=message1 page=fore margint="45" marginl="50" marginr="70" marginb="60"]

@layopt layer="0" visible="true"  


;キャラクターの名前が表示される文字領域
[ptext name="chara_name_area" layer="message1" color="white" size=28 bold=true x=180 y=510]

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

[macro name="cbtn"]
[button name="%name" x="%x" y="%y" layer="%layer|0"  graphic="btn.png"  visible="true" width="65.4545" height="65.4545" target="%tgt" fix="true" ]
[endmacro ]

[fuki_start ]

;通常のメッセージレイヤに対して、ふきだしに適応したいデザインを設定する
[font color="black"]
[position layer="message1" page="fore" radius="15" visible="true" color="white" opacity="255" border_size="3" border_color="black" ]
[current layer="message1" ]

;ふきだしの表示位置をキャラごとに設定する
[fuki_chara name="akane" left=200 top=&270+100 sippo_left=30  sippo="top" radius=15]
;いない
[fuki_chara name="others" left=250 top=500 max_width=700 fix_width=700 radius=0 ]



;ここまで前準備==============================================================================================================================================
;===========================================================================================================================================================
[bg storage="testboxA.jpg" time="50"]

;ボタン設置===============================================================┓
;入口
[cbtn name="btn0" x="607.2727" y="589.0909" tgt="*entrance"]
;ストリーム配信
[cbtn name="btn1" x="607.2727" y="65.4545" tgt="*stream"]
;質問コーナー
[cbtn name="btn1" x="410.91" y="261.82" tgt="*question"]
;面談
[cbtn name="btn1" x="803.6363" y="327.2727" tgt="*meeting"]

;キャラクターを配置
[chara_show name="akane" left="&1280-400" top="&720-600" time="50" wait="true" ]


@layopt layer=message1 visible=true
;[cm ]
#あかね
キャラクターで案内をすることも可能です。
[wait time="200" ]
[chara_mod name="akane" face="happy"  ]

[glink color="btn_24_red" target="*titlejump"  x="&1280-250" y="0" width="200" text="タイトルに戻る" ]

[s]

;---------------------------------------------------------------------------------------------

*titlejump

[fuki_stop]
[cm ]
[clearfix ]
[chara_hide_all time="50" ]
[chara_delete name="akane" ]
[layopt layer="message1" visible="false"  ]
@jump storage="title.ks" 

[s]


*entrance
[dialog text="入口です。" ]
[return ]
[s]

*stream
[dialog text="youtubeなどに繋げてストリーム配信を見れます。"]
[return]
[s]

*question
[dialog text="質問のbotに繋げます。Slideなど。"]
[return]
[s]

*meeting
[dialog text="ZOOMに繋げて1対1の対面接ができます。"]
[return]
[s]