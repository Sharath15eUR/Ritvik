# Assignment 2

## Q1

```
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
 
int thr1(void* arg) {
    int n = *((int*)arg);
    int sum = 0, count = 0, num = 2;
 
    while (count < n) {
        int is_prime = 1;
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                is_prime = 0;
                break;
            }
        }
        if (is_prime) {
            sum += num;
            count++;
        }
        num++;
    }
 
    return sum;
}
 
void* threadA(void* arg) {
    int n = *((int*)arg);
    int sum = thr1(&n);
    printf("Sum of the first %d prime numbers: %d\n", n, sum);
    pthread_exit(NULL);
}
 
void* threadB(void* arg) {
    for (int i = 0; i < 50; i++) {
        printf("Thread 1 is running\n");
        sleep(2);
    }
    pthread_exit(NULL);
}
 
void* threadC(void* arg) {
    for (int i = 0; i < 34; i++) {
        printf("Thread 2 is running\n");
        sleep(3);
    }
    pthread_exit(NULL);
}
 
int main() {
    pthread_t t1, t2, t3;
    int n;
 
    printf("Enter the value of n: ");
    scanf("%d", &n);
 
    pthread_create(&t1, NULL, threadA, &n);
    pthread_create(&t2, NULL, threadB, NULL);
    pthread_create(&t3, NULL, threadC, NULL);
 
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
 
    return 0;
}
```


Q2

```
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
 
volatile int keep_running = 1;
 
void handle_signal(int signal) {
    if (signal == SIGINT) {
        printf("\nSIGINT received. Exiting gracefully...\n");
        keep_running = 0;
    }
}
 
int thr1(int n) {
    int sum = 0, count = 0, num = 2;
    while (count < n) {
        int is_prime = 1;
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                is_prime = 0;
                break;
            }
        }
        if (is_prime) {
            sum += num;
            count++;
        }
        num++;
    }
    return sum;
}
 
void* threadA(void* arg) {
    int n = *((int*)arg);
    clock_t start = clock();
    int sum = thr1(n);
    clock_t end = clock();
    double time_taken = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Sum of the first %d prime numbers: %d\n", n, sum);
    printf("Thread A execution time: %.2f seconds\n", time_taken);
    pthread_exit(NULL);
}
 
void* threadB(void* arg) {
    clock_t start = clock();
    while (keep_running) {
        printf("Thread 1 is running\n");
        sleep(2);
    }
    clock_t end = clock();
    double time_taken = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Thread B execution time: %.2f seconds\n", time_taken);
    pthread_exit(NULL);
}
 
void* threadC(void* arg) {
    clock_t start = clock();
    while (keep_running) {
        printf("Thread 2 is running\n");
        sleep(3);
    }
    clock_t end = clock();
    double time_taken = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Thread C execution time: %.2f seconds\n", time_taken);
    pthread_exit(NULL);
}
 
int main() {
    signal(SIGINT, handle_signal);
 
    pthread_t t1, t2, t3;
    int n;
 
    printf("Enter the value of n: ");
    scanf("%d", &n);
 
    pthread_create(&t1, NULL, threadA, &n);
    pthread_create(&t2, NULL, threadB, NULL);
    pthread_create(&t3, NULL, threadC, NULL);
 
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
 
    return 0;
}
```
