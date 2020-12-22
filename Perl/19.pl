#!/usr/bin/perl
# AdventOfCode2015
# --- Day 19: Medicine for Rudolph ---
#part1: 509
#part1 took 12.03513 ms
#part2 195
#part2 took 14.23406 ms
#Duration: 26.3 ms
#
use strict;
use warnings;
no warnings 'uninitialized';

use List::Util qw/shuffle/;
use Time::HiRes qw/gettimeofday tv_interval time/;
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;
use constant DEBUG => 0;

my $start_time = [gettimeofday];
END { print "Duration: ", tv_interval($start_time)*1000, " ms\n"; }

my $data_start = tell DATA;
my $start = 0;
my $end = 0;
my $runtime = 0;

#my @data = ();
my %hash = ();
my $medicinemolecule="";


$start = time();
part1();
$end = time();
$runtime = sprintf("%.8s", ($end - $start)*1000);
print "part1 took $runtime ms\n";

$start = time();
part2();
$end = time();
$runtime = sprintf("%.8s", ($end - $start)*1000);
print "part2 took $runtime ms\n";

exit(0);



sub part1 {
  %hash=();
  $medicinemolecule="";  
  load_data();

  my %results = ();
  while (my ($key, $value) = each (%hash)) {
    while ($medicinemolecule =~ /$value/g) {
      my $len=$+[0]-$-[0];
      my $temp=$medicinemolecule;
      substr($temp,$-[0],$len,$key);
      $results{$temp}=1;
    }
  }
  my @keys = (keys %results);
  print "part1: ",~~@keys,"\n";
}


sub part2 {
  %hash=();
  $medicinemolecule="";  
  seek DATA, $data_start, 0;  # reposition the filehandle right past __DATA__
  load_data();


  # Non-deterministic (randomized trials), with each trial being greedy.
  # Consider the ordered list of mappings: k_0 => v_0, k_1 => v_1, k_2 => v_2, etc.
  # First, try to substitute all instances of k_0. If there are none left, try k_1.
  # If we found any, go back and try k_0 again (because the v_1s may have caused new
  # instances of k_0 in the string). I.e., every time we make a successful replacement,
  # we start again from k_0. If we exhaust all the k_i, and still haven't reached the
  # target, shuffle the order and start all over. Should succeed sooner or later.
  # Also, go from the long medicine molecule down to "e", instead of the other way around.
  my ($s, $n) = "";
  my @map = ();
  while (my ($key, $value) = each (%hash)) {
    push @map, [$value, $key];
  }

  while ($s ne "e") {
    @map = shuffle @map;
    ($n, $s) = (0, $medicinemolecule);
    for (my $i = 0; $i < @map; ++$i) {
      my ($key, $val) = @{$map[$i]};
      if (my $tmp = $s =~ s/$val/$key/g) {
        $n += $tmp;
        $i = -1;
      }
    }
  }
  print "part2 ",$n, "\n";
}



sub load_data {
  %hash = ();
  ##### Load Data #####
  my $filename = '../data/input-2015-19.txt';
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  while (<$fh>) {
  #while (<DATA>) {
    chomp;
    if (/=>/) {  
      my ($element, $molecule) = /^(\w+) => (\w+)$/;
      $hash{$molecule} = $element;
    } elsif (length($_)> 1) {
      $medicinemolecule = $_;
    }
  }
  close $fh;
}


__DATA__
H => HO
H => OH
O => HH

HOH