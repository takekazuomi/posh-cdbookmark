Get-ChildItem "$PSScriptRoot/*.ps1" |
    ? { $_.Name -notlike "*.Tests.*" } |
    % { . $_.PSPath }

load 

Export-ModuleMember `
    -Function @(
        'Get-CdBookmark'
        'Use-CdBookmark'
        'Add-CdBookmark'
        'Remove-CdBookmark'
    )

Set-Alias cdb Use-CdBookmark
Export-ModuleMember -Alias cdb
Set-Alias Set-CdBookmark Add-CdBookmark
Export-ModuleMember -Alias Set-CdBookmark

