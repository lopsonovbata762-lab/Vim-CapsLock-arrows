#Requires AutoHotkey v2.0
#SingleInstance Force ; 


; ==============================================================================
; Vim-style Navigation + Home Row Modifiers (AHK v2)
; ==============================================================================
; Functionality:
; 1. CapsLock acts as a Toggle for standard CapsLock ONLY when tapped alone.
; 2. CapsLock acts as a Layer Modifier when held down.
; 3. Navigation (IJKL/UO) becomes active while CapsLock is held.
; 4. S and D act as Shift/Ctrl modifiers within the Navigation layer.
; ==============================================================================

#Requires AutoHotkey v2.0
SetCapsLockState "AlwaysOff"

; --- CapsLock Behavior Logic ---
; Tapping CapsLock toggles its state; holding it activates the navigation layer.
*CapsLock::
{
    KeyWait "CapsLock"
    if (A_PriorKey = "CapsLock")
    {
        ; Toggle CapsLock state if no other keys were pressed
        new_state := !GetKeyState("CapsLock", "T")
        SetCapsLockState(new_state ? "AlwaysOn" : "AlwaysOff")
    }
}

; --- Navigation Layer (Active while CapsLock is held) ---
#HotIf GetKeyState("CapsLock", "P")

/**
 * Modifier Function
 * Checks the state of 'S' and 'D' keys to dynamically apply Ctrl and Shift.
 * S = Ctrl (^)
 * D = Shift (+)
 * S+D = Ctrl+Shift (^+ )
 */
Modifier() {
    mod := ""
    if GetKeyState("s", "P")
        mod .= "^"  
    if GetKeyState("d", "P")
        mod .= "+"  
    return mod
}

; Vim-style Directional Keys
*i::Send(Modifier() "{Up}")
*j::Send(Modifier() "{Left}")
*k::Send(Modifier() "{Down}")
*l::Send(Modifier() "{Right}")

; Line Navigation Keys
*u::Send(Modifier() "{Home}")
*o::Send(Modifier() "{End}")

; Disable standard input for modifier keys while in the Navigation Layer
*s::return 
*d::return

#HotIf
