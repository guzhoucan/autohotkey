; Written using AutoHotKey 2.0
#SingleInstance Force

toggle := false
LogFilePath := A_Desktop . "\KeyLog.txt"
global InputHookObj := InputHook("M") ; 'M' option for keyboard hook

^!k::ToggleLogging()

ToggleLogging() {
    global toggle
    toggle := !toggle
    if (toggle) {
        FileAppend("--- Logging Started ---`n", LogFilePath) ; Start message
        StartInputHook()
    } else {
        StopInputHook()
        FileAppend("--- Logging Stopped ---`n", LogFilePath) ; Stop message
    }
}

StartInputHook() {
    global InputHookObj
    InputHookObj.KeyOpt("{All}", "+N")
    InputHookObj.OnKeyDown := LogKey
    InputHookObj.Start()
}

StopInputHook() {
    global InputHookObj
    InputHookObj.Stop()
}

; VK = virtual key code
; SC = scan code
LogKey(InputHookObj, VK, SC) {
    global LogFilePath
    ; MsgBox "LogKey called with VK: " VK ", SC: " SC
    keyName := GetKeyName(Format("vk{:x}sc{:x}", VK, SC))
    TimeStamp := FormatTime("yyyy-MM-dd HH:mm:ss", A_Now)
    FileAppend("keyname: " keyName " - vk: " VK " sc: " SC " - " TimeStamp "`n", LogFilePath)
    FileAppend("input: " InputHookObj.Input "`n", LogFilePath)
}

; Volume_Up::LogSpecificKey("Volume_Up")
; Volume_Down::LogSpecificKey("Volume_Down")
; Volume_Mute::LogSpecificKey("Volume_Mute")

; LogSpecificKey(keyName) {
;     global toggle, LogFilePath
;     if (toggle) {
;         TimeStamp := FormatTime("yyyy-MM-dd HH:mm:ss", A_Now)
;         FileAppend(keyName . " - " . TimeStamp . "`n", LogFilePath)
;     }
; }
