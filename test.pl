# $Id: test.pl,v 1.3 2001/03/22 20:23:03 btrott Exp $

use strict;

use Test;
BEGIN { plan tests => 19 }

use vars qw( $loaded );
END { print "not ok 1\n" unless $loaded; }
use Data::Buffer;
$loaded++;
ok($loaded);

my $buffer = Data::Buffer->new;
ok($buffer);
$buffer->put_str("foo");
ok($buffer->length, 7);
ok($buffer->get_str, "foo");
ok($buffer->offset, 7);

$buffer->put_str(0);
ok($buffer->get_str, 0);

$buffer->put_int32(999999999);
ok($buffer->get_int32, 999999999);

$buffer->put_int8(2);
ok($buffer->get_int8, 2);

$buffer->put_int16(9999);
ok($buffer->get_int16, 9999);

$buffer->put_char('a');
ok($buffer->get_char, 'a');

$buffer->put_chars("bar");
ok($buffer->get_char, 'b');
ok($buffer->get_char, 'a');
ok($buffer->get_char, 'r');

$buffer->insert_template;
my @data = $buffer->get_all;
ok($data[0], "foo");
ok($data[1], 0);
ok($data[2], 999999999);
ok($data[3], 2);
ok($data[4], 9999);
ok($data[5], 'a');
ok($data[6], 'b');
ok($data[7], 'a');
ok($data[8], 'r');

$buffer->empty;
ok($buffer->offset, 0);
ok($buffer->length, 0);
ok($buffer->bytes, '');
ok($buffer->template, '');

$buffer->append("foobar");
ok($buffer->length, 6);
ok($buffer->bytes, "foobar");

$buffer->empty;
ok($buffer->length, 0);
ok($buffer->dump, '');

$buffer->put_int16(129);
ok($buffer->get_int16, 129);
ok($buffer->dump, '00 81');
ok($buffer->dump(1), '81');
