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
  
  public static double norm;
  
  public static void main(String[] args)
  {
    Scanner stdin = new Scanner(System.in);
    ArrayList<structNum> normSorted = new ArrayList<structNum>();
    
    System.out.print("First Argument: ");
    int first = stdin.nextInt();
    
    System.out.print("Second Argument: ");
    int second = stdin.nextInt();
    stdin.close();
    
    
    
    isHappy(first, second, normSorted);
  }
  
  private static void isHappy(int first, int second, ArrayList<structNum> normSorted) 
  {              
    if (first > second)
    {
      int tmp = first;
      first = second;
      second = tmp;
      
    }
    
    
    for (int i = first; i <= second; i++)
    {
      norm = i*i;
      if(checkHappy(i, normSorted))
      {
        structNum nSt = new structNum();
        nSt.num = i;
        nSt.norm = norm;
        normSorted.add(nSt);
        
      }           
    }    
    
    if(normSorted.isEmpty())
      System.out.println("NOBODY'S HAPPY");
    else
    {
      sort(normSorted);
      for(int k = 0; k < normSorted.size() && k < 10; k++)
      {
        System.out.println(normSorted.get(k).num);
        
      }
    }
  }

  private static boolean checkHappy(long number, ArrayList<structNum> normSorted) //Comes from Rosetta Code
  {
    long m = 0;
    int digit = 0;
    HashSet<Long> cycle = new HashSet<Long>();
    
    while (number != 1 && cycle.add(number))
    {
      m = 0;
      
      while (number > 0)
      {
        digit = (int)(number % 10);
        m += digit * digit;
        number /= 10;
    
      }
      number = m;
      norm += (number*number);

    }
    norm = Math.sqrt(norm);
    
    return number == 1;
    
  }
  
  
  
  private static void sort(ArrayList<structNum> normSorted)
  {
    for (int i = 0; i < normSorted.size(); i++)
    {
      int index = i;
      
      for (int j = i; j < normSorted.size(); j++)
      {
        if (normSorted.get(j).norm > normSorted.get(index).norm)
          index = j;
          
      }
      structNum max = normSorted.get(index);
      normSorted.set(index, normSorted.get(i));
      normSorted.set(i, max);
      
    }
  
  }
  
  
}