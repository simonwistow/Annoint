while (my $line = <>) {
	my ($file, $date, $title, $blurb) = split /:/, $line, 4;
	$file =~ s/\.txt/\.title/;
	open my $fh, ">public/issues/$file" or die "Couldn't open $file: $!\n";
	print $fh "$title\n$blurb";
	close($fh);
}
