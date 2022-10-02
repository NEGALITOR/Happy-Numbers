import java.util.HashSet;
import java.util.Scanner;
import java.util.ArrayList;
import java.lang.Math;

public class HappyNum
{
  private static class structNum
  {
    int num;
    double norm;
  }
  
  public static double rNorm;
  
  public static void main(String[] args)
  {
    Scanner stdin = new Scanner(System.in);
    
    System.out.print("First Argument: ");
    int numOne = stdin.nextInt();
    
    System.out.print("Second Argument: ");
    int numTwo = stdin.nextInt();
    stdin.close();
    
    
    isHappy(numOne, numTwo);
  }
  
  private static void isHappy(int numOne, int numTwo) 
  {         
    structNum normSorted[] = new structNum[10];
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
      
      if(checkHappy(i))
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
    
    if(j == 0)
      System.out.println("NOBODYS HAPPY!");
    else
    {
      for(int k = 0; k < j; k++)
      {
        System.out.println(normSorted[k].num);
        System.out.println(" | " + normSorted[k].norm);
      }
    }
    
  }

  private static boolean checkHappy(int num)
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
    rNorm = Math.sqrt(rNorm);
    return true;
    
  }
  
  private static int searchMin(structNum normSorted[])
  {
    structNum minSt = normSorted[0];
    double minNorm; 
    int location = 0;
    
    for (int i = 0; i < normSorted.length; i++)
    {
      minNorm = Math.min(minSt.norm, normSorted[i].norm);
      
      if (minNorm == normSorted[i].norm)
      {
        minSt = normSorted[i];
        location = i;
      }
    }
    return location;
    
  }
  
  private static void sort(structNum normSorted[], int arrSize)
  {
    for (int i = 0; i < arrSize; i++)
    {
      int index = i;
      
      for (int j = i; j < arrSize; j++)
      {
        if (normSorted[j].norm > normSorted[index].norm)
          index = j;
          
      }
      structNum maxim = normSorted[index];
      normSorted[index] = normSorted[i];
      normSorted[i] = maxim;
      
    }
  
  }
  
  
}