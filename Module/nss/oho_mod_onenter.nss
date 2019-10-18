////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_mod_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Dismounts Riding a Horse On Entering the Module (DOES NOT Recall the Horse)
//
////////////////////////////////////////////////////////////////////////////////

#include "oho_inc"

void main()
{
  object oPC    = GetEnteringObject();
  object oMod   = GetModule();

/******************************************************************************/
//: UNIQUE PLAYER ID
/* <= DELETE THIS ROW IF NOT USING ORS (OLANDER'S REALISTIC SYSTEMS)

    //Update and/or Create Player Unique ID
    string sPCU = GetCampaignString("UNIQUEIDS","PCU",oPC);
    if(sPCU == "")
    {
      string sPCN = GetName(oPC);
      string sPre = GetStringLeft(sPCN,2);
      int nNum1 = Random(10000) + 1;
      int nNum2 = Random(10000) + 1;
      int nNum3 = Random(10000) + 1;
      int nNum4 = Random(10000) + 1;
      int nAvg  = (nNum1 + nNum2 + nNum3 + nNum4)/4;
      string sID = sPre + IntToString(nAvg);
      SetLocalString(oPC,"PCU",sID);
      SetCampaignString("UNIQUEIDS","PCU",sID,oPC);
    }
    else SetLocalString(oPC,"PCU",sPCU);

/******************************************************************************/

  //Now We Dismount if We Are Mounted
  if(OHOPCRidingHorse(oPC)) OHODismountHorse(oPC);
}
