cmake_minimum_required(VERSION 3.20)

project(windows_utils)

add_executable(change_wallpaper change_wallpaper.cpp)

set_target_properties(change_wallpaper PROPERTIES CXX_STANDARD 23)