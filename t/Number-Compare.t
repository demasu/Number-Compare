#!perl -w

use strict;
use Test::More tests => 160;

use bignum;
use Number::Compare;

note('Testing without prefixes');
{
    my $label = 'Positive test';

    my $c = Number::Compare->new('>20');
    is( $c->test(21), 1, "$label: Test shows that 21 is greater than 20" );

    $c = Number::Compare->new('<20');
    is( $c->test(19), 1, "$label: Test shows that 19 is less than 20" );

    $c = Number::Compare->new('>=20');
    is( $c->test(20), 1, "$label: Test shows that 20 is greater than or equal to 20" );
    is( $c->test(21), 1, "$label: Test shows that 21 is greater than or equal to 20" );

    $c = Number::Compare->new('<=20');
    is( $c->test(19), 1, "$label: Test shows that 19 is less than or equal to 20" );
    is( $c->test(20), 1, "$label: Test shows that 20 is less than or equal to 20" );
}

{
    my $label = 'Negative test';

    my $c = Number::Compare->new('>20');
    is( $c->test(19), '', "$label: Test shows that 19 is not greater than 20" );
    is( $c->test(20), '', "$label: Test shows that 20 is not greater than 20" );

    $c = Number::Compare->new('<20');
    is( $c->test(21), '', "$label: Test shows that 21 is not less than 20" );
    is( $c->test(20), '', "$label: Test shows that 20 is not less than 20" );

    $c = Number::Compare->new('>=20');
    is( $c->test(19), '', "$label: Test shows that 19 is not greater than or equal to 20" );

    $c = Number::Compare->new('<=20');
    is( $c->test(21), '', "$label: Test shows that 21 is not less than or equal to 20" );
}

note('Testing with non-base two prefixes');
{
    my $label = 'Positive test';

    my $c = Number::Compare->new('>1K');
    is( $c->test(1_001), 1, "$label: Test shows that 1,001 is greater than 1K" );

    $c = Number::Compare->new('<1K');
    is( $c->test(999), 1, "$label: Test shows that 999 is less than 1K" );

    $c = Number::Compare->new('>=1K');
    is( $c->test(1_000), 1, "$label: Test shows that 1,000 is greater than or equal to 1K" );
    is( $c->test(1_001), 1, "$label: Test shows that 1,000 is greater than or equal to 1K" );

    $c = Number::Compare->new('<=1K');
    is( $c->test(999), 1, "$label: Test shows that 999 is less than or equal to 1K" );
    is( $c->test(1_000), 1, "$label: Test shows that 1,000 is less than or equal to 1K" );

    $c = Number::Compare->new('>1M');
    is( $c->test(1_000_001), 1, "$label: Test shows that 1,000,001 is greater than 1M" );

    $c = Number::Compare->new('<1M');
    is( $c->test(999_999), 1, "$label: Test shows that 999,999 is less than 1M" );

    $c = Number::Compare->new('>=1M');
    is( $c->test(1_000_000), 1, "$label: Test shows that 1,000,000 is greater than or equal to 1M" );
    is( $c->test(1_000_001), 1, "$label: Test shows that 1,000,001 is greater than or equal to 1M" );

    $c = Number::Compare->new('<=1M');
    is( $c->test(999_999), 1, "$label: Test shows that 999,999 is less than or equal to 1M" );
    is( $c->test(1_000_000), 1, "$label: Test shows that 1,000,000 is less than or equal to 1M" );

    $c = Number::Compare->new('>1G');
    is( $c->test(1_000_000_001), 1, "$label: Test shows that 1,000,000,001 is greater than 1G" );

    $c = Number::Compare->new('<1G');
    is( $c->test(999_999_999), 1, "$label: Test shows that 999,999,999 is less than 1G" );

    $c = Number::Compare->new('>=1G');
    is( $c->test(1_000_000_000), 1, "$label: Test shows that 1,000,000,000 is greater than or equal to 1G" );
    is( $c->test(1_000_000_001), 1, "$label: Test shows that 1,000,000,001 is greater than or equal to 1G" );

    $c = Number::Compare->new('<=1G');
    is( $c->test(999_999_999), 1, "$label: Test shows that 999,999,999 is less than or equal to 1G" );
    is( $c->test(1_000_000_000), 1, "$label: Test shows that 1,000,000,000 is less than or equal to 1G" );

    $c = Number::Compare->new('>1T');
    is( $c->test(1_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,001 is greater than 1T" );

    $c = Number::Compare->new('<1T');
    is( $c->test(999_999_999_999), 1, "$label: Test shows that 999,999,999,999 is less than 1T" );

    $c = Number::Compare->new('>=1T');
    is( $c->test(1_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000 is greater than or equal to 1T" );
    is( $c->test(1_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,001 is greater than or equal to 1T" );

    $c = Number::Compare->new('<=1T');
    is( $c->test(999_999_999_999), 1, "$label: Test shows that 999,999,999,999 is less than or equal to 1T" );
    is( $c->test(1_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000 is less than or equal to 1T" );

    $c = Number::Compare->new('>1P');
    is( $c->test(1_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,001 is greater than 1P" );

    $c = Number::Compare->new('<1P');
    is( $c->test(999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999 is less than 1P" );

    $c = Number::Compare->new('>=1P');
    is( $c->test(1_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000 is greater than or equal to 1P" );
    is( $c->test(1_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,001 is greater than or equal to 1P" );

    $c = Number::Compare->new('<=1P');
    is( $c->test(999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999 is less than or equal to 1P" );
    is( $c->test(1_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000 is less than or equal to 1P" );

    $c = Number::Compare->new('>1E');
    is( $c->test(1_000_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,000,001 is greater than 1E" );

    $c = Number::Compare->new('<1E');
    is( $c->test(999_999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999,999 is less than 1E" );

    $c = Number::Compare->new('>=1E');
    is( $c->test(1_000_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000,000 is greater than or equal to 1E" );
    is( $c->test(1_000_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,000,001 is greater than or equal to 1E" );

    $c = Number::Compare->new('<=1E');
    is( $c->test(999_999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999,999 is less than or equal to 1E" );
    is( $c->test(1_000_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000,000 is less than or equal to 1E" );

    $c = Number::Compare->new('>1Z');
    is( $c->test(1_000_000_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,000,000,001 is greater than 1Z" );

    $c = Number::Compare->new('<1Z');
    is( $c->test(999_999_999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999,999,999 is less than 1Z" );

    $c = Number::Compare->new('>=1Z');
    is( $c->test(1_000_000_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000,000,000 is greater than or equal to 1Z" );
    is( $c->test(1_000_000_000_000_000_000_001), 1, "$label: Test shows that 1,000,000,000,000,000,000,001 is greater than or equal to 1Z" );

    $c = Number::Compare->new('<=1Z');
    is( $c->test(999_999_999_999_999_999_999), 1, "$label: Test shows that 999,999,999,999,999,999,999 is less than or equal to 1Z" );
    is( $c->test(1_000_000_000_000_000_000_000), 1, "$label: Test shows that 1,000,000,000,000,000,000,000 is less than or equal to 1Z" );
}

{
    my $label = 'Negative test';

    my $c = Number::Compare->new('>1K');
    is( $c->test(1_000), '', "$label: Test shows that 1,000 is not greater than 1K" );

    $c = Number::Compare->new('<1K');
    is( $c->test(1_000), '', "$label: Test shows that 1,000 is not less than 1K" );

    $c = Number::Compare->new('>=1K');
    is( $c->test(999), '', "$label: Test shows that 999 is not greater than or equal to 1K" );

    $c = Number::Compare->new('<=1K');
    is( $c->test(1_001), '', "$label: Test shows that 1,000 is not less than or equal to 1K" );

    $c = Number::Compare->new('>1M');
    is( $c->test(1_000_000), '', "$label: Test shows that 1,000,000 is not greater than 1M" );

    $c = Number::Compare->new('<1M');
    is( $c->test(1_000_000), '', "$label: Test shows that 1,000,000 is not less than 1M" );

    $c = Number::Compare->new('>=1M');
    is( $c->test(999_999), '', "$label: Test shows that 999,999 is not greater than or equal to 1M" );

    $c = Number::Compare->new('<=1M');
    is( $c->test(1_000_001), '', "$label: Test shows that 1,000,000 is not less than or equal to 1M" );

    $c = Number::Compare->new('>1G');
    is( $c->test(1_000_000_000), '', "$label: Test shows that 1,000,000,000 is not greater than 1G" );

    $c = Number::Compare->new('<1G');
    is( $c->test(1_000_000_000), '', "$label: Test shows that 1,000,000,000 is not less than 1G" );

    $c = Number::Compare->new('>=1G');
    is( $c->test(999_999_999), '', "$label: Test shows that 999,999,999 is not greater than or equal to 1G" );

    $c = Number::Compare->new('<=1G');
    is( $c->test(1_000_000_001), '', "$label: Test shows that 1,000,000,001 is not less than or equal to 1G" );

    $c = Number::Compare->new('>1T');
    is( $c->test(1_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000 is not greater than 1T" );

    $c = Number::Compare->new('<1T');
    is( $c->test(1_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000 is not less than 1T" );

    $c = Number::Compare->new('>=1T');
    is( $c->test(999_999_999_999), '', "$label: Test shows that 999,999,999,999 is not greater than or equal to 1T" );

    $c = Number::Compare->new('<=1T');
    is( $c->test(1_000_000_000_001), '', "$label: Test shows that 1,000,000,000,001 is not less than or equal to 1T" );

    $c = Number::Compare->new('>1Z');
    is( $c->test(1_000_000_000_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000,000,000,000 is not greater than 1Z" );

    $c = Number::Compare->new('<1Z');
    is( $c->test(1_000_000_000_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000,000,000,000 is not less than 1Z" );

    $c = Number::Compare->new('>=1Z');
    is( $c->test(999_999_999_999_999_999_999), '', "$label: Test shows that 999,999,999,999,999,999,999 is not greater than or equal to 1Z" );

    $c = Number::Compare->new('<=1Z');
    is( $c->test(1_000_000_000_000_000_000_001), '', "$label: Test shows that 1,000,000,000,000,000,000,001 is not less than or equal to 1Z" );

    $c = Number::Compare->new('>1Y');
    is( $c->test(1_000_000_000_000_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000,000,000,000,000 is not greater than 1Y" );

    $c = Number::Compare->new('<1Y');
    is( $c->test(1_000_000_000_000_000_000_000_000), '', "$label: Test shows that 1,000,000,000,000,000,000,000,000 is not less than 1Y" );

    $c = Number::Compare->new('>=1Y');
    is( $c->test(999_999_999_999_999_999_999), '', "$label: Test shows that 999,999,999,999,999,999,999 is not greater than or equal to 1Y" );

    $c = Number::Compare->new('<=1Y');
    is( $c->test(1_000_000_000_000_000_000_000_001), '', "$label: Test shows that 1,000,000,000,000,000,000,000,001 is not less than or equal to 1Y" );
}

note('Testing with base two prefixes');
{
    my $label = "Positive test";

    my $c = Number::Compare->new('>1Ki');
    is( $c->test(1025), 1, "$label: Test shows that 1025 is greater than 1Ki" );

    $c = Number::Compare->new('<1Ki');
    is( $c->test(1023), 1, "$label: Test shows that 1023 is less than 1Ki" );

    $c = Number::Compare->new('>=1Ki');
    is( $c->test(1024), 1, "$label: Test shows that 1024 is greater than or equal to 1Ki" );
    is( $c->test(1025), 1, "$label: Test shows that 1025 is greater than or equal to 1Ki" );

    $c = Number::Compare->new('<=1Ki');
    is( $c->test(1023), 1, "$label: Test shows that 1023 is less than or equal to 1Ki" );
    is( $c->test(1024), 1, "$label: Test shows that 1024 is less than or equal to 1Ki" );

    $c = Number::Compare->new('>1Mi');
    is( $c->test(1_048_577), 1, "$label: Test shows that 1,048,577 is greater than 1Mi" );

    $c = Number::Compare->new('<1Mi');
    is( $c->test(1_048_575), 1, "$label: Test shows that 1,048,575 is less than 1Mi" );

    $c = Number::Compare->new('>=1Mi');
    is( $c->test(1_048_576), 1, "$label: Test shows that 1,048,576 is greater than or equal to 1Mi" );
    is( $c->test(1_048_577), 1, "$label: Test shows that 1,048,577 is greater than or equal to 1Mi" );

    $c = Number::Compare->new('<=1Mi');
    is( $c->test(1_048_575), 1, "$label: Test shows that 1,048,575 is less than or equal to 1Mi" );
    is( $c->test(1_048_576), 1, "$label: Test shows that 1,048,576 is less than or equal to 1Mi" );

    $c = Number::Compare->new('>1Gi');
    is( $c->test(1_073_741_825), 1, "$label: Test shows that 1,073,741,825 is greater than 1Gi" );

    $c = Number::Compare->new('<1Gi');
    is( $c->test(1_073_741_823), 1, "$label: Test shows that 1,073,741,823 is less than 1Gi" );

    $c = Number::Compare->new('>=1Gi');
    is( $c->test(1_073_741_824), 1, "$label: Test shows that 1,073,741,824 is greater than or equal to 1Gi" );
    is( $c->test(1_073_741_825), 1, "$label: Test shows that 1,073,741,825 is greater than or equal to 1Gi" );

    $c = Number::Compare->new('<=1Gi');
    is( $c->test(1_073_741_823), 1, "$label: Test shows that 1,073,741,823 is less than or equal to 1Gi" );
    is( $c->test(1_073_741_824), 1, "$label: Test shows that 1,073,741,824 is less than or equal to 1Gi" );

    $c = Number::Compare->new('>1Ti');
    is( $c->test(1_099_511_627_777), 1, "$label: Test shows that 1,099,511,627,777 is greater than 1Ti" );

    $c = Number::Compare->new('<1Ti');
    is( $c->test(1_099_511_627_775), 1, "$label: Test shows that 1,099,511,627,775 is less than 1Ti" );

    $c = Number::Compare->new('>=1Ti');
    is( $c->test(1_099_511_627_776), 1, "$label: Test shows that 1,099,511,627,776 is greater than or equal to 1Ti" );
    is( $c->test(1_099_511_627_777), 1, "$label: Test shows that 1,099,511,627,777 is greater than or equal to 1Ti" );

    $c = Number::Compare->new('<=1Ti');
    is( $c->test(1_099_511_627_775), 1, "$label: Test shows that 1,099,511,627,775 is less than or equal to 1Ti" );
    is( $c->test(1_099_511_627_776), 1, "$label: Test shows that 1,099,511,627,776 is less than or equal to 1Ti" );

    $c = Number::Compare->new('>1Pi');
    is( $c->test(1_125_899_906_842_625), 1, "$label: Test shows that 1,125,899,906,842,625 is greater than 1Pi" );

    $c = Number::Compare->new('<1Pi');
    is( $c->test(1_125_899_906_842_623), 1, "$label: Test shows that 1,125,899,906,842,623 is less than 1Pi" );

    $c = Number::Compare->new('>=1Pi');
    is( $c->test(1_125_899_906_842_624), 1, "$label: Test shows that 1,125,899,906,842,624 is greater than or equal to 1Pi" );
    is( $c->test(1_125_899_906_842_625), 1, "$label: Test shows that 1,125,899,906,842,625 is greater than or equal to 1Pi" );

    $c = Number::Compare->new('<=1Pi');
    is( $c->test(1_125_899_906_842_623), 1, "$label: Test shows that 1,125,899,906,842,623 is less than or equal to 1Pi" );
    is( $c->test(1_125_899_906_842_624), 1, "$label: Test shows that 1,125,899,906,842,624 is less than or equal to 1Pi" );

    $c = Number::Compare->new('>1Ei');
    is( $c->test(1_152_921_504_606_846_977), 1, "$label: Test shows that 1,152,921,504,606,846,977 is greater than 1Ei" );

    $c = Number::Compare->new('<1Ei');
    is( $c->test(1_152_921_504_606_846_975), 1, "$label: Test shows that 1,152,921,504,606,846,975 is less than 1Ei" );

    $c = Number::Compare->new('>=1Ei');
    is( $c->test(1_152_921_504_606_846_976), 1, "$label: Test shows that 1,152,921,504,606,846,976 is greater than or equal to 1Ei" );
    is( $c->test(1_152_921_504_606_846_977), 1, "$label: Test shows that 1,152,921,504,606,846,977 is greater than or equal to 1Ei" );

    $c = Number::Compare->new('<=1Ei');
    is( $c->test(1_152_921_504_606_846_975), 1, "$label: Test shows that 1,152,921,504,606,846,975 is less than or equal to 1Ei" );
    is( $c->test(1_152_921_504_606_846_976), 1, "$label: Test shows that 1,152,921,504,606,846,976 is less than or equal to 1Ei" );

    $c = Number::Compare->new('>1Zi');
    is( $c->test(1_180_591_620_717_411_303_426), 1, "$label: Test shows that 1,180,591,620,717,411,303,426 is greater than 1Zi" );

    $c = Number::Compare->new('<1Zi');
    is( $c->test(1_180_591_620_717_411_303_423), 1, "$label: Test shows that 1,180,591,620,717,411,303,423 is less than 1Zi" );

    $c = Number::Compare->new('>=1Zi');
    is( $c->test(1_180_591_620_717_411_303_425), 1, "$label: Test shows that 1,180,591,620,717,411,303,425 is greater than or equal to 1Zi" );
    is( $c->test(1_180_591_620_717_411_303_426), 1, "$label: Test shows that 1,180,591,620,717,411,303,426 is greater than or equal to 1Zi" );

    $c = Number::Compare->new('<=1Zi');
    is( $c->test(1_180_591_620_717_411_303_423), 1, "$label: Test shows that 1,180,591,620,717,411,303,423 is less than or equal to 1Zi" );
    is( $c->test(1_180_591_620_717_411_303_424), 1, "$label: Test shows that 1,180,591,620,717,411,303,424 is less than or equal to 1Zi" );

    $c = Number::Compare->new('>1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_177), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,177 is greater than 1Yi" );

    $c = Number::Compare->new('<1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_175), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,175 is less than 1Yi" );

    $c = Number::Compare->new('>=1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_176), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,176 is greater than or equal to 1Yi" );
    is( $c->test(1_208_925_819_614_629_174_706_177), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,177 is greater than or equal to 1Yi" );

    $c = Number::Compare->new('<=1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_175), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,175 is less than or equal to 1Yi" );
    is( $c->test(1_208_925_819_614_629_174_706_176), 1, "$label: Test shows that 1,208,925,819,614,629,174,706,176 is less than or equal to 1Yi" );
}

{
    my $label = "Negative test";

    my $c = Number::Compare->new('>1Ki');
    is( $c->test(1024), '', "$label: Test shows that 1024 is not greater than 1Ki" );

    $c = Number::Compare->new('<1Ki');
    is( $c->test(1024), '', "$label: Test shows that 1024 is not less than 1Ki" );

    $c = Number::Compare->new('>=1Ki');
    is( $c->test(1023), '', "$label: Test shows that 1023 is not greater than or equal to 1Ki" );

    $c = Number::Compare->new('<=1Ki');
    is( $c->test(1025), '', "$label: Test shows that 1025 is not less than or equal to 1Ki" );

    $c = Number::Compare->new('>1Mi');
    is( $c->test(1_048_576), '', "$label: Test shows that 1,048,576 is not greater than 1Mi" );

    $c = Number::Compare->new('<1Mi');
    is( $c->test(1_048_576), '', "$label: Test shows that 1,048,576 is not less than 1Mi" );

    $c = Number::Compare->new('>=1Mi');
    is( $c->test(1_048_575), '', "$label: Test shows that 1,048,575 is not greater than or equal to 1Mi" );

    $c = Number::Compare->new('<=1Mi');
    is( $c->test(1_048_577), '', "$label: Test shows that 1,048,577 is not less than or equal to 1Mi" );

    $c = Number::Compare->new('>1Gi');
    is( $c->test(1_073_741_824), '', "$label: Test shows that 1,073,741,824 is not greater than 1Gi" );

    $c = Number::Compare->new('<1Gi');
    is( $c->test(1_073_741_824), '', "$label: Test shows that 1,073,741,824 is not less than 1Gi" );

    $c = Number::Compare->new('>=1Gi');
    is( $c->test(1_073_741_823), '', "$label: Test shows that 1,073,741,823 is not greater than or equal to 1Gi" );

    $c = Number::Compare->new('<=1Gi');
    is( $c->test(1_073_741_825), '', "$label: Test shows that 1,073,741,825 is not less than or equal to 1Gi" );

    $c = Number::Compare->new('>1Ti');
    is( $c->test(1_099_511_627_776), '', "$label: Test shows that 1,099,511,627,775 is not greater than 1Ti" );

    $c = Number::Compare->new('<1Ti');
    is( $c->test(1_099_511_627_776), '', "$label: Test shows that 1,099,511,627,776 is not less than 1Ti" );

    $c = Number::Compare->new('>=1Ti');
    is( $c->test(1_099_511_627_775), '', "$label: Test shows that 1,099,511,627,775 is not greater than or equal to 1Ti" );

    $c = Number::Compare->new('<=1Ti');
    is( $c->test(1_099_511_627_777), '', "$label: Test shows that 1,099,511,627,777 is not less than or equal to 1Ti" );

    $c = Number::Compare->new('>1Pi');
    is( $c->test(1_125_899_906_842_624), '', "$label: Test shows that 1,125,899,906,842,624 is not greater than 1Pi" );

    $c = Number::Compare->new('<1Pi');
    is( $c->test(1_125_899_906_842_624), '', "$label: Test shows that 1,125,899,906,842,624 is not less than 1Pi" );

    $c = Number::Compare->new('>=1Pi');
    is( $c->test(1_125_899_906_842_623), '', "$label: Test shows that 1,125,899,906,842,623 is not greater than or equal to 1Pi" );

    $c = Number::Compare->new('<=1Pi');
    is( $c->test(1_125_899_906_842_625), '', "$label: Test shows that 1,125,899,906,842,625 is not less than or equal to 1Pi" );

    $c = Number::Compare->new('>1Ei');
    is( $c->test(1_152_921_504_606_846_976), '', "$label: Test shows that 1,152,921,504,606,846,976 is not greater than 1Ei" );

    $c = Number::Compare->new('<1Ei');
    is( $c->test(1_152_921_504_606_846_976), '', "$label: Test shows that 1,152,921,504,606,846,976 is not less than 1Ei" );

    $c = Number::Compare->new('>=1Ei');
    is( $c->test(1_152_921_504_606_846_975), '', "$label: Test shows that 1,152,921,504,606,846,975 is not greater than or equal to 1Ei" );

    $c = Number::Compare->new('<=1Ei');
    is( $c->test(1_152_921_504_606_846_977), '', "$label: Test shows that 1,152,921,504,606,846,977 is not less than or equal to 1Ei" );

    $c = Number::Compare->new('>1Zi');
    is( $c->test(1_180_591_620_717_411_303_424), '', "$label: Test shows that 1,180,591,620,717,411,303,424 is not greater than 1Zi" );

    $c = Number::Compare->new('<1Zi');
    is( $c->test(1_180_591_620_717_411_303_424), '', "$label: Test shows that 1,180,591,620,717,411,303,424 is not less than 1Zi" );

    $c = Number::Compare->new('>=1Zi');
    is( $c->test(1_180_591_620_717_411_303_423), '', "$label: Test shows that 1,180,591,620,717,411,303,423 is not greater than or equal to 1Zi" );

    $c = Number::Compare->new('<=1Zi');
    is( $c->test(1_180_591_620_717_411_303_425), '', "$label: Test shows that 1,180,591,620,717,411,303,425 is not less than or equal to 1Zi" );

    $c = Number::Compare->new('>1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_176), '', "$label: Test shows that 1,208,925,819,614,629,174,706,176 is not greater than 1Yi" );

    $c = Number::Compare->new('<1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_176), '', "$label: Test shows that 1,208,925,819,614,629,174,706,176 is not less than 1Yi" );

    $c = Number::Compare->new('>=1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_175), '', "$label: Test shows that 1,208,925,819,614,629,174,706,175 is not greater than or equal to 1Yi" );

    $c = Number::Compare->new('<=1Yi');
    is( $c->test(1_208_925_819_614_629_174_706_177), '', "$label: Test shows that 1,208,925,819,614,629,174,706,177 is not less than or equal to 1Yi" );
}

note('Testing when not using an object');
{
    my $label = "Positive test";

    is( Number::Compare->new("1Ki")->(1024), 1, "$label: Calling the coderef directly provides the expected result" );
    is( Number::Compare->parse_to_perl(">1Ki"), '> 1024', "$label: Calling parse_to_perl directly provides the expected result" );
}
