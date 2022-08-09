#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include "GUIScrollbars_Ex.au3"

; Create main GUI
$hGUI = GUICreate("Test", 500, 500)

GUICtrlCreateButton("Always visible", 10, 10, 80, 30)

GUICtrlCreateGroup("Scrollable", 10, 50, 480, 380)

GUICtrlCreateButton("Always visible", 10, 460, 80, 30)

GUISetState(@SW_HIDE, $hGUI)

; Create child window which will be scrollable
$hAperture = GUICreate("", 440, 340, 30, 70, $WS_POPUP, $WS_EX_MDICHILD, $hGUI)
GUISetBkColor(0xFF0000)

For $i = 0 To 20
    For $j = 0 To 6
        GUICtrlCreateLabel($i & "-" & $j, 10 + ($j * 60), 10 + ($i * 40), 50, 30)
        GUICtrlSetBkColor(-1, 0x00FF00)
    Next
Next

GUISetState(@SW_HIDE, $hAperture)

; make the scrollbars
_GUIScrollbars_Generate($hAperture, 0, 21 * 40)

GUISetState(@SW_SHOW, $hGUI)
GUISetState(@SW_SHOW, $hAperture)

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch

WEnd