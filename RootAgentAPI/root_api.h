//
// Created by silver on 08/11/2021.
//

#ifndef ROOTAGENTC___ROOT_API_H
#define ROOTAGENTC___ROOT_API_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>
#pragma pack(1)

#define SERVER_IP  "localhost"
#define PORT 5001

/* Available analyze_request types */
typedef enum {
    OPENFILE, LISTDIR, READLINK
} RequestType;

/* Available answer types */
typedef enum {
    NO_DIFF, NEW_DATA, ERROR
} AnswerType;

typedef size_t AnswerSize;
typedef long int CheckSum;

/* The data struct the server expects from the client socket */
typedef struct {
    RequestType request_type;
    CheckSum old_data_checksum; // Old checksum/md5 data to check diff with new data to ease the channel
    size_t path_len;
    char path[];         // The path to read data from
} Request;


/* The data struct the client expects */
typedef struct {
    AnswerType answer_type;
    CheckSum data_checksum; // Old checksum/md5 data to check diff with new data to ease the channel
    size_t data_len;
    unsigned char data[];         // The path to read data from
} Answer;


AnswerSize analyze_request(char *request, char **answer);
Request* get_request_from_socket(int sock);

#ifdef __cplusplus
} // extern "C" closure
#endif

#endif //ROOTAGENTC___ROOT_API_H