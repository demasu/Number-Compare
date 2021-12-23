#!perl -w

use strict;
use warnings;

use Number::Compare;
use Test::Exception;
use Test::More;

my @tests = (
    {
        '1.0' => {
            'expected' => '== 1.0',
            'description' => 'implicit equal to without a suffix',
        },
    },
    {
        '>=1.0' => {
            'expected'    => '>= 1.0',
            'description' => 'greater than or equal to without a suffix',
        },
    },
    {
        '<=1.0' => {
            'expected'    => '<= 1.0',
            'description' => 'less than or equal to without a suffix',
        },
    },
    {
        '>1.0' => {
            'expected'    => '> 1.0',
            'description' => 'greater than without a suffix',
        },
    },
    {
        '<1.0' => {
            'expected'    => '< 1.0',
            'description' => 'less than without a suffix',
        },
    },
    {
        '==1.0' => {
            'expected' => '== 1.0',
            'description' => 'equal to without a suffix',
        },
    },
    {
        '>=1.0k' => {
            'expected'    => '>= 1000',
            'description' => 'greater than or equal to with a "k" suffix',
        },
    },
    {
        '<=1.0k' => {
            'expected'    => '<= 1000',
            'description' => 'less than or equal to with a "k" suffix',
        },
    },
    {
        '>1.0k' => {
            'expected'    => '> 1000',
            'description' => 'greater than with a "k" suffix',
        },
    },
    {
        '<1.0k' => {
            'expected'    => '< 1000',
            'description' => 'less than with a "k" suffix',
        },
    },
    {
        '==1.0k' => {
            'expected' => '== 1000',
            'description' => 'equal to with a "k" suffix',
        },
    },
    {
        '>=1.0M' => {
            'expected'    => '>= 1000000',
            'description' => 'greater than or equal to with an "M" suffix',
        },
    },
    {
        '<=1.0M' => {
            'expected'    => '<= 1000000',
            'description' => 'less than or equal to with an "M" suffix',
        },
    },
    {
        '>1.0M' => {
            'expected'    => '> 1000000',
            'description' => 'greater than with an "M" suffix',
        },
    },
    {
        '<1.0M' => {
            'expected'    => '< 1000000',
            'description' => 'less than with an "M" suffix',
        },
    },
    {
        '==1.0M' => {
            'expected' => '== 1000000',
            'description' => 'equal to with an "M" suffix',
        },
    },
    {
        '>=1.0G' => {
            'expected'    => '>= 1000000000',
            'description' => 'greater than or equal to with a "G" suffix',
        },
    },
    {
        '<=1.0G' => {
            'expected'    => '<= 1000000000',
            'description' => 'less than or equal to with a "G" suffix',
        },
    },
    {
        '>1.0G' => {
            'expected'    => '> 1000000000',
            'description' => 'greater than with a "G" suffix',
        },
    },
    {
        '<1.0G' => {
            'expected'    => '< 1000000000',
            'description' => 'less than with a "G" suffix',
        },
    },
    {
        '==1.0G' => {
            'expected' => '== 1000000000',
            'description' => 'equal to with a "G" suffix',
        },
    },
    {
        '>=1.0T' => {
            'expected'    => '>= 1000000000000',
            'description' => 'greater than or equal to with a "T" suffix',
        },
    },
    {
        '<=1.0T' => {
            'expected'    => '<= 1000000000000',
            'description' => 'less than or equal to with a "T" suffix',
        },
    },
    {
        '>1.0T' => {
            'expected'    => '> 1000000000000',
            'description' => 'greater than with a "T" suffix',
        },
    },
    {
        '<1.0T' => {
            'expected'    => '< 1000000000000',
            'description' => 'less than with a "T" suffix',
        },
    },
    {
        '==1.0T' => {
            'expected' => '== 1000000000000',
            'description' => 'equal to with a "T" suffix',
        },
    },
    {
        '>=1.0P' => {
            'expected'    => '>= 1000000000000000',
            'description' => 'greater than or equal to with a "P" suffix',
        },
    },
    {
        '<=1.0P' => {
            'expected'    => '<= 1000000000000000',
            'description' => 'less than or equal to with a "P" suffix',
        },
    },
    {
        '>1.0P' => {
            'expected'    => '> 1000000000000000',
            'description' => 'greater than with a "P" suffix',
        },
    },
    {
        '<1.0P' => {
            'expected'    => '< 1000000000000000',
            'description' => 'less than with a "P" suffix',
        },
    },
    {
        '==1.0P' => {
            'expected' => '== 1000000000000000',
            'description' => 'equal to with a "P" suffix',
        },
    },
    {
        '>=1.0E' => {
            'expected'    => '>= 1000000000000000000',
            'description' => 'greater than or equal to with an "E" suffix',
        },
    },
    {
        '<=1.0E' => {
            'expected'    => '<= 1000000000000000000',
            'description' => 'less than or equal to with an "E" suffix',
        },
    },
    {
        '>1.0E' => {
            'expected'    => '> 1000000000000000000',
            'description' => 'greater than with an "E" suffix',
        },
    },
    {
        '<1.0E' => {
            'expected'    => '< 1000000000000000000',
            'description' => 'less than with an "E" suffix',
        },
    },
    {
        '==1.0E' => {
            'expected' => '== 1000000000000000000',
            'description' => 'equal to with an "E" suffix',
        },
    },
    {
        '>=1.0Z' => {
            'expected'    => '>= 1000000000000000000000',
            'description' => 'greater than or equal to with a "Z" suffix',
        },
    },
    {
        '<=1.0Z' => {
            'expected'    => '<= 1000000000000000000000',
            'description' => 'less than or equal to with a "Z" suffix',
        },
    },
    {
        '>1.0Z' => {
            'expected'    => '> 1000000000000000000000',
            'description' => 'greater than with a "Z" suffix',
        },
    },
    {
        '<1.0Z' => {
            'expected'    => '< 1000000000000000000000',
            'description' => 'less than with a "Z" suffix',
        },
    },
    {
        '==1.0Z' => {
            'expected' => '== 1000000000000000000000',
            'description' => 'equal to with a "Z" suffix',
        },
    },
    {
        '>=1.0Y' => {
            'expected'    => '>= 1000000000000000000000000',
            'description' => 'greater than or equal to with a "Y" suffix',
        },
    },
    {
        '<=1.0Y' => {
            'expected'    => '<= 1000000000000000000000000',
            'description' => 'less than or equal to with a "Y" suffix',
        },
    },
    {
        '>1.0Y' => {
            'expected'    => '> 1000000000000000000000000',
            'description' => 'greater than with a "Y" suffix',
        },
    },
    {
        '<1.0Y' => {
            'expected'    => '< 1000000000000000000000000',
            'description' => 'less than with a "Y" suffix',
        },
    },
    {
        '==1.0Y' => {
            'expected' => '== 1000000000000000000000000',
            'description' => 'equal to with a "Y" suffix',
        },
    },
    {
        '>=1.0ki' => {
            'expected'    => '>= 1024',
            'description' => 'greater than or equal to with a "ki" suffix',
        },
    },
    {
        '<=1.0ki' => {
            'expected'    => '<= 1024',
            'description' => 'less than or equal to with a "ki" suffix',
        },
    },
    {
        '>1.0ki' => {
            'expected'    => '> 1024',
            'description' => 'greater than with a "ki" suffix',
        },
    },
    {
        '<1.0ki' => {
            'expected'    => '< 1024',
            'description' => 'less than with a "ki" suffix',
        },
    },
    {
        '==1.0ki' => {
            'expected' => '== 1024',
            'description' => 'equal to with a "ki" suffix',
        },
    },
    {
        '>=1.0Mi' => {
            'expected'    => '>= 1048576',
            'description' => 'greater than or equal to with an "Mi" suffix',
        },
    },
    {
        '<=1.0Mi' => {
            'expected'    => '<= 1048576',
            'description' => 'less than or equal to with an "Mi" suffix',
        },
    },
    {
        '>1.0Mi' => {
            'expected'    => '> 1048576',
            'description' => 'greater than with an "Mi" suffix',
        },
    },
    {
        '<1.0Mi' => {
            'expected'    => '< 1048576',
            'description' => 'less than with an "Mi" suffix',
        },
    },
    {
        '==1.0Mi' => {
            'expected' => '== 1048576',
            'description' => 'equal to with an "Mi" suffix',
        },
    },
    {
        '>=1.0Gi' => {
            'expected'    => '>= 1073741824',
            'description' => 'greater than or equal to with a "Gi" suffix',
        },
    },
    {
        '<=1.0Gi' => {
            'expected'    => '<= 1073741824',
            'description' => 'less than or equal to with a "Gi" suffix',
        },
    },
    {
        '>1.0Gi' => {
            'expected'    => '> 1073741824',
            'description' => 'greater than with a "Gi" suffix',
        },
    },
    {
        '<1.0Gi' => {
            'expected'    => '< 1073741824',
            'description' => 'less than with a "Gi" suffix',
        },
    },
    {
        '==1.0Gi' => {
            'expected' => '== 1073741824',
            'description' => 'equal to with a "Gi" suffix',
        },
    },
    {
        '>=1.0Ti' => {
            'expected'    => '>= 1099511627776',
            'description' => 'greater than or equal to with a "Ti" suffix',
        },
    },
    {
        '<=1.0Ti' => {
            'expected'    => '<= 1099511627776',
            'description' => 'less than or equal to with a "Ti" suffix',
        },
    },
    {
        '>1.0Ti' => {
            'expected'    => '> 1099511627776',
            'description' => 'greater than with a "Ti" suffix',
        },
    },
    {
        '<1.0Ti' => {
            'expected'    => '< 1099511627776',
            'description' => 'less than with a "Ti" suffix',
        },
    },
    {
        '==1.0Ti' => {
            'expected' => '== 1099511627776',
            'description' => 'equal to with a "Ti" suffix',
        },
    },
    {
        '>=1.0Pi' => {
            'expected'    => '>= 1125899906842624',
            'description' => 'greater than or equal to with a "Pi" suffix',
        },
    },
    {
        '<=1.0Pi' => {
            'expected'    => '<= 1125899906842624',
            'description' => 'less than or equal to with a "Pi" suffix',
        },
    },
    {
        '>1.0Pi' => {
            'expected'    => '> 1125899906842624',
            'description' => 'greater than with a "Pi" suffix',
        },
    },
    {
        '<1.0Pi' => {
            'expected'    => '< 1125899906842624',
            'description' => 'less than with a "Pi" suffix',
        },
    },
    {
        '==1.0Pi' => {
            'expected' => '== 1125899906842624',
            'description' => 'equal to with a "Pi" suffix',
        },
    },
    {
        '>=1.0Ei' => {
            'expected'    => '>= 1152921504606846976',
            'description' => 'greater than or equal to with an "Ei" suffix',
        },
    },
    {
        '<=1.0Ei' => {
            'expected'    => '<= 1152921504606846976',
            'description' => 'less than or equal to with an "Ei" suffix',
        },
    },
    {
        '>1.0Ei' => {
            'expected'    => '> 1152921504606846976',
            'description' => 'greater than with an "Ei" suffix',
        },
    },
    {
        '<1.0Ei' => {
            'expected'    => '< 1152921504606846976',
            'description' => 'less than with an "Ei" suffix',
        },
    },
    {
        '==1.0Ei' => {
            'expected' => '== 1152921504606846976',
            'description' => 'equal to with an "Ei" suffix',
        },
    },
    {
        '>=1.0Zi' => {
            'expected'    => '>= 1180591620717411303424',
            'description' => 'greater than or equal to with a "Zi" suffix',
        },
    },
    {
        '<=1.0Zi' => {
            'expected'    => '<= 1180591620717411303424',
            'description' => 'less than or equal to with a "Zi" suffix',
        },
    },
    {
        '>1.0Zi' => {
            'expected'    => '> 1180591620717411303424',
            'description' => 'greater than with a "Zi" suffix',
        },
    },
    {
        '<1.0Zi' => {
            'expected'    => '< 1180591620717411303424',
            'description' => 'less than with a "Zi" suffix',
        },
    },
    {
        '==1.0Zi' => {
            'expected' => '== 1180591620717411303424',
            'description' => 'equal to with a "Zi" suffix',
        },
    },
    {
        '>=1.0Yi' => {
            'expected'    => '>= 1208925819614629174706176',
            'description' => 'greater than or equal to with a "Yi" suffix',
        },
    },
    {
        '<=1.0Yi' => {
            'expected'    => '<= 1208925819614629174706176',
            'description' => 'less than or equal to with a "Yi" suffix',
        },
    },
    {
        '>1.0Yi' => {
            'expected'    => '> 1208925819614629174706176',
            'description' => 'greater than with a "Yi" suffix',
        },
    },
    {
        '<1.0Yi' => {
            'expected'    => '< 1208925819614629174706176',
            'description' => 'less than with a "Yi" suffix',
        },
    },
    {
        '==1.0Yi' => {
            'expected' => '== 1208925819614629174706176',
            'description' => 'equal to with a "Yi" suffix',
        },
    },
);

plan tests => scalar(@tests) + 5;

{
    my $label = 'Positive test';

    foreach my $element (@tests) {
        my $test = ( keys( %{ $element } ) )[0];
        my $description = $element->{$test}->{'description'};
        my $expected = $element->{$test}->{'expected'};
        my $result = Number::Compare->parse_to_perl($test);
        is( $result, $expected, "$label: parse_to_perl() returns the proper string for $description" );
    }
}

{
    my $label = 'Negative test';

    my $args = undef;
    throws_ok(
        sub { Number::Compare->parse_to_perl($args) },
        qr/^Argument.*must be a non-empty string/i,
        "$label: parse_to_perl() throws an exception when the argument is not a non-empty string"
    );

    $args = '';
    throws_ok(
        sub { Number::Compare->parse_to_perl($args) },
        qr/^Argument.*must be a non-empty string/i,
        "$label: parse_to_perl() throws an exception when the argument is an empty string"
    );

    $args = '>';
    throws_ok(
        sub { Number::Compare->parse_to_perl($args) },
        qr/^don't understand.*as a number/i,
        "$label: parse_to_perl() throws an exception when the argument only has a comparison operator"
    );

    $args = '>a';
    throws_ok(
        sub { Number::Compare->parse_to_perl($args) },
        qr/^don't understand.*as a number/i,
        "$label: parse_to_perl() throws an exception when the argument has a non-numeric character"
    );

    $args = '>1q';
    throws_ok(
        sub { Number::Compare->parse_to_perl($args) },
        qr/^don't understand.*as a number/i,
        "$label: parse_to_perl() throws an exception when the argument has an unknown suffix"
    )
}
