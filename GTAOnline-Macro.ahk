#NoEnv
#Persistent
#SingleInstance Ignore
#InstallKeybdHook
#UseHook
SendMode Input
SetWorkingDir %A_ScriptDir%
SetKeyDelay 0
SetWinDelay 0
SetBatchLines -1
SetControlDelay 0
SetTitleMatchMode, 2

rule := "GTAO-NoSave"
ip := "192.81.241.171"
proc := "GTA5.exe"
suspend := "PsSuspend.exe"

if !A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%",, UseErrorLevel
	if ErrorLevel != 0
		MsgBox, 48, Error, This script requires administrator privileges! Please run it again with the correct privileges.
	ExitApp
}

OnExit("AppExit")

<^F9::
	RunWait, netsh advfirewall firewall add rule name="%rule%" dir=out action=block remoteip="%ip%", , Hide
	ToolTip, NO SAVING MODE ON, 10, 10
return

<^F12::
	RunWait, netsh advfirewall firewall delete rule name="%rule%", , Hide
	ToolTip, NO SAVING MODE OFF, 10, 10
	Sleep 3000
	ToolTip
return

<^F4::
	MsgBox, 36, Confirm Suspension, Suspend GTA5.exe for solo session?
	ifMsgBox Yes
	{
		RunWait, %ComSpec% /c "%suspend% %proc%", , Hide
		ToolTip, SUSPENDED (for 10s), 10, 10
		Sleep 10000
		RunWait, %ComSpec% /c "%suspend% -r %proc%", , Hide
		ToolTip, RESUMED, 10, 10
		Sleep 1500
		ToolTip
	}
return

Toggle = false

<^F5::  ; Ctrl + F5 to toggle spam
    Toggle := !Toggle
    if (Toggle) {
        SetTimer, SpamClick, 10  ; Start the timer
    } else {
        SetTimer, SpamClick, Off  ; Stop the timer
    }
return

SpamClick:
    Click, down
    Random, t, 4, 6
    Sleep, t
    Click, up
    Random, r, 80, 90
    Sleep, r
return

AppExit()
{
	global rule, proc, suspend
	RunWait, netsh advfirewall firewall delete rule name="%rule%", , Hide
	RunWait, %ComSpec% /c "%suspend% -r %proc%", , Hide
}
