cmake_minimum_required(VERSION 3.16)

project(MediaPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Sql)

qt_standard_project_setup()

qt_add_executable(appMediaPlayer
    source/main.cpp
)

file(GLOB header_files source/*.h)
file(GLOB source_files source/*.cpp)
file(GLOB ui_files ui/*.qml)

source_group("Header" FILES ${header_files})
source_group("Sources" FILES ${source_files})
source_group("Ui" FILES qrc.qrc)

qt_add_qml_module(appMediaPlayer
    URI MediaPlayer
    VERSION 1.0
    RESOURCES qrc.qrc
    SOURCES ${source_files} ${header_files}
)

set_target_properties(appMediaPlayer PROPERTIES

    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMediaPlayer
    PRIVATE Qt6::Quick
)

target_link_libraries(appMediaPlayer PRIVATE Qt6::Sql)

include(GNUInstallDirs)
install(TARGETS appMediaPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
