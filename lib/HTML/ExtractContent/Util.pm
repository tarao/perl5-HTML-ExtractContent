package HTML::ExtractContent::Util;
use strict;
use warnings;
use Exporter::Lite;
use utf8;

use HTML::Entities;

sub strip {
    my $str = shift;
    $str =~ s/(^\s+|\s+$)//gs;
    return $str;
}

sub strip_tags {
    my $page = shift;
    $page =~ s/<[^>\s]+(?:\s+[^>"]+(?:=(?:"[^"]*"|'[^']*'|\S+))?)*>//gs;
    return $page;
}

sub eliminate_tags {
    my ($page, $tag) = @_;
    $page =~ s/<$tag[\s>].*?<\/$tag\s*>//igs;
    return $page;
}

sub eliminate_links {
    return eliminate_tags shift, 'a';
}

sub eliminate_forms {
    return eliminate_tags shift, 'form';
}

sub eliminate_br {
    my $page = shift;
    $page =~ s/<br[^>]*>/ /igs;
    return $page;
}

sub extract_alt {
    my $page = shift;
    $page =~ s/<img\s[^>]*alt\s*=\s*['"]?(.*?)["']?[^>]*>/$1/igs;
    return $page;
}

sub unescape {
    my $page = shift;
    decode_entities($page);
}

sub reduce_ws {
    my $page = shift;
    $page =~ s/[ \t]+/ /g;
    $page =~ s/\n\s*/\n/gs;
    return $page;
}

sub decode {
    return strip (reduce_ws (unescape (strip_tags (eliminate_br shift))));
}

sub to_text {
    return decode (extract_alt shift);
}

sub match_count {
    my ($str, $exp) = @_;
    my @list = ($str =~ $exp);
    return $#list + 1;
}

our @EXPORT = qw/strip strip_tags eliminate_tags eliminate_links eliminate_forms eliminate_br extract_alt unescape reduce_ws decode to_text match_count/;

1;
