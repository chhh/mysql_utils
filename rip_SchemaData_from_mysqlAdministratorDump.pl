my $file = @ARGV[0];
if (!defined $file) {
	usage();
}
if (!-f $file) {
	print "\nError: Bad file path/name ($file)\n\n";
	exit;
}

$file =~ s/\\/\//g;
print "\nProcessing file: $file\n\n";
my $file_path = '';
my $file_nameWithoutExtension = $file;
my $file_extension = '';

if ($file =~ /(.+\/|^)(.+(?=\.)|.+)(.*)/) {
	$file_path = $1;
	$file_nameWithoutExtension = $2;
	$file_extension = $3;
	#print "\n\nMATCHED:\n1 (path) = $1\n2 (name) = $2\n3 (ext ) = $3\n";   # DEBUG: output how the filename was parsed
}
my $file_out = $file_path . $file_nameWithoutExtension . '_[Empty_Schema]' . $file_extension;
print "Output file: $file_out\n\n";



open FH, '<', $file or die "couldn't open file  ($file): $!\n";
open OUT, '>', $file_out or die "couldn't open file  ($file_out): $!\n";
while (<FH>) {
    #print if not /Dumping data for table `(.+?)`/../ALTER TABLE `(\1)` ENABLE KEYS/;
    print OUT if not /Dumping data for table `.+?`/../ALTER TABLE `.+?` ENABLE KEYS/;
}
close OUT;
close FH;


sub usage {
print STDERR << "EOF";
 
 USAGE:
   rip_SchemaData_from_mysqlAdministratorDump.pl dumpFileName
	
   dumpFileName - path to the dump file, created by mysql Administrator
                  backup function
EOF
exit;
}