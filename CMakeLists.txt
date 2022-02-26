cmake_minimum_required(VERSION 3.5)
project(watchfish VERSION 1.0.0 LANGUAGES CXX)

# options off-by-default that you can enable
option(NOTIFICATION_MONITOR "" OFF)
option(WALL_TIME "" OFF)

if(NOTIFICATION_MONITOR)
     list(APPEND SOURCES notificationmonitor.cpp notification.cpp)
     list(APPEND HEARERS notificationmonitor.h notificationmonitor_p.h notification.h)
endif()

if(WALL_TIME)
     list(APPEND SOURCES walltimemonitor.cpp)
     list(APPEND HEARERS walltimemonitor.h walltimemonitor_p.h)
endif()

configure_file(
    "watchfish_config.h.in"
    "watchfish_config.h"
)
