//inc_party

//NOTE: This script will not compile and will give off an error of
//'inc_party' did not compile.
//inc_party.nss: ERROR: NO FUNCTION MAIN() IN SCRIPT

//Just click YES.

//IGNORE THIS and just save it as a normal script. No big deal, it is a
//workaround for an issue Bioware created with their single-player campaign
//scripting. I included the documentation below for reference for those intere
//interested.

//Sometimes, you might want to store variables and check for variables on an
//entire party rather than a single PC. Bioware has made a function called
//SetPLocalInt and GetPLocalInt that sets / gets a local variable from the PC's
//party. This function, however, is in the include file nw_i0_plot - I choose not to use
//this in this program because of this problem:

//The two include files nw_i0_plot and nw_i0_tool have a function in common which
//means they can't be used at the same time. This is really annoying, and I wish
//Bioware hadn't made it so, but what can you do. Thus, I choose not to use the Get
// SetPLocalInt commands.

//If you wish to check for party local variables, I suggest you use the include file
//below. Simply copy it and save it in your script editor - I give it the name ls_party.
//When you try to compile it, it will give you a 'no function main in script' error - just
//ignore it and say you don't want to compile it as a starting conditional.

//Then, whenever you want to use one of the functions in a script, that script must
//then start with this line:

//#include "inc_party"

//Of course, if you don't call it ls_party, you will have to replace that.

//Then, you can use the following commands:

//SetPartyInt
//SetPartyFloat
//SetPartyString
//SetPartyLocation
//SetPartyObject

//and

//GetPartyInt
//GetPartyFloat
//GetPartyString
//GetPartyLocation
//GetPartyObject

//The paramaters will be the same as for their Set / GetLocal* counterparts. Ie:

//SetPartyInt(oPC, "hello", 1); will basically call SetLocalInt(oPC, "hello", 1) on all
//partymembers, etc. etc.

//Note that, with int and float, if different PCs have different values stored on them,
//the highest of these values will be returned. With string, object, and location, the
//first one found will always be returned. If you use SetParty* all the time, the same
//variable will always be stored on everybody, though, so that problem can be
//easily avoided.

//include file by Lilac Soul, aka Carsten Hjorthoj

void SetPartyInt(object oPC, string sName, int n)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalInt(oMember, sName, n);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

int GetPartyInt(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

int n=0;
int nn;

while (GetIsObjectValid(oMember))
  {
  nn=GetLocalInt(oMember, sName);
  if (nn>n) n=nn;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return n;
}

void SetPartyFloat(object oPC, string sName, float f)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalFloat(oMember, sName, f);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

float GetPartyFloat(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

float f=0.0f;
float ff;

while (GetIsObjectValid(oMember))
  {
  ff=GetLocalFloat(oMember, sName);
  if (ff>f) f=ff;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return f;
}

void SetPartyString(object oPC, string sName, string s)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalString(oMember, sName, s);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

string GetPartyString(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
string s="";

while (GetIsObjectValid(oMember))
  {
  s=GetLocalString(oMember, sName);
  if (s != "") return s;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return s;
}

void SetPartyObject(object oPC, string sName, object o)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalObject(oMember, sName, o);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

object GetPartyObject(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
object o=OBJECT_INVALID;

while (GetIsObjectValid(oMember))
  {
  o=GetLocalObject(oMember, sName);
  if (o != OBJECT_INVALID) return o;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return o;
}

void SetPartyLocation(object oPC, string sName, location l)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalLocation(oMember, sName, l);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

location GetPartyLocation(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
location l;

while (GetIsObjectValid(oMember))
  {
  //testing: if the area of l isn't valid, it isn't a
  //valid location
  l=GetLocalLocation(oMember, sName);
  if (GetAreaFromLocation(l) != OBJECT_INVALID) return l;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return l;
}

