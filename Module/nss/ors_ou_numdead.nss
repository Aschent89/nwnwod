////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Number Dead on Server
//  ors_ou_numdead
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is called from the On Used Event of a Placeable
//
////////////////////////////////////////////////////////////////////////////////

void SpeakInfo(object oSign);

void main()
{
  object oSign = OBJECT_SELF;
  object oMod = GetModule();
  string sTag = GetTag(oSign);

  int nETotal = GetLocalInt(oMod,"EVIL_FACTION");
  int nGTotal = GetLocalInt(oMod,"GOOD_FACTION");
  int nHTotal = GetLocalInt(oMod,"HOSTILE_FACTION");

  if(sTag == "EVIL_DEAD")
  {
    SpeakString("Evil Dead Since Server Reload : "+IntToString(nETotal));
    return;
  }

  if(sTag == "GOOD_DEAD")
  {
    SpeakString("Good and Neutral Dead Since Server Reload : "+IntToString(nGTotal));
    return;
  }

  if(sTag == "HOSTILE_DEAD")
  {
    SpeakString("Hostiles Dead Since Server Reload : "+IntToString(nHTotal));
    return;
  }
}
