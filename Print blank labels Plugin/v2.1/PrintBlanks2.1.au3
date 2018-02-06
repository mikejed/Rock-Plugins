#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=../PrintBlanks.ico
#AutoIt3Wrapper_Res_Fileversion=2.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=Copyright 2018 by Michael Garrison
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <Array.au3>
#include <GuiConstantsEx.au3>

#Region Load settings
$printerIPAddress = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterIPAddress","127.0.0.1")
$printerShareName = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterShareName","\\" & @ComputerName & "\ZPL")
$printerInstalled = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterInstalled","Network")
$mode = INIRead(@ScriptDir & "\settings.ini","PrintBlank","IncrementMode","Random")
$prefix = INIRead(@ScriptDir & "\settings.ini","PrintBlank","Prefix","M")
$codeLength = INIRead(@ScriptDir & "\settings.ini","PrintBlank","CodeLength","2")
$startingCode = INIRead(@ScriptDir & "\settings.ini","PrintBlank","StartingCode","1")
$files = _FileListToArray(@scriptdir,"*.prn",1)
#EndRegion

#Region Define GUI and set correct initial states
GUICreate("Print Blank Labels",640,350)

GUICtrlCreateGroup("Printer installation mode",5,5,630,85)

$ctrl_PrinterInstalledNetwork = GUICtrlCreateRadio("Network printer (IP address)",10,20,300,15)
GUICtrlCreateLabel("Printer Address",10,45,300,15)
$ctrl_printerAddress = GUICtrlCreateInput($printerIPAddress,10,60,150,20)
$ctrl_PrinterInstalledLocal = GUICtrlCreateRadio("Shared local printer",320,20,300,15)
GUICtrlCreateLabel("Share address",320,45,300,15)
$ctrl_printerShareName = GUICtrlCreateInput($printerShareName,320,60,300,20)

GUICtrlCreateGroup("Random alphanumeric security codes",5,110,300,100)
$ctrl_modeOrdered = GUICtrlCreateCheckbox("Print sequential numeric codes instead",10,130,280,15)
GUICtrlCreateLabel("Starting code",10,155,280,20)
$ctrl_startingCode = GUICtrlCreateInput($startingCode,10,170,75,20)
If $mode == "Random" Then
	GUICtrlSetState($ctrl_startingCode,$GUI_DISABLE)
ElseIf $mode == "Sequential" Then
	GUICtrlSetState($ctrl_modeOrdered,$GUI_CHECKED)
EndIf
GUICtrlCreateGroup("", -99, -99, 1, 1)

If $printerInstalled == "Network" Then
	GUICtrlSetState($ctrl_PrinterInstalledNetwork,$GUI_CHECKED)
	GUICtrlSetState($ctrl_printerShareName,$GUI_DISABLE)
ElseIf $printerInstalled == "Local" Then
	GUICtrlSetState($ctrl_PrinterInstalledLocal,$GUI_CHECKED)
	GUICtrlSetState($ctrl_printerAddress,$GUI_DISABLE)
EndIf

GUICtrlCreateLabel("Security code prefix:",5,225,150,15)
$ctrl_prefix = GUICtrlCreateInput($prefix,5,240,75,20)
GUICtrlCreateLabel("Code Length (after prefix):",5,265,150,15)
$ctrl_codeLength = GUICtrlCreateInput($codeLength,5,280,75,20)

GUICtrlCreateLabel("Number of labels to print",165,225,120,15)
$ctrl_numLabels = GUICtrlCreateInput("10",165,240,75,20,0x2000);numbers only
GUICtrlCreateUpDown($ctrl_numLabels)
GUICtrlSetLimit(-1,100,1);limit to integers between 1 and 100. May still be overridden by typing a number

GUICtrlCreateLabel("Labels which will be printed:",320,115,300,15)
$ctrl_filelist = GUICtrlCreateList("",320,130,300,170)
GUICtrlSetData($ctrl_filelist,_ArrayToString($files,"|",1,$files[0]))
GUICtrlSetState($ctrl_filelist,$GUI_DISABLE)

$ctrl_PrintButton = GUICtrlCreateButton("Print",240,320,75,20,0x0001)
$ctrl_CancelButton = GUICtrlCreateButton("Cancel",325,320,75,20)

#EndRegion

#Region display GUI
GUICtrlSetState($ctrl_numLabels,$GUI_FOCUS)

GUISetState()
While 1
	$msg=GUIGetMsg()
	Switch $msg
		Case -3, $ctrl_CancelButton ;Close or Cancel
			Exit
		Case $ctrl_modeOrdered
			If GUICtrlRead($ctrl_modeOrdered) == $GUI_CHECKED Then
				GUICtrlSetState($ctrl_startingCode,$GUI_ENABLE)
				GUICtrlSetState($ctrl_startingCode,$GUI_FOCUS)
			Else
				GUICtrlSetState($ctrl_startingCode,$GUI_DISABLE)
			EndIf
		Case $ctrl_PrinterInstalledNetwork
			If GUICtrlRead($ctrl_PrinterInstalledNetwork) == $GUI_CHECKED Then
				GUICtrlSetState($ctrl_printerShareName,$GUI_DISABLE)
				GUICtrlSetState($ctrl_printerAddress,$GUI_ENABLE)
				GUICtrlSetState($ctrl_printerAddress,$GUI_FOCUS)
			EndIf
		Case $ctrl_PrinterInstalledLocal
			If GUICtrlRead($ctrl_PrinterInstalledLocal) == $GUI_CHECKED Then
				GUICtrlSetState($ctrl_printerAddress,$GUI_DISABLE)
				GUICtrlSetState($ctrl_printerShareName,$GUI_ENABLE)
				GUICtrlSetState($ctrl_printerShareName,$GUI_FOCUS)
			EndIf
		Case $ctrl_PrintButton
			ExitLoop
	EndSwitch
WEnd
#EndRegion

#Region store settings for next time
If GUICtrlRead($ctrl_PrinterInstalledNetwork) == $GUI_CHECKED Then
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","PrinterInstalled","Network")
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","PrinterIPAddress",GUICtrlRead($ctrl_printerAddress))
ElseIf GUICtrlRead($ctrl_PrinterInstalledLocal) == $GUI_CHECKED Then
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","PrinterInstalled","Local")
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","PrinterShareName",GUICtrlRead($ctrl_printerShareName))
EndIf

If GUICtrlRead($ctrl_modeOrdered) == $GUI_CHECKED Then
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","IncrementMode","Sequential")
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","StartingCode",GUICtrlRead($ctrl_startingCode))
Else
	IniWrite(@ScriptDir & "\settings.ini","PrintBlank","IncrementMode","Random")
EndIf

IniWrite(@ScriptDir & "\settings.ini","PrintBlank","Prefix",GUICtrlRead($ctrl_prefix))
IniWrite(@ScriptDir & "\settings.ini","PrintBlank","CodeLength",GUICtrlRead($ctrl_codeLength))
#EndRegion

#Region store number of labels requested (not stored for next session) and hide the GUI
$numLabels = GUICtrlRead($ctrl_numLabels);store the number of requested labels for this session

GUISetState(@SW_HIDE)
#EndRegion

#Region reload parameters from INI file
$printerIPAddress = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterIPAddress","127.0.0.1")
$printerShareName = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterShareName","\\" & @ComputerName & "\ZPL")
$printerInstalled = INIRead(@ScriptDir & "\settings.ini","PrintBlank","PrinterInstalled","Network")
$mode = INIRead(@ScriptDir & "\settings.ini","PrintBlank","IncrementMode","Random")
$prefix = INIRead(@ScriptDir & "\settings.ini","PrintBlank","Prefix","M")
$codeLength = INIRead(@ScriptDir & "\settings.ini","PrintBlank","CodeLength","2")
$startingCode = INIRead(@ScriptDir & "\settings.ini","PrintBlank","StartingCode","1")
#EndRegion

#Region setup infrastructure for printer type
If $printerInstalled == "Network" Then
	TCPStartup()
	$socket = TCPConnect($printerIPAddress,9100)

	If @error Then
		MsgBox(16,"Error","Unable to connect to printer")
		Exit
	EndIf
ElseIf $printerInstalled == "Local" Then
	$tmpfilepath = @TempDir & "\printthis.txt"
EndIf
#EndRegion

#Region assign beginning code based on increment mode
If $mode == "Random" Then
	$code = ""
	For $l=1 To $codeLength
		$code = $code & RandAlphaNum()
	Next
ElseIf $mode == "Sequential" Then
	$code = Pad($startingCode)
EndIf
#EndRegion
	
#Region print the labels
For $lbl=1 To $numLabels
	If $printerInstalled == "Network" Then
		For $i=1 To $files[0]
			$contents=FileRead(@scriptdir & "\" & $files[$i])
			$contents=StringReplace($contents,"???",$prefix & $code)
			TCPSend($socket,$contents)
		Next
	ElseIf $printerInstalled == "Local" Then
		For $i=1 To $files[0]
			$contents=FileRead(@scriptdir & "\" & $files[$i])
			$contents=StringReplace($contents,"???",$prefix & $code)
			$file=FileOpen($tmpfilepath,2)
			If $file = -1 Then
				MsgBox(16,"Error","Error writing the temp file")
				Exit
			EndIf
			FileWrite($file,$contents)
			FileClose($file)
			RunWait(@comspec & ' /c copy /b "' & $tmpfilepath & '" ' & $printerShareName,@scriptdir,@SW_HIDE)
			FileDelete($tmpfilepath)
		Next
	EndIf
	
	#Region get code for next set of labels
	If $mode == "Random" Then
		$code = ""
		For $l=1 To $codeLength
			$code = $code & RandAlphaNum()
		Next
	ElseIf $mode == "Sequential" Then
		$code = Pad($code+1)
		IniWrite(@ScriptDir & "\settings.ini","PrintBlank","StartingCode",$code);stores the "next" number for next session
	EndIf
	#EndRegion
Next
#EndRegion

#Region cleanup and quit
If $printerInstalled == "Network" Then
	TCPCloseSocket($socket)
	TCPShutdown()
EndIf

Exit
#EndRegion

#Region UDFs
Func RandAlphaNum()
	Local $rand = Random(48,83)
	If $rand > 57 Then $rand = $rand + 7
	Return Chr($rand)
EndFunc

Func Pad($code)
	Local $needed = $codeLength - StringLen($code)
	For $_n = 1 To $needed
		$code = "0" & $code
	Next
	Return StringRight($code,$codeLength)
EndFunc
#EndRegion