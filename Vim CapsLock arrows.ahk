#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; Vim-style Navigation + Home Row Modifiers (AHK v2)
; ==============================================================================

SetCapsLockState "AlwaysOff"

; --- Startup Notification ---
MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
MyGui.BackColor := "1a1a1a"
MyGui.SetFont("s14 cWhite w700", "Segoe UI")
MyGui.Add("Text",, "Vim Navigation Active")
MyGui.Show("xCenter y20 NoActivate")
SetTimer (*) => MyGui.Destroy(), 2000

; --- Auto-Enable Startup Logic ---
startupLnk := A_Startup "\VimNavigation.lnk"

if !FileExist(startupLnk) {
    FileCreateShortcut(A_ScriptFullPath, startupLnk)
    TrayTip "Vim Navigation", "Enabled automatically on startup", "Iconi"
}

; --- CapsLock Behavior Logic ---
*CapsLock::
{
    KeyWait "CapsLock"
    if (A_PriorKey = "CapsLock")
    {
        new_state := !GetKeyState("CapsLock", "T")
        SetCapsLockState(new_state ? "AlwaysOn" : "AlwaysOff")
    }
}

; --- Navigation Layer ---
#HotIf GetKeyState("CapsLock", "P")

Modifier() {
    mod := ""
    if GetKeyState("s", "P")
        mod .= "^"  
    if GetKeyState("d", "P")
        mod .= "+"  
    return mod
}

*i::Send(Modifier() "{Up}")
*j::Send(Modifier() "{Left}")
*k::Send(Modifier() "{Down}")
*l::Send(Modifier() "{Right}")
*u::Send(Modifier() "{Home}")
*o::Send(Modifier() "{End}")

*s::return 
*d::return

#HotIf

; --- Tray Menu Management ---
A_TrayMenu.Add() ; Separator
A_TrayMenu.Add("Run at Startup", ToggleStartup)

; Update menu checkmark based on current state
if FileExist(startupLnk)
    A_TrayMenu.Check("Run at Startup")

ToggleStartup(*) {
    if FileExist(startupLnk) {
        FileDelete(startupLnk)
        A_TrayMenu.Uncheck("Run at Startup")
