#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


`::

ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
If HWND =
ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW
If DllCall("IsWindowVisible", UInt, HWND)
{
WinHide, ahk_id %HWND%
WinHide,ahk_class Shell_TrayWnd
WinHide,Start ahk_class Button
}
Else
{
WinShow, ahk_id %HWND%
WinShow,ahk_class Shell_TrayWnd
WinShow,Start ahk_class Button
}

Return