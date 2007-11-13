package Icydee::BulkEmail::Domain;
#
# $HeadURL: file:///var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema.pm $
# $LastChangedRevision: 1349 $
# $LastChangedDate: 2007-05-01 13:01:14 +0100 (Tue, 01 May 2007) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;

use base qw(DBIx::Class::Schema);

__PACKAGE__->load_namespaces(
    result_namespace    => 'Result',
    resultset_namespace => 'ResultSet',
);
1;
