/*
  * Compiling
  * mcs HappyNums.cs
  * mono HappyNums.exe
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

class HappyNums
{
  public struct structNum
  {
    public int num;
    public double norm;
  }
  
  static void Main(string[] args)
  {    
    Console.Write("First Argument: ");
    int numOne = Convert.ToInt32(Console.ReadLine());
    
    Console.Write("Second Argument: ");
    int numTwo = Convert.ToInt32(Console.ReadLine());
    
    isHappy(numOne, numTwo);
    
    
    
  }
  
/*
  * Initializes the normSorted array of size 10
  * Switches numOne and numTwo if numOne is bigger than numTwoi
  * Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not
  * Creates a structNum given the norm and happy number when it returns true from checkHappy
  * Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin
  * Sorts and Prints at the end
*/
  private static void isHappy(int numOne, int numTwo)
  {
  
    structNum[] normSorted = new structNum[10];
    double rNorm = 0;
    int j = 0;
  
    if (numOne > numTwo)
    {
      int tmp = numOne;
      numOne = numTwo;
      numTwo = tmp;
    }
    
    for (int i = numOne; i <= numTwo; i++)
    {
      rNorm = i*i;
      
      if (checkHappy(i, ref rNorm))
      {
        structNum nSt = new structNum();
        nSt.num = i;
        nSt.norm = rNorm;
        
        if (j < 10)
        {
          normSorted[j] = nSt;
          j++;
        }
        else
        {
          int location = searchMin(normSorted);
          
          if (j >= 10 && rNorm > normSorted[location].norm)
          {
            normSorted[location] = nSt;
          }
        }
      }
    }
    
    sort(normSorted, j);
    
    if (j == 0)
      Console.WriteLine("NOBODYS HAPPY!");
    else
    {
      for(int k = 0; k < j; k++)
      {
        Console.WriteLine(normSorted[k].num);
      }
    }
    
  }
  
/*
  * Checks whether a value passed through is Happy or Unhappy
  * Checks if a value is 1 or 4 every passthrough to determine if happy or unhappy
  * Goes through each digit and adds it to the sum after being squared and reassigns it back to num
  * Calculates norm of value after determining if happy or not
  * Returns true if num == 1 and false if num == 4
*/
  private static bool checkHappy(int num, ref double rNorm)
  {
    int sum = 0, digit;
    
    while (num != 1)
    {
      if (num == 4)
        return false;
        
      while (num != 0)
      {
        digit = num % 10;
        sum += (digit*digit);
        num /= 10;
      }
      
      num = sum;
      rNorm += (num*num);
      sum = 0;
    }
    rNorm = Math.Sqrt(rNorm);
    return true;
  }
  
  //Searches through array for the lowest norm and returns the location of the array
  private static int searchMin(structNum[] normSorted)
  {
    structNum minSt = normSorted[0];
    double minNorm;
    int location = 0;
    
    for (int i = 0; i < normSorted.Length; i++)
    {
      minNorm = Math.Min(minSt.norm, normSorted[i].norm);
      
      if (minNorm == normSorted[i].norm)
      {
        minSt = normSorted[i];
        location = i;
      }
      
    }
    return location;
    
  }
  
  //Insertion sort through norms from greatest to least
  private static void sort(structNum[] normSorted, int arrSize)
  {
    for (int i = 0; i < arrSize; i++)
    {
      int index = i;
      
      for (int j = i; j < arrSize; j++)
      {
        if (normSorted[j].norm > normSorted[index].norm)
          index = j;
          
      }
      structNum max = normSorted[index];
      normSorted[index] = normSorted[i];
      normSorted[i] = max;
      
    }
  
  }
    
}