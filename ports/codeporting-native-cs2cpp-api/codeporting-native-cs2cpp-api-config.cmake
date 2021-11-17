if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6...3.17)

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget CodePorting.Native.Cs2Cpp Aspose::CodePorting.Native.Cs2Cpp Aspose::BuildSettings)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)

# Compute the installation prefix relative to this file.
set(_IMPORT_PREFIX "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")

if (VCPKG_TARGET_TRIPLET STREQUAL "x64-windows")
  set(_SUFFIX "vc14x64")
elseif (VCPKG_TARGET_TRIPLET STREQUAL "x86-windows")
  set(_SUFFIX "vc14x86")
elseif (VCPKG_TARGET_TRIPLET STREQUAL "x64-osx")
  set(_SUFFIX "appleclang13")
elseif (VCPKG_TARGET_TRIPLET STREQUAL "x64-linux")
  set(_SUFFIX "clang3_libstdcpp")
endif()

set(_IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/${CMAKE_IMPORT_LIBRARY_PREFIX}aspose_cpp_${_SUFFIX}${CMAKE_IMPORT_LIBRARY_SUFFIX}")
set(_IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/${CMAKE_SHARED_LIBRARY_PREFIX}aspose_cpp_${_SUFFIX}${CMAKE_SHARED_LIBRARY_SUFFIX}")
set(_IMPORTED_SONAME "${CMAKE_SHARED_LIBRARY_PREFIX}aspose_cpp_${_SUFFIX}${CMAKE_SHARED_LIBRARY_SUFFIX}") 
set(_IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/debug/lib/${CMAKE_IMPORT_LIBRARY_PREFIX}aspose_cpp_${_SUFFIX}d${CMAKE_IMPORT_LIBRARY_SUFFIX}")
set(_IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/bin/${CMAKE_SHARED_LIBRARY_PREFIX}aspose_cpp_${_SUFFIX}d${CMAKE_SHARED_LIBRARY_SUFFIX}")

add_library(CodePorting.Native.Cs2Cpp INTERFACE IMPORTED)
set_target_properties(CodePorting.Native.Cs2Cpp PROPERTIES INTERFACE_LINK_LIBRARIES "Aspose::CodePorting.Native.Cs2Cpp")

# Create imported target Aspose::CodePorting.Native.Cs2Cpp
add_library(Aspose::CodePorting.Native.Cs2Cpp SHARED IMPORTED)

set_target_properties(Aspose::CodePorting.Native.Cs2Cpp PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
  INTERFACE_LINK_LIBRARIES "Aspose::BuildSettings"
)

# Create imported target Aspose::BuildSettings
add_library(Aspose::BuildSettings INTERFACE IMPORTED)

if (VCPKG_TARGET_TRIPLET STREQUAL "x64-windows" OR VCPKG_TARGET_TRIPLET STREQUAL "x86-windows")
  set_target_properties(Aspose::BuildSettings PROPERTIES INTERFACE_COMPILE_DEFINITIONS "_CRT_SECURE_NO_WARNINGS;_SCL_SECURE_NO_WARNINGS")
endif()

set_target_properties(Aspose::BuildSettings PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

if(CMAKE_VERSION VERSION_LESS 3.0.0)
  message(FATAL_ERROR "This file relies on consumers using CMake 3.0.0 or greater.")
endif()

if (VCPKG_TARGET_TRIPLET STREQUAL "x64-windows" OR VCPKG_TARGET_TRIPLET STREQUAL "x86-windows")
  set_target_properties(Aspose::CodePorting.Native.Cs2Cpp PROPERTIES
    IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
    IMPORTED_IMPLIB_RELEASE "${_IMPORTED_IMPLIB_RELEASE}"
    IMPORTED_LOCATION_RELEASE "${_IMPORTED_LOCATION_RELEASE}"
    IMPORTED_IMPLIB_DEBUG "${_IMPORTED_IMPLIB_DEBUG}"
    IMPORTED_LOCATION_DEBUG "${_IMPORTED_LOCATION_DEBUG}"
  )

  list(APPEND _IMPORT_CHECK_TARGETS Aspose::CodePorting.Native.Cs2Cpp )
  list(APPEND _IMPORT_CHECK_FILES_FOR_Aspose::CodePorting.Native.Cs2Cpp "${_IMPORTED_IMPLIB_RELEASE}" "${_IMPORTED_LOCATION_RELEASE}" "${_IMPORTED_IMPLIB_DEBUG}" "${_IMPORTED_LOCATION_DEBUG}")
elseif(VCPKG_TARGET_TRIPLET STREQUAL "x64-osx")
  set_target_properties(Aspose::CodePorting.Native.Cs2Cpp PROPERTIES
    IMPORTED_LOCATION "${_IMPORTED_LOCATION_RELEASE}"
    IMPORTED_SONAME "@rpath/${_IMPORTED_SONAME}"
  )

  list(APPEND _IMPORT_CHECK_TARGETS Aspose::CodePorting.Native.Cs2Cpp )
  list(APPEND _IMPORT_CHECK_FILES_FOR_Aspose::CodePorting.Native.Cs2Cpp "${${_IMPORTED_LOCATION_RELEASE}}")
else()
  set_target_properties(Aspose::CodePorting.Native.Cs2Cpp PROPERTIES
    IMPORTED_LOCATION "${_IMPORTED_LOCATION_RELEASE}"
    IMPORTED_SONAME "${_IMPORTED_SONAME}"
  )

  list(APPEND _IMPORT_CHECK_TARGETS Aspose::CodePorting.Native.Cs2Cpp )
  list(APPEND _IMPORT_CHECK_FILES_FOR_Aspose::CodePorting.Native.Cs2Cpp "${${_IMPORTED_LOCATION_RELEASE}}")
endif()

# Cleanup temporary variables.
set(_IMPORT_PREFIX)
unset(_SUFFIX)
unset(_IMPORTED_IMPLIB_RELEASE)
unset(_IMPORTED_LOCATION_RELEASE)
unset(_IMPORTED_SONAME) 
unset(_IMPORTED_IMPLIB_DEBUG)
unset(_IMPORTED_LOCATION_DEBUG)

# Loop over all imported files and verify that they actually exist
foreach(target ${_IMPORT_CHECK_TARGETS} )
  foreach(file ${_IMPORT_CHECK_FILES_FOR_${target}} )
    if(NOT EXISTS "${file}" )
      message(FATAL_ERROR "The imported target \"${target}\" references the file
   \"${file}\"
but this file does not exist.  Possible reasons include:
* The file was deleted, renamed, or moved to another location.
* An install or uninstall procedure did not complete successfully.
* The installation package was faulty and contained
   \"${CMAKE_CURRENT_LIST_FILE}\"
but not all the files it references.
")
    endif()
  endforeach()
  unset(_IMPORT_CHECK_FILES_FOR_${target})
endforeach()
unset(_IMPORT_CHECK_TARGETS)

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)