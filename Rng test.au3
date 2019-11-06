
HotKeySet("{F4}", stopBot)

While(True)
	$rngx = Random()
	$rngy = Random()
	MouseClick("",-689 + 300*$rngx, 283 + 300*$rngy, 1, 0)
WEnd

Func stopBot()
	ConsoleWrite(@CRLF & "Amount of hides tanned: " & @CRLF)
	Exit
EndFunc