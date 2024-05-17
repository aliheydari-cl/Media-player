cmake_minimum_required(VERSION 3.16)

project(MediaPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Sql)

qt_standard_project_setup()

qt_add_executable(appMediaPlayer
    main.cpp
)

qt_add_qml_module(appMediaPlayer
    URI MediaPlayer
    VERSION 1.0
    QML_FILES
        Main.qml

        RESOURCES icon/back.png icon/Hsound.png icon/Lsound.png icon/next.png icon/pause.png icon/play.png icon/delete.png
        RESOURCES icon/crop.png icon/fit.png icon/addFile.png icon/forward.png icon/replay.png icon/menu.png icon/list.png

        QML_FILES MediaControls.qml
        QML_FILES SoundControls.qml
        QML_FILES TimeSlider.qml
        QML_FILES ScreenSetting.qml
        QML_FILES Playlist.qml
        QML_FILES Setting.qml

        SOURCES database.h database.cpp
        RESOURCES icon/setting.png
        RESOURCES icon/time.png icon/dark-mode.png
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
