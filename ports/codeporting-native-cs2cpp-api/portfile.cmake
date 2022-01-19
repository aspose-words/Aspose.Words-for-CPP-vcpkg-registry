set(CODEPORTING_VERSION 22.1)
set(CODEPORTING_SHA512 "a50f75518a462c867bca0c1879cf4bb5093f3f9e5a0057230febbc4d5bd50532ced3d69c21cd5e80344479e9380873adf8fb7e209d16a23c959d591190e77b24")
set(CODEPORTING_DOWNLOAD_URL "https://downloads.codeporting.com/native/cs2cpp/new-releases/codeporting.native-cs2cpp-22.1-api/7fc9a5f85c4342e69653d1f1233c3d63")

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