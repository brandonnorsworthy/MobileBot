HotKeySet("{ENTER}", stopBot)
HotKeySet("{F4}", stopBot)

;window size set to 974, 532
;X -1908 Y 378 X 895 Y 503

Global $windowName = "Streaming game from BlueStacks"
Global $posArray = WinGetPos($windowName)

WinActivate($windowName)
runBot()

Func stopBot()
	ConsoleWrite(@CRLF & "Stopping" & @CRLF)
	Exit
EndFunc

Func runBot()
	$posArray = WinGetPos($windowName)
	ConsoleWrite("X " & $posArray[0] & " Y " & $posArray[1] & " X " & $posArray[2] & " Y " & $posArray[3])
	;x
	betterMouseMove($posArray[2] - 2, $posArray[3]/2 - 2)
	MouseDown("")
	Sleep(300)
	betterMouseMoveSpeed(895 - 2, $posArray[3]/2 - 2, 10)
	MouseUp("")

	Global $posArray = WinGetPos($windowName)
	;y
	betterMouseMove($posArray[2]/2 - 2, $posArray[3] - 2)
	MouseDown("")
	Sleep(300)
	betterMouseMoveSpeed($posArray[2]/2 - 2, 503, 10)
	MouseUp("")

	$posArray = WinGetPos($windowName)
	ConsoleWrite(@CRLF & "X " & $posArray[0] & " Y " & $posArray[1] & " X " & $posArray[2] & " Y " & $posArray[3])
EndFunc

Func betterMouseMove($x, $y)
	MouseMove($x + $posArray[0], $y + $posArray[1], 0)
EndFunc

Func betterMouseMoveSpeed($x, $y, $speed)
	MouseMove($x + $posArray[0], $y + $posArray[1], $speed)
EndFunc