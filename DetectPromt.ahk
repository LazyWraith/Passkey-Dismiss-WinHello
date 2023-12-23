#Persistent
isPasskeyDialog := false
isDarkMode := true
SetTimer, CheckWindow, 500

CheckWindow:
IfWinExist, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
{
    If (!isPasskeyDialog)
    {
        ; Determine if the window is passkey dialog
        WinGetPos, winX, winY, winWidth, winHeight, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
        relativeY := winHeight - 55
        PixelGetColor, pixelColor, 230, %relativeY%, RGB, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
        if (pixelColor = 0x202020 || pixelColor = 0xFFFFFF)
        {
            isPasskeyDialog := true
            SetTimer, CheckColor, 100
        }
    }
}
else
{
    isPasskeyDialog := false
    SetTimer, CheckColor, Off
}
return

CheckColor:
If (isPasskeyDialog)
{
    WinGetPos, winX, winY, winWidth, winHeight, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
    relativeY := winHeight - 55
    PixelGetColor, pixelColor, 230, %relativeY%, RGB, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
    if (isDarkMode) ; Dark mode dialog
    {
        if (pixelColor != 0x202020)
        {
            ControlSend, , {Enter}, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
        }
    }
    else ; Light mode dialog
    {
        if (pixelColor != 0xFFFFFF)
        {
            ControlSend, , {Enter}, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
        }
    }
}
return
