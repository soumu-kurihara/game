;DRPGのように一人称視点で移動していくタイプのテスト
[cm  ]
[clearfix]
[start_keyconfig]


;ボタンを表示

@eval exp="tf.hoge=2" 

[macro name="arbtn" ]
[button name="%name" graphic="%gra" x="%x" y="%y" width="90" height="90" exp="tf.hoge=tf.hoge+preexp*1" preexp="%px" fix="true" target="*ado"  ]
[endmacro ]

[arbtn name="arT" gra="arT.png" x="153.6697" y="414.9908" px="1"]
[arbtn name="arR" gra="arR.png" x="&153.6697+90" y="&414.9908+90" px="0"]
[arbtn name="arB" gra="arB.png" x="&153.6697+0" y="&414.9908+90+90" px="-1"]
[arbtn name="arL" gra="arL.png" x="&153.6697-90" y="&414.9908+90" px="0"]

;表示内容
[macro name="read" ]
[freeimage layer="0" ]
[cm ]
[iscript ]
(tf.hoge<=9)?tf.piyo=0:tf.piyo='';
[endscript ]
[bg storage="&'drpg/'+tf.piyo+tf.hoge+'.jpg'" time="50"]
[endmacro ]

;画像を表示してリンクを貼る(notbutton)
[macro name="imgbtn" ]

[image layer="0" visible="true" name="&mp.name" folder="./bgimage/drpg/" storage="%sto" pos="center" wait="true" ]
[wait time="100" ]

[iscript]
let x= $('.'+mp.name).width()
let y= $('.'+mp.name).height()
TG.ftag.startTag("clickable", { width:x,height:y,x:(1280-x)/2,y:(720-y)/2,target:mp.tgt,color:'0xcccccc'} );
[endscript ]
[s ]

[endmacro ]


;=====================================================
[jump target="*ado" ]
[s ]
*y1
[read]
;入口を設置
[dialog type="confirm" text="タイトルに戻りますか？" target="*exit"  ]
[s]
*exit
[cm ]
[clearfix ]
[clearstack ]
[jump storage="title.ks"]
[s ]
*y2
[read]
;ここからスタート
[s ]
*y3
[read]

[s ]
*y4
[read]
;ここに面談コーナーを出現
[imgbtn name="meet" sto="meeting.png" tgt="*meet"]
*meet
[dialog text="面談用のZOOMを開くリンクを貼ります。" ]
@jump target="*y4" 
[s ]
*y5
[read]

[s ]
*y6
[read]
;ここに質問コーナーを出現
[imgbtn name="ques" sto="question.png" tgt="*ques"]
*ques
[dialog text="質問botが起動するリンクを貼ります。" ]
@jump target="y6" 
[s ]
*y7
[read]

[s ]
*y8
[read]

[s ]
*y9
[read]
;ここにストリームを出現
[imgbtn name="stream" sto="stream.png" tgt="*stream"]
*stream
[dialog text="ストリーム配信しているyoutubeへのリンクを貼ります。" ]
@jump target="*y9" 
[s ]
*y10
[read]
[s ]

*ado
;押したボタンにより、target先を変更する処理。その後ジャンプ。
[iscript ]
if(tf.hoge>10)tf.hoge=10;
if(tf.hoge<1)tf.hoge=1;
tf.fuga='y'+tf.hoge
[endscript ]

[clearstack ]
[jump target="&tf.fuga" ]
[s ]