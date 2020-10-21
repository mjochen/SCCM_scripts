$domein = (Get-ADDomain).DistinguishedName
New-ADUser -name "CM_NA" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_NA" -Description "Config Manager network access" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
New-ADUser -name "CM_JD" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_JD" -Description "Config Manager Join Domain" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
New-ADGroup -GroupScope DomainLocal -Name "LocalCorpAdmins" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein"
New-ADUser -name "CM_CP" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_CP" -Description "Config Manager Client Push" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
Add-ADGroupMember "LocalCorpAdmins" -Members "CM_CP" 
New-ADUser -name "CM_SR" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_SR" -Description "Config Manager SQL Reporting" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
New-ADUser -name "CM_EX" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_EX" -Description "Config Manager Exchange Connector" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
New-ADUser -name "CM_SQ" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein" -samAccountName "CM_SQ" -Description "Config Manager SQL Service" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -Enabled $true
New-ADGroup -GroupScope DomainLocal -name "ConfigMgr_servers" -Path "OU=SCCM,OU=Admins,OU=Acme,$domein"
Get-ADComputer -Filter { Name -like "CM*" } | Add-ADPrincipalGroupMembership -MemberOf "ConfigMgr_Servers"
