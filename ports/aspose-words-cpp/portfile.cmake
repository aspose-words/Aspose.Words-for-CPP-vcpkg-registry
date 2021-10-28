set(ASPOSE_WORDS_VERSION 21.10)
#set(ASPOSE_WORDS_DOWNLOAD_URL "https://www.nuget.org/api/v2/package/Aspose.Words.Cpp/${ASPOSE_WORDS_VERSION}.0")
set(ASPOSE_WORDS_DOWNLOAD_URL "https://auckland.dynabic.com/nugetserver/nuget/Packages(Id='Aspose.Words.Cpp',Version='${ASPOSE_WORDS_VERSION}.1')/Download")
vcpkg_download_distfile(ARCHIVE 
  URLS "${ASPOSE_WORDS_DOWNLOAD_URL}"
  FILENAME "Aspose.Words.Cpp_${ASPOSE_WORDS_VERSION}.0.zip"
  SHA512 6f23b44e288ce42ba84ebfa6e94d7ab9d378f1a775e92677b0936487451668bdd2a900654204ae3c77234bad96c5533f14c469cd8fc6922f37c989d6baec3cca)

vcpkg_extract_source_archive(SOURCE_PATH ARCHIVE "${ARCHIVE}" NO_REMOVE_ONE_LEVEL)

if (TARGET_TRIPLET STREQUAL "x64-windows")
  set(SUFFIX "vc14x64")
  set(PREFIX "x64")
elseif (TARGET_TRIPLET STREQUAL "x86-windows")
  set(SUFFIX "vc14x86")
  set(PREFIX "Win32")
elseif (TARGET_TRIPLET STREQUAL "x64-osx")
  set(SUFFIX "appleclang13")
elseif (TARGET_TRIPLET STREQUAL "x64-linux")
  set(SUFFIX "clang")
endif()

file(INSTALL ${SOURCE_PATH}/build/native/include/Aspose.Words.Cpp DESTINATION ${CURRENT_PACKAGES_DIR}/include)

if (VCPKG_TARGET_IS_WINDOWS)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Release/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Cpp_${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Debug/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Cpp_${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Release/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}Aspose.Words.Cpp_${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Debug/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}Aspose.Words.Cpp_${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

if (VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_OSX)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Cpp_${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
endif()

configure_file(${CMAKE_CURRENT_LIST_DIR}/aspose-words-cpp-config-version.cmake.in ${CURRENT_PACKAGES_DIR}/share/${PORT}/aspose-words-cpp-config-version.cmake @ONLY)
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/aspose-words-cpp-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/build/native/license/End-User-License-Agreement.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)