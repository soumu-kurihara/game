;このファイルは削除しないでください！
;
;make.ks はデータをロードした時に呼ばれる特別なKSファイルです。
;Fixレイヤーの初期化など、ロード時点で再構築したい処理をこちらに記述してください。
;
;
[iscript ]
f.sq=[]
f.sq['x']=$(".grid").width();
f.sq['y']=$(".grid").height();

//現在位置用の変数宣言
tf.cpos=[]
//前後左右の位置の変数宣言
tf.adps=[]
//現在座標の変数宣言
tf.loc=[]
tf.loc['x']=0
tf.loc['y']=0
//↑sleepgameで消える
[endscript ]

;make.ks はロード時にcallとして呼ばれるため、return必須です。
[return]

