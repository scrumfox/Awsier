## AWSier
## Created by: Riyas Karakkadan alias ScrumFox @2022
## Write-Host 'Utility to export api end point details from available api gateways'
## Open API json documentations will be generated in the current folder.
##
## Prerequisities: Need to set up the region and credentials using aws configure.
#-------------------------------------------------------------

Write-Host "				__________       _____________             "
Write-Host "				___    |_ |     / /_  ___/__(_)____________"
Write-Host "				__  /| |_ | /| / /_____ \__  /_  _ \_  ___/"
Write-Host "				_  ___ |_ |/ |/ / ____/ /_  / /  __/  /    "
Write-Host "				/_/  |_|___/|__/  /____/ /_/  \___//_/     "
Write-Host ""                                       
										 
$gatwayids = aws apigateway get-rest-apis --query items[*].id --output text

if(-not ([string]::IsNullOrEmpty($gatwayids))){
	$gatewayFiltered =[regex]::split($gatwayids,',|\s+')
	##foreach($gatway-id in get-content $gatway-ids) { To get contents from file.
	
	foreach($gatwayid in $gatewayFiltered) {
		$stage = aws apigateway get-stages --rest-api-id $gatwayid --query item[*].stageName --output text
	
		if(-not ([string]::IsNullOrEmpty($stage))){
			$regex =  [regex]::split($stage,',|\s+')
			
			foreach($st in $regex){
				if(-not ([string]::IsNullOrEmpty($st))){
					aws apigateway get-export --rest-api-id $gatwayid --stage-name $st --export-type swagger "$gatwayid-$st.json"
				} 
			}
		}
	}
}
