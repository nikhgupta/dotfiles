#!/usr/bin/env perl

my $base_dir_qfn = ".";
my $i = 0;
my $dir;
opendir(my $dh, $base_dir_qfn)
  or die("Can'\''t open dir \"$base_dir_qfn\": $!\n");

while (defined( my $fn = readdir($dh) )) {
  next if $fn =~ /^(?:\.\.?|dir_\d+)\z/;

  my $qfn = "$base_dir_qfn/$fn";

  if ($i % 1000 == 0) {
      $dir_qfn = sprintf("%s/dir_%03d", $base_dir_qfn, int($i/1000)+1);
      mkdir($dir_qfn)
        or die("Can'\''t make directory \"$dir_qfn\": $!\n");
  }

  rename($qfn, "$dir_qfn/$fn")
      or do {
        warn("Can'\''t move \"$qfn\" into \"$dir_qfn\": $!\n");
        next;
      };

  ++$i;
}
