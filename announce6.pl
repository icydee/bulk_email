use strict;
use warnings;

use MIME::Lite;
use Net::SMTP;


my @array = (qw(one two three));

my $last_index = $#array;
print "last index = [$last_index]\n";
exit;


### Adjust sender, recipient and your SMTP mailhost
my $from_address = 'announce6@iandocherty.com';
my $to_address = 'ian@iandocherty.com';
my $mail_host = 'mailhost.zen.co.uk';

### Adjust subject and body message
my $subject = 'A message with 2 parts ...';
my $message_body = "Here's the attachment file(s) you wanted";

### Adjust the filenames
my $my_file_gif = 'CV4-31.doc';
my $your_file_gif = 'CV4-31.doc';

### Create the multipart container
my $msg = MIME::Lite->new (
  From => $from_address,
  To => $to_address,
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
   Path => $my_file_gif,
   Filename => $your_file_gif,
   Disposition => 'attachment'
) or die "Error adding $my_file_gif: $!\n";

### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
$msg->send;
1;

