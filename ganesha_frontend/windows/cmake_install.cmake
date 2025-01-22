# Install script for directory: C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "$<TARGET_FILE_DIR:ganesha_frontend>")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/MinGW/bin/objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/flutter/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/plugins/app_links/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/plugins/url_launcher_windows/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/ganesha_frontend.exe")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner" TYPE EXECUTABLE FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/ganesha_frontend.exe")
  if(EXISTS "$ENV{DESTDIR}/C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/ganesha_frontend.exe" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/ganesha_frontend.exe")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "C:/MinGW/bin/strip.exe" "$ENV{DESTDIR}/C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/ganesha_frontend.exe")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data" TYPE FILE FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/flutter/ephemeral/icudtl.dat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/flutter_windows.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner" TYPE FILE FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/flutter/ephemeral/flutter_windows.dll")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/libapp_links_plugin.dll;C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/liburl_launcher_windows_plugin.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner" TYPE FILE FILES
    "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/plugins/app_links/libapp_links_plugin.dll"
    "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/plugins/url_launcher_windows/liburl_launcher_windows_plugin.dll"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner" TYPE DIRECTORY FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/build/native_assets/windows/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data/flutter_assets")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data" TYPE DIRECTORY FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/build//flutter_assets")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee]|[Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data/app.so")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/runner/data" TYPE FILE FILES "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/build/windows/app.so")
  endif()
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/Users/Latitude 5580/Desktop/Programs/Proyectos/ganesha/Ganesha_front/ganesha_frontend/windows/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
