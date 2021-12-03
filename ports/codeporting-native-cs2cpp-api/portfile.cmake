set(CODEPORTING_VERSION 21.12)
set(CODEPORTING_SHA512 "2d97d28641744cdcf672d2bf3f30bca734c5df278064a1df6b84ab4d199786306a539ad91392d003fbc8bbe349fc0370c83ea30d92401e39652d7a87ccbf8203")
set(CODEPORTING_DOWNLOAD_URL "https://downloads.codeporting.com/native/cs2cpp/new-releases/codeporting.native-cs2cpp-21.12-api/44f3a8989bbe4de6b6fb5e88a54c2433")

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