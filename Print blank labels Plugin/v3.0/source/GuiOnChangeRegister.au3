#Include-once

Global $INTERNAL_CHANGE_REGISTER[1][3] = [[0, 0, 0]]
GUIRegisterMsg (0x0111, "__GUI_CHANGE_REGISTER_WM_COMMAND")

; #FUNCTION# ;====================================================================================================================
;
; Name...........: GUICtrlonchangeRegister
; Description ...: Registers an edit or input control to trigger a function when edited.
; Syntax.........: GUICtrlonchangeRegister($hEdit, $sFunc [, $sParams] )
; Parameters ....: $hEdit              - The handle to the edit control (can be a control ID)
;                  $sFunc              - The string function, as used in functions like HotKeySet + GUISetOnEvent.
;                  $sParams            - a "|" seperated list of parameters for the function (Optional, default = "")
; Return values .: Success             - 1
;                  Failure             - 0 And Sets @Error to 1
; Author ........: Mat
; Modified.......:
; Remarks .......: When using the pipe, use "\|" to stop it from being a seperator.
; Related .......: GUICtrlonchangeUnRegister
; Link ..........:
; Example .......: Yes
;
; ;===============================================================================================================================

Func GUICtrlonchangeRegister ($hEdit, $sFunc, $sParams = "")
   If $hEdit = -1 Then $hEdit = GUICtrlGetHandle (-1)
   If Not IsHwnd ($hEdit) Then $hEdit = GUICtrlGetHandle ($hEdit)
   If $hEdit = 0 Then Return SetError (1, 0, 0) ; $hEdit does not exist

   If $sFunc = "" Then Return GUICtrlonchangeUnRegister ($hEdit)

   ReDim $INTERNAL_CHANGE_REGISTER[UBound ($INTERNAL_CHANGE_REGISTER) + 1][3]
   $INTERNAL_CHANGE_REGISTER[0][0] += 1
   $INTERNAL_CHANGE_REGISTER[$INTERNAL_CHANGE_REGISTER[0][0]][0] = $hEdit
   $INTERNAL_CHANGE_REGISTER[$INTERNAL_CHANGE_REGISTER[0][0]][1] = $sFunc
   $INTERNAL_CHANGE_REGISTER[$INTERNAL_CHANGE_REGISTER[0][0]][2] = $sParams

   Return 1
Endfunc ; ==> GUICtrlonchangeRegister

; #FUNCTION# ;====================================================================================================================
;
; Name...........: GUICtrlonchangeUnRegister
; Description ...: UnRegisters an edit or input control so it no longer triggers a function
; Syntax.........: GUICtrlonchangeUnRegister($hEdit)
; Parameters ....: $hEdit              - The handle to the edit control (can be a control ID)
; Return values .: Success             - 1
;                  Failure             - 0 And Sets @Error to 1
; Author ........: Mat
; Modified.......:
; Remarks .......:
; Related .......: GUICtrlonchangeRegister
; Link ..........:
; Example .......: Yes
;
; ;===============================================================================================================================

Func GUICtrlonchangeUnRegister ($hEdit)
   If $hEdit = -1 Then $hEdit = GUICtrlGetHandle (-1)
   If Not IsHwnd ($hEdit) Then $hEdit = GUICtrlGetHandle ($hEdit)
   If $hEdit = 0 Then Return SetError (1, 0, 0) ; $hEdit does not exist

   Local $i = __GUI_CHANGE_REGISTER_GETINDEX ($hEdit)
   If $i < 0 Then Return SetError (1, 0, 0)

   ;_ArrayDelete ($INTERNAL_CHANGE_REGISTER, $i)
   $INTERNAL_CHANGE_REGISTER[0][0] -= 1

   Return 1
Endfunc ; ==> GUICtrlonchangeUnRegister

; #INTERNAL# ;====================================================================================================================
;
; Name...........: __GUI_CHANGE_REGISTER_WM_COMMAND
; Description ...: Handles the WM_COMMAND message and triggers events.
; Syntax.........: __GUI_CHANGE_REGISTER_WM_COMMAND ($hWnd, $msgID, $wParam, $lParam)
; Parameters ....: $hEdit              - The handle to the edit control (can be a control ID)
; Return values .: "GUI_RUNDEFMSG"
; Author ........: Mat
; Modified.......:
; Remarks .......:
; Related .......: GUICtrlonchangeRegister
; Link ..........:
; Example .......: Yes
;
; ;===============================================================================================================================

Func __GUI_CHANGE_REGISTER_WM_COMMAND ($hWnd, $msgID, $wParam, $lParam)
   If (BitShift($wParam, 16) <> 768) Then Return "GUI_RUNDEFMSG"
   Local $i = __GUI_CHANGE_REGISTER_GETINDEX ($lParam)
   If $i < 0 Then Return "GUI_RUNDEFMSG"

   If $INTERNAL_CHANGE_REGISTER[$i][1] = "" Then
      Call ($INTERNAL_CHANGE_REGISTER[$i][1])
   Else
      Local $avParams = StringRegExp ($INTERNAL_CHANGE_REGISTER[$i][2], "(.*?[^\\])?(?:\||$)", 3)
      For $x = Ubound ($avParams) - 2 to 0 Step -1
         $avParams[$x + 1] = $avParams[$x]
      Next
      $avParams[0] = "CallArgArray"
      Call ($INTERNAL_CHANGE_REGISTER[$i][1], $avParams)
   EndIf

   Return "GUI_RUNDEFMSG"
EndFunc ; ==> __GUI_CHANGE_REGISTER_WM_COMMAND

; #INTERNAL# ;====================================================================================================================
;
; Name...........: __GUI_CHANGE_REGISTER_GETINDEX
; Description ...: Returns the array index for an Edit HWnd, or -1.
; Syntax.........: __GUI_CHANGE_REGISTER_GETINDEX($hWnd)
; Parameters ....: $hWnd               - The handle to the edit control (can NOT be a control ID)
; Return values .: The index or -1
; Author ........: Mat
; Modified.......:
; Remarks .......:
; Related .......: __GUI_CHANGE_REGISTER_WM_COMMAND
; Link ..........:
; Example .......: Yes
;
; ;===============================================================================================================================

Func __GUI_CHANGE_REGISTER_GETINDEX ($hWnd)
   For $i = 1 to $INTERNAL_CHANGE_REGISTER[0][0]
      If $hWnd = $INTERNAL_CHANGE_REGISTER[$i][0] Then Return $i
   Next
   Return SetError (1, 0, -1)
Endfunc ; ==> __GUI_CHANGE_REGISTER_GETINDEX