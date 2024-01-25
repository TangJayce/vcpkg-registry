﻿vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL D:/Projects/vcpkg-playground/example-remote/moza-module-b/.git
    REF 59affb821c040f2161bc131d613595b2dfa4399b
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
        ${FEATURE_OPTIONS}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} # 来自 custom-overlay-triplets 中 triple 定义的变量
        -DENABLE_DOCS=OFF
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
 
# Remove debug include
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)