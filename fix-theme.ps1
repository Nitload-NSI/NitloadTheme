$file = 'd:\Programmer\NitloadTheme\NitloadTheme\NitloadTheme.vstheme'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# === Fix 1 & 2: Terminal and Agent dialog -> dark gray ===
# Replace Nord blue tones with dark gray in ToolWindow and Output Window areas
# We do targeted replacements by color name context

# ToolWindow backgrounds: 2E3440 -> 333337
foreach ($name in @('ToolWindowBackground', 'ToolWindowTabBorder', 'ToolWindowTabGradientBegin', 'ToolWindowTabGradientEnd')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF2E3440(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF333337${2}')
}

# ToolWindow borders: 434C5E -> 434346
foreach ($name in @('ToolWindowBorder')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF434C5E(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF434346${2}')
}

# ToolWindow buttons/hover: 4C566A -> 4D4D50
foreach ($name in @('ToolWindowButtonDown', 'ToolWindowButtonDownBorder', 'ToolWindowButtonHoverActive', 'ToolWindowButtonHoverActiveBorder', 'ToolWindowButtonHoverInactive', 'ToolWindowButtonHoverInactiveBorder')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF4C566A(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF4D4D50${2}')
}

# ToolWindowTabSelectedTab: 4C566A -> 3E3E42
foreach ($name in @('ToolWindowTabSelectedTab')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF4C566A(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF3E3E42${2}')
}

# ToolWindowContentTabGradient 
foreach ($name in @('ToolWindowContentTabGradientBegin', 'ToolWindowContentTabGradientEnd')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF333337${2}')
}

# ToolWindowContentGrid
$pattern = "(<Color Name=`"ToolWindowContentGrid`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF434346${2}')

# ToolWindowTabMouseOver
foreach ($name in @('ToolWindowTabMouseOverBackgroundBegin', 'ToolWindowTabMouseOverBackgroundEnd')) {
    $pattern = "(<Color Name=`"$name`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
    $content = [regex]::Replace($content, $pattern, '${1}FF3E3E42${2}')
}
$pattern = "(<Color Name=`"ToolWindowTabMouseOverBorder`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF434346${2}')

# ToolWindowTabSeparator
$pattern = "(<Color Name=`"ToolWindowTabSeparator`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF434346${2}')

# ToolWindowTabSelectedBorder
$pattern = "(<Color Name=`"ToolWindowTabSelectedBorder`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF3E3E42${2}')

# ToolWindowTabSelectedActiveText - keep foreground, just fix bg if present
$pattern = "(<Color Name=`"ToolWindowTabSelectedActiveText`">\s*<Background Type=`"CT_RAW`" Source=`")FF[0-9A-Fa-f]{6}(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF3E3E42${2}')

Write-Host "ToolWindow colors done"

# === Output Window backgrounds: 2E3440 -> 333337 ===
foreach ($name in @('urlformat', 'OutputHeading', 'OutputError', 'OutputVerbose', 'Plain Text')) {
    # Match within Output Window context - we use a broad pattern since these names are in the Output Window category
    # But "Plain Text" also exists in other categories, so we need to be careful
    # Let's just replace the first occurrence of each in the Output Window section
}

# Actually let's use a section-based approach for Output Window
$owStart = $content.IndexOf('<Category Name="Output Window"')
$owEnd = $content.IndexOf('</Category>', $owStart) + '</Category>'.Length
$owSection = $content.Substring($owStart, $owEnd - $owStart)
$owFixed = $owSection -replace 'Source="FF2E3440"', 'Source="FF333337"'
$content = $content.Substring(0, $owStart) + $owFixed + $content.Substring($owEnd)

Write-Host "Output Window done"

# === Package Manager Console: 2E3440 -> 333337 ===
$pmcStart = $content.IndexOf('<Category Name="Package Manager Console"')
$pmcEnd = $content.IndexOf('</Category>', $pmcStart) + '</Category>'.Length
$pmcSection = $content.Substring($pmcStart, $pmcEnd - $pmcStart)
$pmcFixed = $pmcSection -replace 'Source="FF2E3440"', 'Source="FF333337"'
$content = $content.Substring(0, $pmcStart) + $pmcFixed + $content.Substring($pmcEnd)

Write-Host "Package Manager Console done"

# === Command Window: 2E3440 -> 333337 ===
$cwStart = $content.IndexOf('<Category Name="Command Window"')
if ($cwStart -ge 0) {
    $cwEnd = $content.IndexOf('</Category>', $cwStart) + '</Category>'.Length
    $cwSection = $content.Substring($cwStart, $cwEnd - $cwStart)
    $cwFixed = $cwSection -replace 'Source="FF2E3440"', 'Source="FF333337"'
    $content = $content.Substring(0, $cwStart) + $cwFixed + $content.Substring($cwEnd)
    Write-Host "Command Window done"
}

# === Immediate Window: 2E3440 -> 333337 ===
$iwStart = $content.IndexOf('<Category Name="Immediate Window"')
if ($iwStart -ge 0) {
    $iwEnd = $content.IndexOf('</Category>', $iwStart) + '</Category>'.Length
    $iwSection = $content.Substring($iwStart, $iwEnd - $iwStart)
    $iwFixed = $iwSection -replace 'Source="FF2E3440"', 'Source="FF333337"'
    $content = $content.Substring(0, $iwStart) + $iwFixed + $content.Substring($iwEnd)
    Write-Host "Immediate Window done"
}

# === FSharpInteractive: 2E3440 -> 333337 ===
$fsStart = $content.IndexOf('<Category Name="FSharpInteractive"')
if ($fsStart -ge 0) {
    $fsEnd = $content.IndexOf('</Category>', $fsStart) + '</Category>'.Length
    $fsSection = $content.Substring($fsStart, $fsEnd - $fsStart)
    $fsFixed = $fsSection -replace 'Source="FF2E3440"', 'Source="FF333337"'
    $content = $content.Substring(0, $fsStart) + $fsFixed + $content.Substring($fsEnd)
    Write-Host "FSharpInteractive done"
}

# === Fix 3: Icon colors ===
# Remove NordFluent icon overrides - set to VS Dark defaults for colorful icons
# IconGeneralFill: ECEFF4 (white) -> F1F1F1 (VS Dark default - still light but standard)
$pattern = "(<Color Name=`"IconGeneralFill`">\s*<Background Type=`"CT_RAW`" Source=`")FFECEFF4(`")"
$content = [regex]::Replace($content, $pattern, '${1}FFF1F1F1${2}')

# IconGeneralStroke: 00000000 (transparent) -> FF414141 (visible dark stroke for VS Dark)
$pattern = "(<Color Name=`"IconGeneralStroke`">\s*<Background Type=`"CT_RAW`" Source=`")00000000(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF414141${2}')

# IconActionFill: 4C566A (dark nord blue) -> FF007ACC (VS Blue - standard action color)
$pattern = "(<Color Name=`"IconActionFill`">\s*<Background Type=`"CT_RAW`" Source=`")FF4C566A(`")"
$content = [regex]::Replace($content, $pattern, '${1}FF007ACC${2}')

Write-Host "Icon colors done"

# Save
[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "All changes saved successfully!"
