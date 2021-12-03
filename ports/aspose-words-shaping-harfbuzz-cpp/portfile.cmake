set(ASPOSE_WORDS_SHAPING_HARFBUZZ_VERSION 21.12)
set(ASPOSE_WORDS_SHAPING_HARFBUZZ_SHA512 "ea7537254f7f3085bda83f0fc00ff6b74f6bb31b45e5565908bce0598feb3e546cad41148d77f7c662e05d6e383c884068aa8947beb24f1a81db9ab0615e3d1e")
set(ASPOSE_WORDS_SHAPING_HARFBUZZ_DOWNLOAD_URL "https://www.nuget.org/api/v2/package/Aspose.Words.Shaping.Harfbuzz.Cpp/${ASPOSE_WORDS_SHAPING_HARFBUZZ_VERSION}.0")

vcpkg_download_distfile(ARCHIVE 
  URLS "${ASPOSE_WORDS_SHAPING_HARFBUZZ_DOWNLOAD_URL}"
  FILENAME "Aspose.Words.Shaping.Harfbuzz.Cpp_${ASPOSE_WORDS_SHAPING_HARFBUZZ_VERSION}.0.zip"
  SHA512 "${ASPOSE_WORDS_SHAPING_HARFBUZZ_SHA512}")

vcpkg_extract_source_archive(SOURCE_PATH ARCHIVE "${ARCHIVE}" NO_REMOVE_ONE_LEVEL)

if (TARGET_TRIPLET STREQUAL "x64-windows")
  set(SUFFIX "_vc14x64")
  set(PREFIX "x64")
elseif (TARGET_TRIPLET STREQUAL "x86-windows")
  set(SUFFIX "_vc14x86")
  set(PREFIX "Win32")
elseif (TARGET_TRIPLET STREQUAL "x64-osx")
  set(SUFFIX "")
elseif (TARGET_TRIPLET STREQUAL "x64-linux")
  set(SUFFIX "")
endif()

file(INSTALL ${SOURCE_PATH}/build/native/include/Aspose.Words.Cpp DESTINATION ${CURRENT_PACKAGES_DIR}/include)

if (VCPKG_TARGET_IS_WINDOWS)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Release/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Shaping.HarfBuzz.Cpp${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Debug/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Shaping.HarfBuzz.Cpp${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Release/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}Aspose.Words.Shaping.HarfBuzz.Cpp${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${PREFIX}/Debug/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}Aspose.Words.Shaping.HarfBuzz.Cpp${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

if (VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_OSX)
  file(INSTALL ${SOURCE_PATH}/build/native/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}Aspose.Words.Shaping.HarfBuzz.Cpp${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
endif()

configure_file(${CMAKE_CURRENT_LIST_DIR}/aspose-words-shaping-harfbuzz-cpp-config-version.cmake.in ${CURRENT_PACKAGES_DIR}/share/${PORT}/aspose-words-shaping-harfbuzz-cpp-config-version.cmake @ONLY)
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/aspose-words-shaping-harfbuzz-cpp-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/build/native/license/End-User-License-Agreement.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)