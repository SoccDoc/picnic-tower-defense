cmake_minimum_required(VERSION 3.16)

project(picnic-tower-defense VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(apppicnic-tower-defense
    main.cpp
    images.qrc
)

qt_add_qml_module(apppicnic-tower-defense
    URI picnic-tower-defense
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES images.qrc
        QML_FILES
        SOURCES
        QML_FILES FrogTower.qml
        QML_FILES Ant.qml
        QML_FILES EnemySpawner.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apppicnic-tower-defense PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apppicnic-tower-defense
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apppicnic-tower-defense
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apppicnic-tower-defense
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
