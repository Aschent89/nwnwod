////////////////////////////////////////////////////////////////////////////////
//  LoME Number of Good, Neutral, and Good Players
//  ors_pccount
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeble OnUsed Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    //Go through PCs and sort them based on the local integers "GoodSide" and
    //"EvilSide".
    int nGoodPC = 0;
    int nEvilPC = 0;
    int nCount  = 0;
    string sS   = "";

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
      if(GetLocalInt(oPC, "GoodSide")) nGoodPC++;
      else if (GetLocalInt(oPC, "EvilSide")) nEvilPC++;
      nCount++;
      oPC = GetNextPC();
    }

    //Total Player
    if(nCount > 1) sS = "s";
    SpeakString("Player"+sS+" on Server: " +IntToString(nCount));

    //Good Player
    sS = "";
    if(nGoodPC > 1) sS = "s";
    SpeakString("Good Player"+sS+" on Server: " +IntToString(nGoodPC));

    //Evil Player
    sS = "";
    if(nEvilPC > 1) sS = "s";
    SpeakString("Evil Player"+sS+" on Server: " +IntToString(nEvilPC));
}
