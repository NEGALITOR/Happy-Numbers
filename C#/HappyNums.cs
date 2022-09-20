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
    List<structNum> normSorted = new List<structNum>();
    double rNorm = 0;
    
    Console.Write("First Argument: ");
    int first = Convert.ToInt32(Console.ReadLine());
    
    Console.Write("Second Argument: ");
    int second = Convert.ToInt32(Console.ReadLine());
    
    isHappy(first, second, normSorted, ref rNorm);
    
    
    /*
    int num = 1;
      List<int> happynums = new List<int>();
  
      while (happynums.Count < 8)
      {
          if (ishappy(num))
          {
              happynums.Add(num);
          }
          num++;
      }
      Console.WriteLine("First 8 happy numbers : " + string.Join(",", happynums));
      */
  }
  
  private static void isHappy(int first, int second, List<structNum> normSorted, ref double rNorm)
  {
    if (first > second)
    {
      int tmp = first;
      first = second;
      second = tmp;
    }
    
    for (int i = first; i <= second; i++)
    {
      rNorm = i*i;
      if (checkHappy(i, normSorted, ref rNorm))
      {
        structNum nSt = new structNum();
        nSt.num = i;
        nSt.norm = rNorm;
        normSorted.Add(nSt);
      }
    }
    
    if (normSorted.Count == 0)
      Console.WriteLine("NOBODY'S HAPPY");
    else
    {
      sort(normSorted);
      for(int k = 0; k < normSorted.Count() && k < 10; k++)
      {
        Console.WriteLine(normSorted[k].num);
      }
    }
    
  }
  
  private static bool checkHappy(int n, List<structNum> normSorted, ref double rNorm)
  {
    List<int> cycle = new List<int>();
    int sum = 0;

    while (n != 1)
    {
      if (cycle.Contains(n))
      {
        return false;
      }
      cycle.Add(n);
      
      while (n != 0)
      {
        int digit = n % 10;
        sum += digit * digit;
        n /= 10;
      }
      n = sum;
      rNorm += (n*n);
      sum = 0;
    }
    rNorm = Math.Sqrt(rNorm);
    return true;            
  }
  
  private static void sort(List<structNum> normSorted)
  {
    for (int i = 0; i < normSorted.Count(); i++)
    {
      int index = i;
      
      for (int j = i; j < normSorted.Count(); j++)
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