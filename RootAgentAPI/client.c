#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#include <netdb.h>
#include <netinet/in.h>

#include <string.h>

#include "root_api.h"

size_t create_request(Request** request, RequestType type, CheckSum old_checksum, char* path, size_t path_len)
{
    size_t request_size = sizeof(Request) + (sizeof(char) * path_len);
    *request = (Request*) malloc(request_size);
    (*request)->request_type = type;
    (*request)->old_data_checksum = old_checksum;
    (*request)->path_len = path_len;
    strncpy((*request)->path, path, path_len);
    printf("the path is: %s\n", (*request)->path);
    printf("request_size: %ld\n", request_size);
    return request_size;
}

Answer* get_answer_from_socket(int sock_id)
{
    size_t n;
    size_t first_read_size = sizeof(Answer);
    Answer *answer_p = (Answer*) malloc(sizeof(char) * first_read_size);
    bzero(answer_p, first_read_size);
    printf("first read (reading constants...): ");
    n = read(sock_id, (char*) answer_p, sizeof(char) * first_read_size);
    printf("%ld bytes loaded\n", n);

    if (n < 0) {
        perror("ERROR reading from socket");
        exit(1);
    }
    answer_p = (Answer *) realloc((char*)answer_p, sizeof(char) * (first_read_size + answer_p->data_len));
    n = read(sock_id, ((char*) answer_p) + first_read_size, sizeof(char) * answer_p->data_len);
    printf("second read (reading data...): ");
    if (n < 0) {
        perror("ERROR reading from socket");
        exit(1);
    }
    printf("%ld bytes loaded\n", n);
    printf("Answer type is: %d\n", answer_p->answer_type);
    printf("Answer checksum is : %ld\n", answer_p->data_checksum);
    printf("Answer data len is: %ld\n", answer_p->data_len);
    printf("Answer data is: \n");
    for(int i = 0; i < answer_p->data_len; i++)
    {
        printf("%c", answer_p->data[i]);
    }
    printf("\n");

    return answer_p;
}

int connect_to_server(char* server_ip, int port)
{
    size_t n;
    int sockfd;
    struct sockaddr_in serv_addr;
    struct hostent *server;

    /* Create a socket point */
    sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if (sockfd < 0) {
        perror("ERROR opening socket");
        return -1;
    }

    server = gethostbyname(server_ip);

    if (server == NULL) {
        fprintf(stderr,"ERROR, no such host\n");
        return -1;
    }

    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(port);

    /* Now connect to the server */
    if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("ERROR connecting");
        return -1;
    }
    return sockfd;
}

Answer* send_request_to_server(RequestType request_type, CheckSum old_data_checksum, char* path, size_t path_len)
{
    size_t n;
    int sock_fd = connect_to_server(SERVER_IP, PORT);
    if(sock_fd == -1)
    {
        return NULL;
    }
    Request * request = NULL;
    printf("creating request...\n");
    size_t request_size = create_request(&request, request_type, old_data_checksum, path, path_len);

    /* Send message to the server */
    printf("writing to socket...\n");
    n = write(sock_fd, (char*) request, request_size);
    printf("Wrriten %ld bytes\n", n);
    if (n < 0) {
        perror("ERROR writing to socket");
        return NULL;
    }

    if(request != NULL)
    {
        free(request);
    }

    /* Now read server response */
    Answer* myAnswer = get_answer_from_socket(sock_fd);
    return myAnswer;

}

Answer* open_file(char* path, size_t path_len, CheckSum old_data_checksum)
{
    return send_request_to_server(OPENFILE, old_data_checksum, path, path_len);
}

//Answer* list_dir()
//{
//    return send_request_to_server(LISTDIR, old_data_checksum, path, path_len);
//}
//
//Answer* read_link()
//{
//    return send_request_to_server(READLINK, old_data_checksum, path, path_len);
//}


int main(int argc, char *argv[]) {
    char path[13] = "/proc/meminfo";
    Answer * answer = open_file(path, strlen(path), 0);
    free(answer);
//   int sockfd, portno;
//   size_t n;
//   struct sockaddr_in serv_addr;
//   struct hostent *server;
//
//   if (argc < 7) {
//      fprintf(stderr,"usage %s hostname port request_type(openfile=0, listdir=1, readlink=2)"
//                     " old_data_checksum path_len path\n", argv[0]);
//      exit(0);
//   }
//
//   /* Get request details from user */
//   portno = atoi(argv[2]);
//   RequestType request_type = atoi(argv[3]);
//   CheckSum checksum = atol(argv[4]);
//   size_t path_len = atol(argv[5]);
//   char* path = (char*) malloc(sizeof(char) * path_len);
//   strncpy(path, argv[6], path_len);
//
//   /* Create a socket point */
//   sockfd = socket(AF_INET, SOCK_STREAM, 0);
//
//   if (sockfd < 0) {
//      perror("ERROR opening socket");
//      exit(1);
//   }
//
//   server = gethostbyname(argv[1]);
//
//   if (server == NULL) {
//      fprintf(stderr,"ERROR, no such host\n");
//      exit(0);
//   }
//
//   bzero((char *) &serv_addr, sizeof(serv_addr));
//   serv_addr.sin_family = AF_INET;
//   bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
//   serv_addr.sin_port = htons(portno);
//
//   /* Now connect to the server */
//   if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
//      perror("ERROR connecting");
//      exit(1);
//   }
//
//   Request * request = NULL;
//   printf("creating request...\n");
//   size_t request_size = create_request(&request, request_type, checksum, path, path_len);
//
//   /* Send message to the server */
//   printf("writing to socket...\n");
//   n = write(sockfd, (char*) request, request_size);
//    printf("Wrriten %ld bytes\n", n);
//   if (n < 0) {
//      perror("ERROR writing to socket");
//      exit(1);
//   }
//
//   if(request != NULL)
//   {
//       free(request);
//   }
//
//   /* Now read server response */
//   Answer* myAnswer = get_answer_from_socket(sockfd);
//   free(myAnswer);
//
//   return 0;
}

