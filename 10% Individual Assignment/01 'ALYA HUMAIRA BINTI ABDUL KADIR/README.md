### Name: 'Alya Humaira Binti Abdul Kadir
### Student ID: 2022490964
### Class: CS2554A
### Subject: ITT440

# **Signal SIGINT**

# What are signals?
* Signals are various notifications sent to a process in order to notify it of various "important" events.
* Signals interrupt whatever the process is doing at this minute, and force it to handle them immediately.
* Each signal has an integer number that represents it as well as a symbolic name that is usually defined in the file signal.h or one of the files included by it directly or indirectly.
* Use the command 'kill -l' to see a list of signals supported by your system.

# Sending Signals Using The Keyboard
The most common way of sending signals to processes is using the keyboard. There are certain key presses that are interpreted by the system as requests to send signals to the process with which we are interacting:
1. Ctrl-C
     *  The system will send an INT signal (SIGINT) to the running process causes the process to immediately terminate
2. Ctrl-Z
     *  The system will send a TSTP signal (SIGTSTP) to the running process causes the process to suspend execution.
3. Ctrl-\
     * The system to send a ABRT signal (SIGABRT) to the running process causes the process to immediately terminate.

# _SIGINT_
  * Value: 2
  * Action: A (Interrupt from keyboard)
  * Example `Code`:
     
````  
#include<stdio.h>  
#include<signal.h>  
#include<unistd.h>  
  
void sig_handler(int signo) {  
    if (signo == SIGINT)    
      printf("received SIGINT\n");  
}  

int main(void) {  
    if (signal(SIGINT, sig_handler) == SIG_ERR)  
        printf("\ncan't catch SIGINT\n");  

    // A long long wait so that we can easily issue a signal to this process  
    while(1)
        sleep(1);  

    return 0;  
}  
````
The `output` will be like this:

````
^Creceived SIGINT
^Creceived SIGINT
^Creceived SIGINT
^Creceived SIGINT
^Creceived SIGINT
^Creceived SIGINT
^Creceived SIGINT
````

Thank you for reading my assignment! #smile#
