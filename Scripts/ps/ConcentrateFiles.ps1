$app = New-Object -ComObject Shell.Application
$sourceFolder = $app.BrowseForFolder(0, 'Origen', 0)
if($sourceFolder){
    $sourcePath = $sourceFolder.Self.Path
    $targetFolder = $app.BrowseForFolder(0, 'Destino', 0)
    $targetPath = $targetFolder.Self.Path
    Get-ChildItem -Path $sourcePath -Recurse |
        where { $_.Directory.Name -Like 'migrations' -And $_.Name -Like '*_*'} |
        Copy-Item -Destination $targetPath
}
