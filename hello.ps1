# dog-hello.ps1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# נתיב לתמונה (בתיקיית Downloads של המשתמש הנוכחי)
$imagePath = Join-Path $env:USERPROFILE "Downloads\you.jpg"

# חלון ראשון – תמונה מסך מלא
$form = New-Object Windows.Forms.Form
$form.FormBorderStyle = 'None'
$form.WindowState = 'Maximized'
$form.TopMost = $true
$form.BackColor = 'Black'

# טקסט גיבוי אם התמונה לא קיימת
if (Test-Path $imagePath) {
    $img = [System.Drawing.Image]::FromFile($imagePath)
    $picBox = New-Object Windows.Forms.PictureBox
    $picBox.Image = $img
    $picBox.Dock = 'Fill'
    $picBox.SizeMode = 'StretchImage'
    $form.Controls.Add($picBox)
} else {
    $labelErr = New-Object Windows.Forms.Label
    $labelErr.Text = "I AM SORRY"
    $labelErr.ForeColor = 'White'
    $labelErr.Font = New-Object System.Drawing.Font('Arial', 36)
    $labelErr.Dock = 'Fill'
    $labelErr.TextAlign = 'MiddleCenter'
    $form.Controls.Add($labelErr)
}

# Timer שיפעיל מעבר אחרי 5 שניות
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 5000  # 5000ms = 5 שניות

$timer.Add_Tick({
    $timer.Stop()
    try { $form.Hide() } catch {}
    try { $form.Dispose() } catch {}

    $form2 = New-Object Windows.Forms.Form
    $form2.FormBorderStyle = 'None'
    $form2.WindowState = 'Maximized'
    $form2.TopMost = $true
    $form2.BackColor = 'Black'

    $label = New-Object Windows.Forms.Label
    $label.Text = "hello"
    $label.ForeColor = 'White'
    $label.Font = New-Object System.Drawing.Font('Arial', 72, [System.Drawing.FontStyle]::Bold)
    $label.Dock = 'Fill'
    $label.TextAlign = 'MiddleCenter'

    $form2.Controls.Add($label)
    $form2.ShowDialog()
    exit
})

$timer.Start()
[void]$form.ShowDialog()
