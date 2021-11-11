//
// Created by silver on 08/11/2021.
//

#ifndef ROOTAGENTC___ROOT_API_H
#define ROOTAGENTC___ROOT_API_H

#ifdef __cplusplus
extern "C" {
#endif


/* Available request types */
enum RequestType {
    OPENFILE, LISTDIR, READLINK
};

/* Available answer types */
enum AnswerType {
    NO_DIFF, NEW_DATA, ERROR
};

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


AnswerSize request(char *request, char **answer);

#ifdef __cplusplus
} // extern "C" closure
#endif

#endif //ROOTAGENTC___ROOT_API_H

