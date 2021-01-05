[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True,Position=1, HelpMessage = "CSV Input. Required header 'SourceFileName'")]
   [string]$CsvInputPath,
   [Parameter(Mandatory=$False,Position=2, HelpMessage = "Replacement string for the unsupported char")]
   [string]$ReplacementString="",
   [Parameter(Mandatory=$False,Position=3, HelpMessage = "Rename Items as it evaluates")]
   [switch]$RenameItems,
   [Parameter(Mandatory=$False,Position=4, HelpMessage = "Output to screen and do not create mapping CSV")]
   [bool]$OutputToScreenOnly
)

$ErrorActionPreference="Stop"

$disallowedChars = @()
# 0x0000002A  = '*'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000002A), 0)
# 0x00000022  = quotation mark
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x00000022), 0)
# 0x0000003F  = '?'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000003F), 0)
# 0x0000003E  = '>'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000003E), 0)
# 0x0000003C  = '<'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000003C), 0)
# 0x0000003A  = ':'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000003A), 0)
# 0x0000007C  = '|'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000007C), 0)
# 0x0000002F  = '/'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000002F), 0)
# 0x0000005C  = '\'
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000005C), 0)
# 0x0000007F  = del delete
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000007F), 0)

# Unsupported control chars
# high octet preset
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x00000081), 0)
# ri reverse line feed
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000008D), 0)
# ss3 single shift three
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000008F), 0)
# dcs device control string
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x00000090), 0)
# osc operating system command
$disallowedChars += [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x0000009D), 0)

# Function validates the validity for the char supported by azure blobs
# Chars outside the range as validated by this function are invalid/control chars
function IsSupported([string]$charString) {
    [int]$CodePoint = [char]::ConvertToUtf32($charString, 0);

    Write-Host "Testing character $($charString) (CodePoint: $($CodePoint))" -ForegroundColor Green

    [bool]$InRange = $false;

    switch ($CodePoint) {
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x1F), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xD7FF), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xF900), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xFDCF), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xFDF0), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xFFEF), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x10000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x1FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x20000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x2FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x30000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x3FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x40000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x4FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x50000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x5FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x60000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x6FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x70000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x7FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x80000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x8FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x90000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x9FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xA0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xAFFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xB0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xBFFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xC0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xCFFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xD0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xDFFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xE1000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xEFFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xE000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xF8FF), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xF0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xFFFFD), 0)} { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x100000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0x10FFFD), 0) } { $InRange = $true }
        { [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xE0000), 0) -le $_ -and $_ -le [char]::ConvertToUtf32([char]::ConvertFromUtf32([int]0xE0FFF), 0) } { $InRange = $true }
        default { $InRange = $false }
    }

    if ($InRange) {
        # The character is withing the range of valid characters supported by XStore,
        # hence it is supported, unless it is part of the exception list
        if ($disallowedChars.Contains($CodePoint)) {
            Write-Host "Unsupported char code point: $($CodePoint)" -ForegroundColor Red
            return $CodePoint
        } else {
            return 0
        }
    } else {
        # The character is outside the range of valid characters supported by XStore
        Write-Host "Not in range - Unsupported char code point: $($CodePoint)" -ForegroundColor Red
        return $CodePoint;
    }
}

if ([string]::IsNullOrEmpty($ReplacementString) -or $ReplacementString.Contains(' ') -or $ReplacementString.Contains('.'))
{
    Write-Host "ReplacementString not provided, using default as ''" -ForegroundColor Yellow
    $ReplacementString = ""
}
else
{
    Write-Host "Provided ReplacementString: " $ReplacementString
}

if (-not ([string]::IsNullOrEmpty($CsvInputPath)))
{
    if (-not (Test-Path -Path $CsvInputPath -PathType Leaf))
    {
        Write-Error "Specified input is not available: $CsvInputPath" -ErrorAction Stop
    }
}

$csvImport = Import-Csv -Path $CsvInputPath

if (($csvImport | Measure-Object | Select-Object -ExpandProperty Count) -lt 1) {
    Write-Output "CSV contains not valid items. Please provide a proper input."
}

$csvExport = @()

foreach ($record in $csvImport) {
    [char]$prevChar = "a"
    [int]$exitCode = 0;
    [string]$message = ""
    [string]$sourceName = $record.SourceFileName
    [string]$destName = ""

    foreach ($char in $sourceName.ToCharArray()) {
        #Write-Host "Testing character: $($char)" -ForegroundColor Green
        $foundUnsupportedChar = $false;

        if ([char]::IsHighSurrogate($char) -and $testString.Length -eq 1) {
            $exitCode = -1;
            $message = "Invalid surrogate char found in the name";
        } elseif (-not [char]::IsHighSurrogate($prevChar) -and [char]::IsHighSurrogate($char)) {
            // Valid case
        } elseif (-not [char]::IsHighSurrogate($prevChar) -and [char]::IsLowSurrogate($char)) {
            $exitCode = -1;
            $message = "Found a low surrogate character without a preceding high surrogate character";
        } elseif ([char]::IsHighSurrogate($prevChar) -and -not [char]::IsLowSurrogate($char)) {
            $exitCode = -1;
            $message = "Invalid surrogate pair found in the name";
        } elseif ([char]::IsHighSurrogate($prevChar) -and [char]::IsLowSurrogate($char))
        {
            [char[]]$charArray = $prevChar, $char;
            $exitCode = IsSupported(New-Object System.String($charArray));
        }
        else
        {
            [char[]]$charArray = $char;
            $exitCode = IsSupported(New-Object System.String($charArray));
        }

        if ($exitCode -ne 0) {
            $foundUnsupportedChar = $true
            if ($message.Length -gt 0) {
                Write-Host "Message: $($message)"
            }
        }

        if ($RenameItems) {
            if ($foundUnsupportedChar) {
                $destName = $destName.Substring(0,$destName.Length - 1)
                $destName += $ReplacementString
            } else {
                $destName += $char
            }
        } else {
            $destName += $char
        }

        $prevChar = $char;
    }

    if (-not $OutputToScreenOnly) {
        $exportRecord = [PSCustomObject]@{
            SourceFileName = $sourceName
            DestinationFileName = $destName
        }
        $csvExport += $exportRecord;
    }

    Write-Host "Source name:      $($sourceName)" -ForegroundColor Yellow
    Write-Host "Destination name: $($destName)" -ForegroundColor Yellow
}

if (-not $OutputToScreenOnly) {
    $FixedFileNamesFileName = (Split-Path -Path $CsvInputPath) + "\\FixedFileNames.csv"
    $csvExport | Export-Csv -Path $FixedFileNamesFileName -NoTypeInformation -Force -Encoding UTF8
}