#!/usr/bin/perl
# AdventOfCode2015
# --- Day 16: Aunt Sue ---
#part1: 373
#part1 took 1.05748176574707 ms to execute
#part2: 260
#part2 took 1.19378566741943 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;
use constant TEASPOONCNT => 100;

my $start = time();
my %sue=();

##### Load Data #####
my $filename = '../data/input-2015-16.txt';
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
#while (<DATA>) {
    chomp;
    my ($number, $name1, $count1, $name2, $count2, $name3, $count3) = /^Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)$/;
    $sue{$number}{$name1}=$count1;
    $sue{$number}{$name2}=$count2;
    $sue{$number}{$name3}=$count3;
}
close $fh;

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
  my %ans = ();
  $ans{children}=3;
  $ans{cats}=7;
  $ans{samoyeds}=2;
  $ans{pomeranians}=3;
  $ans{akitas}=0;
  $ans{vizslas}=0;
  $ans{goldfish}=5;
  $ans{trees}=3;
  $ans{cars}=2;
  $ans{perfumes}=1;

  for my $k1 (sort {$a <=> $b} keys %sue) {
    my $flag=1;
    for my $k2 (sort keys %{$sue{$k1}}) {
      if ($sue{$k1}{$k2} == $ans{$k2}) {
        $flag = ($flag && 1);
      } else {
        $flag = ($flag && 0);
      }
    }
    if ($flag == 1) {
      print "part1: $k1\n";
    }
  }
}


sub part2 {
  my %ans = ();
  $ans{children}=3;
  $ans{cats}=7;
  $ans{samoyeds}=2;
  $ans{pomeranians}=3;
  $ans{akitas}=0;
  $ans{vizslas}=0;
  $ans{goldfish}=5;
  $ans{trees}=3;
  $ans{cars}=2;
  $ans{perfumes}=1;

  for my $k1 (sort {$a <=> $b} keys %sue) {
    my $flag=1;
    for my $k2 (sort keys %{$sue{$k1}}) {
      if ($k2 eq "trees" or $k2 eq "cats") {
        if ($sue{$k1}{$k2} > $ans{$k2}) {
          $flag = ($flag && 1);
        } else {
          $flag = ($flag && 0);
        }
      } elsif ($k2 eq "pomeranians" or $k2 eq "goldfish") {
        if ($sue{$k1}{$k2} < $ans{$k2}) {
          $flag = ($flag && 1);
        } else {
          $flag = ($flag && 0);
        }
      } else {
        if ($sue{$k1}{$k2} == $ans{$k2}) {
          $flag = ($flag && 1);
        } else {
          $flag = ($flag && 0);
        }
      }
    }
    if ($flag == 1) {
      print "part2: $k1\n";
    }
  }
}


__DATA__
