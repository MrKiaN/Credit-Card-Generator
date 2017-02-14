#!/usr/bin/perl
# Protected under GPL, see http://www.gnu.org/copyleft/gpl.html

use Getopt::Std;

getopts('vmdat', \%opt)||die usage();

if(defined($opt{'v'})) { $type=4  }
if(defined($opt{'m'})) { $type=5  }
if(defined($opt{'d'})) { $type=6  }
if(defined($opt{'t'})) { $type=3  }
if(defined($opt{'a'})) { $type=37 }
if(!defined($type)) { usage() } else { gen() }

print("\nACREDIT - Programmed by Anarchy\n");
print("===============================\n");
print("Card number: $card\n");
print("Cardtype   : ", card_type($card),"\n\n");
exit 0;

sub gen() {
    $lo=1;
    $card=$type;
    if($type eq 37) { $i=2 } else { $i=1 }
    for($i;$i<15;$i++) {
       srand;
       if($type ne 37) {
       if($lo==4||$lo==8||$lo==12) { $card=$card." "; }
       } else {
       if($lo==3||$lo==7||$lo==11) { $card=$card." "; }
       } 
       $lo++;
       $card=$card.(int(rand 9)+1);
    }
    return $card=$card.(gen_card($card));
}


sub gen_card {
 my $number=shift;
 my ($i, $sum, $str);

 # Remove all non-digits from $number...
 $number=~s/\D//g;
 
 # Generate credit card number...
 for($i=0; $i<length($number); $i++) {
  $str=substr($number, (1+$i)*(-1),1)*(2-($i%2));
  if($str<10) { $sum+=$str } else { $tr+=$str-9 }
 }
 
 return (10-$sum%10)%10;
} 

sub card_type {
 my $number=shift;
 if($number=~/[^\d\s]/) { return "Invalid credit card number !!!" }

 # Remove all non-digits from $number...
 $number=~s/\D//g;

 if(substr($number,0,1)==4)  { return "VISA card" }
 if(substr($number,0,1)==5)  { return "Master card" }
 if(substr($number,0,1)==6)  { return "Discover card" }
 if(substr($number,0,2)==37) { return "American Express card" }
 if(substr($number,0,1)==3)  { return "Diner's CLub/Trasmedia" }
} 

sub usage() {
 print("\nACREDIT - Programmed by Anarchy (anarchy\@elxsi.de)\n");
 print("==================================================\n");
 print("Usage  :   ACREDIT [card type]\n");
 print("Options:   -v  <visa card>\n");
 print("           -m  <master card>\n");
 print("           -d  <discover card>\n");
 print("           -a  <american express>\n");
 print("           -t  <transmedia/diner's club>\n\n");
 exit(1);
}

