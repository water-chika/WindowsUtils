param(
    $File,
    $Host
)
MakeCert -r -pe -ss PrivateCertStore -n "CN=test.com(Test)" testcert.cer
Signtool sign /v /fd sha256 /s PrivateCertStore /n 'Test.com(Test)' /t http://timestamp.digicert.com $File

Get-Command certmgr.exe | Copy-Item
ssh $Host "mkdir C:/Debug"
scp certmgr.exe $Host:C:/Debug
ssh $Host "C:/Debug/certmgr.exe /add C:/Debug/testcert.cer /s /r localMachine root"
ssh $Host "certutil.exe -store root"

