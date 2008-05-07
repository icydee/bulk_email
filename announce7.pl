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
use Template;

use Icydee::BulkEmail::Domain;

#
# Make database connection
#
my $schema = Icydee::BulkEmail::Domain->connect('DBI:mysql:host=localhost;database=contracting', 'bulk_email', 'nvtQQZJmVpc9Vr4e');

print "schema = [$schema]\n";

my $mail_host       = 'mailhost.zen.co.uk';
my $subject         = 'I am available for LAMP contract (Linux Apache Mysql Perl)';
my $template_file   = 'email_text.tt';

### Adjust the filenames
my $my_file = 'CV4-31.doc';
my $your_file = 'IanDocherty_CV4_31.doc';

#
# get all contracting agents
#
my $agent_rs = $schema->resultset('Agent');
#print "resultset = [$agent_rs]\n";

while (my $agent = $agent_rs->next) {
    print "AGENT: ".$agent->firstname." ".$agent->lastname." from ".$agent->company." tel: ".$agent->phone." email: ".$agent->email."\n";

    #
    # Load and apply the text to the template
    #
    my $message_body = '';
    my $template = Template->new({
    });
    my $vars = {
        agent   => $agent
    };
    $template->process($template_file, $vars, \$message_body) or die "cannot process template";

    ### Create the multipart container
    my $msg = MIME::Lite->new (
      From => $agent->reply_email.'@iandocherty.com',
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

