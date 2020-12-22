#!/usr/bin/perl
# AdventOfCode2019
# --- Day 18: Like a GIF For Your Yard ---
# part1: 768
# part2: 781
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;

my $start = time();
my %points = ();
my %point1 = ();
my %point2 = ();
my $row = 0;
my $col = 0;

# Display loaded data
#print Dumper(%points), $col, " ", $row, "\n";


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
  load_data();
  #print "\$col:$col|\$row:$row\n";

  # key is in form "($col" . "," . "$row)";
  # Calculate the results
  my @keys = sort keys %points;
  #print "Keys: ",Dumper(@keys),"\n";

  for (0 .. 99) {
  #for (0 .. 3) {  
    #print_state();
    #print "Step: ",$_+1,"\n";
    if ($_%2) { #odd
      %point1 = ();
    } else {
      %point2 = ();
    }
    for my $key (@keys) {
      my ($col) = $key =~ /\((\d+),/;
      my ($row) = $key =~ /,(\d+)\)/;
      if ($_%2) { #odd
        $point1{$key}=calculate_state($col,$row,$points{$key});
      } else {
        $point2{$key}=calculate_state($col,$row,$points{$key});
      }
    }
    if ($_%2) { #odd @small_hash{ keys %small_hash } = @big_hash{ keys %small_hash };
      @points{ keys %points } = @point1{ keys %points };
      %point1 = ();
    } else {
      @points{ keys %points } = @point2{ keys %points };
      %point2 = ();
    }
  }
  #print_state();
  # Sum Results 
  my $counter = 0;
  for my $key (@keys) {
    $counter++ if $points{$key};
  }

  # Display Results  
  print "part1: $counter\n";
}


sub part2 {
  load_data();
  #print "\$col:$col-1|\$row:$row-1\n";  # to be less confusing, display in 0 based counting

  # key is in form "($col" . "," . "$row)";
  # Calculate the results
  my @keys = sort keys %points;
  #print "Keys: ",Dumper(@keys),"\n";

  #print_state();
  for (0 .. 99) {
  #for (0 .. 4) {  
    #print "Step: ",$_+1,"\n";
    if ($_%2) { #odd
      %point1 = ();
    } else {
      %point2 = ();
    }
    for my $key (@keys) {
      my ($co) = $key =~ /\((\d+),/;
      my ($ro) = $key =~ /,(\d+)\)/;
      #print "\$co:$co|\$col:",$col-1,"|\$ro:$ro|\$row:",$row-1,"\n";
      if (($co==0 || $co==$col-1) && ($ro==0 || $ro==$row-1)) {
        my $k="($co" . "," . "$ro)";
        #print "edge case: We dont touch key:",$k,"\n";
        if ($_%2) { #odd
          $point1{$key}=1;
        } else {
          $point2{$key}=1;
        }
      } else {
        if ($_%2) { #odd
          $point1{$key}=calculate_state($co,$ro,$points{$key});
        } else {
          $point2{$key}=calculate_state($co,$ro,$points{$key});
        }
      }
    }
    if ($_%2) { #odd @small_hash{ keys %small_hash } = @big_hash{ keys %small_hash };
      @points{ keys %points } = @point1{ keys %points };
      %point1 = ();
    } else {
      @points{ keys %points } = @point2{ keys %points };
      %point2 = ();
    }

    #print_state();
  }


  # Sum Results 
  my $counter = 0;
  for my $key (@keys) {
    $counter++ if $points{$key};
  }

  # Display Results  
  print "part2: $counter\n";
}

sub calculate_state {
  my ($x,$y,$state) = @_;
  #key is in form "($col" . "," . "$row)";

  my $counter = 0;
  # Check eight states
  #1 left
  my $a=$x-1;
  my $b=$y;
  my $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #2 upper left
  $a=$x-1;
  $b=$y-1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #3 up 
  $a=$x;
  $b=$y-1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #4 upper right
  $a=$x+1;
  $b=$y-1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #5 right
  $a=$x+1;
  $b=$y;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #6 lower right
  $a=$x+1;
  $b=$y+1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #7 down
  $a=$x;
  $b=$y+1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  #8 lower left
  $a=$x-1;
  $b=$y+1;
  $key = "($a" . "," . "$b)";
  if (defined $points{$key} && $points{$key}==1) {
    #print "\$points{($key}:$points{$key}\n";  
    $counter++;
  }
  

  if ($state) {
    if ($counter==2 || $counter==3) {
      #print "ON:\$x:$x|\$y:$y|\$state:$state|\$counter:$counter\n";
      return 1;
    } else {
      #print "OFF:\$x:$x|\$y:$y|\$state:$state|\$counter:$counter\n";
      return 0;
    }
  }

  unless ($state) {
    if ($counter==3) {
      #print "ON:\$x:$x|\$y:$y|\$state:$state|\$counter:$counter\n";
      return 1;
    } else {
      #print "OFF:\$x:$x|\$y:$y|\$state:$state|\$counter:$counter\n";
      return 0;
    }
  }
  print "Error - no return value\n";
}


sub print_state {
  for my $i (0..$row-1) {
    for my $j (0..$col-1) {
      my $key = "($j" . "," . "$i)";
      if ($points{$key}) {
        print "#";
      } else {
        print ".";
      }
    }
    print "\n";
  }
  print "\n";
}


sub load_data {
  %points = ();
  %point1 = ();
  %point2 = ();
  $row=0;
  $col=0;
  ##### Load Data #####
  my $filename = '../data/input-2015-18.txt';
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  while (<$fh>) {
  #while (<DATA>) {
      chomp;
      my @data = split '', $_;
      for my $data (@data) {
          my $colrow = "($col" . "," . "$row)";
          if ($data eq '#') {
              $points{$colrow}=1;
          } else {
              $points{$colrow}=0;
          }
          $col += 1;
      }
      $col = 0;
      $row += 1;
  }
  close $fh;
}


__DATA__
##.#.#
...##.
#....#
..#...
#.#..#
####.#