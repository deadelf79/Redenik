Graphics3D 320,240,32

Plot 160,120

For radius=1 To 5
	For index=1 To 5
		x=(Sin(72*index+108))*(radius*20)+160
		y=(Cos(72*index+108))*(radius*20)+120
		
		Plot x,y
	Next
Next

SetFont LoadFont("arial",18)

x=(Sin(72*1+108))*110+160
y=(Cos(72*1+108))*110+120
Text x,y,"st",1,1

x=(Sin(72*2+108))*110+160
y=(Cos(72*2+108))*110+120
Text x,y,"dx",1,1

x=(Sin(72*3+108))*110+160
y=(Cos(72*3+108))*110+120
Text x,y,"iq",1,1

x=(Sin(72*4+108))*110+160
y=(Cos(72*4+108))*110+120
Text x,y,"ht",1,1

x=(Sin(72*5+108))*110+160
y=(Cos(72*5+108))*110+120
Text x,y,"cr",1,1

;warrior
st=12
dx=9
iq=8
ht=11
cr=10

st_x=(Sin(72*1+108))*(st*5)+160
st_y=(Cos(72*1+108))*(st*5)+120
dx_x=(Sin(72*2+108))*(dx*5)+160
dx_y=(Cos(72*2+108))*(dx*5)+120
iq_x=(Sin(72*3+108))*(dx*5)+160
iq_y=(Cos(72*3+108))*(dx*5)+120
ht_x=(Sin(72*4+108))*(dx*5)+160
ht_y=(Cos(72*4+108))*(dx*5)+120
cr_x=(Sin(72*5+108))*(dx*5)+160
cr_y=(Cos(72*5+108))*(dx*5)+120

Color 255,136,0

Line st_x,st_y,dx_x,dx_y
Line dx_x,dx_y,iq_x,iq_y
Line iq_x,iq_y,ht_x,ht_y
Line ht_x,ht_y,cr_x,cr_y
Line cr_x,cr_y,st_x,st_y

WaitKey
End