my $file = @ARGV[0];
if (!defined $file) {
	usage();
}
my $file_nameWithoutExtension = $file;
if ($file =~ /^(.*?)\./) {
	$file_nameWithoutExtension = $1;
}
my $file_out = $file_nameWithoutExtension . '_[Schema].sql';

open fh, '<', $file or die "couldn't open file  ($file): $!\n";
open out, '>', $file_out or die "couldn't open file  ($file): $!\n";
while (<fh>) {
    #print if not /Dumping data for table `(.+?)`/../ALTER TABLE `(\1)` ENABLE KEYS/;
    print out if not /Dumping data for table `.+?`/../ALTER TABLE `.+?` ENABLE KEYS/;
}
close out;
close fh;


sub usage {
print STDERR << "EOF";
 
 USAGE:
   rip_SchemaData_from_mysqlAdministratorDump.pl dumpFileName
	
   dumpFileName - path to the dump file, created by mysql Administrator
                  backup function
EOF
exit;
}