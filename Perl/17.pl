#!/usr/bin/perl
# AdventOfCode2015
# --- Day 17: No Such Thing as Too Much ---
#part1: 1638
#part1 took 0.00232420516014 ms to execute
#part2: 17
#part2 took 0.00479134011268 ms to execute

use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;
use constant TOTAL => 150;

my $start = time();
my @values=();
my @results=();

##### Load Data #####
my $filename = '../data/input-2015-17.txt';
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
#while (<DATA>) {
    chomp;
    push @values,$_;
}
close $fh;

#print Dumper(@values);

# Display loaded data
#for my $k1 (sort {$a <=> $b} keys %sue) {
#  for my $k2 (sort keys %{$sue{$k1}}) {
#    print "\$sue{$k1}{$k2}:$sue{$k1}{$k2}\n";
#  }
#}
#print "\n";

part1();
my $end = time();
my $runtime = sprintf("%.16s", ($end - $start)/1000);
print "part1 took $runtime ms to execute\n\n";

part2();
$end = time();
$runtime = sprintf("%.16s", ($end - $start)/1000);
print "part2 took $runtime ms to execute\n";

exit(0);


sub part1 {
  my $counter = 0;
  for (my $i = 1; $i < scalar @values - 1; $i++) {
    my $iter = combinations(\@values, $i);
    while (my $c = $iter->next) {
      my $sum = 0;
      for my $c (@$c) {
        #print "$c  ";
        $sum+= $c;
      }
      #print "\n";
      if ($sum==TOTAL) {
        $counter++;
      }
      
    }
  }
  print "part1: $counter\n";
}


sub part2 {
  my %hash = ();
  my $counter = 0;
  for (my $i = 1; $i < scalar @values - 1; $i++) {
    my $iter = combinations(\@values, $i);
    while (my $c = $iter->next) {
      my $sum = 0;
      my $counter = 0;
      for my $c (@$c) {
        $sum+= $c;
        $counter++;
      }
      if ($sum == TOTAL) {
        if (defined $hash{$counter}) {
          $hash{$counter}++;
        } else {
          $hash{$counter}=1;
        }  
      }
    }
  }
  my @keys = sort {$a <=> $b} keys %hash;
  my $key = $keys[0];
  print "part2: $hash{$key}\n";
}




__DATA__
20
15
10
5
5