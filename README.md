# Combat Display System

The Combat Display System is a project designed to provide a graphical interface for displaying combat-related information. This README provides a detailed guide on how to set up, build, and run the application.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- CMake (version 3.10 or higher)
- GCC (or any other compatible C++ compiler)
- Micro XRCE-DDS

## Directory Structure

The project has the following directory structure:

Combat_Display_System
├── CMakeLists.txt
├── build
├── include
├── qml
├── src
└── xmlParser


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

Once the project is built, you can run the application using the following command:

```bash
./CombatDisplay localhost 8888 FastDDSManifest.xml
```

Command Arguments

localhost: The hostname or IP address where the application will run.
8888: The port number to be used by the application.
FastDDSManifest.xml: The configuration file required for Micro XRCE-DDS.

QML Files
The qml directory contains QML files which define the UI components of the application. Ensure that these files are not modified unintentionally as they are crucial for the proper functioning of the UI.

XML Parser
The xmlParser directory contains the necessary files for parsing XML data used by the application.

Cleaning Up
To clean up the build files, you can run the following command from the Combat_Display_System directory:
```bash
rm -rf build/*
```

Contributing
If you wish to contribute to this project, please follow these steps:

Fork the repository.
- Create a new branch (git checkout -b feature-branch).
- Commit your changes (git commit -am 'Add new feature').
- Push to the branch (git push origin feature-branch).
- Create a new Pull Request.

Contact
For any questions or issues, please contact at shubhamcr10@gmail.com .
