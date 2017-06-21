Set-Variable -Name "config" -Value ([string]"$HOME/.cdbookmark") -Scope script -Option constant
Set-Variable -Name "cdBookmark" -Value ([hashtable]@{}) -Scope global
function save {
    Write-Host "save"
    $global:cdBookmark | ConvertTo-Json | Out-File $script:config
}
function load {
    Write-Host "load $config"
    $o = Get-Content $script:config -ErrorAction SilentlyContinue -ErrorVariable $e | ConvertFrom-Json
    if ($e) {
        $global:cdBookmark = $null
        save 
    }
    # convert to hashtable
    $o.psobject.properties | Foreach { $global:cdBookmark[$_.Name] = $_.Value }
}

function Get-CdBookmark {
    Write-Host "Get-CdBookmark"
    Write-Output $global:cdBookmark

    <#
.Synopsis
    Show bookmarks.
.Description     
.Example
    Get-Bookmarks
    
    Name                           Value
    ----                           -----
    cdb                            C:\ws\project\Cdbookmark
    ws                             C:\ws\project
#>

}
function Set-CdBookmark {

    [CmdletBinding()]
    Param(
    )
    Write-Host "Set-CdBookmark"

    # https://blogs.technet.microsoft.com/pstips/2014/06/09/dynamic-validateset-in-a-dynamic-parameter/
    DynamicParam {
        Write-Host "Set-CdBookmark DynamicParam"
        # Set the dynamic parameters' name
        $ParameterName = 'Name'
            
        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Create the collection of attributes
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            
        # Create and set the parameters' attributes
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $true
        $ParameterAttribute.Position = 1

        # Add the attributes to the attributes collection
        $AttributeCollection.Add($ParameterAttribute)

        # Generate and set the ValidateSet 
        $arrSet = $global:cdBookmark.keys
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)

        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }
    begin {
        Write-Host "Set-CdBookmark begin"
        # Bind the parameter to a friendly variable
        $Name = $PsBoundParameters[$ParameterName]
    }

    process {
        Write-Host "Set-CdBookmark process"
        Set-Location $global:cdBookmark[$Name]

    }
    <#
.Synopsis
    Set bookmark location.
.Description     
.Parameter Name
    bookmark name
.Example
    Set-CdBookmark cdb

#>
}
 
function Add-CdBookmark {
    Param(
        $Name,
        $Path
    )
    Write-Host "Add-CdBookmark"

    $global:cdBookmark[$Name] = (Resolve-Path $Path).Path
    save

    <#
.Synopsis
    Add or update bookmark
.Description     
.Parameter Name
    bookmark name
.Parameter Path
    bookmark location
.Example
    Add-CdBookmark -Name cdb -Path C:\ws\project\Cdbookmark
    
#>
}
  
function Remove-CdBookmark {
    Param(
        [string]$Name,
        [switch]$All = $false
    )
    Write-Host "Add-CdBookmark"

    if ($All) {
        $global:cdBookmark = [hashtable]@{}
    }
    else {
        if ($global:cdBookmark) {
            $global:cdBookmark.Remove($Name)
            save
        }
    }

    <#
.Synopsis
    Remove bookmark
.Description     
.Parameter Name
    bookmark name
.Example
    Remove-CdBookmark -Name cdb
#>
}
