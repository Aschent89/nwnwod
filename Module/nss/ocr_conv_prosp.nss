////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Prospecting Ore and Plants
//  ocr_conv_prosp
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is will make useable any placeables within 10 Meters that have the
//  OCR_RESOURCE Variable Set to 1
//
//  The Resource will Set Itself back to Non-Usable after sometime via a
//  Psuedo HB (30 Secs)
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC  = GetPCSpeaker();
    object oMod = GetModule();

    //Lore Required
    int nRLore = GetLocalInt(oMod,"OCR_LORE");
    if(nRLore <= 0) nRLore = 10;

    //Player's Lore Skill (Raw Skill)
    int nPLore = GetSkillRank(SKILL_LORE,oPC);

    //Total Natural Herbal Bonuses
    int nHerb = 0;
    if(GetRacialType(oPC) == RACIAL_TYPE_ELF) nHerb = nHerb + 2;
    if(GetClassByPosition(1,oPC) == CLASS_TYPE_DRUID) nHerb = nHerb + 5;
    if(GetClassByPosition(1,oPC) == CLASS_TYPE_RANGER) nHerb = nHerb + 5;

    //Total Natural Ore Bonuses
    int nOre = 0;
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF) nOre = nOre + 5;
    if(GetRacialType(oPC) == RACIAL_TYPE_HUMAN) nOre = nOre + 2;

    int nOCR = 0;int nTHerb; int nTOre;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPC), TRUE, OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
      nOCR = GetLocalInt(oTarget,"OCR_RESOURCE");

      //Placeable is a Resource
      if(nOCR == 1)
      {
        nTHerb = GetLocalInt(oTarget,"OCR_HERB");
        if(nTHerb == 1)
        {
          if((nPLore + nHerb) >= nRLore)
          {
            SetUseableFlag(oTarget,TRUE);
            DelayCommand(2.0, ExecuteScript("ocr_hb_resource", oTarget));
          }
        }

        nTOre = GetLocalInt(oTarget,"OCR_ORE");
        if(nTOre == 1)
        {
          if((nPLore + nOre) >= nRLore)
          {
            SetUseableFlag(oTarget,TRUE);
            DelayCommand(2.0, ExecuteScript("ocr_hb_resource", oTarget));
          }
        }
      }

      oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(oPC), TRUE, OBJECT_TYPE_PLACEABLE);
    }
}

