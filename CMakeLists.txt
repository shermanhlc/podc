cmake_minimum_required(VERSION 3.31)

set(PROJECT_NAME rddc_x)

set(CMAKE_C_COMPILER "/bin/gcc")
set(CMAKE_CXX_COMPILER "/bin/g++")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED true)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

project(${PROJECT_NAME} VERSION 0.1.0)

find_package(Qt6 REQUIRED COMPONENTS Core)

add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME}
  PRIVATE
  Qt6::Core
)

