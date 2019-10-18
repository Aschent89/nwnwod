////////////////////////////////////////////////////////////////////////////////
//
//  Conversation Tokens for Horses
//  oho_merch_tokens
//  by Don Anderson
//  dandersonru@msn.com
//
//  Sets up all Tokens for the Horse Merchant
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC      = GetPCSpeaker();
  object oMerch   = OBJECT_SELF;
  object oMod     = GetModule();

  //Prices
  int nPrice = GetLocalInt(oMod,"HORSEPRICE");

  //Sale Price
  object oItem = GetItemPossessedBy(oPC,"HorseControl");
  int nCost = GetLocalInt(oItem,"OHO_SALEPRICE");
  SetCustomToken(2101,IntToString(nCost));

  //Set Up the Animals in the Area
  string sAnimal = "Horse";
  int nNth = 1; object oObject; int nEndPrice;
  object oAnimal = GetNearestObjectByTag(sAnimal,oMerch,nNth);
  while(nNth <= 10 && GetIsObjectValid(oAnimal))
  {
    //Set Name of Animal
    string sName = GetName(oAnimal);
    SetCustomToken(2109 + nNth,sName);
    SetLocalString(oMerch,"NAME" + IntToString(nNth),sName);

    //Set Prices of Animal
    nEndPrice = FloatToInt(GetChallengeRating(oAnimal)) * nPrice;
    if(nEndPrice < 100) nEndPrice = 100;
    SetCustomToken(2209 + nNth,IntToString(nEndPrice));
    SetCustomToken(2309 + nNth,IntToString(nEndPrice/2));
    SetLocalInt(oMerch,"PRICE" + IntToString(nNth),nEndPrice);

    //Set Local Object and ResRef for Easy Access to NPC
    SetLocalObject(oAnimal,"OBJECT" + IntToString(nNth),oMerch);
    string sResRef = GetResRef(oAnimal);
    SetLocalString(oMerch,"RESREF" + IntToString(nNth),sResRef);

    nNth++;
    oAnimal = GetNearestObjectByTag(sAnimal,oMerch,nNth);
  }
}
