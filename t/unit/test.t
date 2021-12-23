#!perl -w

use strict;
use warnings;

use Test::MockModule;
use Test::More tests => 2;

my $mnuc = Test::MockModule->new('Number::Compare');

{
    my $label = 'Positive test';

    do_mocking();
    my $compare = Number::Compare->new('>=1.2');
    my $result = $compare->test(1.2);
    is( $result, 1, "$label: test() returns 1 when the comparison is true" );

    $result = $compare->test(1.1);
    is( $result, '', "$label: test() returns an empty string when the comparison is false" );
}

sub do_mocking {
    $mnuc->mock(
        'new',
        sub {
            return bless( sub { return $_[0] >= 1.2 }, 'Number::Compare' );
        }
    );
}