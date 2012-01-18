FIND_PROGRAM(MONO_EXECUTABLE mono)
FIND_PROGRAM(MONO_GMCS_EXECUTABLE gmcs)
FIND_PROGRAM(MONO_GACUTIL_EXECUTABLE gacutil)

IF(WIN32)
	FIND_PATH(MONO_INCLUDE_DIR mono/jit/jit.h)
	SET(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
	SET(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" "")
	FIND_LIBRARY(MONO_LIBRARY NAMES mono-2.0 DOC "The Mono Library")
	FIND_PATH(MONO_LIBRARY_DIR mono-2.0.lib)
ELSEIF(UNIX)
	FIND_PACKAGE(PkgConfig REQUIRED)
	PKG_SEARCH_MODULE(MONO mono-2 REQUIRED QUIET)
	FIND_PATH(MONO_INCLUDE_DIR mono/jit/jit.h HINTS ${MONO_INCLUDE_DIR} ${MONO_INCLUDE_DIRS})
	FIND_LIBRARY(MONO_LIBRARY NAMES mono-2.0 HINTS ${MONO_LIBRARY_DIRS})
ENDIF()

SET(MONO_INCLUDE_DIRS ${MONO_INCLUDE_DIR})
SET(MONO_LIBRARIES ${MONO_LIBRARY})
SET(MONO_LIBRARY_DIRS ${MONO_LIBRARY_DIR})

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MONO DEFAULT_MSG
		MONO_EXECUTABLE MONO_GMCS_EXECUTABLE MONO_GACUTIL_EXECUTABLE MONO_INCLUDE_DIR MONO_LIBRARY MONO_LIBRARY_DIR)

MARK_AS_ADVANCED(MONO_EXECUTABLE MONO_GMCS_EXECUTABLE MONO_GACUTIL_EXECUTABLE MONO_INCLUDE_DIR MONO_LIBRARY MONO_LIBRARY_DIR)