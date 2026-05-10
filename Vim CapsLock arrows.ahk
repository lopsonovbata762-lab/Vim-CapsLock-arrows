#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; Vim Navigation Layer (Stable Clean Version)
; ==============================================================================

; --- SETTINGS ---
SetCapsLockState "AlwaysOff"

; ==============================================================================
; INIT
; ==============================================================================

InitTray()

; ==============================================================================
; CAPSLOCK TAP VS HOLD
; ==============================================================================

*CapsLock::
{
    ; Tap = toggle CapsLock
    if KeyWait("CapsLock", "T0.2") {
        state := !GetKeyState("CapsLock", "T")
        SetCapsLockState(state ? "AlwaysOn" : "AlwaysOff")
    }
}

; ==============================================================================
; NAVIGATION LAYER
; ==============================================================================

#HotIf GetKeyState("CapsLock", "P")

GetMods() {
    mods := ""
    if GetKeyState("s", "P")
        mods .= "^"   ; Ctrl
    if GetKeyState("d", "P")
        mods .= "+"   ; Shift
    return mods
}

*i::SendInput "{Blind}" GetMods() "{Up}"
*j::SendInput "{Blind}" GetMods() "{Left}"
*k::SendInput "{Blind}" GetMods() "{Down}"
*l::SendInput "{Blind}" GetMods() "{Right}"

*u::SendInput "{Blind}" GetMods() "{Home}"
*o::SendInput "{Blind}" GetMods() "{End}"

*s::return
*d::return

#HotIf

; ==============================================================================
; TRAY MENU
; ==============================================================================

InitTray() {
    A_TrayMenu.Delete() ; очистить меню полностью

    A_TrayMenu.Add("Reload", (*) => Reload())
    A_TrayMenu.Add("Exit", (*) => ExitApp())
}
; check
