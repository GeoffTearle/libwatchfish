cmake_minimum_required(VERSION 3.5)
project(watchfish VERSION 1.0.0 LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core DBus REQUIRED)
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# options off-by-default that you can enable
option(NOTIFICATION_MONITOR "" OFF)
option(WALL_TIME "" OFF)
option(MUSIC "" OFF)
option(CALENDAR "" OFF)
option(VOICE_CALL "" OFF)
option(VOLUME "" OFF)

if(NOTIFICATION_MONITOR)
    find_package(DBus REQUIRED)
    list(APPEND SOURCES notificationmonitor.cpp notification.cpp)
    list(APPEND HEARERS notificationmonitor.h notificationmonitor_p.h notification.h)
endif()

if(WALL_TIME)
    find_package(TimedQt REQUIRED)
    list(APPEND SOURCES walltimemonitor.cpp)
    list(APPEND HEARERS walltimemonitor.h walltimemonitor_p.h)
endif()

if(MUSIC)
    find_package(MprisQt REQUIRED)
    list(APPEND SOURCES musiccontroller.cpp)
    list(APPEND HEARERS musiccontroller.h musiccontroller_p.h)
endif()

if(CALENDAR)
    # Not yet implemented
endif()

if(VOICE_CALL)
     list(APPEND SOURCES voicecallcontroller.cpp)
     list(APPEND HEARERS voicecallcontroller.h voicecallcontroller_p.h)
endif()

if(VOLUME)
     list(APPEND SOURCES volumecontroller.cpp)
     list(APPEND HEARERS volumecontroller.h volumecontroller_p.h)
endif()

configure_file(
    "watchfish_config.h.in"
    "watchfish_config.h"
)

add_library(watchfish SHARED
    ${SOURCES}
    )
set_target_properties(watchfish PROPERTIES AUTOMOC ON)
target_compile_options(watchfish PRIVATE -Wall -Wextra -pedantic -Werror)
target_compile_features(watchfish PUBLIC cxx_std_17)
target_include_directories(watchfish PRIVATE ${PROJECT_BINARY_DIR} ${HEADERS})
target_link_libraries(watchfish PRIVATE Qt5::Core Qt5::DBus)
if(DBUS_FOUND)
    target_include_directories(watchfish PRIVATE ${DBUS_INCLUDE_DIRS})
    target_link_libraries(watchfish PRIVATE ${DBUS_LIBRARIES})
endif()
if(MprisQt_FOUND)
    target_include_directories(watchfish PRIVATE ${MprisQt_INCLUDE_DIRS})
    target_link_libraries(watchfish PRIVATE ${MprisQt_LIBRARY})
    target_include_directories(watchfish PRIVATE MprisQt::MprisQt)
endif()
if(TimedQt_FOUND)
    target_include_directories(watchfish PRIVATE ${TimedQt_INCLUDE_DIRS})
    target_link_libraries(watchfish PRIVATE ${TimedQt_LIBRARY})
    target_include_directories(watchfish PRIVATE TimedQt::TimedQt)
endif()
install(TARGETS watchfish)
