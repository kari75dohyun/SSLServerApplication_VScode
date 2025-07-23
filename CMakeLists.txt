cmake_minimum_required(VERSION 3.16)
project(BoostSSLChatServer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 소스 파일 나열 (프로젝트에 있는 .cpp 파일 모두!)
set(SOURCES
    main.cpp
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
    MessageHandlers/ChatHandler.cpp
    # 필요하다면 여기에 추가
)

add_executable(server ${SOURCES})

# Boost 라이브러리 찾기
find_package(Boost REQUIRED COMPONENTS system thread)
target_include_directories(server PRIVATE ${Boost_INCLUDE_DIRS})
target_link_libraries(server PRIVATE ${Boost_LIBRARIES})

# OpenSSL
find_package(OpenSSL REQUIRED)
target_include_directories(server PRIVATE ${OPENSSL_INCLUDE_DIR})
target_link_libraries(server PRIVATE OpenSSL::SSL OpenSSL::Crypto)

# nlohmann_json (JSON 라이브러리)
find_package(nlohmann_json 3.2.0 REQUIRED)
target_link_libraries(server PRIVATE nlohmann_json::nlohmann_json)

# spdlog (로깅)
find_package(spdlog REQUIRED)
target_link_libraries(server PRIVATE spdlog::spdlog)

# curl (슬랙 알림 등)
find_package(CURL REQUIRED)
target_link_libraries(server PRIVATE CURL::libcurl)

# pthread (스레드, 리눅스 필수)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(server PRIVATE Threads::Threads)
