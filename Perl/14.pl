#!/usr/bin/perl
# AdventOfCode2015
# Day 14
#part 1: 2640
#part1 took 2.29959487915039 ms to execute
#
#part 2: 1102
#part2 took 4.81760501861572 ms to execute

use strict;
use warnings;
use Time::HiRes qw( time );
use Data::Dumper;
#use constant MAXTIME => 1000;
use constant MAXTIME => 2503;
use constant FALSE => 0;
use constant TRUE => 1;


my $start = time();
my %reindeer=();

##### Load Data #####
my $filename = '../data/input-2015-14.txt';
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
while (<$fh>) {
#while (<DATA>) {
    chomp;
    #print "$_\n";
    my ($name) = /^(\w+)/;
    #print "$name\n";
    my ($speed, $time, $rest) = /\d+/g;
    #print "$speed, $time, $rest\n";
    $reindeer{$name}{SPEED}=0+$speed;
    $reindeer{$name}{TIME}=0+$time;
    $reindeer{$name}{REST}=0+$rest;
    $reindeer{$name}{DISTANCE}=0;
    $reindeer{$name}{POINTS}=0;
}
close $fh;

#for my $reindeerName (sort keys %reindeer) {
#    print "$reindeerName|$reindeer{$reindeerName}{SPEED}|$reindeer{$reindeerName}{TIME}|$reindeer{$reindeerName}{REST}|$reindeer{$reindeerName}{DISTANCE}|$reindeer{$reindeerName}{POINTS}\n";
#}
#rint "\n";

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
    # Start gathering winners for each second
    my $max=0;
    for my $reindeerName (sort keys %reindeer) {
        my $currentDistance=0;
        my $total=0;
        for (my $currentTime = 0; $currentTime <= MAXTIME; $currentTime++) {
            my $value = $currentTime % ($reindeer{$reindeerName}{TIME} + $reindeer{$reindeerName}{REST});
            my $l1 = ($value <= $reindeer{$reindeerName}{TIME});
            my $l2 = ($value != 0);
            my $isMoving = ($l1 && $l2);
            my $yield = $isMoving?($currentDistance+$reindeer{$reindeerName}{SPEED}):$currentDistance;
            $total+=$yield
        }
        if ($total>$max) {
            $max=$total;
        }
    }
    print "part 1: $max\n";
}

#                SPEED       TIME                              REST
# Dancer can fly 27 km/s for 5 seconds, but then must rest for 132 seconds.
sub part2 {
    my @deerNames = sort keys %reindeer;
    # go for TIME seconds.  Each second, give a point to the reindeer with best cumulative distance.
    for my $currentTime (1 .. MAXTIME) {
        for my $reindeerName (@deerNames) {
            my $value = $currentTime % ($reindeer{$reindeerName}{TIME} + $reindeer{$reindeerName}{REST});
            my $l1 = ($value <= $reindeer{$reindeerName}{TIME});
            my $l2 = ($value != 0);
            my $isMoving = ($l1 && $l2);
            my $yield = $isMoving?$reindeer{$reindeerName}{SPEED}:0;
            $reindeer{$reindeerName}{DISTANCE}+=$yield;
        }

        my $max=0;
        for my $reindeerName (@deerNames) {
            if ($reindeer{$reindeerName}{DISTANCE} > $max) {
                $max = $reindeer{$reindeerName}{DISTANCE};
            }
        }
        
        # If there are multiple reindeer tied for the lead, they each get one point.
        for my $reindeerName (@deerNames) {
            if ($reindeer{$reindeerName}{DISTANCE} == $max) {
                $reindeer{$reindeerName}{POINTS} += 1;
            }
        }

        #for my $reindeerName (@deerNames) {
        #    $reindeer{$reindeerName}{DISTANCE} = 0;
        #}

        #print "$currentTime:";
        #for my $reindeerName (@deerNames) {
        #    print "$reindeerName:$reindeer{$reindeerName}{POINTS}:";
        #}
        #print "\n";
    }

    # Get the reindeer with the max points.
    my $max=0;
    for my $reindeerName (@deerNames) {
        if ($reindeer{$reindeerName}{POINTS} > $max) {
            $max = $reindeer{$reindeerName}{POINTS};
        }
    }
    print "part 2: $max\n";

}


__DATA__
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.