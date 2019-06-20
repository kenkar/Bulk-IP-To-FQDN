# Bulk-IP-To-FQDN
Powershell script for bulk nsklookup 
########################################################################################################################################
# This is a rewrite of Dineshswpd's script (Bulk NsLookup.ps1). My intention was to make the script more automatic                     #
# so you can chose folder and text file when script is executed instead of editing the script                                          #
# for each text file and for each different location where tex file might be located                                                   #
# For more information about the original script: https://gallery.technet.microsoft.com/scriptcenter/Run-NsLookup-for-Bulk-of-1df49eab # 
########################################################################################################################################

Write-Host "This script will do bulk nslookup against ip addresses" -ForegroundColor Green
sleep -Seconds 2
Write-Host "You'll get 2 questions:" -ForegroundColor Green
sleep -Seconds 2
Write-Host "Which folder is your text file in ? (drive or UNC-path)" -ForegroundColor Green
sleep -Seconds 2
Write-Host "Name of text file?" -ForegroundColor Green
sleep -Seconds 2
Write-Host "Here we go" -ForegroundColor Green
sleep -Seconds 2
$folder = Read-Host -Prompt 'input folder name'
$file = Read-Host -Prompt 'Input file name'
$input = ("$folder" + "\" + "$file")
sleep -Seconds 2
Get-Content $input 
# If you want output to file instead of screen just remove the '#' infront of pipe sign on line 35
$ips = Get-Content $input
Foreach ($ip in $ips)	{
$name = nslookup $ip 2> $null | select-string -pattern "Name:"
	if ( ! $name ) { $name = "" }
	$name = $name.ToString()
	if ($name.StartsWith("Name:")) {
	$name = (($name -Split ":")[1]).Trim()
	}
	else {
	$name = "NOT FOUND"
	}
Echo "$ip `t $name" #| Out-File -FilePath "\\server\share\reports\address.csv" -Append
}
