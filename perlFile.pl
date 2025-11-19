#!/usr/bin/perl

use strict;
use warnings;


my $password = "Checkmarx!123";
print "Hello World $password\n";

$pstmt = $con -> prepare("SELECT username FROM users WHERE id=?");
$result = $pstmt -> execute($userID);
$path = $pstmt -> fetchrow();

open(my $fileHandler,'<:encoding(UTF-8)',$path)
  or die "404";
my $fileContent = <$fileHandler>;
close $fileHandler;

print $fileContent;