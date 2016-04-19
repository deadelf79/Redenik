Graphics3D 800,600,32,2

Global maxw=50, maxh=50
Dim array(maxw,maxh)
Global size=32,fill=False
Global xoff=-(maxw/2-maxw/4)*size,yoff=-(maxh/2-maxh/4)*size,speed=4

SetFont LoadFont("Arial",14)

Global tileid = 2,wedrawline,linex,liney

;sample map data
For x=0 To maxw-1
	For y=0 To maxh-1
		array(x,y)=1	
	Next
Next
array(-xoff/size+1, -yoff/size )=0  ; _
array(-xoff/size+2, -yoff/size )=-1 ; trader
array(-xoff/size+3, -yoff/size )=-2 ; inn
array(-xoff/size+4, -yoff/size )=-3 ; quest
array(-xoff/size+5, -yoff/size )=-4 ; bed
array(-xoff/size+6, -yoff/size )=-5 ; chest
array(-xoff/size+7, -yoff/size )=-6 ; npc-man
array(-xoff/size+8, -yoff/size )=-7 ; npc-woman
array(-xoff/size+9, -yoff/size )=-8 ; npc-nosex
array(-xoff/size+10,-yoff/size )=-9 ; npc-ally
array(-xoff/size+11,-yoff/size )=-10 ; npc-enemy

For x=-xoff/size-1 To -xoff/size+GraphicsWidth()/size+1
	array(x,-yoff/size-1)=255
	array(x,-yoff/size+GraphicsHeight()/size+1)=255
Next
For y=-yoff/size-1 To -yoff/size+GraphicsHeight()/size+1
	array(-xoff/size-1,y)=255
	array(-xoff/size+GraphicsWidth()/size+1,y)=255
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
				Case 2
					fill=True
					Color 255,255,255
				; map border
				Case 255
					fill=False
					Color 200,128,0
				Default
					fill=True
					Color 200,200,200
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
		; show current tile info
		Rect GraphicsWidth()-197,3,194,20,0
		If RectsOverlap(MouseX(),MouseY(),1,1,0,0,GraphicsWidth()-200,GraphicsHeight()) Then
			If RectsOverlap(MouseX(),MouseY(),1,1,xoff,yoff,GraphicsWidth()-xoff,GraphicsHeight()-yoff) Then
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
								Text xoff+x*size+size/2,yoff+y*size+size/2,"questboard",1,1
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
							Case -11
								Text xoff+x*size+size/2,yoff+y*size+size/2,"door",1,1
							Case -12
								Text xoff+x*size+size/2,yoff+y*size+size/2,"teleport",1,1
							Case -13
								Text xoff+x*size+size/2,yoff+y*size+size/2,"torch",1,1
							case -100
								Text xoff+x*size+size/2,yoff+y*size+size/2,"gate a",1,1
							case -200
								Text xoff+x*size+size/2,yoff+y*size+size/2,"-opened door-",1,1
							Case 0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"_",1,1
							Case 2
								Color 0,0,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"UP BRICK WALL",1,1
							Case 3
								Color 0,0,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"SIDE BRICK WALL",1,1
							Case 4
								Color 0,0,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"UP BRICK COLUMN",1,1
							Case 5
								Color 0,0,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"SIDE BRICK COLUMN",1,1
							Case 255
								Color 200,128,0
								Text xoff+x*size+size/2,yoff+y*size+size/2,"border",1,1
							End Select
							
							; draw tileid
							If keydown(29)
								if MouseDown(1)
									if wedrawline=0
										linex = x
										liney = y
										array(x,y) = tileid
										wedrawline=1
									Else
										DrawLineToMap(linex,liney,x,y, tileid)
										wedrawline=1
									EndIf
								else
									wedrawline=0
									array(x,y) = tileid
								EndIf
							EndIf
							If MouseDown(2)
								if KeyDown(29) or keydown(157)
									array(x,y) = 1
								Else
									tileid = array(x,y)
								EndIf
							EndIf
						EndIf
					Next
				Next
			EndIf
		Else
			Color 255,255,255
			Text GraphicsWidth()-195,5,"< nothing selected >"
		EndIf
		; show current tile id
		Color 255,255,255
		Rect GraphicsWidth()-197,33,194,20,0
		Text GraphicsWidth()-195,33,"TileID: "+tileid
		Color 0,255,0
		Select tileid
		Case 0
			Text GraphicsWidth()-120,33,"["+"NOINDEX"+"]"
		; MAPPING LIST
		Case 1
			Text GraphicsWidth()-120,33,"["+"Emptiness"+"]"
		Case 2
			Text GraphicsWidth()-120,33,"["+"Up Brick Wall"+"]"
		Case 3
			Text GraphicsWidth()-120,33,"["+"Side Brick Wall"+"]"
		; EVENT LIST
		Case -1
			Text GraphicsWidth()-120,33,"["+"Trader"+"]"
		Case -2
			Text GraphicsWidth()-120,33,"["+"Inn provider"+"]"
		Case -3
			Text GraphicsWidth()-120,33,"["+"Questboard"+"]"
		Case -4
			Text GraphicsWidth()-120,33,"["+"Place to sleep"+"]"
		Case -5
			Text GraphicsWidth()-120,33,"["+"Chest"+"]"
		Case -6
			Text GraphicsWidth()-120,33,"["+"NPC Man"+"]"
		Case -7
			Text GraphicsWidth()-120,33,"["+"NPC Woman"+"]"
		Case -8
			Text GraphicsWidth()-120,33,"["+"NPC Soulless"+"]"
		Case -9
			Text GraphicsWidth()-120,33,"["+"NPC Ally"+"]"
		Case -10
			Text GraphicsWidth()-120,33,"["+"NPC Enemy"+"]"
		Case -11
			Text GraphicsWidth()-120,33,"["+"Door"+"]"
		Case -12
			Text GraphicsWidth()-120,33,"["+"Teleport"+"]"
		Case -13
			Text GraphicsWidth()-120,33,"["+"Torch"+"]"
		End Select
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
	; select tileid
	If KeyHit(16) Then
		tileid = tileid - 1
	EndIf
	If KeyHit(18) Then
		tileid = tileid + 1
	EndIf
	Flip 0:VWait
Wend
End

Function DrawLineToMap(linex,liney,x,y,tileid)
	if linex=x
		if liney=y
			return
		EndIf
	EndIf
	if linex=x
		if liney>y
			For index = y To liney
				array(x,y) = tileid
			Next
		Else
			For index = liney To y
				array(x,y) = tileid
			Next
		EndIf
	Else
		
	EndIf
	if liney=y
			if linex>x
				For index = x To linex
					array(x,y) = tileid
				Next
			Else
				For index = linex To x
					array(x,y) = tileid
				Next
			EndIf
		Else
			
		EndIf
End Function

Function SaveMap(filename$)
	file = WriteFile("maps/"+filename)

	closefile(file)
End Function


Function RenderBitmap(mapname$,use_autotile=False)
	temp = CreateImage(maxw*32,maxh*32)
	tileset = LoadImage("res/tileset.bmp")

	SaveBuffer ImageBuffer(temp),"resulrender_"+mapname+".bmp"
End Function