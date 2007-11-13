#!/usr/bin/perl -w
#
# $Id:  $
# $Revision: 1.1 $
# $Author:  $
# $Source:  $
#
# $Log:  $
#
use strict;
use warnings;

#
# Announce that I am available for contract work
#
use lib 'lib';
use MIME::Lite;
use Net::SMTP;
use Icydee::BulkEmail::Domain;

#
# Make database connection
#
my $schema = Icydee::BulkEmail::Domain->connect('DBI:mysql:host=localhost;database=contracting', 'bulk_email', 'nvtQQZJmVpc9Vr4e');

print "schema = [$schema]\n";

my $from_address = 'announce6@iandocherty.com';
my $mail_host = 'mailhost.zen.co.uk';
my $subject = 'I am available for LAMP contract (Linux Apache Mysql Perl)';

### Adjust the filenames
my $my_file = 'CV4-31.doc';
my $your_file = 'IanDocherty_CV4_31.doc';

#
# get all contracting agents
#
my $agent_rs = $schema->resultset('Agent');
print "resultset = [$agent_rs]\n";

while (my $agent = $agent_rs->next) {
    print "AGENT: ".$agent->firstname." ".$agent->lastname." from ".$agent->company." tel: ".$agent->phone." email: ".$agent->email."\n";


### Adjust subject and body message
my $message_body = "Here's the attachment file(s) you wanted";


    ### Create the multipart container
    my $msg = MIME::Lite->new (
      From => $from_address,
      To => $agent->email,
      Subject => $subject,
      Type =>'multipart/mixed'
    ) or die "Error creating multipart container: $!\n";

    ### Add the text message part
    $msg->attach (
      Type => 'TEXT',
      Data => $message_body
    ) or die "Error adding the text message part: $!\n";

    ### Add the file
    $msg->attach (
       Type => 'application/msword',
       Path => $my_file,
       Filename => $your_file,
       Disposition => 'attachment'
    ) or die "Error adding $my_file: $!\n";

### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
$msg->send;

}
exit;

1;

