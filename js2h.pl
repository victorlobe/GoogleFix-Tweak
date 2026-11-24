#!/usr/bin/perl
# Converts Polyfills.js into Polyfills.h (an NSString literal) at build time.
# usage: perl js2h.pl Polyfills.js > .theos/Polyfills.h
use strict; use warnings;
local $/; my $js = <>;
$js =~ s/\\/\\\\/g;
$js =~ s/"/\\"/g;
$js =~ s/\r//g;
$js =~ s/\n/\\n"\n@"/g;
print "// Generated from Polyfills.js by js2h.pl - do not edit.\n";
print "static NSString *const kPolyfillJS = \@\"$js\";\n";
