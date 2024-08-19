cmake_minimum_required(VERSION 3.5)

project(CombatDisplay LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(UCLIENT_PROFILE_UDP TRUE)
set(UCLIENT_PROFILE_TCP TRUE)
set(UCLIENT_PROFILE_SERIAL TRUE)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Update paths based on where dependencies are installed
set(MICRO_XRCE_DDS_AGENT_DIR "/usr/local/bin/MicroXRCEAgent")
set(MICRO_XRCE_DDS_CLIENT_DIR "/usr/local/lib")
set(MICRO_CDR_DIR "/usr/local/lib/cmake/microcdr")
set(MICRO_XRCE_DDS_CLIENT_DIR "/usr/local/lib/cmake/microxrcedds_client")

set(CMAKE_PREFIX_PATH "/usr/local" ${CMAKE_PREFIX_PATH})

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/xmlParser)
include_directories(${CMAKE_SOURCE_DIR}/include)
include_directories(/usr/local/include)  # Include the directory where microcdr and microxrcedds_client headers are located

# Find required packages
find_package(microcdr REQUIRED PATHS ${MICRO_CDR_DIR})
find_package(microxrcedds_client REQUIRED PATHS ${MICRO_XRCE_DDS_CLIENT_DIR})
find_package(Qt5 COMPONENTS Core Quick REQUIRED)

# Source and header files
set(DDS_SRCS
    xmlParser/Tool.cpp
    src/subscriber.cpp
)

set(DDS_HEADERS
    xmlParser/Tool.h
    xmlParser/pugixml.hpp
    xmlParser/pugiconfig.hpp
    include/subscriber.h
    include/TopicDefinitions.h
)

# Add executable or library
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

# Link libraries
target_link_libraries(CombatDisplay
  PRIVATE Qt5::Core Qt5::Quick
  microxrcedds_client
  microcdr
  ${CMAKE_SOURCE_DIR}/xmlParser/libs/libpugixml.a
)

# Set compile definitions
target_compile_definitions(CombatDisplay
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

# Copy manifest file
file(COPY ${CMAKE_SOURCE_DIR}/xmlParser/FastDDSManifest.xml DESTINATION ${CMAKE_BINARY_DIR})

# Configure Micro XRCE-DDS dependencies
include_directories(${MICRO_XRCE_DDS_CLIENT_DIR}/uxr/client)
link_directories(${MICRO_XRCE_DDS_CLIENT_DIR})

# Add target for Micro XRCE-DDS Agent
add_custom_target(MicroXRCEAgent
    COMMAND ${CMAKE_COMMAND} -E echo "Micro XRCE-DDS Agent installed at ${MICRO_XRCE_DDS_AGENT_DIR}"
    DEPENDS ${MICRO_XRCE_DDS_AGENT_DIR}
)

# Add target for Micro XRCE-DDS Client
add_custom_target(MicroXRCEClient
    COMMAND ${CMAKE_COMMAND} -E echo "Micro XRCE-DDS Client installed at ${MICRO_XRCE_DDS_CLIENT_DIR}"
    DEPENDS ${MICRO_XRCE_DDS_CLIENT_DIR}
)
