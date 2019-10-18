////////////////////////////////////////////////////////////////////////////////
//
//  Create Creature at Waypoint When Opening Chest/Coffin Etc
//  ors_cr_monster
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place this on the On Open Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oPC      = GetLastOpenedBy();
    object oSelf    = OBJECT_SELF;

    //Make Creature
    string sCreature = GetLocalString(oSelf,"CREATURE");
    if(sCreature != "")
    {
      object oWP = GetNearestObjectByTag("CREATURE",oSelf,1);
      location lWP = GetLocation(oWP);

      object oCreature = CreateObject(OBJECT_TYPE_CREATURE,sCreature,lWP,TRUE,"");

      //Now Remove the Local String So it can not be done again
      DeleteLocalString(oSelf,"CREATURE");
    }
    else
    {
      string sNotice = "**Nothing of interest in here**";
      ORS_FloatColorString(oPC, sNotice, GRAY);
    }
}

