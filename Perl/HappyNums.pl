#!/usr/bin/perl

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
    #print($i."\n");
    if(checkHappy($i, $rNorm))
    {
      #print($i." ".$rNorm."\n");
      my $nSt = structNum->new();
      $nSt->num($i);
      $nSt->norm($rNorm);
      
      #print(scalar @normSorted);
      

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
      
      #print(scalar @normSorted);
      
    }
  }  
  

  #printNums(scalar @normSorted, @normSorted);
  @normSorted = sortNorm(@normSorted);
  
  #print($normSorted[0]->num."\n");
  #printNums(@normSorted);
  
  if (scalar @normSorted == 0)
  {
    print("NOBODYS HAPPY!\n")
  }
  else
  {
    printNums(@normSorted);
  }
}

sub checkHappy()
{
  my $num = $_[0];
  #my $rNorm = $_[1];
  my $digit, my $sum;
  
  #print($num." ".$rNorm."\n");
  
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
    #print($num." ".$rNorm."\n");
  }
  $_[1] = sqrt($_[1]);
  #print($rNorm."\n");
  return 1;
}

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

sub sortNorm()
{
  my @normSorted = @_;
  my $maxim;
  

  
  for (my $i = 0; $i < scalar @normSorted; $i++)
  {
    my $index = $i;
    
    for (my $j = $i; $j < scalar @normSorted; $j++)
    {
      #printf("i: %d | j: %d | sortSize: %d\n", $i, $j, scalar @normSorted);
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

sub printNums()
{
  my @normSorted = @_;
  
  #print($normSorted[0]->num);

  for (my $i = 0; $i < scalar @normSorted; $i++)
  {
    print($normSorted[$i]->num."\n");
  }
}


main();
