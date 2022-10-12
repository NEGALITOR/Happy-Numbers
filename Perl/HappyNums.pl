#!/usr/bin/perl

#----------------------------------------------------------------------------------------------------------------------------------
# Compiling
# chmod u+x HappyNums.pl
# ./HappyNums.pl
#----------------------------------------------------------------------------------------------------------------------------------

use strict;
use warnings;
use Class::Struct;
use List::Util qw(min);

struct structNum =>
{
	num => '$',
	norm => '$',
};

sub main
{
  print("First Argument: ");
  my $numOne = <>;
  print("Second Argument: ");
  my $numTwo = <>;
  
  isHappy(int($numOne), int($numTwo));
  
}

#----------------------------------------------------------------------------------------------------------------------------------
# Initializes the normSorted array of size 10
# Switches numOne and numTwo if numOne is bigger than numTwoi
# Runs a for-loop where it iterates from numOne to numTwo to determine if a value is a Happy Number or not
# Creates a structNum given the norm and happy number when it returns true from checkHappy
# Fills array with happy numbers till size 10. If size exceeds 10, find lowest norm in array and replace it with searchMin
# Sorts and Prints at the end
#----------------------------------------------------------------------------------------------------------------------------------
sub isHappy()
{
  my @normSorted = ();
  my $numOne = $_[0];
  my $numTwo = $_[1];
  my $rNorm = 0;
  my $tmp; my $j = 0; my $location = 0;
  
  if ($numOne > $numTwo)
  {
      $tmp = $numOne;
      $numOne = $numTwo;
      $numTwo = $tmp;
  }
  
  for (my $i = $numOne; $i <= $numTwo; $i++)
  {
    $rNorm = $i*$i;
    if(checkHappy($i, $rNorm))
    {
      my $nSt = structNum->new();
      $nSt->num($i);
      $nSt->norm($rNorm);
      

      if ($j < 10)
      {
        push(@normSorted, $nSt);
        $j++;
      }
      else
      {
        $location = searchMin(@normSorted);
        
        if ($j >= 10 && $rNorm > $normSorted[$location]->norm)
        {
          $normSorted[$location] = $nSt;
        }
        
      }
      
    }
  }  
  
  @normSorted = sortNorm(@normSorted);
  
  if (scalar @normSorted == 0)
  {
    print("NOBODYS HAPPY!\n")
  }
  else
  {
    printNums(@normSorted);
  }
}

#----------------------------------------------------------------------------------------------------------------------------------
# Checks whether a value passed through is Happy or Unhappy
# Checks if a value is 1 or 4 every passthrough to determine if happy or unhappy
# Goes through each digit and adds it to the sum after being squared and reassigns it back to num
# Calculates norm of value after determining if happy or not
# Returns true if num == 1 and false if num == 4
#----------------------------------------------------------------------------------------------------------------------------------
sub checkHappy()
{
  my $num = $_[0];
  my $digit, my $sum;
  
  while ($num != 1)
  {
    if ($num == 4)
    { 
      return;
    }
    
    while ($num != 0)
    {
      $digit = $num % 10;
      $sum += ($digit*$digit);
      $num /= 10;
      
    }
    
    $num = $sum;
    $_[1] += ($num*$num);
    $sum = 0;
  }
  $_[1] = sqrt($_[1]);
  return 1;
}

#----------------------------------------------------------------------------------------------------------------------------------
# Searches through array for the lowest norm and returns the location of the array
#----------------------------------------------------------------------------------------------------------------------------------
sub searchMin()
{
  my @normSorted = @_;
  my $minSt = $normSorted[0];
  
  my $minNorm = 0; my $location = 0;
  
  
  for (my $i = 0; $i < scalar @normSorted; $i++)
  {
    
    $minNorm = min($minSt->norm, $normSorted[$i]->norm);
    
    if ($minNorm == $normSorted[$i]->norm)
    {
      $minSt = $normSorted[$i];
      $location = $i;
    }
  }
  return $location;
}


#----------------------------------------------------------------------------------------------------------------------------------
# Insertion sort through norms from greatest to least
#----------------------------------------------------------------------------------------------------------------------------------
sub sortNorm()
{
  my @normSorted = @_;
  my $maxim;
  
  for (my $i = 0; $i < scalar @normSorted; $i++)
  {
    my $index = $i;
    
    for (my $j = $i; $j < scalar @normSorted; $j++)
    {
      if ($normSorted[$j]->norm > $normSorted[$index]->norm)
      {
        $index = $j;
      }
    }
    
    $maxim = $normSorted[$index];
    $normSorted[$index] = $normSorted[$i];
    $normSorted[$i] = $maxim;
  }
  return @normSorted;
}

#----------------------------------------------------------------------------------------------------------------------------------
# Prints all nums in array
#----------------------------------------------------------------------------------------------------------------------------------
sub printNums()
{
  my @normSorted = @_;

  for (my $i = 0; $i < scalar @normSorted; $i++)
  {
    print($normSorted[$i]->num."\n");
  }
}


main();
