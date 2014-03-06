#!usr/bin/perl

use Device::MiniLED;
use LWP 5.64;
use JSON qw( decode_json);
use Data::Dumper;
use warnings;

my $url = "https://api.solidearth.com/sandbox/v1/listing/gcar/counters/52f01a4d3f2cce2434fde63e?format=json&access_token=*SPRING_ACCESS_TOKEN*";
my $sign=Device::MiniLED->new(devicetype => "sign");

 my $browser = LWP::UserAgent->new;
  my $response = $browser->get($url);
  die "Error at $url\n ", $response->status_line, "\n Aborting"
   unless $response->is_success;
  print "Whee, it worked!  I got that ",
   $response->content_type, " document!\n";


$decode = $response->{'_content'};
my $decode_json = decode_json( $decode );
print Dumper $decode_json;

$prohits = $decode_json->{'professional'};
$conhits = $decode_json->{'consumer'};
$anohits = $decode_json->{'anonymous'};
$tothits = $decode_json->{'total'};

$sign->addMsg(
     data => "Spring API",
     effect => "snow",
     speed => 3
);

$sign->addMsg(
     data => "Pull Street Name Here",
     effect => "scroll",
     speed => 5
);

$sign->addMsg(
     data => "Total Hits",
     effect => "flash",
     speed => 3
);

$sign->addMsg(
     data => $tothits,
     effect => "snow",
     speed => 4
);

$sign->addMsg(
     data => "Anonymous " . $anohits . " Consumer " . $conhits . " Professional " . $prohits,
     effect => "scroll",
     speed => 5
);

$sign->addMsg(
     data => "",
     effect => "flash",
     speed => 5
);

$sign->addMsg(
     data => "",
     effect => "flash",
     speed => 5
);


$sign->addMsg(
     data => "                                   ",
     effect => "flash",
     speed => 1
);

$sign->send(device => "/dev/tty.NoZAP-PL2303-00001014");
