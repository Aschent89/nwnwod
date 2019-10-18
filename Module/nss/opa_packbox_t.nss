////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_packbox_t
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Convo.
//
//  Checks for Pack Box on Ground.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;

  object oPackBox = GetLocalObject(oAnimal,"PackBox");
  int nTransferred = GetLocalInt(oPC,"OPA_TRANSFERRED");
  if(GetIsObjectValid(oPackBox) == TRUE && nTransferred == TRUE)
  {
    return TRUE;
  }
  else return FALSE;
}
