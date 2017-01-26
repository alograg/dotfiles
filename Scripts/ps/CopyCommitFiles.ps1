$app = New-Object -ComObject Shell.Application
$sourceFolder = $app.BrowseForFolder(0, 'Referencia', 0)
if($sourceFolder){
    $fles = @()
    $sourcePath = $sourceFolder.Self.Path
    Set-Location $sourcePath
    $commitString = Read-Host -Prompt 'Search:'
    if($commitString -ne ''){
        $hashes = git log --pretty="%H" --grep=$commitString
        if($hashes){
            [array]::Reverse($hashes)
        }
    }else{
        $hashPath = .\Storage\use.hash
        $hashes = Get-Content $hashPath 
    }
    Remove-Item .\storage\filesToMove -Recurse -Force
    $hashes | % { git diff-tree --no-commit-id --name-only -r $_ } |
        % { $_ -replace '\/',"\" } |
        % { 
            $source = '.\' + $_
            $destination = '.\storage\filesToMove\' + $_
            New-Item -ItemType File -Path $destination -Force
            Copy-Item $source $destination -Force
        }
    $hashes | % {  git log -n 1 --oneline $_ >>.\storage\filesToMove\commitMessage.txt }
    $currentBranch = git rev-parse --abbrev-ref HEAD
    $toBranchString = Read-Host -Prompt 'To branch:'
    $commitMessage = Get-Content .\storage\filesToMove\commitMessage.txt
    git checkout $toBranchString
    Copy-Item .\storage\filesToMove\* -Destination .\ -Force -Recurse
    git commit -m "$commitMessage"
}
