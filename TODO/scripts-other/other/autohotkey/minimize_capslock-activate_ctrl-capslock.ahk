#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
previous_ID := 0

loop 
{	
	; get the current window's handle
	WinGet, current_ID, ID, A
	
	; wait until a new window is activated
	WinWaitNotActive, ahk_id %current_ID%
	
	; save the previous window's handle for later
	previous_ID := current_ID
}

Capslock::WinMinimize, A
^Capslock::WinActivate ahk_id %previous_ID%
return