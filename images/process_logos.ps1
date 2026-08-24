Add-Type -AssemblyName System.Drawing

$img = [System.Drawing.Image]::FromFile("c:\Users\dooni\Downloads\dooninfra\images\logo2.png")
$bmp = New-Object System.Drawing.Bitmap($img.Width, $img.Height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.DrawImage($img, 0, 0)
$img.Dispose()

$bmpLight = New-Object System.Drawing.Bitmap($bmp)
$bmpDark = New-Object System.Drawing.Bitmap($bmp)

for ($x = 0; $x -lt $bmp.Width; $x++) {
    for ($y = 0; $y -lt $bmp.Height; $y++) {
        $pixel = $bmp.GetPixel($x, $y)
        # If pixel is near white, make it transparent
        if ($pixel.R -gt 240 -and $pixel.G -gt 240 -and $pixel.B -gt 240) {
            $bmpLight.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            $bmpDark.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        } else {
            # For the dark background version, convert the bottom text ("Your Trusted...") to white
            if ($y -gt ($bmp.Height * 0.70)) {
                # If it's a dark pixel, make it white
                if ($pixel.R -lt 150 -and $pixel.G -lt 150 -and $pixel.B -lt 200) {
                    $bmpDark.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($pixel.A, 255, 255, 255))
                }
            }
        }
    }
}

$bmpLight.Save("c:\Users\dooni\Downloads\dooninfra\images\logo-light.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpDark.Save("c:\Users\dooni\Downloads\dooninfra\images\logo-dark.png", [System.Drawing.Imaging.ImageFormat]::Png)

$bmp.Dispose()
$bmpLight.Dispose()
$bmpDark.Dispose()
Write-Host "Logos processed successfully!"
