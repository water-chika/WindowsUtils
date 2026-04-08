param(
    $DriverDir,
    $CatFile,
    $Host
)

Inf2Cat.exe /driver:$DriverDir /os:Vista_x64

MakeCert -r -pe -ss PrivateCertStore -n "CN=test.com(Test)" testcert.cer
Signtool sign /v /fd sha256 /s PrivateCertStore /n 'Test.com(Test)' /t http://timestamp.digicert.com $File

Get-Command certmgr.exe | Copy-Item
ssh $Host "mkdir C:/Debug"
scp certmgr.exe $Host:C:/Debug

$cert_store = "TrustedPublisher"
ssh $Host "C:/Debug/certmgr.exe /add C:/Debug/testcert.cer /s /r localMachine $cert_store"

ssh $Host "certutil.exe -store $cert_store"

