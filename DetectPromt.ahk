SetTitleMatchMode, 2 ; Allow for partial matching of window titles

#Persistent ; Keep the script running

SetTimer, CheckWindow, 500 ; Set timer to check the window every 500 milliseconds

CheckWindow:
IfWinExist, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
{
    ; Get the position and size of the window
    WinGetPos, winX, winY, winWidth, winHeight, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
    
    ; Calculate the relative position for the pixel check (55 pixels from the bottom)
    relativeY := winHeight - 55
    
    ; Get the color of the specified pixel (230, relativeY) relative to the window
    PixelGetColor, pixelColor, 230, %relativeY%, RGB, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
    
    ; Check if the color is not #202020
    if (pixelColor != 0x202020)
    {
        ; If the color is different, send the "Enter" key
        ControlSend, , {Enter}, Windows Security ahk_class Credential Dialog Xaml Host ahk_exe CredentialUIBroker.exe
    }
}
return