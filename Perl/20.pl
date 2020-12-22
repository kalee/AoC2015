#!/usr/bin/perl
# AdventOfCode2015
# --- Day 20: Infinite Elves and Infinite Houses ---
#part1: 776160
#part1 took 8901.669 ms
#part2: 786240
#part2 took 4216.320 ms
#Duration: 13118.125 ms
#
use strict;
use warnings;
no warnings 'uninitialized';

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
my $data = 33100000;
#my $data = 1000;

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
  my $dat = $data / 10;
  my @houses = ($dat);
  my $houseNumber = $dat;

  for (my $i = 1; $i < $dat; $i++) {
    for (my $j = $i; $j < $dat; $j += $i) {
      if (($houses[$j] += $i) >= $dat && $j < $houseNumber) {
        $houseNumber = $j;
      }
    }
  }
  print "part1: ",$houseNumber, "\n";
}


sub part2 {  
  #@data=();
  #seek DATA, $data_start, 0;  # reposition the filehandle right past __DATA__
  #load_data();
  my $dat = $data / 10;
  my @houses = ($dat);
  my $houseNumber = $dat;

  for (my $i = 1; $i < $dat; $i++) {
    my $visits = 0;
    for (my $j = $i; $j < $dat; $j += $i) {
      if (($houses[$j] = ($houses[$j] || 11) + $i * 11) >= $dat * 10 && $j < $houseNumber) {
        $houseNumber = $j;
      }
      $visits++;
      if ($visits == 50) {
        last;
      }
    }
  }
  print "part2: ",$houseNumber, "\n";
}


sub load_data {
  ##### Load Data #####
  #my $filename = '../data/google-20.txt';
  #my $filename = '../data/reddit-20.txt';
  #open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  #while (<$fh>) {
  #while (<DATA>) {
  #  chomp;
  #  push @data,$_;
  #}
}


__DATA__
