////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pack Animals
//  opa_set_buyt4
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Pack Animal Salesman Convo.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nNum = 4;

  //Price
  int nPrice = GetLocalInt(oNPC,"PRICE"+IntToString(nNum));

  //ResRef
  string sAnimal = GetLocalString(oNPC,"RESREF"+IntToString(nNum));

  SetLocalString(oPC,"OPA_CHOOSE_WP","PackAnimalShop");
  SetLocalString(oPC,"OPA_CHOOSE_TYPE",sAnimal);
  SetLocalInt(oPC,"OPA_CHOOSE_PRICE",nPrice);
}
