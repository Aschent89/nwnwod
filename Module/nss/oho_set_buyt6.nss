////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_set_buyt6
//  By Don Anderson
//  dandersonru@msn.com
//
//  This script is called from the Animal Salesman Convo.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nNum = 6;

  //Price
  int nPrice = GetLocalInt(oNPC,"PRICE"+IntToString(nNum));

  //ResRef
  string sAnimal = GetLocalString(oNPC,"RESREF"+IntToString(nNum));

  SetLocalString(oPC,"OHO_CHOOSE_WP","HorseShop");
  SetLocalString(oPC,"OHO_CHOOSE_TYPE",sAnimal);
  SetLocalInt(oPC,"OHO_CHOOSE_PRICE",nPrice);
}
