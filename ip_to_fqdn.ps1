######################################################################################################
# Just open a powershell console and navigate to the folder where the script is and  execute it      #
# by typing .\ip_to_fqdn.ps1                                                                         #
######################################################################################################

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
# O B S !!! If you want output to file instead of screen just remove the # on line 35
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
