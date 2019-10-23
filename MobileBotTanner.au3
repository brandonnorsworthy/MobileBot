HotKeySet("{ENTER}", stopBot)
HotKeySet("{F4}", stopBot)
HotKeySet("{F3}", startBot)

;window size set to 974, 532

#Region ### GLOBAL VARIABLES
Global $posArray = WinGetPos("Streaming game from BlueStacks")
Global $tanLeather = "soft" ;"soft" or "hard"
Global $startBot = False
Global $amountTanned = 0
Global $gotLost = 0
#EndRegion

WinActivate("Streaming game from BlueStacks")

walkToGrandExchange()

;stops script when hotkey is pressed
Func stopBot()
	ConsoleWrite(@CRLF & "Amount of hides tanned: " & $amountTanned & @CRLF)
	Exit
EndFunc

;toggle for starting the bot so it can start on command
Func startBot()
	If Not $startBot Then
		$startBot = True
	Else
		$startBot = False
	EndIf
EndFunc

Func betterMouseClick($x, $y)
	MouseClick("", $x + $posArray[0], $y + $posArray[1], 1, 0)
EndFunc

Func betterMouseClickSpeed($x, $y, $speed)
	MouseClick("", $x + $posArray[0], $y + $posArray[1], 1, $speed)
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
EndFunc

;inital setup for the bot
Func runBot()
	While Not $startBot
		Sleep(1000)
	WEnd

	MouseClick("", 768+$posArray[0], 51+$posArray[1], 1, 0)
	Sleep(500)

	;position camera up
	MouseMove(474+$posArray[0], 209+$posArray[1], 0)
	MouseDown("")
	MouseMove(474+$posArray[0], 409+$posArray[1])
	MouseUp("")

	;disable run
	Local $color = PixelGetColor(768+$posArray[0], 162+$posArray[1])
	If ($color = 0xECDA67) Then
		MouseClick("", 768+$posArray[0], 162+$posArray[1], 1, 0)
		Sleep(1000)
	EndIf

	;open bank
	MouseClick("", 451+$posArray[0], 267+$posArray[1], 1, 0)
	Sleep(1000)
	;despoit all
	MouseClick("", 599+$posArray[0], 481+$posArray[1], 1, 0)
	Sleep(1000)
	;withdraw coins
	MouseClick("", 253+$posArray[0], 270+$posArray[1], 1, 0)
	Sleep(1000)

	withdrawCowhides()
EndFunc

Func banking()
	Sleep(3000)
	PixelSearch(480+$posArray[0], 484+$posArray[1], 496+$posArray[0], 501+$posArray[1], 0x8F221F, 2)
	If Not @error Then
		depositLeather()
	Else
		PixelSearch(415+$posArray[0], 145+$posArray[1], 415+$posArray[0], 145+$posArray[1], 0x3833E2, 2)
		If Not @error Then
			MouseClick("", 372+$posArray[0], 141+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 322+$posArray[0], 77+$posArray[1], 1, 0)
			Sleep(1000)
			depositLeather()
		Else
			ConsoleWrite("banking() bank not found!" & " Amount tanned before breaking:" & $amountTanned & @CRLF & @CRLF)
		EndIf
	EndIf
EndFunc

Func checkIfOutOfCowhides()
	PixelSearch(299+$posArray[0], 274+$posArray[1], 299+$posArray[0], 274+$posArray[1], 0x7D736D, 5)
	If Not @error Then
		teleportToVarrock()
	EndIf
EndFunc

Func teleportToVarrock()
	MouseClick("", 596+$posArray[0], 488+$posArray[1], 1, 0) ;deposit inventory
	Sleep(1500)

	withdrawVarrockRunes()

	MouseClick("", 637+$posArray[0], 200+$posArray[1], 1, 0) ;close bank
	Sleep(3000)

	;check if magic tab is open
	PixelSearch(58+$posArray[0], 311+$posArray[1],58+$posArray[0], 311+$posArray[1], 0x71261D, 2)
	If @error Then
		MouseClick("", 58+$posArray[0], 311+$posArray[1], 1, 0)
		Sleep(1000)
	EndIf

	;check if can cast varrock teleport
	PixelSearch(134+$posArray[0], 297+$posArray[1], 134+$posArray[0], 297+$posArray[1], 0x7070E5, 5)
	If Not @error Then
		MouseClick("", 135+$posArray[0], 290+$posArray[1], 1, 0)
	Else
		ConsoleWrite("teleportToVarrock(): Tried teleporting to varrock and failed")
		Exit
	EndIf

	Sleep(5000)
	walkToGrandExchange()
EndFunc

Func walkToGrandExchange()
	;align self to door
;~ 	Local $doorFound = False
;~ 	While Not $doorFound
;~ 		Local $aCoord = PixelSearch(798+$posArray[0], 71+$posArray[1], 833+$posArray[0], 96+$posArray[1], 0xC41713, 10)
;~ 		If Not @error Then
;~ 			$doorFound = True
;~ 			MouseClick("", $aCoord[0]+4, $aCoord[1]+1, 1, 0)
;~ 		Else
;~ 			ConsoleWrite("walkToGrandExchange() T1: Lost" & " ")
;~ 			$doorFound = False

;~ 			Local $bCoord = PixelSearch(798+$posArray[0], 71+$posArray[1], 833+$posArray[0], 96+$posArray[1], 0xAC170E, 25)
;~ 			If Not @error Then
;~ 				$doorFound = True
;~ 				MouseClick("", $bCoord[0]+4, $bCoord[1]+1, 1, 0)
;~ 			Else
;~ 				ConsoleWrite("T2: Lost")
;~ 				$doorFound = False
;~ 			EndIf
;~ 		EndIf
;~ 	WEnd
;~ 	ConsoleWrite(@CRLF)

;~ 	;walks to grand exchange
;~ 	Sleep(10000)
;~ 	betterMouseClick(800, 58)
;~ 	Sleep(12000)
;~ 	betterMouseClick(787, 77)
;~ 	Sleep(8000)
;~ 	betterMouseClick(782, 98)
;~ 	Sleep(7500)
;~ 	betterMouseClick(835, 45)
;~ 	Sleep(9000)
;~ 	betterMouseClick(844, 51)
;~ 	Sleep(10000)

	;opens bank
	betterMouseMove(484, 224)
	MouseDown("")
	Sleep(2000)
	betterMouseMoveSpeed(485, 278, 10)
	Sleep(1500)
	MouseUp("")

	;deposit all just incase
	Sleep(2000)
	betterMouseClick(598, 485)
	Sleep(1000)

	;set quantity to all, withdraw as note
	If betterPixelSearch(492, 498, 492, 498, 0x585853, 2) Then ;checks if all is already enabled
		betterMouseClick(489, 492) ;click all
		Sleep(1000)
	EndIf
	If betterPixelSearch(371, 490, 371, 490, 0x545450, 2) Then ;checks if note is already enabled
		betterMouseClick(354, 493) ;click note
		Sleep(1000)
	EndIf

	Local $withdrawnItems[4] = [0, 0, 0, 0]

	;withdraw coins, all hides including leather
	If betterPixelSearch(250, 278, 250, 278, 0xCEA311, 2) Then ;checks if coins are in the bank
		betterMouseClick(248, 278) ;click coins
		Sleep(1000)
		$withdrawnItems[0] = 1
	EndIf
	If betterPixelSearch(297, 270, 297, 270, 0xACA09F, 2) Then
		betterMouseClick(296, 272) ;click cowhide
		Sleep(1000)
		$withdrawnItems[1] = 1
	EndIf
	If betterPixelSearch(344, 273, 344, 273, 0x2A2414, 2) Then
		betterMouseClick(341, 274) ;click hard leather
		Sleep(1000)
		$withdrawnItems[2] = 1
	EndIf
	If betterPixelSearch(389, 273, 389, 273, 0x3D3905, 2) Then
		betterMouseClick(390, 272) ;click leather
		Sleep(1000)
		$withdrawnItems[3] = 1
	EndIf

	;close the bank
	betterMouseClick(638, 199)
	Sleep(1000)

	;open grand exchange
	betterMouseMove(462, 247)
	MouseDown("")
	Sleep(2000)
	betterMouseMoveSpeed(462, 301, 10)
	Sleep(1500)
	MouseUp("")

	;sell items

EndFunc

Func depositLeather()
	Sleep(3000)
	MouseClick("", 769+$posArray[0], 258+$posArray[1], 1, 0)
	Sleep(1000)
	$amountTanned = $amountTanned + 27
	withdrawCowhides()
EndFunc

Func withdrawVarrockRunes()
	MouseClick("", 390+$posArray[0], 493+$posArray[1], 1, 0) ;select quantity 1
	Sleep(1500)
	MouseClick("", 437+$posArray[0], 271+$posArray[1], 1, 0) ;withdraw law
	Sleep(1500)
	MouseClick("", 482+$posArray[0], 272+$posArray[1], 1, 0) ;withdraw fire
	Sleep(1500)
EndFunc

Func withdrawCowhides()
	;cowhides
	checkIfOutOfCowhides()
	MouseClick("", 299+$posArray[0], 282+$posArray[1], 1, 0)
	Sleep(1000)
	MouseClick("", 637+$posArray[0], 197+$posArray[1], 1, 0)
	Sleep(1000)

	walkToTanner()
EndFunc

Func walkToTanner()
	;walk from alkarid bank
	MouseClick("", 865+$posArray[0], 62+$posArray[1], 1, 0)
	Sleep(8600)
	MouseClick("", 836+$posArray[0], 53+$posArray[1], 1, 0)
	Sleep(13000)
	tannerSearch()
EndFunc

;Look to tanner
Func tannerSearch()
	$tannerFound = False
	While Not $tannerFound
		Local $aCoord = PixelSearch(351+$posArray[0], 162+$posArray[1], 604+$posArray[0], 328+$posArray[1], 0xBC633F, 10, 3)
		If Not @error Then
			MouseClick("", $aCoord[0], $aCoord[1], 1, 0)
			$tannerFound = True
			Sleep(7000)
		Else
			$tannerFound = False
			ContinueLoop
		EndIf

		PixelSearch(420+$posArray[0], 74+$posArray[1], 420+$posArray[0], 74+$posArray[1], 0xCBBA95, 5)
		If Not @error Then
			$tannerFound = True
			tanLeather()
		Else
			$tannerFound = False
			ContinueLoop
		EndIf
	WEnd
EndFunc

Func tanLeather()
	Switch $tanLeather
		Case "soft"
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 303+$posArray[0], 92+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)

			;hold down mouse and drag to tan all0
			MouseMove(254+$posArray[0], 275+$posArray[1],0)
			MouseDown("")
			Sleep(1000)
			MouseMove(254+$posArray[0], 275+$posArray[1]+106)
			MouseUp("")
		Case "hard"
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 303+$posArray[0], 92+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)

			;hold down mouse and drag to tan all0
			MouseMove(362+$posArray[0], 274+$posArray[1],0)
			MouseDown("")
			Sleep(1000)
			MouseMove(362+$posArray[0], 274+$posArray[1]+106)
			MouseUp("")
		Case Default
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 303+$posArray[0], 92+$posArray[1], 1, 0)
			Sleep(1000)
			MouseClick("", 348+$posArray[0], 142+$posArray[1], 1, 0)
			Sleep(1000)

			;hold down mouse and drag to tan all
			MouseMove(254+$posArray[0], 275+$posArray[1],0)
			MouseDown("")
			Sleep(1000)
			MouseMove(254+$posArray[0], 275+$posArray[1]+106)
			MouseUp("")
	EndSwitch

	Sleep(1000)
	walkToBank()
EndFunc

Func walkToBank()
	Local $doorFound = False
	While Not $doorFound
		Local $aCoord = PixelSearch(840+$posArray[0], 100+$posArray[1], 885+$posArray[0], 130+$posArray[1], 0xD34325, 10)
		If Not @error Then
			$doorFound = True
			MouseClick("", $aCoord[0]+4, $aCoord[1]+1, 1, 0)
		Else
			ConsoleWrite("T1: Lost" & ", ")
			$doorFound = False

			Local $bCoord = PixelSearch(840+$posArray[0], 100+$posArray[1], 885+$posArray[0], 130+$posArray[1], 0xCF4F2E, 25)
			If Not @error Then
				$doorFound = True
				MouseClick("", $bCoord[0]+4, $bCoord[1]+1, 1, 0)
			Else
				ConsoleWrite("T2: Lost" & ", ")
				$doorFound = False

				Local $cCoord = PixelSearch(840+$posArray[0], 100+$posArray[1], 885+$posArray[0], 130+$posArray[1], 0xD04B2D, 25)
				If Not @error Then
					$doorFound = True
					MouseClick("", $cCoord[0]+4, $cCoord[1]+1, 1, 0)
				Else
					ConsoleWrite("T3: Lost" & @CRLF)
					$doorFound = False
				EndIf
			EndIf
		EndIf
	WEnd

	;walk from tanner to bank
	Sleep(4000)
	MouseClick("", 832+$posArray[0], 182+$posArray[1], 1, 0)
	Sleep(10000)
	MouseClick("", 808+$posArray[0], 151+$posArray[1], 1 ,0)
	Sleep(6500)
	MouseClick("", 358+9+$posArray[0], 273+$posArray[1], 1, 0) ;opens bank

	banking()
EndFunc