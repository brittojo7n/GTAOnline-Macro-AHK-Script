#NoEnv
#Persistent
#SingleInstance Ignore
#UseHook
SendMode Input
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetTitleMatchMode, 2

rule := "GTAO-NoSave"
ip := "192.81.241.171"
proc := "GTA5.exe"
suspend := "PsSuspend.exe"
GTAWasSuspended := false

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

Toggle := false

<^F5::
	Toggle := !Toggle
	if (Toggle) {
		SetTimer, SpamClick, 10
		ToolTip, AUTOCLICK ON, 10, 10
	} else {
		SetTimer, SpamClick, Off
		ToolTip, AUTOCLICK OFF, 10, 10
		Sleep 2000
		ToolTip
	}
return

SpamClick:
	if !WinActive("Grand Theft Auto V")
		return
	Click, down
	Random, t, 4, 6
	Sleep, t
	Click, up
	Random, r, 80, 90
	Sleep, r
return

afkOn := false

<^F6::
	afkOn := !afkOn
	if (afkOn) {
		SetTimer, AntiAFK, 1000
		ToolTip, ANTI-AFK ON, 10, 10
	} else {
		SetTimer, AntiAFK, Off
		ToolTip, ANTI-AFK OFF, 10, 10
		Sleep 2000
		ToolTip
	}
return

AntiAFK:
	if !WinActive("Grand Theft Auto V")
		return

	if (GetKeyState("w", "P") || GetKeyState("a", "P") || GetKeyState("s", "P") || GetKeyState("d", "P"))
		return

	Random, k, 1, 4
	Random, h, 50, 100
	Random, w, 1000, 2000
	key := SubStr("wasd", k, 1)

	Send, {%key% down}
	Sleep, %h%
	Send, {%key% up}
	Sleep, %w%
return

AppExit()
{
	global rule, proc, suspend
	SetTimer, SpamClick, Off
	SetTimer, AntiAFK, Off
	RunWait, netsh advfirewall firewall delete rule name="%rule%", , Hide
	RunWait, %ComSpec% /c "%suspend% -r %proc%", , Hide
	ToolTip
}
