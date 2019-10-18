////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Lounge Placeables
//  ors_lounge
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable OnUsed Event
//
////////////////////////////////////////////////////////////////////////////////

//Gets a Drink From a Keg for Cost
void GetCupGP(object oPC,string sResRef);

//Gets a Drink From a Keg for Free
void GetCupFR(object oPC,string sResRef);

void main()
{
  object oPC = GetLastUsedBy();
  object oArea = GetArea(oPC);
  object oPlace = OBJECT_SELF;
  string sPlace = GetTag(oPlace);

  //ResRefs Used
  string sDarkAle = "cupofdarkale";
  string sPaleAle = "cupofpaleale";
  string sPilsner = "cupofpilsner";
  string sRedWine = "cupofredwine";
  string sWhiteWine = "cupofwhitewine";

  //Cost
  if(sPlace == "DarkAle") { GetCupGP(oPC,sDarkAle);return; }
  if(sPlace == "PaleAle") { GetCupGP(oPC,sPaleAle);return; }
  if(sPlace == "Pilsner") { GetCupGP(oPC,sPilsner);return; }
  if(sPlace == "RedWine") { GetCupGP(oPC,sRedWine);return; }
  if(sPlace == "WhiteWine") { GetCupGP(oPC,sWhiteWine);return; }

  //Free
  if(sPlace == "DarkAleFree") { GetCupFR(oPC,sDarkAle);return; }
  if(sPlace == "PaleAleFree") { GetCupFR(oPC,sPaleAle);return; }
  if(sPlace == "PilsnerFree") { GetCupFR(oPC,sPilsner);return; }
  if(sPlace == "RedWineFree") { GetCupFR(oPC,sRedWine);return; }
  if(sPlace == "WhiteWineFree") { GetCupFR(oPC,sWhiteWine);return; }
}

void GetCupGP(object oPC,string sResRef)
{
   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0));
   DelayCommand(1.0,PlaySound("fs_water_hard1"));
   object oItem = CreateItemOnObject(sResRef,oPC, 1);
   int nCost = GetGoldPieceValue(oItem);
   TakeGoldFromCreature(nCost,oPC,TRUE);
   SetStolenFlag(oItem,TRUE);
}

void GetCupFR(object oPC,string sResRef)
{
   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0));
   DelayCommand(1.0,PlaySound("fs_water_hard1"));
   object oItem = CreateItemOnObject(sResRef,oPC, 1);
   SetStolenFlag(oItem,TRUE);
}
