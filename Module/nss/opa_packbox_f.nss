////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_packbox_f
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Convo.
//
//  Checks for Pack Box on Animal.
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oAnimal = OBJECT_SELF;

  object oPackBox = GetLocalObject(oAnimal,"PackBox");
  if(GetIsObjectValid(oPackBox) == FALSE)
  {
    return TRUE;
  }
  else return FALSE;
}
