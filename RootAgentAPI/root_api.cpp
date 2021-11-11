#include <cstring>
#include <string>
#include <array>
#include <memory>
#include <iostream>
#include <fstream>
#include <vector>
#include "root_api.h"

#define CANT_READ_FILE_ERROR "Can't read file"

typedef unsigned char      byte;    // Byte is a char
typedef unsigned short int word16;  // 16-bit word is a short int
typedef unsigned int       word32;  // 32-bit word is an int


std::vector<unsigned char> open_file(const std::string& file_name);
CheckSum checksum(const std::vector<unsigned char>& data);

AnswerSize request(char *request, char **answer) {
    Answer* myAnswer;
    auto *myRequest = (Request*) request;  // cast to request struct
    std::vector<unsigned char> new_data;                     // the new data stored here
    std::string path;                         // the path to get data from
    char* temp_path = (char*) malloc(sizeof(char) * myRequest->path_len);
    AnswerSize answer_size;
    strncpy(temp_path, myRequest->path, myRequest->path_len);  // get the path from the request struct
    path = std::string(temp_path);
    free(temp_path);
    switch (myRequest->request_type) {
        case OPENFILE:
            new_data = open_file(path);
            break;
        case READLINK:
            // TODO: read link
            new_data = std::vector<unsigned char>(CANT_READ_FILE_ERROR, std::end(CANT_READ_FILE_ERROR));
            break;
        case LISTDIR:
            // TODO: list dir
            new_data = std::vector<unsigned char>(CANT_READ_FILE_ERROR, std::end(CANT_READ_FILE_ERROR));

            break;
    }
    // Here we check the new data
    CheckSum new_data_checksum = checksum(new_data);  // get new data checksum
    if(new_data_checksum == myRequest->old_data_checksum)  // the checksum is identical to the old checksum
    {
        answer_size = sizeof(AnswerType) + sizeof(CheckSum) + sizeof(size_t);
        myAnswer = (Answer*) malloc(answer_size);  // no data to alloc
        myAnswer->data_checksum = myRequest->old_data_checksum;  // the same check sum
        myAnswer->data_len = 0;  // no need for data so the data_len of the expected data is 0
        if(std::string(new_data.begin(), new_data.end()) == CANT_READ_FILE_ERROR)  // operation failed
        {
            myAnswer->answer_type = ERROR;  // set answer type to error
        }
        else // operation succeeded but no change found
        {
            myAnswer->answer_type = NO_DIFF;  // set answer type to no diff from last request
        }
    }
    else  // the check sum is different from the old checksum
    {
        answer_size = (int) (sizeof(AnswerType) + sizeof(CheckSum) + sizeof(size_t) + (sizeof(char) * new_data.size()));
        myAnswer = (Answer*) malloc(answer_size);
        myAnswer->answer_type = NEW_DATA;
        myAnswer->data_checksum = new_data_checksum;
        myAnswer->data_len = new_data.size();
        std::copy(new_data.begin(), new_data.end(), myAnswer->data);
    }
    *answer = (char*) myAnswer;
    myAnswer = nullptr;
    return answer_size;
}

std::vector<unsigned char> open_file(const std::string& file_name) {
    /**
     * A private static method that opens a file by a file_name -
     * first, we try to open the file with expected size. If the file is normal file and not a string, it will succeed.
     * Otherwise, the file is a string (most of /proc are strings) so we open it without an expected size.
     * **/
    std::ifstream file( file_name, std::ios::binary | std::ios::ate); // open file and put seek on end
    std::streamsize size = file.tellg(); // get file size
    file.seekg(0, std::ios::beg); // return seek to start
    std::vector<unsigned char> buffer;
    if(size > -1) {  // if the file is path from /proc the std::ios::ate flag will terminate the file opening
        buffer.resize(size);
        if (!(file.read(reinterpret_cast<char *>(buffer.data()), size))) {
            buffer = std::vector<unsigned char>(CANT_READ_FILE_ERROR, std::end(CANT_READ_FILE_ERROR));
        }
    }
    else  // reached here if failed to open file the std::ios:ate flag
    {
        file.close();
        file = std::ifstream(file_name, std::ios::binary);
        buffer = std::vector<unsigned char> (std::istreambuf_iterator<char>(file), {});
    }
    file.close();
    return buffer;
}

CheckSum checksum(const std::vector<unsigned char> &data) {
    word32 sum = 0;

    // Main summing loop
    for(unsigned char i : data)
    {
        sum = sum + i;
    }
    // Fold 32-bit sum to 16 bits
    while (sum>>16)
        sum = (sum & 0xFFFF) + (sum >> 16);

    return(~sum);
}