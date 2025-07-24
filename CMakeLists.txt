cmake_minimum_required(VERSION 3.16)
project(BoostSSLChatServer LANGUAGES CXX)

if(POLICY CMP0167)
  cmake_policy(SET CMP0167 NEW)
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SOURCES
    SSLServerApplication.cpp
    DataHandler.cpp
    SSLSession.cpp
    SessionPool.cpp
    SessionManager.cpp
    MessageDispatcher.cpp
    UDPManager.cpp
    Logger.cpp
    Utility.cpp
    Zone.cpp
    ZoneManager.cpp
    SSLServer.cpp
    MessageBufferManager.cpp
    MessageHandlers/ChatHandler.cpp
    MessageHandlers/CertifyHandler.cpp
    MessageHandlers/KeepaliveHandler.cpp
    UDPMessageHandlers/UdpBroadcastHandler.cpp
    UDPMessageHandlers/UdpBroadcastZoneHandler.cpp
    UDPMessageHandlers/UdpHandler.cpp
    UDPMessageHandlers/UdpRegisterHandler.cpp
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
