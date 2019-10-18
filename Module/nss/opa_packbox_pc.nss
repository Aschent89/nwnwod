////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_packbox_pc
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

  object oPackBoxPC = GetLocalObject(oPC,"PackBox");
  object oPackBoxA = GetLocalObject(oAnimal,"PackBox");
  if(GetIsObjectValid(oPackBoxPC) == TRUE && GetIsObjectValid(oPackBoxA) == FALSE)
  {
    return TRUE;
  }
  else return FALSE;
}
