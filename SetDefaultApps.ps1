$treeFilePath = "c:\treeline_files"

#gets files beacuse intune will only send the script
Invoke-WebRequest https://github.com/drewpchannel/AdobeSettings/archive/refs/heads/main.zip -OutFile $treeFilePath\asa.zip
Expand-Archive -Path $treeFilePath\asa.zip -DestinationPath $treeFilePath -Force

#gets the user idea from whoami /user
$SID = & "$treeFilePath\SIDget\GetSID.ps1"

# Set the default browser to Chrome
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$protocols = @(
    "http",
    "https",
    "ftp",
    "mailto",
    "chromehtml"
)
foreach ($protocol in $protocols) {
    Set-ItemProperty -Path "Registry::HKEY_USERS\$SID\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$protocol\UserChoice" -Name "ProgId" -Value "ChromeHTML" -Force
}

# Set the default PDF viewer to Adobe Acrobat
$adobePath = "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
$extension = "pdf"
Set-ItemProperty -Path "Registry::HKEY_USERS\$SID\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.$extension\UserChoice" -Name "ProgId" -Value "AcroExch.Document.DC" -Force

# Set the default email client to Outlook
$outlookPath = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
$protocols = @(
    "mailto"
)
#test laptop used Outlook.URL.mailto.15, .15 was added in when switching through normal default apps
foreach ($protocol in $protocols) {
    Set-ItemProperty -Path "Registry::HKEY_USERS\$SID\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$protocol\UserChoice" -Name "ProgId" -Value "Outlook.URL.mailto.15" -Force
}