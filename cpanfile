requires 'Class::Accessor::Lvalue::Fast';
requires 'Exporter::Lite';
requires 'HTML::Entities';
requires 'HTML::Strip';

on 'test' => sub {
    requires 'Test::Base';
    requires 'Test::More';
};
