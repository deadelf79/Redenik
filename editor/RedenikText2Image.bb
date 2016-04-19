a$ = CommandLine$() 

filename$ = "test_result/text2image.txt"

If a > 0

	filename = a
	
EndIf

size = 16

mapsize = 50

fillrects = True

file$ = ReadFile( filename )

image = CreateImage( mapsize * size, mapsize * size )

SetBuffer( ImageBuffer( image ) )

leafs = 1

For x = 0 To mapsize - 1

	For y = 0 To mapsize - 1
	
		Color 32, 32, 32
	
		Rect x * size, y * size, size, size, 0 
	
	Next
	
Next

While Not Eof( file )

	b$ = ReadLine( file )
	
	
	If Instr( b, "leaf" )
	
		DebugLog(leafs)
	
		Color 128, 128, 128
		
		x      = 	Int(Mid( b, 6,  8 )) * size
		y      = 	Int(Mid( b, 14, 8 )) * size
		width  = 	Int(Mid( b, 22, 8 )) * size
		height = 	Int(Mid( b, 30, 8 )) * size
		
		Rect x, y, width, height, 0
		
		DebugLog "x: " + x
		DebugLog "y: " + y
		DebugLog "width: " + width
		DebugLog "height: " + height
		
		leafs = leafs + 1
		
	EndIf
	
	If Instr( b, "room" )
	
		Color 255, 255, 255
		
		x      = 	Int(Mid( b, 6,  8 )) * size
		y      = 	Int(Mid( b, 14, 8 )) * size
		width  = 	Int(Mid( b, 22, 8 )) * size
		height = 	Int(Mid( b, 30, 8 )) * size
		
		Rect x, y, width, height, 0
		Rect x + 1, y + 1, width - 2, height - 2, fillrects
		
	EndIf
	
	If Instr( b, "worm" )
	
		Color 255, 255, 255
		
		x1      = 	Int(Mid( b, 6,  8 )) * size + size/2
		y1      = 	Int(Mid( b, 14, 8 )) * size + size/2
		x2  	= 	Int(Mid( b, 22, 8 )) * size + size/2
		y2 		= 	Int(Mid( b, 30, 8 )) * size + size/2
		
		Line x1, y1, x2, y2
		
		If ( x1 > x2 )
			If ( y1 > y2 )
				Rect x2 - size/2, y1 - size/2, ( x1 - x2 ) + size, ( y1 - y2 ) + size, fillrects
			Else
				Rect x2 - size/2, y2 - size/2, ( x1 - x2 ) + size, ( y2 - y1 ) + size, fillrects
			EndIf
		Else
			If ( y1 > y2 )
				Rect x1 - size/2, y2 - size/2, ( x2 - x1 ) + size, ( y1 - y2 ) + size, fillrects
			Else
				Rect x1 - size/2, y1 - size/2, ( x2 - x1 ) + size, ( y2 - y1 ) + size, fillrects
			EndIf
		EndIf
		
	EndIf
	
Wend

CloseFile(file)

SaveImage( image, "image.bmp")

End