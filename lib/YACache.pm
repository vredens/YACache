package YACache;

use 5.012003;
use strict;
use warnings;

our $VERSION = '1.00';

my $mem = {};

my $limit = {};

sub add($$$) {
	my ($type, $key, $value) = @_;
	$mem->{$_[0]} = {} unless defined $mem->{$type};
	return $mem->{$type}->{$key} if defined $mem->{$type}->{$key};
	$mem->{$type}->{$key} = $value;
}

sub set($$$) {
	my ($type, $key, $value) = @_;
	$mem->{$type} = {} unless defined $mem->{$type};
	$mem->{$type}->{$key} = $value;
}

sub get($$) {
	my ($type, $key) = @_;
	return $mem->{$type}->{$key};
}

sub del($$) {
	my ($type, $key) = @_;
	delete $mem->{$type}->{$key};
}

sub clear($) {
	my $type = shift;
	delete $mem->{$type};
}

1;

__END__

=head1 NAME

YACache - Yet Another Cache

=head1 SYNOPSIS

	use YACache;

	# store a value
	YACache::set('people', 'me', {'fullname' => 'jb ribeiro', 'birth' => 'the future!'});

	# fetch a value
	my $me = YACache::get('people', 'me');

	# remove a value
	YACache::del('people', 'me');

	# clean up a whole type
	YACache::clean('people');

=head1 DESCRIPTION

Yet Another Cache is a short, simple memory cache for your Perl programs. 
The Cache module collection already supports everything this module does, 
so why another? Because this one is a lot simpler, faster and it's not 
OO. It should be used preferably if you just want to store small 
structures or scalars.

YACache is not OO, which means you don't need to initialize it and can
access the cache from anywhere in your program.

YACache supports namespaces. Actually, you are required to always use
namespaces. 

If you wish to use YACache for caching data, make sure you implement a
cache resize using your own logic. YACache does not keep last-access or
last-insert timestamps or any other metadata for that matter.

=head1 DEPENDENCIES

None.

=head1 Public methods

=head2 add (namespace, key, val)

Same as set except it does nothing if the key already exists. Returns the
value of the already existing key.

=head2 set (namespace, key, val)

sets a value in the cache, replacing any previous value with the same (namespace, key).

=head2 get (namespace, key)

returns a value from the cache. returns undef if not found.

=head2 del (namespace, key)

removes a value from the cache

=head2 clean (namespace)

removes a whole namespace

=head1 SEE ALSO

(TODO)

=head1 AUTHOR

J.B. Ribeiro, E<lt>vredens@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by J.B. Ribeiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
