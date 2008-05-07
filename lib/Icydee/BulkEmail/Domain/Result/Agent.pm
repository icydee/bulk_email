package Icydee::BulkEmail::Domain::Result::Agent;
#
# $HeadURL: file:///var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/User.pm $
# $LastChangedRevision: 1349 $
# $LastChangedDate: 2007-05-01 13:01:14 +0100 (Tue, 01 May 2007) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(PK::Auto Core));
__PACKAGE__->table('agent');
__PACKAGE__->add_columns(qw(id firstname lastname company email phone notes reply_email));
__PACKAGE__->set_primary_key('id');

1;
