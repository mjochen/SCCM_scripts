#region create 7 zip install collection

New-CMCollection -CollectionType User `
    -Name "SW_7zip_Uninstall" -Comment "All groups and users in this collection will have 7zip automatically uninstalled." `
    -LimitingCollectionName "All Users and User Groups"

Get-CMCollection -Name "SW_7zip_Uninstall" | Move-CMObject -FolderPath "PS1:\UserCollection\Software"

$query = 'select SMS_R_USERGROUP.ResourceID,SMS_R_USERGROUP.ResourceType,SMS_R_USERGROUP.Name,SMS_R_USERGROUP.UniqueUsergroupName,SMS_R_USERGROUP.WindowsNTDomain from SMS_R_UserGroup where SMS_R_UserGroup.Name = "CD\\SW_7zip_Uninstall" '

Get-CMCollection -Name "SW_7zip_Uninstall" | Add-CMUserCollectionQueryMembershipRule -QueryExpression $query -RuleName "7zip Uninstall"

#endregion
#region create 7 zip uninstall collection

New-CMCollection -CollectionType User `
    -Name "SW_7zip_Install" -Comment "All groups and users in this collection will have 7zip automatically installed." `
    -LimitingCollectionName "All Users and User Groups"

Get-CMCollection -Name "SW_7zip_Install" | Move-CMObject -FolderPath "PS1:\UserCollection\Software"

$query = 'select SMS_R_USERGROUP.ResourceID,SMS_R_USERGROUP.ResourceType,SMS_R_USERGROUP.Name,SMS_R_USERGROUP.UniqueUsergroupName,SMS_R_USERGROUP.WindowsNTDomain from SMS_R_UserGroup where SMS_R_UserGroup.Name = "CD\\SW_7zip_Install" '

Get-CMCollection -Name "SW_7zip_Install" | Add-CMUserCollectionQueryMembershipRule -QueryExpression $query -RuleName "7zip Install"
Get-CMCollection -Name "SW_7zip_Install" | Add-CMUserCollectionExcludeMembershipRule -ExcludeCollectionName "SW_7zip_Uninstall"

Get-CMCollection -Name "SW_7zip_Install" | Get-Member

#endregion