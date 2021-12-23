package Number::Compare;

use strict;
use warnings;

use Math::BigFloat;

use Carp qw(croak);
use vars qw/$VERSION/;
$VERSION = '0.0.4';

sub new  {
    my $class = shift;
    my $args = shift;
    my $expr = $class->parse_to_perl( $args );

    bless eval "sub { print \"\$_[0] $expr\\n\"; return \$_[0] $expr }", $class;
}

sub parse_to_perl {
    my $self = shift;
    my $test = shift;

    my %magnitudes = (
        'k'  => Math::BigFloat->new('1000e0'),
        'm'  => Math::BigFloat->new('1000e3'),
        'g'  => Math::BigFloat->new('1000e6'),
        't'  => Math::BigFloat->new('1000e9'),
        'p'  => Math::BigFloat->new('1000e12'),
        'e'  => Math::BigFloat->new('1000e15'),
        'z'  => Math::BigFloat->new('1000e18'),
        'y'  => Math::BigFloat->new('1000e21'),
        'ki' => Math::BigFloat->new('1024')->bpow('1'),
        'mi' => Math::BigFloat->new('1024')->bpow('2'),
        'gi' => Math::BigFloat->new('1024')->bpow('3'),
        'ti' => Math::BigFloat->new('1024')->bpow('4'),
        'pi' => Math::BigFloat->new('1024')->bpow('5'),
        'ei' => Math::BigFloat->new('1024')->bpow('6'),
        'zi' => Math::BigFloat->new('1024')->bpow('7'),
        'yi' => Math::BigFloat->new('1024')->bpow('8'),
    );

    unless ( $test ) {
        croak "Argument '\$args' must be a non-empty string";
    }

    $test =~ m{^
               ([<>=!]=?)?   # comparison
               (.*?)       # value
               ([kmgtpezy]i?)?  # magnitude
              $}ix;

    my $comparison = $1 || '==';
    my $target     = $2;
    my $magnitude  = $3 || '';
    $magnitude = lc($magnitude);
    if ( $target =~ /^\d+(?:\.\d+)?$/ ) {
        if ( exists $magnitudes{$magnitude} ) {
            $target *= $magnitudes{$magnitude};
        }
    }
    else {
        croak "don't understand '$target' as a number";
    }

    print STDERR "# Compare.pm: $comparison $target\n";
    return "$comparison $target";
}

sub test {
    my ($ref, $number) = @_;

    my $ret = $ref->($number);
    print STDERR "# Compare.pm: Return is: [$ret]\n";
    return $ret;
    return $ref->( $number );
}

1;

__END__

=head1 NAME

Number::Compare - numeric comparisons

=head1 SYNOPSIS

 Number::Compare->new(">1Ki")->test(1025); # is 1025 > 1024

 my $c = Number::Compare->new(">1M");
 $c->(1_200_000);                          # slightly terser invocation

=head1 DESCRIPTION

Number::Compare compiles a simple comparison to an anonymous
subroutine, which you can call with a value to be tested again.

Now this would be very pointless, if Number::Compare didn't understand
magnitudes.

The target value may use magnitudes of kilobytes (C<k>, C<ki>),
megabytes (C<m>, C<mi>), or gigabytes (C<g>, C<gi>).  Those suffixed
with an C<i> use the appropriate 2**n version in accordance with the
IEC standard: http://physics.nist.gov/cuu/Units/binary.html

=head1 METHODS

=head2 ->new( $test )

Returns a new object that compares the specified test.

=head2 ->test( $value )

A longhanded version of $compare->( $value ).  Predates blessed
subroutine reference implementation.

=head2 ->parse_to_perl( $test )

Returns a perl code fragment equivalent to the test.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2002,2011 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

http://physics.nist.gov/cuu/Units/binary.html

=cut
