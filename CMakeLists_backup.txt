cmake_minimum_required(VERSION 3.5)

project(CombatDisplay LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(UCLIENT_PROFILE_UDP TRUE)
set(UCLIENT_PROFILE_TCP TRUE)
set(UCLIENT_PROFILE_SERIAL TRUE)

find_package(microcdr REQUIRED)
find_package(microxrcedds_client REQUIRED)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

link_directories(${CMAKE_SOURCE_DIR}/xmlParser)
include_directories(${CMAKE_SOURCE_DIR}/xmlParser)
include_directories(${CMAKE_SOURCE_DIR}/include)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

set(DDS_SRCS
    xmlParser/Tool.cpp
    src/subscriber.cpp
)

# Add headers
set(DDS_HEADERS
    xmlParser/Tool.h
    xmlParser/pugixml.hpp
    xmlParser/pugiconfig.hpp
    include/subscriber.h
    include/TopicDefinitions.h
)

if(ANDROID)
    add_library(CombatDisplay SHARED
       src/main.cpp
       qml/qml.qrc
       include/ownship.h
       src/ownship.cpp
       include/jthread.h
       src/jthread.cpp
       include/tracks.h
       src/tracks.cpp
       include/ssmtargetdata.h
       src/ssmtargetdata.cpp
       include/waypoints.h
       src/waypoints.cpp
       include/weapondangerzone.h
       src/weapondangerzone.cpp
       include/liquidationparameters.h
       src/liquidationparameters.cpp
       include/probabilityofkill.h
       src/probabilityofkill.cpp
       include/trajectorycomputation.h
       src/trajectorycomputation.cpp
       include/combat.h
       src/combat.cpp
    )
else()
    add_executable(CombatDisplay ${DDS_SRCS} ${DDS_HEADERS}
      src/main.cpp
      qml/qml.qrc
      include/ownship.h
      src/ownship.cpp
      include/jthread.h
      src/jthread.cpp
      include/tracks.h
      src/tracks.cpp
      include/ssmtargetdata.h
      src/ssmtargetdata.cpp
      include/waypoints.h
      src/waypoints.cpp
      include/weapondangerzone.h
      src/weapondangerzone.cpp
      include/liquidationparameters.h
      src/liquidationparameters.cpp
      include/probabilityofkill.h
      src/probabilityofkill.cpp
      include/trajectorycomputation.h
      src/trajectorycomputation.cpp
      include/combat.h
      src/combat.cpp
    )
endif()

target_compile_definitions(CombatDisplay
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(CombatDisplay
  PRIVATE Qt5::Core Qt5::Quick )

target_link_libraries(CombatDisplay
  PRIVATE microxrcedds_client ${CMAKE_SOURCE_DIR}/xmlParser/libs/libpugixml.a)

file(COPY ${CMAKE_SOURCE_DIR}/xmlParser/FastDDSManifest.xml DESTINATION ${CMAKE_BINARY_DIR})

