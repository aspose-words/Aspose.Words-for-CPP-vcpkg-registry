set(CODEPORTING_VERSION 22.3)
set(CODEPORTING_SHA512 "d0295664e295ac7f9c73553be15443eedf1baf032d0c4ad74db6e8332578c4f0296cb9698d9fdc55bec60898af0c3cd7f1bcbe22ebbddc7839774498f00322d0")
set(CODEPORTING_DOWNLOAD_URL "https://downloads.codeporting.com/native/cs2cpp/new-releases/codeporting.native-cs2cpp-22.3-api/9470997e33204c9a88e81180215a1f8a")

vcpkg_download_distfile(ARCHIVE 
  URLS "${CODEPORTING_DOWNLOAD_URL}"
  FILENAME "codePorting.Native.Cs2Cpp_api_${CODEPORTING_VERSION}.zip"
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

file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}aspose_cpp${SUFFIX}${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}aspose_cpp${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}aspose_cpp${SUFFIX}d${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}aspose_cpp${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}aspose_cpp${SUFFIX}${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
endif()
if (EXISTS ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}aspose_cpp${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX})
  file(INSTALL ${SOURCE_PATH}/lib/${VCPKG_TARGET_IMPORT_LIBRARY_PREFIX}aspose_cpp${SUFFIX}d${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

file(INSTALL ${SOURCE_PATH}/codeporting.native.cs2cpp-config-version.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME codeporting-native-cs2cpp-api-config-version.cmake )
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/codeporting-native-cs2cpp-api-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

file(INSTALL ${SOURCE_PATH}/licenses DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/misc DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/pch DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

file(INSTALL ${SOURCE_PATH}/licenses/Aspose_End-User-License-Agreement.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)