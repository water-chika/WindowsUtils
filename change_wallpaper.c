#include <objbase.h>
#include <ShlObj.h>
#include <stdio.h>

int main()
{
    HRESULT hr;
    hr = CoInitialize(NULL);
    if (hr != S_OK)
    {
        printf("Error happend!\n");
    }
    else
    {
        CLSID clsid = CLSID_DesktopWallpaper;
        IID iid = IID_IDesktopWallpaper;
        IDesktopWallpaper *desktop_wallpaper;
        hr = CoCreateInstance(&clsid, NULL, CLSCTX_LOCAL_SERVER, &iid, (void **)&desktop_wallpaper);
        if (hr == S_OK)
        {
            hr = desktop_wallpaper->lpVtbl->SetBackgroundColor(desktop_wallpaper, RGB(255, 255, 255));
            if (hr != S_OK)
            {
                printf("set background color fail\n");
            }
            else
            {
                hr = desktop_wallpaper->lpVtbl->Enable(desktop_wallpaper, FALSE);
                if (hr != S_OK && hr != S_FALSE)
                {
                    printf("set background to color fail");
                }
                else
                {
                    printf("Set wallpaper to solid color successfully!\n");
                }
                desktop_wallpaper->lpVtbl->Release(desktop_wallpaper);
            }
        }
        CoUninitialize();
    }
}