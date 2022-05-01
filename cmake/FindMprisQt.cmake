include(FindPackageHandleStandardArgs)

find_library(MPRISQT_LIBRARY 
	NAMES mprisqt)

find_path(MPRISQT_INCLUDE_DIR 
	NAMES MprisQt/mprisqt.h)

find_package_handle_standard_args(MprisQt REQUIRED_VARS MPRISQT_LIBRARY MPRISQT_INCLUDE_DIR)

if (MPRISQT_FOUND)
	mark_as_advanced(MPRISQT_INCLUDE_DIR)
	mark_as_advanced(MPRISQT_LIBRARY)
endif()

if (MPRISQT_FOUND AND NOT TARGET MprisQt::MprisQt)
	add_library(MprisQt::MprisQt IMPORTED)
	set_property(TARGET MprisQt::MprisQt PROPERTY IMPORTED_LOCATION ${MPRISQT_LIBRARY})
	target_include_directories(MprisQt::MprisQt INTERFACE ${MPRISQT_INCLUDE_DIR})
endif()
