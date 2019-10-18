////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Lore Based Automatic ID
//  ors_conv_autoid
//  By Don Anderson
//
//  Called from the Rest Menu
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
   object oPC = GetPCSpeaker();
   object oInventory = GetFirstItemInInventory(oPC);

   int nAmount = (GetSkillRank(SKILL_LORE, oPC)/4) + 1;

   //Check for Lore Level
   int nMyLore = GetSkillRank(SKILL_LORE, oPC);
   int nItemValue;
   string sMaxValue = Get2DAString("SkillVsItemCost", "DeviceCostMax", nMyLore);
   int nMaxValue = StringToInt(sMaxValue);

   //Max Value Set for weird stuff
   if (sMaxValue == "") nMaxValue = 120000000;

   //Crap Lore....Quit
   if (nMyLore < 1) return;

   while(oInventory != OBJECT_INVALID)
   {
     //Set Inventory to Identified to All that can
     if(!GetIdentified(oInventory))
     {
       SetIdentified(oInventory, TRUE);
       nItemValue = GetGoldPieceValue(oInventory);
       SetIdentified(oInventory, FALSE);

       if(nMaxValue >= nItemValue)
       {
         SetIdentified(oInventory, TRUE);
         SendMessageToPC(oPC, GetName(OBJECT_SELF) + " " +  GetStringByStrRef(75930) + " " + GetName(oInventory));
       }
     }
     oInventory = GetNextItemInInventory(oPC);
   }

   //Make Visual Effect
   effect eVisual = EffectVisualEffect(VFX_IMP_HEAD_MIND);
   DelayCommand(15.0 - (nAmount * 1.0) , ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC));
   SendMessageToPC(oPC, "All items capable of being Identified...have been.");
}
