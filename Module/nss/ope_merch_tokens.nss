////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Pets - Conversation Tokens
//  ope_merch_tokens
//  by Don Anderson
//  dandersonru@msn.com
//
//  Sets up all Tokens for the Pet Merchant
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC      = GetPCSpeaker();
  object oMerch   = OBJECT_SELF;
  object oMod     = GetModule();

  //Pet Prices
  int nPetPrice = GetLocalInt(oMod,"PETPRICE");

  //Sale Price
  object oItem = GetItemPossessedBy(oPC,"PetControl");
  int nCost = GetLocalInt(oItem,"OPE_SALEPRICE");
  SetCustomToken(2101,IntToString(nCost));

  //Set Up the Pets in the Area
  string sPet = "Pet";
  int nNth = 1; object oObject; int nEndPrice;
  object oPet = GetNearestObjectByTag(sPet,oMerch,nNth);
  while(nNth <= 10 && GetIsObjectValid(oPet))
  {
    //Set Name of Pet
    string sName = GetName(oPet);
    SetCustomToken(2109 + nNth,sName);
    SetLocalString(oMerch,"NAME" + IntToString(nNth),sName);

    //Set Prices of Pet
    nEndPrice = FloatToInt(GetChallengeRating(oPet)) * nPetPrice;
    if(nEndPrice < 100) nEndPrice = 100;
    SetCustomToken(2209 + nNth,IntToString(nEndPrice));
    SetCustomToken(2309 + nNth,IntToString(nEndPrice/2));
    SetLocalInt(oMerch,"PRICE" + IntToString(nNth),nEndPrice);

    //Set Local Object and ResRef for Easy Access to NPC
    SetLocalObject(oPet,"OBJECT" + IntToString(nNth),oMerch);
    string sResRef = GetResRef(oPet);
    SetLocalString(oMerch,"RESREF" + IntToString(nNth),sResRef);

    nNth++;
    oPet = GetNearestObjectByTag(sPet,oMerch,nNth);
  }
}
