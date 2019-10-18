////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_chk_owner
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Horse Convo.
//
//  Checks for Owner Match.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oHorse = OBJECT_SELF;
  object oMod = GetModule();

  if(oPC == OBJECT_INVALID) return FALSE;

  //Player Information
  string sPCU = GetLocalString(oPC,"PCU");
  string sAPCU = GetLocalString(oHorse, "OHO_OWNER_UNIQUE");
  object oOwner = GetLocalObject(oHorse,"OHO_OWNER");
  string sOwner = GetName(oOwner);
  if(!GetIsObjectValid(oOwner)) sOwner = "Nobody";
  SetCustomToken(2031,sOwner);

  if(sPCU == sAPCU)
  {
    SetCustomToken(2030,GetName(oHorse));
    return TRUE;
  }
  else return FALSE;
}
