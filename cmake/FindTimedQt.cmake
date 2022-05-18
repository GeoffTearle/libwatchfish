include(FindPackageHandleStandardArgs)

find_package(PkgConfig)
pkg_check_modules(TimedQt_PC QUIET timed-qt5)

find_library(TimedQt_LIBRARY
        NAMES timed-qt5
        HINTS ${TimedQt_PC_LIBDIR}
        ${TimedQt_PC_LIBRARY_DIRS}
)

find_path(TimedQt_Wallclock_INCLUDE_DIR
        NAMES timed-qt5/wallclock
        HINTS ${TimedQt_PC_INCLUDEDIR}
        ${TimedQt_PC_INCLUDE_DIRS}
        ${_TimedQt_LIBRARY_DIR}
        ${TimedQt_INCLUDE_DIR}
)

find_path(TimedQt_Interface_INCLUDE_DIR
        NAMES timed-qt5/interface
        HINTS ${TimedQt_PC_INCLUDEDIR}
        ${TimedQt_PC_INCLUDE_DIRS}
        ${_TimedQt_LIBRARY_DIR}
        ${TimedQt_INCLUDE_DIR}
)

SET(TimedQt_INCLUDE_DIRS ${TimedQt_Wallclock_INCLUDE_DIR} ${TimedQt_Interface_INCLUDE_DIR} ${TimedQt_PC_INCLUDEDIR})

find_package_handle_standard_args(TimedQt
    REQUIRED_VARS
    TimedQt_LIBRARY
    TimedQt_INCLUDE_DIRS
    HANDLE_COMPONENTS
)

if (TimedQt_FOUND)
        mark_as_advanced(TimedQt_INCLUDE_DIR)
        mark_as_advanced(TimedQt_INCLUDE_DIRS)
        mark_as_advanced(TimedQt_LIBRARY)
endif()

if (TimedQt_FOUND AND NOT TARGET TimedQt::TimedQt)
        add_library(TimedQt::TimedQt SHARED IMPORTED)
        set_property(TARGET TimedQt::TimedQt PROPERTY IMPORTED_LOCATION ${TimedQt_LIBRARY})
        target_include_directories(TimedQt::TimedQt INTERFACE ${TimedQt_INCLUDE_DIRS})
endif()
