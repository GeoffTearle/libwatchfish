include(FindPackageHandleStandardArgs)

find_package(PkgConfig)
pkg_check_modules(MprisQt_PC QUIET mpris-qt5)

find_library(MprisQt_LIBRARY
        NAMES mpris-qt5
        HINTS ${MprisQt_PC_LIBDIR}
        ${MprisQt_PC_LIBRARY_DIRS}
)

get_filename_component(_MprisQt_LIBRARY_DIR ${MprisQt_LIBRARY} PATH)


find_path(MprisQt_INCLUDE_DIR
        NAMES MprisQt/mpris.h
        HINTS ${MprisQt_PC_INCLUDEDIR}
        ${MprisQt_PC_INCLUDE_DIRS}
        ${_MprisQt_LIBRARY_DIR}
        ${MprisQt_INCLUDE_DIR}
)

find_path(MprisQt_Mpris_INCLUDE_DIR
        NAMES MprisQt/mprisqt.h
        HINTS ${MprisQt_PC_INCLUDEDIR}
        ${MprisQt_PC_INCLUDE_DIRS}
        ${_MprisQt_LIBRARY_DIR}
        ${MprisQt_INCLUDE_DIR}
)

SET(MprisQt_INCLUDE_DIRS ${MprisQt_INCLUDE_DIR} ${MprisQt_Mpris_INCLUDE_DIR} ${MprisQt_PC_INCLUDEDIR})

find_package_handle_standard_args(MprisQt
    REQUIRED_VARS
    MprisQt_LIBRARY
    MprisQt_INCLUDE_DIRS
    HANDLE_COMPONENTS
)

if (MprisQt_FOUND)
        mark_as_advanced(MprisQt_INCLUDE_DIR)
        mark_as_advanced(MprisQt_INCLUDE_DIRS)
        mark_as_advanced(Mprisqt_LIBRARY)
endif()

if (MprisQt_FOUND AND NOT TARGET MprisQt::MprisQt)
        add_library(MprisQt::MprisQt SHARED IMPORTED)
        set_property(TARGET MprisQt::MprisQt PROPERTY IMPORTED_LOCATION ${MprisQt_LIBRARY})
        target_include_directories(MprisQt::MprisQt INTERFACE ${MprisQt_INCLUDE_DIRS})
endif()
