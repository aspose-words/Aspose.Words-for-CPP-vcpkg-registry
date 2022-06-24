set(CODEPORTING_VERSION 22.6)
set(CODEPORTING_SHA512 "f1e9f736e10f3b881a9cd16e00e42f45226ae8aeb5fa54117e5699582049f95c464d1fb0bbdbe3d5a7d7dc5f4e20dc088dfe49d23f542757bc1c63cb4a29234f")
set(CODEPORTING_URL_HASH "b7c19697112f4838af86933c5a4e35ff")

set(CODEPORTING_DOWNLOAD_URL "https://downloads.codeporting.com/native/cs2cpp/new-releases/codeporting.translator-cs2cpp-${CODEPORTING_VERSION}-framework/${CODEPORTING_URL_HASH}")

vcpkg_download_distfile(ARCHIVE 
  URLS "${CODEPORTING_DOWNLOAD_URL}"
  FILENAME "CodePorting.Translator.Cs2Cpp_framework_${CODEPORTING_VERSION}.zip"
  SHA512 "${CODEPORTING_SHA512}")

vcpkg_extract_source_archive(SOURCE_PATH ARCHIVE "${ARCHIVE}")

if (TARGET_TRIPLET STREQUAL "x64-windows")
  set(SUFFIX "_vc14x64")
elseif (TARGET_TRIPLET STREQUAL "x86-windows")
  set(SUFFIX "_vc14x86")
elseif (TARGET_TRIPLET STREQUAL "x64-osx")
  set(SUFFIX "_appleclang")
elseif (TARGET_TRIPLET STREQUAL "x64-linux")
  set(SUFFIX "_x86_64_libstdcpp_libc2.23")
endif()

file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
endif()
if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}codeporting.translator.cs2cpp.framework${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

file(INSTALL ${SOURCE_PATH}/codeporting.translator.cs2cpp.framework-config-version.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME codeporting-translator-cs2cpp-framework-config-version.cmake )
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/codeporting-translator-cs2cpp-framework-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

file(INSTALL ${SOURCE_PATH}/licenses DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/misc DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/pch DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

file(INSTALL ${SOURCE_PATH}/licenses/Aspose_End-User-License-Agreement.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)