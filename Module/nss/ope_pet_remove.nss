////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_pet_remove
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the On Death Event.
//
////////////////////////////////////////////////////////////////////////////////

#include "ope_inc"

void main()
{
  object oAnimal = OBJECT_SELF;

  string sPC = GetLocalString(oAnimal, "OPE_OWNER_NAME");
  string sPCU = GetLocalString(oAnimal, "OPE_OWNER_UNIQUE");
  string sCheck = "";

  //First Find Our PC
  int nPC = 0;
  object oPC = GetFirstPC();
  while (GetIsObjectValid(oPC) == TRUE && nPC < 100)
  {
    sCheck = GetName(oPC);
    if(sCheck == sPC) break;
    nPC = nPC++;
    oPC = GetNextPC();
  }

  //Remove this Animal from PC
  DismissAnimal(oPC, oAnimal);

  //Tell Player What the Animal Total is
  SendMessageToPC(oPC,"Your Pet Has Died!");
}
