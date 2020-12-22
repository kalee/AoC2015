#!/usr/bin/env perl

use warnings;
use strict;
use v5.20;

my %values;

for (<>) {
  die unless /(.*?) -> (\w+)/;
  $values{$2} = $1;
}

say calculate('a');

sub calculate {
  my $target = shift;
  return $target if $target =~ /^\d+$/;

  die $target unless exists $values{$target};

  my $rule = $values{$target};

  my $result;
  if ($rule =~ /^\d+$/) {
	 return $rule;
  } elsif ($rule =~ /(\w+) AND (\w+)/) {
	 my ($op1, $op2) = ($1, $2);
	 $result = calculate($op1) & calculate($op2);
  } elsif ($rule =~ /(\w+) OR (\w+)/) {
	 my ($op1, $op2) = ($1, $2);
	 $result = calculate($op1) | calculate($op2);
  } elsif ($rule =~ /(\w+) LSHIFT (\d+)/) {
	 my ($op1, $op2) = ($1, $2);
	 $result = calculate($op1) << $op2;
  } elsif ($rule =~ /(\w+) RSHIFT (\d+)/) {
	 my ($op1, $op2) = ($1, $2);
	 $result = calculate($op1) >> $op2;
  } elsif ($rule =~ /NOT (\w+)/) {
	 my $op = $1;
	 $result = ~calculate($op);
  } elsif (exists $values{$rule}) {
	 $result = calculate($rule);
  } else {
	 die $rule;
  }
  $values{$target} = $result & 0xFFFF;
}