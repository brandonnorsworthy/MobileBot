HotKeySet("{F4}", stopBot)
Global $posArray = WinGetPos("Streaming game from BlueStacks")

Func stopBot()
	ConsoleWrite(@CRLF & "Amount of hides tanned: " & @CRLF)
	Exit
EndFunc

While(true)
	$rnd = Random()
	Sleep(1000 + 2000*$rnd)
	betterMouseClick(-1000-$rnd*300,500+$rnd*300)
WEnd

Func betterMouseClick($x, $y)
	MouseUp("")
	Local $pos = MouseGetPos()
	MouseClick("", $x + $posArray[0], $y + $posArray[1], 1, 0)
	MouseMove($pos[0], $pos[1], 0)
EndFunc

Func betterMouseClickSpeed($x, $y, $speed)
	MouseUp("")
	Local $pos = MouseGetPos()
	MouseClick("", $x + $posArray[0], $y + $posArray[1], 1, $speed)
	MouseMove($pos[0], $pos[1], 0)
EndFunc

Func betterMouseMove($x, $y)
	MouseUp("")
	Local $pos = MouseGetPos()
	MouseMove($x + $posArray[0], $y + $posArray[1], 0)
	MouseMove($pos[0], $pos[1], 0)
EndFunc

Func betterMouseMoveSpeed($x, $y, $speed)
	MouseUp("")
	Local $pos = MouseGetPos()
	MouseMove($x + $posArray[0], $y + $posArray[1], $speed)
	MouseMove($pos[0], $pos[1], 0)
EndFunc

Func betterPixelSearchArray($left, $top, $right, $bottom, $color, $shade)
	$aCoord = PixelSearch($left + $posArray[0], $top + $posArray[1], $right + $posArray[0], $bottom + $posArray[1], $color, $shade)
	If Not @error Then
		Return $aCoord
	EndIf
EndFunc

Func betterPixelSearch($left, $top, $right, $bottom, $color, $shade)
	PixelSearch($left + $posArray[0], $top + $posArray[1], $right + $posArray[0], $bottom + $posArray[1], $color, $shade)
	If Not @error Then
		Return True
	EndIf
EndFunc