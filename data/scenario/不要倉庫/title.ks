
[cm]

@hidemenubutton
@clearstack
@bg storage ="title2.jpg" time=100
@wait time = 200

*start 

; [button x=135 y=230 graphic="title/button_start.png" enterimg="title/button_start2.png"  target="gamestart" keyfocus="1"]
; [button x=135 y=320 graphic="title/button_load.png" enterimg="title/button_load2.png" role="load" keyfocus="2"]
; [button x=135 y=410 graphic="title/button_cg.png" enterimg="title/button_cg2.png" storage="cg.ks" keyfocus="3"]
; [button x=135 y=500 graphic="title/button_replay.png" enterimg="title/button_replay2.png" storage="replay.ks" keyfocus="4"]

[macro name="ttlbtn"]
[button x="135" y="&230+90*mp.hgt" folder="image/title/" graphic="%a" enterimg="%b" activeimg="%c" target="*gamestart" exp="tf.slt=preexp" preexp="%px" ]
[endmacro ]

*smnbtn
[ttlbtn hgt="0" a="&'g'+0+'a.png'" b="&'g'+0+'b.png'" c="&'g'+0+'c.png'" px="0"]
[ttlbtn hgt="1" a="&'g'+1+'a.png'" b="&'g'+1+'b.png'" c="&'g'+1+'c.png'" px="1"]
[ttlbtn hgt="2" a="&'g'+2+'a.png'" b="&'g'+2+'b.png'" c="&'g'+2+'c.png'" px="2"]
[ttlbtn hgt="3" a="&'g'+3+'a.png'" b="&'g'+3+'b.png'" c="&'g'+3+'c.png'" px="3"]

@eval exp="tf.ps1='btn_fps',tf.ps2='btn_ttp'" 
[button height="150" x="800" y="&400+160*0" folder="image/title/" graphic="&tf.ps1+'1.png'" enterimg="&tf.ps1+'2.png'" target="*gamestart" exp="tf.slt=preexp" preexp="4" ]
[button height="150" x="800" y="&400+160*1" folder="image/title/" graphic="&tf.ps2+'1.png'" enterimg="&tf.ps2+'2.png'" target="*gamestart" exp="tf.slt=preexp" preexp="5" ]


;[button x=135 y=230 graphic="title/button_start.png" enterimg="title/button_start2.png"  target="gamestart" keyfocus="1"]
;[button x=135 y=320 graphic="title/button_load.png" enterimg="title/button_load2.png" role="load" keyfocus="2"]
;[button x=135 y=410 graphic="title/button_cg.png" enterimg="title/button_cg2.png" storage="cg.ks" keyfocus="3"]
;[button x=135 y=500 graphic="title/button_replay.png" enterimg="title/button_replay2.png" storage="replay.ks" keyfocus="4"]
[button x=135 y=590 graphic="title/button_config.png" enterimg="title/button_config2.png" role="sleepgame" storage="config.ks" keyfocus="5"]

[s]

*gamestart
;一番最初のシナリオファイルへジャンプする

; [dialog text="&tf.slt+''"]
; [return]
; [s ]
; [if exp="tf.slt==0"]
; @jump storage="scene1.ks"
; [endif ]
;TG.ftag.startTag("clickable", { width:x,height:y,x:(1280-x)/2,y:(720-y)/2,target:mp.tgt,color:'0xcccccc'} );


[iscript ]
if(tf.slt==0)TG.ftag.startTag("jump",{storage:"scene1.ks"});
if(tf.slt==1)TG.ftag.startTag("jump",{storage:"test.ks"});
if(tf.slt==2)TG.ftag.startTag("jump",{storage:"drpg.ks"});
if(tf.slt==3)TG.ftag.startTag("jump",{storage:"rpg.ks"});
if(tf.slt==4)TG.ftag.startTag("jump",{storage:"tare.ks"});
//if(tf.slt==5)TG.ftag.startTag("jump",{storage:"marge1t.ks"});

if(tf.slt==5)TG.ftag.startTag("jump",{storage:"testalpha.ks"});

[endscript ]
[s ]


