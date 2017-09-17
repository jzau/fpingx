#ifndef _FPING_H
#define _FPING_H

#define __APPLE_USE_RFC_3542 1

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>

/* fping.c */
int main(int argc, char** argv);
void crash_and_burn( char *message );
void errno_crash_and_burn( char *message );
int in_cksum( unsigned short *p, int n );
extern int random_data_flag;

typedef struct host_entry {
    /* Each host can have an event attached: either the next time that a ping needs
     * to be sent, or the timeout, if the last ping was sent */
    struct host_entry* ev_prev; /* double linked list for the event-queue */
    struct host_entry* ev_next; /* double linked list for the event-queue */
    struct timeval ev_time; /* time, after which this event should happen */
    int ev_type; /* event type */

    int i; /* index into array */
    char* name; /* name as given by user */
    char* host; /* text description of host */
    char* pad; /* pad to align print names */
    struct sockaddr_storage saddr; /* internet address */
    socklen_t saddr_len;
    int timeout; /* time to wait for response */
    unsigned char running; /* unset when through sending */
    unsigned char waiting; /* waiting for response */
    struct timeval last_send_time; /* time of last packet sent */
    int num_sent; /* number of ping packets sent */
    int num_recv; /* number of pings received (duplicates ignored) */
    int num_recv_total; /* number of pings received, including duplicates */
    int max_reply; /* longest response time */
    int min_reply; /* shortest response time */
    int total_time; /* sum of response times */
    /* _i -> splits (reset on every report interval) */
    int num_sent_i; /* number of ping packets sent */
    int num_recv_i; /* number of pings received */
    int max_reply_i; /* longest response time */
    int min_reply_i; /* shortest response time */
    int total_time_i; /* sum of response times */
    int discard_next_recv_i; /* don't count next received reply for split reporting */
    int* resp_times; /* individual response times */
#if defined(DEBUG) || defined(_DEBUG)
    int* sent_times; /* per-sent-ping timestamp */
#endif /* DEBUG || _DEBUG */
} HOST_ENTRY;

/*** globals ***/

HOST_ENTRY** fping(int argc, char** argv);

/* socket.c */
int  open_ping_socket_ipv4();
void init_ping_buffer_ipv4(size_t ping_data_size);
void socket_set_src_addr_ipv4(int s, struct in_addr *src_addr);
int  socket_sendto_ping_ipv4(int s, struct sockaddr *saddr, socklen_t saddr_len, uint16_t icmp_seq, uint16_t icmp_id);
//#ifdef IPV6
int  open_ping_socket_ipv6();
void init_ping_buffer_ipv6(size_t ping_data_size);
void socket_set_src_addr_ipv6(int s, struct in6_addr *src_addr);
int  socket_sendto_ping_ipv6(int s, struct sockaddr *saddr, socklen_t saddr_len, uint16_t icmp_seq, uint16_t icmp_id);
//#endif

#endif

