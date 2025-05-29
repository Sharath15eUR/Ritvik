#    Assignment 1

## Question 1 :  C program that represents the calender for the week
```
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_TASKS 3
#define MAX_DAYS 7
#define MAX_TASK_LEN 100

typedef struct {
    char name[10];
    char tasks[MAX_TASKS][MAX_TASK_LEN];
    int taskCount;
} Day;

// Initializing days

void initializeWeek(Day week[]) {
    const char *names[MAX_DAYS] = {
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    };
    for (int i = 0; i < MAX_DAYS; i++) {
        strcpy(week[i].name, names[i]);
        week[i].taskCount = 0;
    }
}

// Finding day index by name

int findDayIndex(Day week[], const char *dayName) {
    for (int i = 0; i < MAX_DAYS; i++) {
        if (strcasecmp(week[i].name, dayName) == 0)
            return i;
    }
    return -1;
}

// To add Tasks

void addTask(Day week[]) {
    char input[20];
    printf("Enter day name: ");
    scanf("%s", input);

    int index = findDayIndex(week, input);
    if (index == -1) {
        printf("Invalid day name. Try again.\n");
        return;
    }

    if (week[index].taskCount >= MAX_TASKS) {
        printf("Task limit reached for %s (max %d tasks).\n", week[index].name, MAX_TASKS);
        return;
    }

    getchar();
    printf("Enter task: ");
    fgets(week[index].tasks[week[index].taskCount], MAX_TASK_LEN, stdin);
    week[index].tasks[week[index].taskCount][strcspn(week[index].tasks[week[index].taskCount], "\n")] = '\0';
    week[index].taskCount++;

    printf("Task added to %s.\n", week[index].name);
}

// Displaying Tasks

void displayTasks(const Day week[]) {
    printf("\n--- Weekly Tasks ---\n");
    for (int i = 0; i < MAX_DAYS; i++) {
        printf("%s:\n", week[i].name);
        if (week[i].taskCount == 0) {
            printf("  No tasks\n");
        } else {
            for (int j = 0; j < week[i].taskCount; j++) {
                printf("  - %s\n", week[i].tasks[j]);
            }
        }
    }
    printf("--------------------\n");
}


int main() {
    Day week[MAX_DAYS];
    int choice;

    initializeWeek(week);

    do {
        printf("\n--- Weekly To-Do List Menu ---\n");
        printf("1. Add Task\n");
        printf("2. Display Tasks\n");
        printf("3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                addTask(week);
                break;
            case 2:
                displayTasks(week);
                break;
            case 3:
                printf("Exiting program.\n");
                break;
            default:
                printf("Invalid choice. Please enter 1, 2, or 3.\n");
        }
    } while (choice != 3);

    return 0;
}
```

## Question 2 : Pointers

```
#include <stdio.h>
#include <stdlib.h>
 
void func(int* arr, int n) {
    int* lo = arr;
    int* hi = arr;
 
    while (hi < arr + n) {
        if (!(*hi & 1)) {
            int temp = *lo;
            *lo = *hi;
            *hi = temp;
            lo++;
        }
        hi++;
    }
}
 
int main() {
    int n;
    scanf("%d", &n);
    int* arr = (int*) malloc(sizeof(int) * n);
 
    for (int i = 0; i < n; i++) {
        scanf("%d", arr + i);
    }
 
    func(arr, n);
 
    for (int i = 0; i < n; i++) {
        printf("%d ", *(arr+i));
    }
    printf("\n");
 
    free(arr);
    return 0;
}
```

## Question 3 : Arrays 

```#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
 
bool searchMatrix(int** matrix, int rows, int cols, int target) {
    int low = 0, high = rows * cols - 1;
 
    while (low <= high) {
        int mid = (low + high) / 2;
        int row = mid / cols;
        int col = mid % cols;
        int midValue = matrix[row][col];
 
        if (midValue == target) {
            return true;
        } else if (midValue < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
 
    return false;
}
 
int main() {
    int rows, cols, target;
    scanf("%d %d", &rows, &cols);
 
    int** matrix = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        matrix[i] = (int*)malloc(cols * sizeof(int));
    }
 
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }
 
    scanf("%d", &target);
 
    if (searchMatrix(matrix, rows, cols, target)) {
        printf("Element found in the matrix.\n");
    } else {
        printf("Element not found in the matrix.\n");
    }
 
    for (int i = 0; i < rows; i++) {
        free(matrix[i]);
    }
    free(matrix);
 
    return 0;
}
```
