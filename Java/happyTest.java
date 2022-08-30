import java.util.HashSet;
public class happyTest{
   public static boolean happy(long number){
       //System.out.print(number + " ");
       long m = 0;
       int digit = 0;
       HashSet<Long> cycle = new HashSet<Long>();
       while(number != 1 && cycle.add(number)){
           m = 0;
           while(number > 0){
               //System.out.print(number + " ");
               digit = (int)(number % 10);
               //System.out.print(digit + " ");
               //System.out.print(m + " ");
               m += digit*digit;
               number /= 10;
           }
           number = m;
           //System.out.print(number + " ");
       }
       //System.out.print(number + " ");
       return number == 1;
   }

   public static void main(String[] args){
       for(long num = 10, count = 0; count < 10; num++){
           if(happy(num)){
               System.out.println("\n" + num);
               count++;
           }
       }
   }
}