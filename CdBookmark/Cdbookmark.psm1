Get-ChildItem "$PSScriptRoot/*.ps1" |
    ? { $_.Name -notlike "*.Tests.*" } |
    % { . $_.PSPath }

load 

Export-ModuleMember `
    -Function @(
        'Get-CdBookmark'
        'Set-CdBookmark'
        'Add-CdBookmark'
        'Remove-CdBookmark'
    )

Set-Alias cdb Set-CdBookmark
Export-ModuleMember -Alias cdb

