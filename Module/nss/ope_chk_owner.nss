////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_chk_owner
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Convo.
//
//  Checks for Owner Match.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;
  object oMod = GetModule();

  if(oPC == OBJECT_INVALID) return FALSE;

  //Player Information
  string sPCU = GetLocalString(oPC,"PCU");
  string sAPCU = GetLocalString(oAnimal, "OPE_OWNER_UNIQUE");
  object oOwner = GetLocalObject(oAnimal,"OPE_OWNER");
  string sOwner = GetName(oOwner);
  if(!GetIsObjectValid(oOwner)) sOwner = "Nobody";
  SetCustomToken(2101,sOwner);

  if(sPCU == sAPCU)
  {
    SetCustomToken(2100,GetName(oAnimal));
    return TRUE;
  }
  else return FALSE;
}
