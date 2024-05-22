/*
タイトル改造

初めからと続きから
あとで実績確認ボタンなども。
*/

[cm]

@hidemenubutton
@clearstack

[iscript ]
    tf.n=0;
    if(f.end01)tf.n=1;
[endscript ]


@bg storage ="&'bg_title'+tf.n+'.jpg'" time=100

@wait time = 200

*start 

[image name="logo" layer="0" page="back"  storage="../image/title/logo_title.png" visible="true" x="26" y="10"   ]

[trans layer="0" time="1500" method="slideInUp"]

[wait time="1500" ]

[button name="stbtn01" x="610" y="420" graphic="title/btn_sts01_0.png" enterimg="title/btn_sts01_1.png" target="gamestart" keyfocus="1" exp="f.mode='01'"]
[button name="conbtn" x="976" y="536" graphic="title/btn_config0.png" enterimg="title/btn_config1.png"  ]
[button name="crebtn" x="976" y="611" graphic="title/btn_credit0.png" enterimg="title/btn_credit1.png"  ]
/*
[button x=135 y=230 graphic="title/btn_md011.png" enterimg="title/btn_md012.png"  target="gamestart" keyfocus="1" exp="f.mode='01'"]
[button x=135 y="&230+100" graphic="title/button_start2.png" enterimg="title/button_start3.png"  target="gamestart" keyfocus="2" exp="f.mode='none'" ]
[button x=135 y=590 graphic="title/button_config.png" enterimg="title/button_config2.png" role="sleepgame" storage="config.ks" keyfocus="5"]
*/
[s]

*gamestart
[cm ]
[clearfix ]

[image name="bgtitle" layer="0" folder="bgimage"  storage="&'bg_title'+tf.n+'.jpg'" visible="true"]
[wait time="500" ]
[anim name="bgtitle" width="2000"  left="-500" top="-400" ]
[mask time="2000" ]
[wait time="2000" ]
[free layer="0" name="bgtitle" ]
[free layer="0" name="logo" ]
[freeimage layer="base"]
[mask_off time="50" ]


[jump storage="map.ks" ]
[s ]
