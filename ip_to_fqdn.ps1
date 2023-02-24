$ErrorActionPreference = "Continue"
Write-Host "Skrivet av Kent Karlsson - den som vill får gärna förbättra det" -ForegroundColor Green                                                                    
sleep -Seconds 2
$folder = Read-Host -Prompt 'input folder name'
$file = Read-Host -Prompt 'Input file name'
$input = ("$folder" + "\" + "$file")
sleep -Seconds 2
(Get-Content $input) | % {Resolve-DnsName $_ } | ConvertTo-Html | Out-File "c:\logs\nslookup_$((Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')).html"
