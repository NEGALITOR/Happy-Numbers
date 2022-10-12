# Project - Happy Numbers

This is the Happy Number Project for CSC 330. It will be programmed in Java, C, C#, Go, Python, Perl, Fortran, Lisp

## How to Compile and Run
###### Java
> javac HappyNums.java  
> java HappyNums

###### C#
> mcs HappyNums.cs  
> mono HappyNums.exe

###### Python
> python3 HappyNums.py

###### C
> gcc HappyNums.c  
> ./a.out

###### Go
> go run HappyNums.go

###### Perl
> chmod u+x HappyNums.pl  
> ./HappyNums.pl

###### Fortran
> gfortran HappyNums.f95  
> ./a.out

###### Lisp
> chmod u+x HappyNums.lisp  
> ./HappyNums.lisp

## Algorithms
> isHappy()  
Initializes the normSorted array of size 10  
Switches numOne and numTwo if numOne is bigger than numTwo  
Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not  
Creates a structNum given the norm and happy number when it returns true from checkHappy  
Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin  
Sorts and Prints at the end

> checkHappy()  
Checks whether a value passed through is Happy or Unhappy  
Checks if a value is 1 or 4 every passthrough to determine if happy or unhappy  
Goes through each digit and adds it to the sum after being squared and reassigns it back to num  
Calculates norm of value after determining if happy or not  
Returns true if num == 1 and false if num == 4

> searchMin()  
Searches through array for the lowest norm and returns the location of the array

> sortNorm()  
Insertion sort through norms from greatest to least

>printNums()  
Prints all nums in array
