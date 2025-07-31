cmake_minimum_required(VERSION 3.16)
project(BoostSSLChatServer LANGUAGES CXX)

if(POLICY CMP0167)
  cmake_policy(SET CMP0167 NEW)
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SOURCES
    ServerApplication/ServerApplication.cpp
    ServerApplication/DataHandler.cpp
    ServerApplication/Session.cpp
    ServerApplication/SessionPool.cpp
    ServerApplication/SessionManager.cpp
    ServerApplication/MessageDispatcher.cpp
    ServerApplication/UDPManager.cpp
    ServerApplication/Logger.cpp
    ServerApplication/Utility.cpp
    ServerApplication/Zone.cpp
    ServerApplication/ZoneManager.cpp
    ServerApplication/Server.cpp
    ServerApplication/MessageBufferManager.cpp
    ServerApplication/MessageHandlers/ChatHandler.cpp
    ServerApplication/MessageHandlers/CertifyHandler.cpp
    ServerApplication/MessageHandlers/KeepaliveHandler.cpp
    ServerApplication/UDPMessageHandlers/UdpBroadcastHandler.cpp
    ServerApplication/UDPMessageHandlers/UdpBroadcastZoneHandler.cpp
    ServerApplication/UDPMessageHandlers/UdpHandler.cpp
    ServerApplication/UDPMessageHandlers/UdpRegisterHandler.cpp
    ServerApplication/MemoryTracker.cpp
)

add_executable(server ${SOURCES})

find_package(Boost REQUIRED COMPONENTS system thread)
target_link_libraries(server PRIVATE Boost::system Boost::thread)

find_package(OpenSSL REQUIRED)
target_link_libraries(server PRIVATE OpenSSL::SSL OpenSSL::Crypto)

find_package(nlohmann_json 3.2.0 REQUIRED)
target_link_libraries(server PRIVATE nlohmann_json::nlohmann_json)

find_package(spdlog REQUIRED)
target_link_libraries(server PRIVATE spdlog::spdlog)

find_package(CURL REQUIRED)
target_link_libraries(server PRIVATE CURL::libcurl)

find_package(Threads REQUIRED)
target_link_libraries(server PRIVATE Threads::Threads)

add_definitions(-D_WIN32_WINNT=0x0A00)  # Windows 10
