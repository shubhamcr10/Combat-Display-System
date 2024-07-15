# Combat Display System

The Combat Display System is a project designed as a clone of a navy-like display system. It provides a graphical interface for visualizing the movements of tracks captured by radar and sonar sensors, with data sent by simulators.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- CMake (version 3.10 or higher)
- GCC (or any other compatible C++ compiler)
- Micro XRCE-DDS

### Installing Micro XRCE-DDS Agent

To install Micro XRCE-DDS Agent, run the following commands:

```bash
git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd Micro-XRCE-DDS-Agent
mkdir build && cd build
cmake ..
make
sudo make install
```

### Installing Micro XRCE-DDS Client

To install Micro XRCE-DDS Client, run the following commands:

```bash
git clone https://github.com/eProsima/Micro-XRCE-DDS-Client.git
cd Micro-XRCE-DDS-Client
mkdir build && cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib/
```

## Directory Structure

The project has the following directory structure:
```
Combat_Display_System
├── CMakeLists.txt
├── build
├── include
├── qml
├── src
└── xmlParser
```

## Building the Project

Follow these steps to build the project:

1. **Clone the Repository**: If you haven't cloned the repository, do so with the following command:
    ```bash
    git clone <repository-url>
    cd Combat_Display_System
    ```

2. **Create and Navigate to the Build Directory**:
    ```bash
    mkdir build && cd build
    ```

3. **Run CMake**:
    ```bash
    cmake ..
    ```

4. **Compile the Project**:
    ```bash
    make
    ```

## Running the Application

Before running the application, ensure that the Micro XRCE-DDS Agent is running. You can start the agent with the following command (after building it):

```bash
./MicroXRCEAgent udp4 -p 8888
```

Once the agent is running, you can start the application with the following command:

```bash
./CombatDisplay localhost 8888 FastDDSManifest.xml
```

Command Arguments

- localhost: The hostname or IP address where the application will run.
- 8888: The port number to be used by the application.
- FastDDSManifest.xml: The configuration file required for Micro XRCE-DDS.

QML Files:
- The qml directory contains QML files which define the UI components of the application. Ensure that these files are not modified unintentionally as they are crucial for the proper functioning of the UI.

XML Parser:
- The xmlParser directory contains the necessary files for parsing XML data used by the application.

Simulators
For generating simulated data, you can use the following simulators:
- [Track Simulator](https://github.com/shubhamcr10/Track-Simulator)
- [Course Simulator](https://github.com/shubhamcr10/Course-Simulator)

Track Simulator
Course Simulator

## Cleaning Up
To clean up the build files, you can run the following command from the Combat_Display_System directory:
```bash
rm -rf build/*
```

## Demo
![Combat Display System Demo](https://gifyu.com/image/StC0k)

This GIF demonstrates the Combat Display System in action, visualizing tracks captured by radar and sonar sensors.

## Contributing
If you wish to contribute to this project, please follow these steps:

Fork the repository.
- Create a new branch (git checkout -b feature-branch).
- Commit your changes (git commit -am 'Add new feature').
- Push to the branch (git push origin feature-branch).
- Create a new Pull Request.

## Contact
For any questions or issues, please contact at shubhamcr10@gmail.com .
