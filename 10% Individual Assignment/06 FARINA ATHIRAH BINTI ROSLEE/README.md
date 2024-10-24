# ITT440 Individual Assignment 10%
### Name: Farina Athirah binti Roslee
### Student ID: 2022214142
### Group: M3CS2554A
### Lecturer's Name: Sir Shahadan Saad

# SIGTERM
## Introduction to Signal
- A signal can be defined as a software interrupt or a notification that alerts a process about an event occurring in the system.
- Signals offer a versatile mechanism for efficient event handling and coordination between processes, enhancing the overall functionality and reliability of C programs.
- In other words, signal serve as a mean of communication between a running program (process) and the operating system, allowing the program to respond to various events in an unsynchronized manner.
- There are a few signal functions that can be used and each function has its own usage, such as `kill()` or `raise()` functions.

## What is SIGTERM?
- SIGTERM signal is used for **terminating a program** and serve to exit program **gracefully**.
- The sigaction() function and the struct of the same name, defined in the system header `signal.h`.
- The SIGTERM can also be referred as a soft kill because the process that receives the SIGTERM signal may choose to ignore it.
- Unlike SIGGKILL, this signal can be blocked, handled and ignored. The shell command `kill` (built-in sheel commands) generates 'SIGTERM' by default.

### How to Send SIGTERM?
- To send SIGTERM signal in C, we can use `kill()` function. Remember that SIGTERM allows the process to clean up and exit gracefully. It is much more better to use SIGTERM first and only use SIGKILL for last resort.

## C Program for SIGTERM
```C
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

// Signal handler function for SIGTERM
void sigterm() {
    printf("CHILD: I have received SIGTERM\n");
    exit(0); // Exit after handling the signal
}

int main() {
    int pid;
    pid = fork(); // Create a child process

    if (pid < 0) {
        perror("fork");
        exit(1); // Exit if fork fails
    }

    if (pid == 0) { // Child process
        signal(SIGTERM, sigterm); // Register signal handler for SIGTERM
        for (int x = 1;; x++); // Infinite loop
    } else { // Parent process
        printf("\nPARENT: sending SIGTERM\n\n");
        sleep(1); // Ensure the child process is ready to receive the signal
        kill(pid, SIGTERM); // Send SIGTERM to child process
        sleep(1); // Pause for 1 second to allow the child process to handle the signal
    }

    return 0;
}

```
## Sample Output
![image](https://github.com/addff/2403-ITT440/assets/166041339/0aa2920a-1ad8-47e0-b891-34623e4895b9)

## Youtube Link
- This is the youtube link for further explanation regarding SIGTERM in C [SIGTERM IN C PROGRAMMING](https://youtu.be/NHQXUX6pg1g?si=3JV5-80uUslnFFUa)

## References
- [Termination Signals](https://www.gnu.org/software/libc/manual/html_node/Termination-Signals.html#:~:text=The%20SIGTERM%20signal%20is%20a,kill%20generates%20SIGTERM%20by%20default)
- [Catch SIGTERM Exit Gracefully](https://airtower.wordpress.com/2010/06/16/catch-sigterm-exit-gracefully/)
- [Understanding Signals in the C Language: Harness the Power of Asynchronous Event Handling](https://medium.com/@razika28/signals-ad83f38f80b6)
- [C library function - signal()](https://www.tutorialspoint.com/c_standard_library/c_function_signal.htm)
