////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets
//  ope_set_buyp5
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pet Salesman Convo.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nNum = 5;

  //Price
  int nPrice = GetLocalInt(oNPC,"PRICE"+IntToString(nNum));

  //ResRef
  string sAnimal = GetLocalString(oNPC,"RESREF"+IntToString(nNum));

  SetLocalString(oPC,"OPE_CHOOSE_TYPE",sAnimal);
  SetLocalInt(oPC,"OPE_CHOOSE_PRICE",nPrice);
}
