////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Herbology Crafting
//  ocr_oc_herb
//  Modified by Don Anderson
//
//  Original Script From - Ståle Kvernes
//
//  This is placed on the On Closed Event of the Cook Pot
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC   = GetLastClosedBy();
    object oSelf = OBJECT_SELF;

    //Don't bother going through the script if inventory is empty
    object oItem = GetFirstItemInInventory(oSelf);
    if(!GetIsObjectValid(oItem)) return;

    object oArea = GetArea(oPC);
    int nArea = GetIsAreaNatural(oArea);

    //Set Campfire back up if in a Natural Area
    if(nArea == TRUE)
    {
      DestroyObject(oSelf) ;
      CreateObject(OBJECT_TYPE_PLACEABLE, "campfire", GetLocation(oSelf));
      return;
    }

    //We need to get the Skill Level of the Player
    int nSkill = GetSkillRank(SKILL_LORE, oPC);

    //Set all the components to 0
    int comp01=0; int comp02=0; int comp03=0; int comp04=0; int comp05=0;
    int comp06=0; int comp07=0; int comp08=0; int comp09=0; int comp10=0;
    int comp11=0; int comp12=0; int comp13=0; int comp14=0; int comp15=0;
    int comp16=0; int comp17=0; int comp18=0; int comp19=0; int comp20=0;
    int comp21=0; int comp22=0;

    //Check for the Cook Pot and Set up Skill Checks/Rolls
    if(GetIsObjectValid(oSelf))
    {
      int nWis = GetAbilityModifier(ABILITY_WISDOM,oPC);
      nSkill = nWis + nSkill;
      int nD20 = d20();
      nSkill = nSkill + nD20;
      string sTag; int nEnd; int nStack = 1; int nBoost = 0; int DC; int nFailed = TRUE;
      string sItemToCreate = "";
      string sItemName = "";

      //Check Components in Inventory
      object oComponent = GetFirstItemInInventory(oSelf);
      while(GetIsObjectValid(oComponent))
      {
        sTag = GetTag(oComponent);
        nStack = GetNumStackedItems(oComponent);
        if(sTag == "Archangel") comp01+=nStack;
        if(sTag == "Cereus") comp02+=nStack;
        if(sTag == "Cohosh") comp03+=nStack;
        if(sTag == "Darkmous") comp04+=nStack;
        if(sTag == "Digitalis") comp05+=nStack;
        if(sTag == "Eyebright") comp06+=nStack;
        if(sTag == "Ginseng") comp07+=nStack;
        if(sTag == "Henbane") comp08+=nStack;
        if(sTag == "Maidenhair") comp09+=nStack;
        if(sTag == "Milfoil") comp10+=nStack;
        if(sTag == "Pennyroyal") comp11+=nStack;
        if(sTag == "Pinang") comp12+=nStack;
        if(sTag == "Spoonwort") comp13+=nStack;
        if(sTag == "Suma") comp14+=nStack;
        if(sTag == "Sumach") comp15+=nStack;
        if(sTag == "Tansy") comp16+=nStack;
        if(sTag == "Valerian") comp17+=nStack;
        if(sTag == "WildIndigo") comp18+=nStack;
        if(sTag == "Wintergreen") comp19+=nStack;
        if(sTag == "Wormwood") comp20+=nStack;
        if(sTag == "x2_it_cfm_pbottl") comp21+=nStack;//Magic Potion Bottle
        if(sTag == "x2_it_amt_cpadd") comp22+=nStack;//Wool Cloth Pads

        oComponent = GetNextItemInInventory(oSelf);
      }
      nSkill = nSkill + nBoost;

/******************************************************************************/
//: ELIXIRS/POTIONS SECTION

      /* Elixir of Aid DC20 */
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==10 &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==5  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 20;

        if(nSkill > DC)
        {
          sItemToCreate = "aid";
          sItemName = "Elixir of Aid";
          nFailed = FALSE;
        }
      }

      // Bandage DC5
      else
      if(
         comp01==5  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==5  &&
         comp10==5  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==5  &&
         comp17==0  &&
         comp18==5  &&
         comp19==0  &&
         comp20==0  &&
         comp21==0  &&
         comp22==1  )
      {
        DC = 5;

        if(nSkill > DC)
        {
          sItemToCreate = "bandage";
          sItemName = "Bandage";
          nFailed = FALSE;
        }
      }

      // Elixir of Antidote DC7
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==5  &&
         comp06==0  &&
         comp07==0  &&
         comp08==5  &&
         comp09==0  &&
         comp10==0  &&
         comp11==5  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 7;

        if(nSkill > DC)
        {
          sItemToCreate = "antidote";
          sItemName = "Elixir of Antidote";
          nFailed = FALSE;
        }
      }

      // Elixir of Clarity DC30
      else
      if(
         comp01==0  &&
         comp02==5  &&
         comp03==0  &&
         comp04==5  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==5  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==5  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 30;

        if(nSkill > DC)
        {
          sItemToCreate = "clarity";
          sItemName = "Elixir of Clarity";
          nFailed = FALSE;
        }
      }

      // Elixir of Quickness DC30
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==10 &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==10 &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 30;

        if(nSkill > DC)
        {
          sItemToCreate = "quickness";
          sItemName = "Elixir of Quickness";
          nFailed = FALSE;
        }
      }

      //Elixir of Strength DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==5  &&
         comp15==0  &&
         comp16==0  &&
         comp17==10 &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "strength";
          sItemName = "Elixir of Strength";
          nFailed = FALSE;
        }
      }

      // Elixir of Dexterity DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==5  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==10 &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "dexterity";
          sItemName = "Elixir of Dexterity";
          nFailed = FALSE;
        }
      }

      // Elixir of Endurance DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==5  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==5  &&
         comp14==10 &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "endurance";
          sItemName = "Elixir of Endurance";
          nFailed = FALSE;
        }
      }

      // Elixir of Intelligence DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==5  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==5  &&
         comp19==0  &&
         comp20==10 &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "intelligence";
          sItemName = "Elixir of Intelligence";
          nFailed = FALSE;
        }
      }

      // Elixir of Wisdom DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==10 &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==5  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "wisdom";
          sItemName = "Elixir of Wisdom";
          nFailed = FALSE;
        }
      }

      // Elixir of Beauty DC15
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==0  &&
         comp06==10 &&
         comp07==0  &&
         comp08==5  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==5  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 15;

        if(nSkill > DC)
        {
          sItemToCreate = "charisma";
          sItemName = "Elixir of Beauty";
          nFailed = FALSE;
        }
      }

      // Elixir of Lesser Restoration DC20
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==5  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==5  &&
         comp13==5  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 20;

        if(nSkill > DC)
        {
          sItemToCreate = "l_restore";
          sItemName = "Elixir of Lesser Restoration";
          nFailed = FALSE;
        }
      }

      // Elixir of Restoration DC30
      else
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==5  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==5  &&
         comp09==0  &&
         comp10==0  &&
         comp11==5  &&
         comp12==5  &&
         comp13==10 &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==1  &&
         comp22==0  )
      {
        DC = 30;

        if(nSkill > DC)
        {
          sItemToCreate = "restore";
          sItemName = "Elixir of Restoration";
          nFailed = FALSE;
        }
      }
      else nFailed = TRUE;

//: END OF ELIXIRS/POTIONS
/******************************************************************************/

      //Cleanup of Herbs and Catalysts
      oComponent = GetFirstItemInInventory(oSelf);
      while(GetIsObjectValid(oComponent))
      {
        DestroyObject(oComponent);
        oComponent = GetNextItemInInventory(oSelf);
      }
      if(nFailed == FALSE)
      {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT),oPC,2.5);
        CreateItemOnObject(sItemToCreate);
        DelayCommand(0.5,SendMessageToPC(oPC,"Sucess! "+ sItemName +" was hand crafted nicely. Rolled "+IntToString(nSkill)+" DC="+IntToString(DC)));
      }
      if(nFailed == TRUE)
      {
        if(DC == 0)
        {
          DelayCommand(0.5,SendMessageToPC(oPC,"I really botched that recipe. I need to pay more attention to the recipe."));
        }
        else DelayCommand(0.5,SendMessageToPC(oPC,"Darn it anyhow. I ruined that one. Rolled "+IntToString(nSkill)+" DC="+IntToString(DC)));
      }
    }

    //Lock for 10 Seconds
    SetLocked(oSelf,TRUE);
    DelayCommand(10.0,AssignCommand(oSelf,SetLocked(oSelf,FALSE)));
}

/*


CUSTOM RECIPES CAN BE ADDED BY THE FOLLOWING:

      //<NAME> DC - **

      //Change each quantity after the == to the number of herbs required for the recipe
      if(
         comp01==0  &&
         comp02==0  &&
         comp03==0  &&
         comp04==0  &&
         comp05==0  &&
         comp06==0  &&
         comp07==0  &&
         comp08==0  &&
         comp09==0  &&
         comp10==0  &&
         comp11==0  &&
         comp12==0  &&
         comp13==0  &&
         comp14==0  &&
         comp15==0  &&
         comp16==0  &&
         comp17==0  &&
         comp18==0  &&
         comp19==0  &&
         comp20==0  &&
         comp21==0  )
      {
          DC = 25; //Change this to the difficulty of the recipe

          if(nSkill>=DC)
          {
            sItemToCreate = "<TAG NAME>";
            sItemName = "<ITEM NAME>";
            nFailed = FALSE;
          }
        }


*/

