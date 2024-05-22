/*
第一工場入口イベント集
呼び出し番号により呼ばれる箇所を変更する
callで呼び出す
*/

;ADV表示の準備------------------------------
[adv]
;イベントラベル番号f.labelを作成する---------
[crilbl]
;---------------------------------------------------

;----ここまで全てのマップ共通------


[jump target="&f.label" ]
[s]

*12743
;清掃機器
[bg storage="ent1/eve/trmng.jpg" time="50" ]

#
これは取るミングと呼ばれる清掃機器です。[p ]
[return ]
[s ]

*12943
;手洗い場
[bg storage="ent1/eve/tari.jpg" time="50" ]

#
ここは手洗い場です。[p]

[dialog cond="f.iswash==true" type="confirm" text="すでに手洗いは完了していますが、もう一度洗いますか？" target_cancel="*next" ]

[html ]
<!--
<iframe width="1280" height="720" src="https://www.youtube.com/embed/CbnZlB5pv1A?si=QhHYnjrcxbkLDQ1U&amp&controls=0&autoplay=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<iframe width="560"  height="315" src="https://www.youtube.com/embed/310BjKiIPAk" frameborder="0" style="position: absolute; left: 200px; top: 30px;"                                                         allowfullscreen></iframe>
<iframe width="1280" height="720" src="https://www.youtube.com/embed/CbnZlB5pv1A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture;" allowfullscreen></iframe>

-->
<iframe width="1280" height="720" src="https://www.youtube.com/embed/CbnZlB5pv1A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture;" allowfullscreen></iframe>



[endhtml]

@eval exp="f.iswash=false "

[wait time="15000"]
[glink target="*next" text="SKIP" name="skip" x="1000" y="60" color="btn_12_black"]


[wait time="15000"]

@eval exp="f.iswash=true "

;見終わったのボタンを出す

[free layer="fix" name="skip"  ]
[glink target="*next" text="見終わった" x="1000" y="60" color="btn_12_blue"]

[s]
*next
[wait_cancel]
[cm ]

#
[emb exp="f.iswash" ][r]
おわり。
[p]
;[awakegame ]
[return ]
[s ]

;踏んだ時に反応

*11622

#
マットを踏んだ。[p]

[return ]
[s]

*11682
[jump target="*skip11682" cond="f.isent"  ] 
[chara_show name="guard" time="200" left="800"   ]
[if exp="f.iswash" ]
    #門番さん
    確認ヨシ！本日も一日ご安全に！[p]

    ;一度Trueになったらこのイベントをスキップして通れる。
    @eval exp="f.isent=true" 
    [else]
        #門番さん
        あー、そこのあなた？[p]
        手洗い不足です、[l]ちゃんと[font color="red" ]30秒間[resetfont]洗ってください。[p]
        [knockback ]
[endif]
[chara_hide name="guard" time="500" pos_mode="false" ]
/*
#
[emb exp="f.iswash" ][r]

ここで認証する。[p]
*/
*skip11682
[return ]
[s ]

;マップごとに登場するモノや人を宣言しておく
*dec
[chara_new name="guard" storage="chara/fig/guard.png" jname="門番さん" height="720"   ]

[return]
[s]