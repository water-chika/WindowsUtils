#include <vector>
#include <functional>
#include <algorithm>
#include <stdexcept>
#include <iostream>
#include <objbase.h>
#include <ShlObj.h>
#include <stdio.h>

namespace co {
    HRESULT initialize(void* reserved) {
        return CoInitialize(reserved);
    }
    void uninitialize() {
        CoUninitialize();
    }
}

class set_wallpaper_to_white {
public:
    set_wallpaper_to_white(std::wstring wallpaper_path) {
        HRESULT hr;
        initialize();
        create_desktop_wallpaper();
        if (0) {
            hr = m_desktop_wallpaper->SetBackgroundColor(RGB(255, 255, 255));
            if (hr != S_OK)
            {
                throw std::runtime_error{ "set background color fail" };
            }
            hr = m_desktop_wallpaper->Enable(FALSE);
        }
        else {
            hr = m_desktop_wallpaper->SetWallpaper(NULL, wallpaper_path.c_str());
            if (hr != S_OK)
            {
                throw std::runtime_error{ "set background fail" };
            }
            hr = m_desktop_wallpaper->Enable(TRUE);
        }

        if (hr != S_OK && hr != S_FALSE)
        {
            throw std::runtime_error{ "set background to color fail" };
        }
        else
        {
            std::cout << "Set wallpaper to solid color successfully!" << std::endl;
        }

    }
    ~set_wallpaper_to_white() {
        while (!m_destroy_calls.empty()) {
            auto& destroy_call = m_destroy_calls.back();
            destroy_call();
            m_destroy_calls.pop_back();
        }
    }
private:
    void initialize() {
        if (S_OK == co::initialize(NULL)) {
            m_destroy_calls.push_back([this]() {this->uninitialize(); });
        }
        else {
            throw std::runtime_error{ "failed to initialize COM library" };
        }
    }
    void uninitialize() {
        co::uninitialize();
    }

    void create_desktop_wallpaper() {
        CLSID clsid = CLSID_DesktopWallpaper;
        IID iid = IID_IDesktopWallpaper;
        HRESULT hr = CoCreateInstance(clsid, NULL, CLSCTX_LOCAL_SERVER, iid, (void**)&m_desktop_wallpaper);
        if (hr == S_OK) {
            m_destroy_calls.push_back([this]() {this->destroy_desktop_wallpaper(); });
        }
        else {
            throw std::runtime_error{ "failed to create object desktop wallpaper" };
        }
    }
    void destroy_desktop_wallpaper() {
        m_desktop_wallpaper->Release();
    }


    std::vector<std::function<void()>> m_destroy_calls;

    IDesktopWallpaper* m_desktop_wallpaper;
};

int main(int argc, const char** argv)
{
    std::setlocale(LC_ALL, "en_US.utf8");
    std::wstring wallpaper_path;
    if (argc == 1) {

    }
    else if (argc == 2) {
        std::mbstate_t mbstate{};
        std::vector<wchar_t> buf(strlen(argv[1]) + 1);
        mbsrtowcs(buf.data(), argv + 1, buf.size(), &mbstate);
        wallpaper_path = buf.data();
    }
    try {
        set_wallpaper_to_white{wallpaper_path};
    }
    catch (std::exception& e) {
        std::cerr << e.what() << std::endl;
    }
}