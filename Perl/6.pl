my $lights = {};

foreach my $line (@data) {
    chomp $line;
    $line =~ /^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/;
    my $instr = $1;
    my ($x1, $y1) = ($2, $3);
    my ($x2, $y2) = ($4, $5);

    my $x = $x1;

    while ($x <= $x2) {
        my $y = $y1;
        while ($y <= $y2) {
            if ($instr =~ m/on/) {
                $lights->{$x}{$y} = 1;
            }
            if ($instr =~ m/off/) {
                $lights->{$x}{$y} = 0;
            }
            if ($instr =~ m/toggle/) {
                $lights->{$x}{$y} = 0 unless defined $lights->{$x}{$y};
                $lights->{$x}{$y} = 1 - $lights->{$x}{$y};
            }
            $y++;
        }
        $x++;
    }
}

foreach my $x (keys %$lights) {
    foreach my $y (keys %{$lights->{$x}}) {
        $count++ if $lights->{$x}{$y};
    }
}