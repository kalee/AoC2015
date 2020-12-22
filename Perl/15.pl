#!/usr/bin/perl
# AdventOfCode2015
# --- Day 15: Science for Hungry People ---
#part1: 21367368
#part1 took 0.00023192310333 ms to execute
#part2: 1766400
#art2 took 0.00047922611236 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;
use constant TEASPOONCNT => 100;

my $start = time();
my %ingredients=();

##### Load Data #####
my $filename = '../data/input-2015-15.txt';
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
#while (<DATA>) {
    chomp;
    my ($name) = /^(\w+):/;
    #print "$name\n";
    my ($capacity) = /capacity (-?\d+),/;
    my ($durability) = /durability (-?\d+),/;
    my ($flavor) = /flavor (-?\d+),/;
    my ($texture) = /texture (-?\d+),/;
    my ($calories) = /calories (-?\d+)$/;
    #print "$speed, $time, $rest\n";
    $ingredients{$name}{CAPACITY}=$capacity;
    $ingredients{$name}{DURABILITY}=$durability;
    $ingredients{$name}{FLAVOR}=$flavor;
    $ingredients{$name}{TEXTURE}=$texture;
    $ingredients{$name}{CALORIES}=$calories;
}
close $fh;

my @keys = sort keys %ingredients;
for my $name (@keys) {
    print "$name|$ingredients{$name}{CAPACITY}|$ingredients{$name}{DURABILITY}|$ingredients{$name}{FLAVOR}|$ingredients{$name}{TEXTURE}|$ingredients{$name}{CALORIES}\n";
}
print "\n";

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
    my @cookie = ();
    my ($capacity, $durability, $flavor, $texture) = 0;
    for (my $butterscotch = 0; $butterscotch < TEASPOONCNT; $butterscotch++) {
        for (my $candy = 0; $candy < TEASPOONCNT - $butterscotch; $candy++) {
            for (my $chocolate = 0; $chocolate < TEASPOONCNT - $butterscotch - $candy; $chocolate++) {
                my $sprinkles = TEASPOONCNT - $butterscotch - $candy - $chocolate;

                $capacity = $ingredients{Butterscotch}{CAPACITY}*$butterscotch + 
                            $ingredients{Candy}{CAPACITY}*$candy + 
                            $ingredients{Chocolate}{CAPACITY}*$chocolate + 
                            $ingredients{Sprinkles}{CAPACITY}*$sprinkles;
                if ($capacity<0) {$capacity=0}

                $durability = $ingredients{Butterscotch}{DURABILITY}*$butterscotch + 
                              $ingredients{Candy}{DURABILITY}*$candy + 
                              $ingredients{Chocolate}{DURABILITY}*$chocolate + 
                              $ingredients{Sprinkles}{DURABILITY}*$sprinkles;
                if ($durability<0) {$durability=0}

                $flavor = $ingredients{Butterscotch}{FLAVOR}*$butterscotch + 
                          $ingredients{Candy}{FLAVOR}*$candy + 
                          $ingredients{Chocolate}{FLAVOR}*$chocolate + 
                          $ingredients{Sprinkles}{FLAVOR}*$sprinkles;
                if ($flavor<0) {$flavor=0}
                $texture = $ingredients{Butterscotch}{TEXTURE}*$butterscotch + 
                           $ingredients{Candy}{TEXTURE}*$candy + 
                           $ingredients{Chocolate}{TEXTURE}*$chocolate + 
                           $ingredients{Sprinkles}{TEXTURE}*$sprinkles;
                if ($texture<0) {$texture=0}

                my $cookieAmount = $capacity * $durability * $flavor * $texture;
                push(@cookie,$cookieAmount);
            }
        }
    }
    my @cookie_sort = sort {$b <=> $a} @cookie;  # descending numerically
    print "part1: $cookie_sort[0]\n";
}


sub part2 {
    my @cookie = ();
    my ($capacity, $durability, $flavor, $texture, $calories) = 0;
    for (my $butterscotch = 0; $butterscotch < TEASPOONCNT; $butterscotch++) {
        for (my $candy = 0; $candy < TEASPOONCNT - $butterscotch; $candy++) {
            for (my $chocolate = 0; $chocolate < TEASPOONCNT - $butterscotch - $candy; $chocolate++) {
                my $sprinkles = TEASPOONCNT - $butterscotch - $candy - $chocolate;

                $capacity = $ingredients{Butterscotch}{CAPACITY}*$butterscotch + 
                            $ingredients{Candy}{CAPACITY}*$candy + 
                            $ingredients{Chocolate}{CAPACITY}*$chocolate + 
                            $ingredients{Sprinkles}{CAPACITY}*$sprinkles;
                if ($capacity<0) {$capacity=0}

                $durability = $ingredients{Butterscotch}{DURABILITY}*$butterscotch + 
                              $ingredients{Candy}{DURABILITY}*$candy + 
                              $ingredients{Chocolate}{DURABILITY}*$chocolate + 
                              $ingredients{Sprinkles}{DURABILITY}*$sprinkles;
                if ($durability<0) {$durability=0}

                $flavor = $ingredients{Butterscotch}{FLAVOR}*$butterscotch + 
                          $ingredients{Candy}{FLAVOR}*$candy + 
                          $ingredients{Chocolate}{FLAVOR}*$chocolate + 
                          $ingredients{Sprinkles}{FLAVOR}*$sprinkles;
                if ($flavor<0) {$flavor=0}
                $texture = $ingredients{Butterscotch}{TEXTURE}*$butterscotch + 
                           $ingredients{Candy}{TEXTURE}*$candy + 
                           $ingredients{Chocolate}{TEXTURE}*$chocolate + 
                           $ingredients{Sprinkles}{TEXTURE}*$sprinkles;
                if ($texture<0) {$texture=0}

                $calories = $ingredients{Butterscotch}{CALORIES}*$butterscotch + 
                            $ingredients{Candy}{CALORIES}*$candy + 
                            $ingredients{Chocolate}{CALORIES}*$chocolate + 
                            $ingredients{Sprinkles}{CALORIES}*$sprinkles;
                if ($calories<0) {$calories=0}

                my $cookieAmount = $capacity * $durability * $flavor * $texture;
                if ($calories == 500) { 
                    push(@cookie,$cookieAmount);
                }
            }
        }
    }
    my @cookie_sort = sort {$b <=> $a} @cookie;  # descending numerically
    print "part2: $cookie_sort[0]\n";
}


__DATA__
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3