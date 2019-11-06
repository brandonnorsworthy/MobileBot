HotKeySet("{F4}", stopBot)
Global $posArray = WinGetPos("Streaming game from BlueStacks")
Global $mined = 0

WinActivate("Streaming game from BlueStacks")
runBot()

Func stopBot()
	ConsoleWrite(@CRLF & "Stopping mined: " & $mined & @CRLF)
	Exit
EndFunc

Func runBot()
	betterMouseClick(768, 50)
	Sleep(1000)
	betterMouseMove(492, 200)
	MouseDown("")
	betterMouseMoveSpeed(492, 500, 10)
	MouseUp("")
	Sleep(1000)
	While(true)
		Global $posArray = WinGetPos("Streaming game from BlueStacks")
		Sleep(1000)
		If betterPixelSearch(459, 334, 459, 334, 0x988D8C, 10) Then
			$rng = Random()
			betterMouseClickRandom(464, 318, 502, 353)
			$i = 0
			While Not betterPixelSearch(470, 317, 470, 317, 0x474343, 10)
				$i += 1
				If $i >= 100 Then
					ExitLoop
				EndIf
				Sleep(100)
			WEnd
			$mined += 1
			Sleep(200)
			betterMouseClickRandom(721, 250, 738, 266)
		EndIf
		Sleep(100)
		If betterPixelSearch(412, 286, 412, 286, 0x908585, 10) Then
			$rng = Random()
			betterMouseClickRandom(420, 266, 452, 299)
			$i = 0
			While Not betterPixelSearch(412, 286, 412, 286, 0x565050, 10)
				$i += 1
				If $i >= 100 Then
					ExitLoop
				EndIf
				Sleep(100)
			WEnd
			$mined += 1
			Sleep(200)
			betterMouseClickRandom(721, 250, 738, 266)
		EndIf
	WEnd
	ConsoleWrite("Hit")
EndFunc

Func betterMouseClick($x, $y)
	MouseUp("")
	Local $pos = MouseGetPos()
	MouseClick("", $x + $posArray[0], $y + $posArray[1], 1, 0)
	MouseMove($pos[0], $pos[1], 0)
EndFunc

Func betterMouseClickRandom($x1, $y1, $x2, $y2)
	$rng = Random()
	$x = $x1 + (($x2 - $x1) * $rng)
	$y = $y1 + (($y2 - $y1) * $rng)
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
	MouseMove($x + $posArray[0], $y + $posArray[1], 0)
EndFunc

Func betterMouseMoveSpeed($x, $y, $speed)
	MouseMove($x + $posArray[0], $y + $posArray[1], $speed)
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
	Return False
EndFunc