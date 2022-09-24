#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct numNode
{
  int num;
  double norm;
  struct numNode *back;
  struct numNode *next;
};

struct cycleNode
{
  int num;
  struct cycleNode *back;
  struct cycleNode *next;
};

void isHappy(int numOne, int numTwo, struct numNode *ptr, struct numNode *head);
int checkHappy(int num, struct cycleNode *cyclePtr, double *rNorm);
void sort(struct numNode **ptr, struct numNode *head);
int getCount(struct numNode **ptr, struct numNode *head);
void printNodes(struct numNode *ptr);
void printSorted(struct numNode sorted[], struct numNode *ptr, struct numNode *head);

int main()
{
  int numOne, numTwo;
    
  
  struct numNode *numPtr = (struct numNode*)malloc(sizeof(struct numNode));
  struct numNode *head = numPtr;
  
  printf("First Argument: ");
  scanf("%i", &numOne);
  
  printf("Second Argument: ");
  scanf("%i", &numTwo);
  
  if (numOne > numTwo)
  {
    int tmp = numOne;
    numOne = numTwo;
    numTwo = tmp;
  }
  
  
  isHappy(numOne, numTwo, numPtr, head);
  
  
  return 0;
  
}

void isHappy(int numOne, int numTwo, struct numNode *numPtr, struct numNode *head)
{
  struct cycleNode *cyclePtr = (struct cycleNode*)malloc(sizeof(struct cycleNode));
  double rNorm = 0;
  
  
  for (int i = numOne, j = 1; i <= numTwo; i++)
  {
    rNorm = i*i;
    if (checkHappy(i, cyclePtr, &rNorm))
    {
           
      numPtr->num = i;
      numPtr->norm = rNorm;
      numPtr->next = (struct numNode*)malloc(sizeof(struct numNode));
      numPtr->next->back = numPtr;
      
      //printf("Number: %i\n", numPtr->num);
      
      numPtr = numPtr->next;
      
    }
  }
  
  
  if (numPtr->back != NULL)
  {
    numPtr = numPtr->back;
    free(numPtr->next);
    numPtr->next = NULL;
  }
  else
  {
    free(numPtr);
  }
  
  numPtr = head;
  
  if (numPtr->next == NULL)
    printf("NOBODYS HAPPY!\n");
  else
  {
    sort(&numPtr, head);
    
  }
}

int checkHappy(int num, struct cycleNode *cyclePtr, double *rNorm)
{  
  if (num == 4)
    return 0;
  
  if (num == 1)
  {
    *rNorm = sqrt(*rNorm);
    return 1;
  }
  
  struct cycleNode *ptr = (struct cycleNode*)malloc(sizeof(struct cycleNode));
  int sum = 0;
  
  cyclePtr->num = num;
  cyclePtr->next = ptr;
  ptr->back = cyclePtr;
  
  while (num != 0)
  {
    int digit = num % 10;
    sum += digit * digit;
    num /= 10;
    
  }
  num = sum;
  *rNorm += (num*num);
        
  checkHappy(num, ptr, rNorm);
}


void sort(struct numNode **ptr, struct numNode *head)
{
  int listLength = getCount(ptr, head);
  struct numNode sorted[listLength];
  
  (*ptr) = head;  
  
  for (int k = 0; k < listLength; k++)
  {
    sorted[k] = (**ptr);
    (*ptr) = (*ptr)->next;    
  }
  
  int i, j;
  struct numNode key;
  
  for (i = 1; i < listLength; i++)
  {
    key = sorted[i];
    j = i - 1;
    
    while (j >= 0 && sorted[j].norm > key.norm)
    {
      sorted[j+1] = sorted[j];
      j--;
      
    }
    sorted[j + 1] = key;
    
  }
  
  printSorted(sorted, *ptr, head);
  
}

int getCount(struct numNode **ptr, struct numNode *head)
{
    int count = 0;
    (*ptr) = head;
    
    while ((*ptr) != NULL)
    {
        count++;
        *ptr = (*ptr)->next;
    }
    return count;
}

void printNodes(struct numNode *ptr)
{
  while (ptr != NULL)
  {
    ptr = ptr->next;
  }
}

void printSorted(struct numNode sorted[], struct numNode *ptr, struct numNode *head)
{
  int listLength = getCount(&ptr, head);
  for (int l = listLength-1, m = 0; l >= 0 && m < 10; l--, m++)
  {
    printf("%i\n", sorted[l].num);
  }
}
