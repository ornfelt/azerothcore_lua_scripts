# mod-nbem-scan
# Compatibility file for AzerothCore module layouts that still expect a module-local CMakeLists.txt.
# This checkout's top-level modules/CMakeLists.txt auto-collects sources from module folders.

AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/mod_nbem_scan.cpp")
