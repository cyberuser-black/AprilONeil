#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <csignal>
#include <string>
#include <array>
#include <memory>
#include <iostream>
#include <fstream>
#include "vector"
#include "root_api.h"



int main()
{
//    std::string path = "/home/silver/Desktop/test_binary_file";
    std::string path = "/proc/self/maps";
    auto* request = (Request*) malloc(sizeof (char) * path.length() + sizeof (RequestType) + sizeof (CheckSum) + sizeof (size_t));
    request->request_type = OPENFILE;
    request->old_data_checksum = 0;

    request->path_len = path.length();
    strncpy(request->path, path.c_str(), request->path_len);
    char* answer = nullptr;

    int size = RootApi::request((char*)request, &answer);

    auto * myAnswer = (Answer*) answer;
    std::cout << myAnswer->data_len << std::endl;
//    for(int i = 0; i < myAnswer->data_len; i++)
//    {
//        std::cout << myAnswer->data[i] << std::endl;
//    }
    std::cout << myAnswer->data_checksum << std::endl;
    free(answer);
    return 0;
}