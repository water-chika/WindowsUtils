$app_model_unlock = "HKLM:/Software/Mircosoft/Windows/CurrentVersion/AppModelUnlock"
New-ItemProperty -Path $app_model_unlock -Name 'AllowAllTrustedApp' -PropertyType DWord -Value 1
New-ItemProperty -Path $app_model_unlock -Name 'AllowDevelopmentWithoutDevLicense' -PropertyType DWord -Value 1

