vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL http://git.gudsen-rd.com/rs21/rs21-pc/moza/module-c.git
    REF d4844aa94b8740b992d8c8786d93a5bfbf2895dd
)

# 需要在 triple 中定义 ${CMAKE_PREFIX_PATH} 变量
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
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