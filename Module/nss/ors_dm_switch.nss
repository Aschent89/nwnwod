////////////////////////////////////////////////////////////////////////////////
//  DM Control Room Switch
//  ors_dm_switch
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Switch OnUsed Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void ActivateSwitch()
{
   DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(2.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void main()
{
    object oPC = GetLastUsedBy();
    object oMod = GetModule();
    object oSwitch = OBJECT_SELF;
    string sDB = ORS_GetDBString();

    string sSwitch = GetTag(oSwitch);

//:****************************************************************************/
//: CHANGE GLOBAL SYSTEMS ON AND OFF

    //Module Reload
    if(sSwitch == "DMReloadSwitch")
    {
      int nPrep = GetLocalInt(oMod,"RELOADPREP");
      if(nPrep == 0)
      {
        SetLocalInt(oMod,"RELOADPREP",1);
        ActivateSwitch();
        SpeakString("Reload is Prepared. Use this switch again within 20 Seconds to Start Module Reload.");
        DelayCommand(20.0,DeleteLocalInt(oMod,"RELOADPREP"));//So it does not stay Prepared
      }
      if(nPrep == 1)
      {
        ActivateSwitch();
        ExecuteScript("ors_dm_modreload",oMod);
      }
    }

    //Binding Stones System
    if(sSwitch == "DMBindingSwitch")
    {
      int BS_ENABLE = GetLocalInt(oMod,"BS_ENABLE");
      if(BS_ENABLE == 0)
      {
        SetLocalInt(oMod,"BS_ENABLE",1);
        ActivateSwitch();
        SpeakString("Binding Stones are now ON.");
      }
      if(BS_ENABLE == 1)
      {
        SetLocalInt(oMod,"BS_ENABLE",0);
        ActivateSwitch();
        SpeakString("Binding Stones are now OFF.");
      }
    }

    //Binding Stone Jump to Leader Switch
    if(sSwitch == "DMBindingStoneJTLSwitch")
    {
      int BSJUMP = GetLocalInt(oMod,"BSJUMP");
      if(BSJUMP == 0)
      {
        SetLocalInt(oMod,"BSJUMP",1);
        ActivateSwitch();
        SpeakString("Binding Stone Jump to Leader is now ON.");
      }
      if(BSJUMP == 1)
      {
        SetLocalInt(oMod,"BSJUMP",0);
        ActivateSwitch();
        SpeakString("Binding Stone Jump to Leader is now OFF.");
      }
    }

    //Bleeding and Death Reset Switch
    if(sSwitch == "DMDeathResetSwitch")
    {
      ActivateSwitch();
      SetLocalInt(oPC,"BLEED_STATUS",0);
      NBDE_SetCampaignInt(sDB,"BLEED_STATUS",0,oPC);

      SpeakString("Your Death and Bleeding have been Reset. This is NOT Lifes.");
      return;
    }

    //HTF System Globally
    if(sSwitch == "DMHTFSwitch")
    {
      int nHTFGLOBAL = GetLocalInt(oMod,"HTFGLOBAL");
      if(nHTFGLOBAL == 0)
      {
        SetLocalInt(oMod,"HTFGLOBAL",1);
        ActivateSwitch();
        SpeakString("HTF System is now ON.");
      }
      if(nHTFGLOBAL == 1)
      {
        SetLocalInt(oMod,"HTFGLOBAL",0);
        ActivateSwitch();
        SpeakString("HTF System is now OFF.");
      }
    }

    //HTF Hunger System
    if(sSwitch == "DMHungerSwitch")
    {
      int nHUNGERSYSTEM = GetLocalInt(oMod,"HUNGERSYSTEM");
      if(nHUNGERSYSTEM == 0)
      {
        SetLocalInt(oMod,"HUNGERSYSTEM",1);
        ActivateSwitch();
        SpeakString("HTF Hunger System is now ON.");
      }
      if(nHUNGERSYSTEM == 1)
      {
        SetLocalInt(oMod,"HUNGERSYSTEM",0);
        ActivateSwitch();
        SpeakString("HTF Hunger System is now OFF.");
      }
    }

    //HTF Fatigue System
    if(sSwitch == "DMFatigueSwitch")
    {
      int nFATIGUESYSTEM = GetLocalInt(oMod,"FATIGUESYSTEM");
      if(nFATIGUESYSTEM == 0)
      {
        SetLocalInt(oMod,"FATIGUESYSTEM",1);
        ActivateSwitch();
        SpeakString("HTF Hunger System is now ON.");
      }
      if(nFATIGUESYSTEM == 1)
      {
        SetLocalInt(oMod,"FATIGUESYSTEM",0);
        ActivateSwitch();
        SpeakString("HTF Hunger System is now OFF.");
      }
    }

    //HTF Debug System Globally
    if(sSwitch == "DMHTFDebugSwitch")
    {
      int nHTFGLOBAL = GetLocalInt(oMod,"HTFDEBUG");
      if(nHTFGLOBAL == 0)
      {
        SetLocalInt(oMod,"HTFDEBUG",1);
        ActivateSwitch();
        SpeakString("HTF Debug System is now ON.");
      }
      if(nHTFGLOBAL == 1)
      {
        SetLocalInt(oMod,"HTFDEBUG",0);
        ActivateSwitch();
        SpeakString("HTF Debug System is now OFF.");
      }
    }

    //DM HTF Player Reset Switch
    if(sSwitch == "DMHTFPlayerReset")
    {
      if(GetIsPC(oPC)==TRUE)
      {
        ActivateSwitch();

        string sDB = ORS_GetDBString();

        int nHungerHP       = GetLocalInt(oMod,"HUNGER");
        int nThirstHP       = GetLocalInt(oMod,"THIRST");
        int nFatigueHP      = GetLocalInt(oMod,"FATIGUE");

        //Now we make the data fresh for the player
        //Refrsh DB
        NBDE_SetCampaignInt(sDB,"HUNGER",nHungerHP,oPC);
        NBDE_SetCampaignInt(sDB,"THIRST",nThirstHP,oPC);
        NBDE_SetCampaignInt(sDB,"FATIGUE",nFatigueHP,oPC);
        NBDE_SetCampaignInt(sDB,"ALCTOTAL",0,oPC);

        //Set on Player
        SetLocalInt(oPC,"HUNGER",nHungerHP);
        SetLocalInt(oPC,"THIRST",nThirstHP);
        SetLocalInt(oPC,"FATIGUE",nFatigueHP);
        SetLocalInt(oPC,"ALCTOTAL",0);

        SpeakString("Your Hunger Thirst and Fatigue Has Been Reset.");
      }
    }

    //Resting System
    if(sSwitch == "DMRestingSwitch")
    {
      int nRESTGLOBAL = GetLocalInt(oMod,"RESTGLOBAL");
      if(nRESTGLOBAL == 0)
      {
        SetLocalInt(oMod,"RESTGLOBAL",1);
        ActivateSwitch();
        SpeakString("Resting System is now ON.");
      }
      if(nRESTGLOBAL == 1)
      {
        SetLocalInt(oMod,"RESTGLOBAL",0);
        ActivateSwitch();
        SpeakString("Resting System is now OFF.");
      }
    }

    //PHB Resting System
    if(sSwitch == "DMPHBRestingSwitch")
    {
      int nRESTPHB = GetLocalInt(oMod,"RESTPHB");
      if(nRESTPHB == 0)
      {
        SetLocalInt(oMod,"RESTPHB",1);
        ActivateSwitch();
        SpeakString("PHB Resting is now ON.");
      }
      if(nRESTPHB == 1)
      {
        SetLocalInt(oMod,"RESTPHB",0);
        ActivateSwitch();
        SpeakString("PHB Resting is now OFF.");
      }
    }

    //Crafting System
    if(sSwitch == "DMCraftingSwitch")
    {
      int nCRAFTGLOBAL = GetLocalInt(oMod,"CRAFTGLOBAL");
      if(nCRAFTGLOBAL == 0)
      {
        SetLocalInt(oMod,"CRAFTGLOBAL",1);
        ActivateSwitch();
        SpeakString("Crafting System is now ON.");
      }
      if(nCRAFTGLOBAL == 1)
      {
        SetLocalInt(oMod,"CRAFTGLOBAL",0);
        ActivateSwitch();
        SpeakString("Crafting System is now OFF.");
      }
    }

    //Crafting System
    if(sSwitch == "DMCraftingDeflectSwitch")
    {
      int nDEFLECTMESSAGE = GetLocalInt(oMod,"DEFLECTMESSAGE");
      if(nDEFLECTMESSAGE == 0)
      {
        SetLocalInt(oMod,"DEFLECTMESSAGE",1);
        ActivateSwitch();
        SpeakString("Crafting Deflection Messages are now ON.");
      }
      if(nDEFLECTMESSAGE == 1)
      {
        SetLocalInt(oMod,"DEFLECTMESSAGE",0);
        ActivateSwitch();
        SpeakString("Crafting Deflection Messages are now OFF.");
      }
    }

    //Crafting System
    if(sSwitch == "DMCraftingRollSwitch")
    {
      int nROLLMESSAGE = GetLocalInt(oMod,"ROLLMESSAGE");
      if(nROLLMESSAGE == 0)
      {
        SetLocalInt(oMod,"ROLLMESSAGE",1);
        ActivateSwitch();
        SpeakString("Crafting Roll Messages are now ON.");
      }
      if(nROLLMESSAGE == 1)
      {
        SetLocalInt(oMod,"ROLLMESSAGE",0);
        ActivateSwitch();
        SpeakString("Crafting Roll Messages are now OFF.");
      }
    }

    //Weather System
    if(sSwitch == "DMWeatherSwitch")
    {
      int nWEATHERGLOBAL = GetLocalInt(oMod,"WEATHERGLOBAL");
      if(nWEATHERGLOBAL == 0)
      {
        SetLocalInt(oMod,"WEATHERGLOBAL",1);
        ActivateSwitch();
        SpeakString("Weather System is now ON.");
      }
      if(nWEATHERGLOBAL == 1)
      {
        SetLocalInt(oMod,"WEATHERGLOBAL",0);
        ActivateSwitch();
        SpeakString("Weather System is now OFF.");
      }
    }

    //Sky Box Disable System
    if(sSwitch == "DMSkyBoxSwitch")
    {
      int nWEATHERSKYBOX = GetLocalInt(oMod,"WEATHERSKYBOX");
      if(nWEATHERSKYBOX == 0)
      {
        SetLocalInt(oMod,"WEATHERSKYBOX",1);
        ActivateSwitch();
        SpeakString("Dynamic Sky Box System is now ON.");
      }
      if(nWEATHERSKYBOX == 1)
      {
        SetLocalInt(oMod,"WEATHERSKYBOX",0);
        ActivateSwitch();
        SpeakString("Dynamic Sky Box System is now OFF.");
      }
    }

    //DM Inventory Cleaner (Will Clean out Everything except Creature Stuff (For Subrace)!!!)
    if(sSwitch == "DMInventoryCleanerSwitch")
    {
      int nPrep = GetLocalInt(oSwitch,"CLEANPREP");
      if(nPrep == 0)
      {
        SetLocalInt(oSwitch,"CLEANPREP",1);
        ActivateSwitch();
        SpeakString("Cleaner is Prepared! Use this Switch again within 10 Seconds to Clean your inventory.");
        DelayCommand(10.0,DeleteLocalInt(oSwitch,"CLEANPREP"));//So it does not stay Prepared
      }
      if(nPrep == 1)
      {
        ActivateSwitch();
        //Now we Destroy all the objects in the inventory
        object oItem = GetFirstItemInInventory(oPC);
        while (oItem != OBJECT_INVALID)
        {
          DestroyObject(oItem);
          oItem = GetNextItemInInventory(oPC);
        }
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC), 0.0);
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC), 0.0);

        SpeakString("Your Inventory has been Cleansed.");

        //Now give a Basic Robe
        object oRobe = CreateItemOnObject("nw_cloth007",oPC);
        AssignCommand(oPC,ActionEquipItem(oRobe,INVENTORY_SLOT_CHEST));
      }
    }

    //Allegiance Reset Switch
    if(sSwitch == "DMAllegianceResetSwitch")
    {
      int nPrep = GetLocalInt(oSwitch,"ALRESETPREP");
      if(nPrep == 0)
      {
        SetLocalInt(oSwitch,"ALRESETPREP",1);
        ActivateSwitch();
        SpeakString("Allegiance Reset is Prepared! Use this Switch again within 10 Seconds to Reset your Allegiance.");
        DelayCommand(10.0,DeleteLocalInt(oSwitch,"ALRESETPREP"));//So it does not stay Prepared
      }
      if(nPrep == 1)
      {
        ActivateSwitch();

        //Destroy Allegiance Skin
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), 0.0);

        //Now Give a PC Property Skin
        object oSkin = CreateItemOnObject("ors_pcskin",oPC);
        AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
        SetLocalObject(oPC,"oX3_Skin",oSkin);

        //Now Update Player
        string sDB = GetLocalString(oMod,"ORS_DATABASE");
        NBDE_SetCampaignInt(sDB, "ORS_ALIGN", 0, oPC);
        NBDE_SetCampaignString(sDB,"ORS_ALIGN_SKIN","",oPC);
        SetSubRace(oPC, "");
        SpeakString("Your Allegiance has been Reset. Please Align Once Again.");
      }
    }

    //Player Jumping to Leader
    if(sSwitch == "DMLeaderJump")
    {
      int nJump = GetLocalInt(oMod,"LEADERJUMP");
      if(nJump == 0)
      {
        SetLocalInt(oMod,"LEADERJUMP",1);
        ActivateSwitch();
        SpeakString("ORM Porting to Leader is now ON.");
      }
      if(nJump == 1)
      {
        SetLocalInt(oMod,"LEADERJUMP",0);
        ActivateSwitch();
        SpeakString("ORM Porting to Leader is now OFF.");
      }
    }

    //OAI Critical System
    if(sSwitch == "DMOAICriticalSwitch")
    {
      int nOAICRIT = GetLocalInt(oMod,"OAICRIT");
      if(nOAICRIT == 0)
      {
        SetLocalInt(oMod,"OAICRIT",1);
        ActivateSwitch();
        SpeakString("OAI Critical System is now ON.");
      }
      if(nOAICRIT == 1)
      {
        SetLocalInt(oMod,"OAICRIT",0);
        ActivateSwitch();
        SpeakString("OAI Critical System is now OFF.");
      }
    }

    //DM Enchanting Book Reset
    if(sSwitch == "DMEncBookResetSwitch")
    {
      if(GetIsPC(oPC) == TRUE)
      {
        ActivateSwitch();

        object oBook = GetItemPossessedBy(oPC,"BookofEnchanting");
        DeleteLocalInt(oBook,"ENC_REG");
        DeleteLocalInt(oBook,"ENCHANTING_LVL");

        SpeakString("Your Enchanting Book Has Been Reset.");
      }
    }

    //DM Enchanting Book Add 4
    if(sSwitch == "DMEncBookAdd4Switch")
    {
      if(GetIsPC(oPC)==TRUE)
      {
        ActivateSwitch();

        object oBook    = GetItemPossessedBy(oPC,"BookofEnchanting");
        int nLevel      = GetLocalInt(oBook,"ENCHANTING_LVL");

        nLevel = nLevel + 4;
        if(nLevel <= 20) SetLocalInt(oBook,"ENCHANTING_LVL",nLevel);

        if(nLevel <= 20) SpeakString("Your Enchanting Book now has "+IntToString(nLevel)+" College Credits.");
      }
    }

    //DM Herbology Book Reset
    if(sSwitch == "DMHerBookResetSwitch")
    {
      if(GetIsPC(oPC) == TRUE)
      {
        ActivateSwitch();

        object oBook = GetItemPossessedBy(oPC,"BookofHerbology");
        DeleteLocalInt(oBook,"HERB_REG");
        DeleteLocalInt(oBook,"HERBOLOGY_LVL");

        SpeakString("Your Herbology Book Has Been Reset.");
      }
    }

    //DM Herbology Book Add 4
    if(sSwitch == "DMHerBookAdd4Switch")
    {
      if(GetIsPC(oPC)==TRUE)
      {
        ActivateSwitch();

        object oBook    = GetItemPossessedBy(oPC,"BookofEnchanting");
        int nLevel      = GetLocalInt(oBook,"HERBOLOGY_LVL");

        nLevel = nLevel + 4;
        if(nLevel <= 20) SetLocalInt(oBook,"HERBOLOGY_LVL",nLevel);

        if(nLevel <= 20) SpeakString("Your Herbology Book now has "+IntToString(nLevel)+" College Credits.");
      }
    }

    //DM Smithing Book Reset
    if(sSwitch == "DMSmiBookResetSwitch")
    {
      if(GetIsPC(oPC) == TRUE)
      {
        ActivateSwitch();

        object oBook = GetItemPossessedBy(oPC,"BookofSmithing");
        DeleteLocalInt(oBook,"BLK_REG");
        DeleteLocalInt(oBook,"HERBOLOGY_LVL");

        SpeakString("Your Smithing Book Has Been Reset.");
      }
    }

    //DM Smithing Book Add 4
    if(sSwitch == "DMSmiBookAdd4Switch")
    {
      if(GetIsPC(oPC)==TRUE)
      {
        ActivateSwitch();

        object oBook    = GetItemPossessedBy(oPC,"BookofSmithing");
        int nLevel      = GetLocalInt(oBook,"SMITHING_LVL");

        nLevel = nLevel + 4;
        if(nLevel <= 20) SetLocalInt(oBook,"SMITHING_LVL",nLevel);

        if(nLevel <= 20) SpeakString("Your Smithing Book now has "+IntToString(nLevel)+" College Credits.");
      }
    }

    //DM Woodworking Book Reset
    if(sSwitch == "DMWdwBookResetSwitch")
    {
      if(GetIsPC(oPC) == TRUE)
      {
        ActivateSwitch();

        object oBook = GetItemPossessedBy(oPC,"BookofWoodworking");
        DeleteLocalInt(oBook,"WDW_REG");
        DeleteLocalInt(oBook,"WOODWORKING_LVL");

        SpeakString("Your Woodworking Book Has Been Reset.");
      }
    }

    //DM Woodworking Book Add 4
    if(sSwitch == "DMWdwBookAdd4Switch")
    {
      if(GetIsPC(oPC)==TRUE)
      {
        ActivateSwitch();

        object oBook    = GetItemPossessedBy(oPC,"BookofWoodworking");
        int nLevel      = GetLocalInt(oBook,"WOODWORKING_LVL");

        nLevel = nLevel + 4;
        if(nLevel <= 20) SetLocalInt(oBook,"WOODWORKING_LVL",nLevel);

        if(nLevel <= 20) SpeakString("Your Woodworking Book now has "+IntToString(nLevel)+" College Credits.");
      }
    }

    //DM Wing Adder Switch
    if(sSwitch == "DMWingSwitch")
    {
      ActivateSwitch();

      int nWing = GetCreatureWingType(oPC);
      int nNWing = nWing + 1;
      if(nNWing > 6) nNWing = 0;

      SetCreatureWingType(nNWing,oPC);
    }

    //DM Tail Adder Switch
    if(sSwitch == "DMTailSwitch")
    {
      ActivateSwitch();

      int nTail = GetCreatureTailType(oPC);
      int nNTail = nTail + 1;
      if(nNTail > 3) nNTail = 0;

      SetCreatureTailType(nNTail,oPC);
    }

    //DM Phenotype Changer Switch
    if(sSwitch == "DMPhenoSwitch")
    {
      ActivateSwitch();

      int nPheno = GetPhenoType(oPC);
      if(nPheno > PHENOTYPE_NORMAL)
      {
        SetPhenoType(PHENOTYPE_NORMAL,oPC);
        return;
      }

      if(nPheno == PHENOTYPE_NORMAL)
      {
        SetPhenoType(PHENOTYPE_BIG,oPC);
        return;
      }
    }

    //Tutorial Kill Self
    if(sSwitch == "TutorialKillSelf")
    {
      ActivateSwitch();

      int nHP = GetCurrentHitPoints(oPC);
      effect eKillPC = EffectDamage(nHP + 1000);
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eKillPC,oPC);
    }

    //Tutorial Set to Good
    if(sSwitch == "TutorialSettoGood")
    {
      ActivateSwitch();

      AdjustAlignment(oPC, ALIGNMENT_GOOD, 100, FALSE);
    }

    //Tutorial Set to Neutral
    if(sSwitch == "TutorialSettoNeutral")
    {
      ActivateSwitch();

      AdjustAlignment(oPC, ALIGNMENT_NEUTRAL, 50, FALSE);
    }

    //Tutorial Set to Evil
    if(sSwitch == "TutorialSettoEvil")
    {
      ActivateSwitch();

      AdjustAlignment(oPC, ALIGNMENT_EVIL, 100, FALSE);
    }
}
