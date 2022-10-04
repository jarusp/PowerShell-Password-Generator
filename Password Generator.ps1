#add .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

#Function to generate randomized string with min 12 characters for complexity
Function Generate-Password {
    [CmdletBinding()]
    param(
        [parameter(mandatory)]
        [ValidateScript({$_ -ge '12'})]
        [int] $charcount = 12
        )
    Process {
        -join((33..126)|Get-Random -count $charcount|% {[char]$_})
        }
}

#Build base form (the window)
$passwin = New-Object System.Windows.Forms.Form
$passwin.text = 'Password Generator'
$passwin.size = New-Object System.Drawing.Size(250,250)
$passwin.FormBorderStyle = 'FixedDialog'
$passwin.MaximizeBox = $false
$passwin.startposition = 'CenterScreen'

#Label the character input box
$labelchar = new-object system.windows.forms.label
$labelchar.location = New-Object System.Drawing.Point(20,20)
$labelchar.size = New-Object System.Drawing.size(200,20)
$labelchar.text = 'How many characters? (min 12)'
$passwin.controls.add($labelchar)

#Build the Character input box and attach to window
#12 will appear in the box by default
$charbox = New-Object System.Windows.Forms.TextBox
$charbox.location = New-Object System.Drawing.Point(20,40)
$charbox.Size = New-Object system.drawing.size(210,20)
$charbox.Text = '12'
$passwin.controls.Add($charbox)

#Label the textbox the password will appear in
$labelpass = New-Object System.Windows.Forms.Label
$labelpass.location = New-Object system.drawing.point(20,80)
$labelpass.size = New-Object system.drawing.size(200,20)
$labelpass.text = 'Your new password:'
$passwin.controls.Add($labelpass)

#Build the button to generate the password, assign functionality,
#and add to window
$genbut = New-Object System.Windows.Forms.Button
$genbut.location = New-Object System.Drawing.Point(20,140)
$genbut.size = New-Object system.drawing.size(100,50)
$genbut.text = 'Generate Password'
$genbut.Add_Click({
        $passbox.Text = Generate-Password $charbox.Text
    })
$passwin.AcceptButton = $genbut
$passwin.controls.add($genbut)

#Build the textbox the password will appear in
$passbox = New-Object System.Windows.Forms.TextBox
$passbox.Location = New-Object system.drawing.point(20,100)
$passbox.Size = New-Object system.drawing.size(210,20)
$passwin.controls.Add($passbox)

#Build a button to copy the password to the clipboard
$gencop = New-Object System.Windows.Forms.Button
$gencop.Location = New-Object system.drawing.point(130,140)
$gencop.Size = New-Object System.Drawing.Size(100,50)
$gencop.Text = 'Copy to Clipboard'
$gencop.Add_Click({
    Set-Clipboard -value $passbox.text
    })
$passwin.controls.add($gencop)

#Make sure the window always appears on top of other windows
$passwin.TopMost = $true

#display the completed form
$passwin.ShowDialog()