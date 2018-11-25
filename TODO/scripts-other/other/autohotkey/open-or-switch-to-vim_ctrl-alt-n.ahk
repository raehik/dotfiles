#NoEnv                      ; Recommended for performance and compatibility
                            ; with future AutoHotkey releases.
;#Warn                      ; Enable warnings to assist with detecting common
                            ; errors.
SendMode Input              ; Recommended for new scripts due to its superior
                            ; speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

^!n::
if WinExist("ahk_class Vim")
{
    WinActivate
    Send ^n
}
else
{
    Run, C:\Users\Ben\Documents\programs\portable\editors\vim\vim74\gvim.exe
}
