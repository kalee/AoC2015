#!/usr/bin/perl
# AdventOfCode2015
# --- Day 21: RPG Simulator 20XX ---
#
#
#
#
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

my %data = ();

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
  %data=();
  load_data();

  my %weapons = {
    "dagger", { cost: 8, damage: 4, armor: 0 },
    "shortsword", { cost: 10, damage: 5, armor: 0 },
    "warhammer", { cost: 25, damage: 6, armor: 0 },
    "longsword", { cost: 40, damage: 7, armor: 0 },
    "greataxe", { cost: 74, damage: 8, armor: 0 },
  };

  my %armor = {
    ["nothing", { cost: 0, damage: 0, armor: 0 }],
    ["leather", { cost: 13, damage: 0, armor: 1 }],
    ["chainmail", { cost: 31, damage: 0, armor: 2 }],
    ["splintmail", { cost: 53, damage: 0, armor: 3 }],
    ["bandedmail", { cost: 75, damage: 0, armor: 4 }],
    ["platemail", { cost: 102, damage: 0, armor: 5 }],
  };

  my %rings = {
    ["nothing", { cost: 0, damage: 0, armor: 0 }],
    ["damage+1", { cost: 25, damage: 1, armor: 0 }],
    ["damage+2", { cost: 50, damage: 2, armor: 0 }],
    ["damage+3", { cost: 100, damage: 3, armor: 0 }],
    ["defense+1", { cost: 20, damage: 0, armor: 1 }],
    ["defense+2", { cost: 40, damage: 0, armor: 2 }],
    ["defense+3", { cost: 80, damage: 0, armor: 3 }],
  };

  my %boss = {
    ["damage", 8],
    ["armor", 2],
    ["health", 100],
  };

  my %player = {
    ["damage", 0],
    ["armor", 0],
    ["health", 100],
  };
  print Dumper(%player),"\n";

  #print "part1: ","\n";
}


sub part2 {  # 48447, too low; needs to be 52069
  # waypoint is fixed.  10 units east, 1 unit north, fixed.
  %data=();
  seek DATA, $data_start, 0;  # reposition the filehandle right past __DATA__
  load_data();


  print "part2: ","\n";
}


sub load_data {
  ##### Load Data #####
  my $filename = '../data/input-1015-21.txt';
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  #while (<$fh>) {
  while (<DATA>) {
    chomp;
    if (/^(Hit Points): (\d+)$/) {
      $hash{$1}=$2;
    }
    if (/^(Damage): (\d+)$/) {
      $hash{$1}=$2;
    }
    if (/^(Armor): (\d+)$/) {
      $hash{$1}=$2;
    }
  }
}


__DATA__
Hit Points: 104
Damage: 8
Armor: 1
