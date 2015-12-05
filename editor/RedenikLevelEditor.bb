Graphics3D 800,600,32,2

Global maxw=50, maxh=50
Dim array(maxw,maxh)
Global size=32,fill=False
Global xoff,yoff,speed=4

;sample map data
For x=0 To maxw-1
	For y=0 To maxh-1
		array(x,y)=1	
	Next
Next
array(1, 1 )=0  ; _
array(2, 1 )=-1 ; trader
array(3, 1 )=-2 ; inn
array(4, 1 )=-3 ; quest
array(5, 1 )=-4 ; bed
array(6, 1 )=-5 ; chest
array(7, 1 )=-6 ; npc-man
array(8, 1 )=-7 ; npc-woman
array(9, 1 )=-8 ; npc-nosex
array(10,1 )=-9 ; npc-ally
array(11,1 )=-10 ; npc-enemy

For x=0 To 29
	array(x,0)=255
	array(x,29)=255
	array(0,x)=255
	array(29,x)=255
Next

While Not KeyHit(1)
	Cls
	; map render
		Color 255,255,255
		For x=0 To maxw-1
			For y=0 To maxh-1
				Select array(x,y)
				; EVENTS
				; trader
				Case -1
					fill=True
					Color 0,128,0
				; inn
				Case -2
					fill=True
					Color 128,200,0
				; quest
				Case -3
					fill=True
					Color 0,128,128
				; bed
				Case -4
					fill=True
					Color 150,0,128
				; chest
				Case -5
					fill=True
					Color 255,200,0
				; npc-man
				Case -6
					fill=True
					Color 0,128,255
				; npc-woman
				Case -7
					fill=True
					Color 255,0,128
				; npc-nosex
				Case -8
					fill=True
					Color 255,128,255
				; npc-ally
				Case -9
					fill=True
					Color 0,200,0
				; npc-enemy
				Case -10
					fill=True
					Color 200,0,0
				; _
				Case 0
					fill=True
					Color 32,32,32
				; TILES
				; empty
				Case 1
					fill=False
					Color 255,255,255
				; map border
				Case 255
					fill=False
					Color 200,128,0
				End Select
				Rect xoff+x*size,yoff+y*size,size+1,size+1,fill
			Next
		Next
		Color 0,0,0
	; editor render
	Color 0,0,0
	Rect GraphicsWidth()-200,0,200,GraphicsHeight()
	Color 255,255,255
	Rect GraphicsWidth()-200,0,200,GraphicsHeight(),0
	Rect GraphicsWidth()-197,3,194,GraphicsHeight()-6,0
		; show current tile
		Rect GraphicsWidth()-197,3,194,20,0
		If RectsOverlap(MouseX(),MouseY(),1,1,0,0,GraphicsWidth()-200,GraphicsHeight()) Then
			If RectsOverlap(MouseX(),MouseY(),1,1,xoff,yoff,GraphicsWidth(),GraphicsHeight()) Then
				For x=0 To maxw-1
					For y=0 To maxh-1
						If RectsOverlap(MouseX(),MouseY(),1,1,xoff+x*size,yoff+y*size,size,size) Then
							Color 255,0,0
							fill=False
							Rect xoff+x*size,yoff+y*size,size+1,size+1,fill
							Color 255,255,255
							Text GraphicsWidth()-195,5,"( "+x+", "+y+" ) "+"ID:"+array(x,y)
							Select array(x,y)
							Case -1
								Text xoff+x*size+size/2,yoff+y*size+size/2,"trader",1,1
							Case -2
								Text xoff+x*size+size/2,yoff+y*size+size/2,"inn",1,1
							Case -3
								Text xoff+x*size+size/2,yoff+y*size+size/2,"quest",1,1
							Case -4
								Text xoff+x*size+size/2,yoff+y*size+size/2,"bed",1,1
							Case -5
								Text xoff+x*size+size/2,yoff+y*size+size/2,"chest",1,1
							Case -6
								Text xoff+x*size+size/2,yoff+y*size+size/2,"npc-man",1,1
							Case -7
								Text xoff+x*size+size/2,yoff+y*size+size/2,"npc-woman",1,1
							Case -8
								Text xoff+x*size+size/2,yoff+y*size+size/2,"npc-nosex",1,1
							Case -9
								Text xoff+x*size+size/2,yoff+y*size+size/2,"npc-ally",1,1
							Case -10
								Text xoff+x*size+size/2,yoff+y*size+size/2,"npc-enemy",1,1
							Case 0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"_",1,1
							Case 255
								Color 200,128,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"border",1,1
							End Select
						EndIf
					Next
				Next
			EndIf
		Else
			Color 255,255,255
			Text GraphicsWidth()-195,5,"< nothing selected >"
		EndIf
	; map movement
	If KeyDown(30) Then
		xoff=xoff+speed
	EndIf
	If KeyDown(32) Then
		xoff=xoff-speed
	EndIf
	If KeyDown(17) Then
		yoff=yoff+speed
	EndIf
	If KeyDown(31) Then
		yoff=yoff-speed
	EndIf
	Flip 0:VWait
Wend
End