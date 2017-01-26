setx /m PathSystem32 %SystemRoot%\system32
setx /m PathPowerShell %PathSystem32%\WindowsPowerShell\v1.0
setx /m PSModulePath "%ProgramFiles%\WindowsPowerShell\Modules;%PathPowerShell%\Modules"
setx /m PathWget "C:\Program Files (x86)\GnuWin32\bin"
setx /m PathMySql D:\wamp\bin\mysql\mysql5.6.17\bin
setx /m PathPHP "D:\wamp\bin\php\php5.6.20"
setx /m PathComposerBin "C:\Users\Henry\AppData\Roaming\Composer\vendor\bin"
setx /m PathPhantomJS "D:\Aplicaciones\PhantomJS\bin"
setx /m PathPython "C:\Program Files\Python"
setx /m PathNode "D:\Aplicaciones\node"
setx /m AlogragPaths "%PathSystem32%;%PathPowerShell%;%PSModulePath%;%PathWget%;%PathMySql%;%PathPHP%;%PathComposerBin%;%PathPhantomJS%;%PathPython%;%PathNode%"
setx /m PATH "%PATH%;%AlogragPaths%"
