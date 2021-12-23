#!perl -w

use strict;
use warnings;

use Scalar::Util qw(reftype);
use Test::Exception;
use Test::More tests => 3;
use Test::MockModule;

my $mnuc = Test::MockModule->new('Number::Compare');

{
    my $label = 'Positive test';

    do_mocking();
    my $args = '>=1.2';
    my $compare = Number::Compare->new($args);

    is( ref($compare), 'Number::Compare', "$label: new() returns a blessed ref when given valid arguments" );
    is( reftype($compare), 'CODE', "$label: new() returns a blessed coderef when given valid arguments" );
}

{
    my $label = 'Negative test';

    do_mocking();
    my $args;

    throws_ok {
        Number::Compare->new($args);
    } qr/^Argument '\$args' must be a non-empty string/, "$label: new() throws an exception when given no arguments";
}

sub do_mocking {
    $mnuc->mock(
        'parse_to_perl',
        sub {
            my $self = shift;
            my $test = shift;

            unless ( $test ) {
                die "Argument '\$args' must be a non-empty string";
            }
            return '== 1';
        }
    );
}