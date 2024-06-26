**Student Name :** Tengku Zafran Shah bin Tengku Iskandar Zulkarnain

**Student ID   :** 2022842268

**Group        :** M3CS2554A

**Title        :** ITT440 10% Individual Assignment

**Lecturer     :** Sir Shahadan Saad

# Socket Programming in C VS Python

## What is Socket Programming ?

### Definition 

Socket programming is a method of establishing a brief connection between two existing nodes to communicate with each other. The two nodes are commonly known as **Client** and **Server**. The way of communicating is usually one node listens on a particular port with assigned IP address, while the other node reach out to form a brief connection. The connection is commonly made for accessing resources from the other node such as files, songs, videos, or some other services. For more detailed informations about __Client__ and __Server__ are as follows:

* `Client` --> The client is what sends a request to that server socket, and waits for a response.

* `Server` --> Server's sole purpose is to do as what its name implies - serve its **Client**.

_The diagram below showing how the `Client-Server` interact to establish connection_ :

![server-client](https://github.com/addff/2403-ITT440/assets/166004983/dd259dca-21d3-43ce-91bb-68b8aa9e974e)

1.  `socket()` --> Creating a new socket.
2.  `bind()` --> Binding the socket to a specific port and an IP address so that socket can communicate.
3.  `listen()` --> Waiting for feedback from the other end for incoming connection request.
4.  `accept()` --> Accepting a connection from client and returning a brand new socket to start communicating.
5.  `connect()` --> Establishing a connection to a remote and private server.
6.  `write()` --> Sending data that was requested through the socket created.
7.  `read()` --> Receiving data that was sended from the socket.
8.  `close()` --> Ending the session by closing the socket connection.

There are various programming languages that can be used to code socket programming and the most popular ones are __C__ and __Python__. In this experiment on finding out which language is better for socket programming, a simple `Client-Server` program will be made to print message if connection is established.

## Socket Programming in C

The platform that is used to write, compile and run the codes for `client-server` for __C language__ is __FreeBSD__, a free and easy to use platform for beginner to explore. __FreeBSD__ is a free and open-source Unix-like operating system descended from the *Berkeley Software Distribution*. The first version of __FreeBSD__ was released in 1993 developed from 386BSD and the current version runs on x86, ARM, PowerPC and RISC-V processors.

![FreeBSD-logo](https://github.com/addff/2403-ITT440/assets/166004983/d57c7009-31e8-46d1-9ea9-5470c019decb)

_The diagram below showing common commands used in socket programming with C language_ :

![Screenshot 2024-05-02 171924](https://github.com/addff/2403-ITT440/assets/166004983/4ae9432f-2a7a-4597-b760-29dc3d3c007e)

### Server Code :

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>

#define PORT 27679

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int addrlen = sizeof(address);

    // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // Forcefully attaching socket to the port 27679
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    // Forcefully attaching socket to the port 27679
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address))<0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    if (listen(server_fd, 5) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    while(1) {
        // Accept connection from client
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen))<0) {
            perror("accept");
            exit(EXIT_FAILURE);
        }

        printf("Got connection from %s\n", inet_ntoa(address.sin_addr));

        // Send a thank you message to the client
        char *message = "Thank you for establishing connection";
        send(new_socket, message, strlen(message), 0);

        // Close the connection
        close(new_socket);
    }

    return 0;
}
```

### Client Code :

```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>

#define PORT 27679

int main() {
    int sock;
    struct sockaddr_in serv_addr;

    // Create socket
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Server details
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(PORT);

    // Convert IPv4 and IPv6 addresses from text to binary form
    if(inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr)<=0) {
        perror("invalid address");
        exit(EXIT_FAILURE);
    }

    // Connect to server
    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("connection failed");
        exit(EXIT_FAILURE);
    }

    // Receive data from server and print it
    char buffer[1024] = {0};
    if (read(sock, buffer, 1024) < 0) {
        perror("read failed");
        exit(EXIT_FAILURE);
    }
    printf("%s\n", buffer);

    // Close the socket
    close(sock);

    return 0;
}
```

### Compiling Server and Client :

![Screenshot 2024-05-01 234747](https://github.com/addff/2403-ITT440/assets/166004983/827ecd98-5650-4329-8a08-7f026d598cab)

### Output :

The output in server terminal is as follows:

![Screenshot 2024-05-01 234046](https://github.com/addff/2403-ITT440/assets/166004983/b18ec33e-4e4b-4a51-9633-cd723dcab25d)

* The server's code should be run first before the client's code to make sure the server is ready for incoming request from the client.
* The server will print the IP address that were used to bind with the socket.

The output in client terminal is as follows:

![Screenshot 2024-05-01 234058](https://github.com/addff/2403-ITT440/assets/166004983/cae7fd88-0b73-4203-9337-f08a75cb70ed)

* The client will print out the message if connection is successfully established between client and server.
* The client terminal will not show any output if the client's code is run first before the server's code.

 ## Socket Programming in Python

 The platform that is used to write, compile and run the codes for `client-server` for __Python language__ is __Visual Studio Code (VS Code)__, a free and easy to use platform for beginner to explore. __VS Code__ is a source-code editor developed by *Microsoft* for Windows, Linux, macOS and web browsers. Features include support for debugging, syntax highlighting, intelligent code completion, snippets, code refactoring, and embedded version control with Git. User can install Python extension packs inside __VS Code__ so that it can be used as a Python coding tool.

![vscode](https://github.com/addff/2403-ITT440/assets/166004983/b4ea65e1-e601-417b-ad38-7ec73d54c17d)

_The diagram below showing common commands used in socket programming with Python language_ :

![Screenshot 2024-05-02 171940](https://github.com/addff/2403-ITT440/assets/166004983/d969d8c2-e6af-49af-9460-0224f8b3bf24)

 ### Server Code :

 ```Python
import socket

# Create a socket object
s = socket.socket()

# Define the port on which you want to connect
port = 27679

# Bind to the port
s.bind(('localhost', port))

# Wait for client connection
s.listen(5)

while True:
    # Establish connection with client
    c, addr = s.accept()
    print('Got connection from', addr)

    # Send a thank you message to the client
    c.send('Thank you for establishing connection'.encode())

    # Close the connection
    c.close()
```

 ### Client Code :

 ```Python
import socket

# Create a socket object
s = socket.socket()

# Define the port on which you want to connect
port = 27679

try:
    # Connect to the server
    s.connect(('localhost', port))

    # Receive data from server and print it
    print(s.recv(1024).decode())

    # Close the connection
    s.close()
except ConnectionRefusedError:
    print("Connection refused. Make sure the server is running.")

 ```

 ### Output :

 The output in server terminal is as follows:

 ![Screenshot 2024-05-01 213443](https://github.com/addff/2403-ITT440/assets/166004983/5492f40a-53d6-4b05-b1c7-5bdb9838a339)

 * The server will print the IP address and the port number that were used to establish connection between client and server.
 * The port number will be different each time the server code is run again and it will never be the same as before.

 The output in client terminal is as follows:

 ![Screenshot 2024-05-01 213527](https://github.com/addff/2403-ITT440/assets/166004983/019fcf5c-e975-4757-9860-5cb47398ffbe)

 * The client will print out the message if connection is successfully established between client and server.
 
 ## C or Python, Which Language is Better for Socket Programming?

There is no definite answer for above question as different programmers would have different opinion on which language is more suitable for socket programming. Alas, what programmer seek in learning and creating socket programming will differ on which language that they use. At the end of the day, both languages give different exposure and knowledge to its user. In conclusion, both __C__ and __Python__ are good languages to use for socket programming. The most noticeable differences between both languages are as shown below:

 | Socket Programming with C Language                              | Socket Programming with Python Language                    |
 | --------------------------------------------------------------- | ---------------------------------------------------------- |
 | Longer line of codes with detailed commands                     | Shorter line of codes with simpler commands                |
 | Complex and too detailed for beginner                           | Beginner-friendly                                          |
 | Good for deeper understanding on the flow of socket programming | Only utilise the surface level of socket programming       | 
 | Need to use Unix as Operating System (OS)                       | Can be code and run in multiple Operating System (OS)      |
 | Consume lots of time to write basic codes for `Client-Server`   | Take a short time to write basic codes for `Client-Server` |
 

 ## Video

 For better understanding, a video to demonstrate on how to compile and run basic `Client-Server` codes and to differentiate between socket programming in C VS Python is made. The video can be accessed by clicking the link below:

 [Socket Programming in C VS Python](https://youtu.be/i0GqqTi5RBY)

 ## References

 Various articles and websites are used as references and sources for this assignment. the links for those references are as shown below:

 1. [Socket Programming in C - GeeksforGeeks](https://www.geeksforgeeks.org/socket-programming-cc/)
 2. [How to use Python Socket Programming for computer networking?](https://www.linkedin.com/pulse/how-use-python-socket-programming-computer-networking-rangnekar-dvyif#:~:text=For%20carrying%20out%20the%20communication,access%20the%20BSD%20socket%20interface)
 3. [Datacamp - A Complete Guide to Socket Programming in Python](https://www.datacamp.com/tutorial/a-complete-guide-to-socket-programming-in-python)
 4. [Socket Programming in C/C++ - javatpoint](https://www.javatpoint.com/socket-programming-in-c-or-cpp)
