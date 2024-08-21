# This file controls User-level build steps. It should not be edited.
cmake_minimum_required(VERSION 3.14)

set(CONFIG_DIR "${CMAKE_CURRENT_SOURCE_DIR}/config")

# Configuration provided via flutter tool.
include(${CONFIG_DIR}/config.cmake)
