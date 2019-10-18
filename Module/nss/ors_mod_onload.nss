////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Master Configurations Script
//  ors_mod_onload
//  By Don Anderson
//  dandersonru@msn.com
//
/*

This is a master configurations script for the module load. This centers all the
Olander's Realistic Systems configurations to 1 location. This is the ONLY place
you will have to come to get your World configured how you wish.

If you are not using all of the stuff below....not a problem. The Systems you use or
choose will only use what they need!

NOTE:
There are also specific tweaks and configurations specific to a particular system
like tweaking intensity values to HTF. You should not have to touch this kind of
stuff so I have not provided it here. If you wish to play with them...be my guest.
break it and start hammering me about why something doesn't work is just plain
irresponsible!

Cheers!

Olander

*/
//
//  This goes in the Module On Load Event FIRST IN THE LIST OF wrap_mod_onload !!!
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_restsys"

void main()
{
    object oMod = GetModule();

//:****************************************************************************/
//: OLANDER'S MODULE CONFIGS

    //DM Control Switch Module Restart
    //Module Name - This is your file name!!
    string sMODNAME = "White Wolf Final Nights";
    AssignCommand(oMod,SetLocalString(oMod,"MODNAME",sMODNAME));

    //Module Campaign Name (Used for ALL ORSv5 Databases)
    //NOTE: Some DBs are System Specific and are on their Own.
    string sORS_DATABASE = "ORSv5DB";
    AssignCommand(oMod,SetLocalString(oMod,"ORS_DATABASE",sORS_DATABASE));

    //Module Minutes Per Hour Setting
    //Please set to Multiples of 2 and 60 is max!!
    int nMPH = 8;//Minutes Per Hour Setting
    AssignCommand(oMod,SetLocalInt(oMod,"MPH",nMPH));

    //MODULE LOADED AND RUNNING PROPERLY
    int nRUNNING = GetLocalInt(oMod,"MODULE_RUNNING");
    if(nRUNNING <= 0)
    {
      DelayCommand(300.0,AssignCommand(oMod,SetLocalInt(oMod,"MODULE_RUNNING",1)));
    }

    //Require Player Alignment
    /*
      This means a Player Must Ally to an Allegiance Sign to be able to access the Realm Portal
    */
    int nORS_ALIGN = 0;//(0 is OFF)
    AssignCommand(oMod,SetLocalInt(oMod,"ORS_ALIGN",nORS_ALIGN));

    //Module PvP Mode
    /*
      PvP is very troublesome in this game. Players can set themselves hostile
      to each other easy enough.....however.....unless the AI Creature's Factions
      are set up properly (Hostile works reliably) the AI creatures have a really
      tough time trying to figure out who is the enemy/ally.

      So....in the OAI (Not NWN Default) I have coded up methods for NPCs to figure out
      who is who for ALL your Custom Factions.

      This Principle is Based Upon AXIS, NEUTRAL, and ALLY

      These strings are set up on the Player so that NPCs will 'think' the Player is
      just another NPC in terms of Alliance.

      So....if you want Evil vs. Good in Full PvP.....then that is what you will get. In
      Ally Mode ALL Players are on the same side regardless of Alignment.

      Neutral Aligned Character
      - You can Disallow Neutral Characters....Recommended for PvP.

      PvP Mode:
      - Evil Aligned Players are the AXIS
      - Good Aligned Players are the ALLY
      - Neutral Aligned Players are the NEUTRAL (If Enabled)
        (If Not Enabled....Neutral goes to the ALLY side)

      Ally Mode:
      - ALL Players go to ALLY
    */
    int nNeutral =  1;//Allow Neutral Alignment Character....PvP Game Exploit (0 is Disallow)
    AssignCommand(oMod,SetLocalInt(oMod,"NEUTRAL_ALLOW",nNeutral));

    int nPvPMode =  0;//1 = PvP Mode, 0 = Ally Mode
    AssignCommand(oMod,SetLocalInt(oMod,"PVP_MODE",nPvPMode));

    int nGONG = 1;//Gongs ...yep Gongs. Turn them off by setting this to 0
    AssignCommand(oMod,SetLocalInt(oMod,"GONG",nGONG));

    //Clock Syncing
    /*
        Is your Module Time Clock not working properly? Will not cooperate?
        Well this is an indication that your module is under a great strain.
        You have a bunch of stuff functioning the module is laggin out or
        something strange is happening.

        Turn this beauty on to Sync the Module Clock. You Module will STILL
        be under strain but at least your Clock and timing will work again.
        This is on a 30Second Permanent Interval.
    */
    int nCLOCKSYNC = 1;//Set this to Clock Syncing (0 is OFF)
    AssignCommand(oMod,SetLocalInt(oMod,"CLOCKSYNC",nCLOCKSYNC));
    AssignCommand(oMod,ExecuteScript("ors_timesync",oMod));

    //Small Creature Movement Penalities
    //10% Speed decrease for Small Creatures and Dwarves (Used In Crafting and AI)
    int nRACIALMOVE    = 0;//Allow speed penalty to Racial Movement Rates PHB 3.5 (0 is Off)
    AssignCommand(oMod,SetLocalInt(oMod,"RACIALMOVE",nRACIALMOVE));
    AssignCommand(oMod,SetLocalInt(oMod,"SML_CREATURE_MOVEPEN",10));

    //Armor Movement Penalities
    //Movement penalty for wearing Armor % decrease in speeds
    int nARMORMOVE  = 0;//Allow speed penalty to Armor Movement Rates (0 is Off)
    int nARMOR10    = 5;//For Light Armors
    int nARMOR20    =10;//For Medium Armors
    int nARMOR30    =15;//For Heavy Armors
    AssignCommand(oMod,SetLocalInt(oMod,"ARMORMOVE",nARMORMOVE));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMOR10",nARMOR10));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMOR20",nARMOR20));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMOR30",nARMOR30));


SetLocalString(GetModule(), "X2_S_UD_SPELLSCRIPT", "vamp_spells"); //local varible for vampire scripts
//:****************************************************************************/
//: OLANDER'S ILLEGAL ITEMS AND ITEM PROPERTIES

    //NOTE: Temporary Effects on Items will be removed at every Player Log In. This is
    //      not part of the configurations below.

    //Illegal Items and Item Properties
    /*
      What will happen is Illegal Items will be Destroyed where Illegal Properties
      will be removed from each item possesing it/them. This makes it SUPER Easy to get rid of
      items that are no longer acceptable for players to have or are not needed in the module at
      a particular time....DM Event....Etc.

      There is NO Reimbursement Code to give Gold or Replace with an Item. This is a DM's Job.

      Note: Illegal Items must have Tags placed below NOT ResRefs
            Item Properties use the Game Engine Constants

      Formats:   # = 1 to 999
      AssignCommand(oMod,SetLocalString(oMod,"ILLEGALITEM#","ItemTag"));
      AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP#",ITEM_PROPERTY_#########));
    */
    int nILLItemQTY = 3;//Set this to Qty of ResRefs You Add Below (0 is OFF)
    int nILLPropQTY = 7;//Set this to Qty of Properties You Add Below (0 is OFF)
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALITEMQTY",nILLItemQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROPQTY",nILLPropQTY));

    //Illegal Items
    /**************************************************************************/
    //Major Ring of Universal Elemental Resistance
    AssignCommand(oMod,SetLocalString(oMod,"ILLEGALITEM1","X2_IT_MRING019"));

    //Elixir of Invisibility
    AssignCommand(oMod,SetLocalString(oMod,"ILLEGALITEM2","invisibilty"));

    //Ring of Power
    AssignCommand(oMod,SetLocalString(oMod,"ILLEGALITEM3","NW_IT_MRING030"));

    //Treasure Room Key
    AssignCommand(oMod,SetLocalString(oMod,"ILLEGALITEM4","Key_TreasureRoom"));

    //Illegal Properties
    /**************************************************************************/
    //Freedom of Movement
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP1",ITEM_PROPERTY_FREEDOM_OF_MOVEMENT));

    //Immunity of Damage Type
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP2",ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE));

    //Immunity of Miscellaneous
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP3",ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS));

    //Immunity of Specific Spell
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP4",ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL));

    //Immunity of Spell School
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP5",ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL));

    //Immunity of Spells by Level
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP6",ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL));

    //True Seeing
    AssignCommand(oMod,SetLocalInt(oMod,"ILLEGALPROP7",ITEM_PROPERTY_TRUE_SEEING));


//:****************************************************************************/
//: UMD CONFIGS

    /*
      Please See  x2_pc_umdcheck  for credits on UMD work (Demitrious). Some modifications
      were made to this script for the ORS....configuration below. This script also has
      Sir Elric's fix in it as well. There should be nothing else you need for a great UMD
      ruleset.
    */

    // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
    // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
    SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, FALSE);

    //Bard & Rogue UMD is Class Levels + CHA + 3 for casting Spell Scrolls
    /*
       This is dependent upon whether the Module UMD Switch is set to TRUE

       This is a fix for Saving Skill Points and taking only a couple of levels
       in Bard and Rogue to leverage UMD.....this is a Game Exploit.
    */
    int nORS_UMD = 1;//Set to 1 or 0 (0 is OFF)
    AssignCommand(oMod,SetLocalInt(oMod,"ORS_UMD",nORS_UMD));

//:****************************************************************************/
//: MODULE SWITCHES

   /*
      These are Bioware Module Switches that come with the game. Configure how you wish.
   */

   // * Activating the switch below will make AOE spells hurt neutral NPCS by default
   SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, FALSE);

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
   SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, FALSE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
   SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, FALSE);
   AssignCommand(oMod,SetLocalInt(oMod,"BIOCRAFT",TRUE));//For ORS Spellhook

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, FALSE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, FALSE);

   // * Bioware Restrict Use Poison To Feat Only
   SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, FALSE);

   // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
   // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
   SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);

   // * Item Event Scripts: The game's default event scripts allow routing of all item related events
   // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
   // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
   // * is triggered. Check "x2_it_example.nss" for an example.
   // * This feature is disabled by default.
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
        // * If Tagbased scripts are enabled, and you are running a Local Vault Server
        // * you should use the line below to add a layer of security to your server, preventing
        // * people to execute script you don't want them to. If you use the feature below,
        // * all called item scrips will be the prefix + the Tag of the item you want to execute, up to a
        // * maximum of 16 chars, instead of the pure tag of the object.
        // * i.e. without the line below a user activating an item with the tag "test",
        // * will result in the execution of a script called "test". If you uncomment the line below
        // * the script called will be "1_test.nss"
        // SetUserDefinedItemEventPrefix("1_");
   }

   // * This initializes Bioware's wandering monster system as used in Hordes of the Underdark
   // * You can deactivate it, making your module load faster if you do not use it.
   // * If you want to use it, make sure you set "x2_mod_def_rest" as your module's OnRest Script
   SetModuleSwitch(MODULE_SWITCH_USE_XP2_RESTSYSTEM, FALSE);

   if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
   {

       // * This allows you to specify a different 2da for the wandering monster system.
       // SetWanderingMonster2DAFile("des_restsystem");

       //* Do not change this line.
       WMBuild2DACache();
   }

//:****************************************************************************/
//: OLANDER'S FIRST ENTER STUFF

    int nXP         = 0;//Set to how much XP you want the Player to start at (See Below)

    //PHB Settings
    int nPHBStrip   =     0;//This will make the PHB Gold to be Class Specific (0 is OFF)
    int nGiveGold   =  350;//Set to how much Gold to give a New Player if PHB Strip is OFF
                           //If you set this amount to 0 the Player will get an amount of
                           //Gold per level Per PHB.

    AssignCommand(oMod,SetLocalInt(oMod,"STARTXP",nXP));
    AssignCommand(oMod,SetLocalInt(oMod,"PHBSTRIP",nPHBStrip));
    AssignCommand(oMod,SetLocalInt(oMod,"GIVEGOLD",nGiveGold));

    /*
    INFORMATION:
    Amount of XP to Give to set the Initial Level
    L1 = 1
    L2 = 1000
    L3 = 3000
    L4 = 6000
    L5 = 10000
    L6 = 15000
    L7 = 21000
    L8 = 28000
    L9 = 36000
    L10 = 45000
    L11 = 55000
    L12 = 66000
    L13 = 78000
    L14 = 91000
    L15 = 105000
    L16 = 120000
    L17 = 136000
    L18 = 153000
    L19 = 171000
    L20 = 190000
    L21 = 210000
    L22 = 231000
    L23 = 253000
    L24 = 276000
    L25 = 300000
    L26 = 325000
    L27 = 351000
    L28 = 378000
    L29 = 406000
    L30 = 435000
    L31 = 465000
    L32 = 496000
    L33 = 528000
    L34 = 561000
    L35 = 595000
    L36 = 630000
    L37 = 666000
    L38 = 703000
    L39 = 741000
    L40 = 780000
    */

//:****************************************************************************/
//: OLANDER'S PERSISTENT TIME

    //Persistent Time
    int nPERMTIME = 1;//Set this to Make Time Persistent (0 is OFF)
    AssignCommand(oMod,SetLocalInt(oMod,"PERMTIME",nPERMTIME));

    if(nPERMTIME == 1)
    {
      int nCurHour = GetTimeHour();
      int nCurMin = GetTimeMinute();
      int nCurSec = GetTimeSecond();
      int nCurMS = GetTimeMillisecond();

      //Check for a Existing DB and Set to the Module
      int nOldYear = GetCampaignInt("TIME","TIMEYEAR",oMod);
      if(nOldYear > 0)
      {
        int nHour = GetCampaignInt("TIME","TIMEHOUR",oMod);
        int nDay = GetCampaignInt("TIME","TIMEDAY",oMod);
        int nMonth = GetCampaignInt("TIME","TIMEMONTH",oMod);
        int nYear = GetCampaignInt("TIME","TIMEYEAR",oMod);
        SetCalendar(nYear, nMonth, nDay);
        SetTime(nHour,0,0,0);

        //Now Make it Persistent
        SetCampaignInt("TIME","TIMEHOUR",GetTimeHour(),oMod);
        SetCampaignInt("TIME","TIMEDAY",GetCalendarDay(),oMod);
        SetCampaignInt("TIME","TIMEMONTH",GetCalendarMonth(),oMod);
        SetCampaignInt("TIME","TIMEYEAR",GetCalendarYear(),oMod);
      }

      //New Time DB
      else
      {
        //Now Make it Persistent
        SetCampaignInt("TIME","TIMEHOUR",GetTimeHour(),oMod);
        SetCampaignInt("TIME","TIMEDAY",GetCalendarDay(),oMod);
        SetCampaignInt("TIME","TIMEMONTH",GetCalendarMonth(),oMod);
        SetCampaignInt("TIME","TIMEYEAR",GetCalendarYear(),oMod);

        SetTime(nCurHour,0,0,0);
      }
    }

    //Month Naming For Clocks and Time Stuff (Sindarin/Elvish Provided)
    string sMonth1  = "January ";
    string sMonth2  = "Febuary ";
    string sMonth3  = "March ";
    string sMonth4  = "April ";
    string sMonth5  = "May ";
    string sMonth6  = "June ";
    string sMonth7  = "July ";
    string sMonth8  = "August ";
    string sMonth9  = "September ";
    string sMonth10 = "October ";
    string sMonth11 = "November ";
    string sMonth12 = "December ";

    AssignCommand(oMod,SetLocalString(oMod,"MONTH1",sMonth1));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH2",sMonth2));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH3",sMonth3));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH4",sMonth4));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH5",sMonth5));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH6",sMonth6));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH7",sMonth7));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH8",sMonth8));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH9",sMonth9));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH10",sMonth10));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH11",sMonth11));
    AssignCommand(oMod,SetLocalString(oMod,"MONTH12",sMonth12));

//:****************************************************************************/
//: OLANDER'S MERCHANT CLEANER

  /*
    Requires  ors_merch_clnr to be placed in the Store OnOpen Event.
    CAREFUL!! If you have Singular Items in your Store for Limited Purchase then
    MAKE SURE the Number of Duplicates Allowed are set properly!

    This checks for Duplicate ResRefs in the Store...NOT Tags! Tags for Food can
    be used now since many of the Tags are the same.

    Thanks to Adrian for the original script.
  */

  //Merchant Cleaner
  int nMERCHCLEAN  = 1;//Set to Allow Merchants to be cleaned when Opened (0 is OFF)
  int nMERCHREPNUM = 3;//Set to Quantity of Replicas Allowed
  AssignCommand(oMod,SetLocalInt(oMod,"MERCHCLEAN",nMERCHCLEAN));
  AssignCommand(oMod,SetLocalInt(oMod,"MERCHREPNUM",nMERCHREPNUM));

//:****************************************************************************/
//: OLANDER'S JUMP TO LEADER FROM PCM CONVERSATION

  //Leader Jump
  int nJump = 0;//Set to Allow Players to Jump to the Party Leader (0 is OFF)
  AssignCommand(oMod,SetLocalInt(oMod,"LEADERJUMP",nJump));

//:****************************************************************************/
//: OLANDER'S COMBAT TRAINERS/DUMMIES

  int nTrainerXPS = 150;//Set this to the XP Per Each Session
  int nTrainerDPS = 20;//Set this to Amount of Damage Required Per Session
  int nTrainerXPL = 10000;//Set this to the Max XP for Combat Trainers (Level 10 Default)

  AssignCommand(oMod,SetLocalInt(oMod,"TRAINERXPS",nTrainerXPS));
  AssignCommand(oMod,SetLocalInt(oMod,"TRAINERDPS",nTrainerDPS));
  AssignCommand(oMod,SetLocalInt(oMod,"TRAINERXPL",nTrainerXPL));

//:****************************************************************************/
//: OLANDER'S DEATH, BLEEDING, and RESPAWN SYSTEMS

  //  0 = Bioware
  //  1 = Soul Rune and Binding Stones System

  int nDeathChoose    =  1;//Set this number to one of the Systems Above
  int nBS             =  0;//Set to turn on Binding Stones (0 is OFF)
  int nBSJUMP         =  0;//Set to turn on Binding Stone Jump to Leader Option (0 is OFF)
  int nPermDeath      =  0;//Set to turn on Permanent Death (0 is OFF)
  int nSLife          = 10;//Set to Level and below to Not Remove Lives (1 to 40)
                           //This ALSO sets when the XP and GP Losses take affect!!
  int nLives          = 12;//Number of Lives (Soul Runes) Given to New Players

  /*
    XP Penalties:
    nXPPen MUST be Set to 1
    Can NOT Lose a Level due to XP Loss

    Example 1: nXPC = 1
        Hit Dice = 15
        nXPLvl x 15 = 7500 XP

    Example 2: nXPC = 2
        Hit Dice = 15 (Let's Say 115,000 XP)
        115,000 x nXPRate = 17,250XP (will go back to 105,000 Due to No Level Loss)

    Example 1: nXPC = 3
        Hit Dice = 15
        (nXPLvl x 15) x (nXPRate + (nXPAdder x 15) = 7500 + 2250 = 9750 XP
        Note: This Method is Progressive as Levels Get Higher
              Level 13 would be 8320 XP
              Level 14 would be 9030 XP
              9030 - 8320 = 710 XP  and  9750 - 9030 = 720 XP

  */
  int nXPPen          = 1;//Set this to Give XP Penalties for Respawning (0 is OFF)
  int nXPC            = 1;//Choose Type of XP Penalty to Take when Pressing Respawn
                          //Requires nXPPen Set to 1
                          //1 = XP Per Character Level
                          //2 = XP % Rate of TOTAL XP
                          //3 = XP % Base Rate + Adder % Per Character Level x XP Per Character Level
  int nXPRate         = 10;//This is the % Rate as Explained Above
  int nXPLvl          = 150;//This is the XP Per Character Level Penalty
  int nXPAdder        = 1;//This is the % Adder to the nXPRate for Progressive XP Loss

  AssignCommand(oMod,SetLocalInt(oMod,"XPPEN",nXPPen));
  AssignCommand(oMod,SetLocalInt(oMod,"XPC",nXPC));
  AssignCommand(oMod,SetLocalInt(oMod,"XPRATE",nXPRate));
  AssignCommand(oMod,SetLocalInt(oMod,"XPLVL",nXPLvl));
  AssignCommand(oMod,SetLocalInt(oMod,"XPADDER",nXPAdder));

  /*
    Gold Penalties are much simpler than XP
    Note: Hard Cap at 50K Gold
  */
  int nGPPen          =  1;//Set this to Give Gold Penalties for Respawning (0 is OFF)
  int nGPRate         = 20;//This is the % Gold Penalty if Gold Penalties is ON

  AssignCommand(oMod,SetLocalInt(oMod,"GPPEN",nGPPen));
  AssignCommand(oMod,SetLocalInt(oMod,"GPRATE",nGPRate));

  /*
  NOTE: Permanent Death is based upon Zero Soul Runes left in their inventory.
        A Soul Rune is removed every time the player presses Respawn (Players can not
        cheat death by logging out).

        If PermDeath is set to Zero this will also disable Soul Rune Bonuses upon Level Up.
  */

  /*
    Number of Rounds before Afterlife Portal can be used after pressing Respawn. Countdown
    messages are sent based on this time. Set to 0 if you dont want there to
    be any Portal Delay.
  */
  int nPortal = 0;
  AssignCommand(oMod,SetLocalInt(oMod,"OBD_PORTAL_DEL",nPortal));

  /*
    Number of Rounds before forcing a player to Respawn. Countdown
    messages are sent based on this time. Set to 0 if you dont want there to
    be any Forced Countdown.
  */
  int nCDown = 360;
  AssignCommand(oMod,SetLocalInt(oMod,"OBD_FORCE_RESPAWN",nCDown));

  /*
    Please see bs_include for custom System Tweaks like dropping all inventory items
    into a bag....and many many more.
  */

  string sDeathPanel  = "White Wolf's Death Panel";

  string sDeathSystem   = "nw_o0_death";
  string sDyingSystem   = "nw_o0_dying";
  string sRespawnSystem = "nw_o0_respawn";

  switch(nDeathChoose)
  {
    case 0:
    {
      sDeathSystem      = "nw_o0_death";
      sDyingSystem      = "nw_o0_dying";
      sRespawnSystem    = "nw_o0_respawn";
    }
    break;
    case 1:
    {
      sDeathSystem      = "obd_mod_ondeath";
      sDyingSystem      = "obd_mod_ondying";
      sRespawnSystem    = "obd_mod_respawn";
    }
    break;
  }

  if(nDeathChoose == 1)
  {
    AssignCommand(oMod,SetLocalInt(oMod,"BS_ENABLE",nBS));
    AssignCommand(oMod,SetLocalInt(oMod,"PERMDEATH",nPermDeath));
    AssignCommand(oMod,SetLocalInt(oMod,"STARTLIVES",nSLife));
    AssignCommand(oMod,SetLocalInt(oMod,"LIVES",nLives));
  }

  AssignCommand(oMod,SetLocalInt(oMod,"DEATHCHOOSE",nDeathChoose));
  AssignCommand(oMod,SetLocalString(oMod,"DEATHSYSTEM",sDeathSystem));
  AssignCommand(oMod,SetLocalString(oMod,"DYINGSYSTEM",sDyingSystem));
  AssignCommand(oMod,SetLocalString(oMod,"RESPAWNSYSTEM",sRespawnSystem));
  AssignCommand(oMod,SetLocalString(oMod,"DEATHPANEL",sDeathPanel));
  AssignCommand(oMod,SetLocalInt(oMod,"BSJUMP",nBSJUMP));

//:****************************************************************************/
//: OLANDER'S HUNGER THIRST AND FATIGUE (HTF) SYSTEM
            //Turned off by Knightstar 10-13-11
  int nHTFGLOBAL = 0;//Set this to globally turn on or off the HTF System (0 is OFF)

  // Setting HUNGERSYSTEM to 0 will turn off the need for PCs to regularly consume
  // food and water to avoid death by starvation or dehydration.
  int nHUNGERSYSTEM = 0;

  // Setting FATIGUESYSTEM to 0 will turn off the ill effects recieved by a PC that
  // goes a time without resting.
  int nFATIGUESYSTEM = 1;

  // Setting CONBASEDHEAL to 0 will turn off the Natural Healing Ability due to CON
  // Note: This is like Natural Regeneration and happens ONCE Per Game Hour
  int nCONBASEDHEAL = 1;

  // Setting COLDSYSTEM to 0 will turn off the Cold effects recieved by a PC
  int nCOLDSYSTEM = 1;

  //This determines at what percentage of the maximum hunger and thirst levels
  //a PC is unable to rest becuase of hunger and/or thirst.
  //The PC cannot rest if their current levels are below the given percentage.
  float fRESTRESTRICTIONPERCENT = 0.1;

  //Change the below value to increase or decrease the amount of changes the
  //water canteen item can hold.
  int nMAXCANTEENCHARGES = 10;

  //The Quantity of Hunger, Thirst, and Fatigue Hit Points
  int nHUNGER  = 15000;
  int nTHIRST  = 15000;
  int nFATIGUE = 30000;

  //Percentage amount that players are allowed to go over quantites above
  float fBUFFER = 0.2;

  //The Value Ratings of Food and Drinks
  //Food
  int nRICH    = 6000;
  int nNORM    = 5000;
  int nPOOR    = 4000;
  //Drink
  int nHIGH    = 6000;
  int nMED     = 5000;
  int nLOW     = 4000;

  AssignCommand(oMod,SetLocalInt(oMod,"HTFGLOBAL", nHTFGLOBAL));
  AssignCommand(oMod,SetLocalInt(oMod,"HUNGERSYSTEM", nHUNGERSYSTEM));
  AssignCommand(oMod,SetLocalInt(oMod,"FATIGUESYSTEM", nFATIGUESYSTEM));
  AssignCommand(oMod,SetLocalInt(oMod,"CONBASEDHEAL", nCONBASEDHEAL));
  AssignCommand(oMod,SetLocalInt(oMod,"COLDSYSTEM", nCOLDSYSTEM));
  AssignCommand(oMod,SetLocalFloat(oMod,"RESTRESTRICTIONPERCENT", fRESTRESTRICTIONPERCENT));
  AssignCommand(oMod,SetLocalInt(oMod,"MAXCANTEENCHARGES", nMAXCANTEENCHARGES));
  AssignCommand(oMod,SetLocalInt(oMod,"HUNGER", nHUNGER));
  AssignCommand(oMod,SetLocalInt(oMod,"THIRST", nTHIRST));
  AssignCommand(oMod,SetLocalInt(oMod,"FATIGUE", nFATIGUE));
  AssignCommand(oMod,SetLocalFloat(oMod,"BUFFER", fBUFFER));
  AssignCommand(oMod,SetLocalInt(oMod,"RICH", nRICH));
  AssignCommand(oMod,SetLocalInt(oMod,"NORM", nNORM));
  AssignCommand(oMod,SetLocalInt(oMod,"POOR", nPOOR));
  AssignCommand(oMod,SetLocalInt(oMod,"HIGH", nMED));
  AssignCommand(oMod,SetLocalInt(oMod,"MED", nMED));
  AssignCommand(oMod,SetLocalInt(oMod,"LOW", nLOW));

//:****************************************************************************/
//: OLANDER'S CAMPING AND RESTING

  int nRESTGLOBAL = 1;//Set this to globally turn on or off the HTF System (0 is OFF)

  int nRESTPHB    = 0;//Set this for PHB Resting Rules (0 is Off)
  int nRESTLEVEL  = 10;//Set this to the Level to Start Resting Restrictions
  int nRESTHOURS  = 0;//The Number of Hours a Player Must Wait Between Rests
  int nNATREGEN   = 1;//Set this for Natural Healing based on CON Bonus (0 is OFF)
  int nWISCOOK    = 1;//Set this for Wisdom Based Cooking (0 is OFF)

  //These 3 will not function without PHB Resting
  int nRESTHEAL   = 1;//Set this to make Healing on Resting Per HP per level Plus CON (0 is Off or Full Heal)
  int nRESTCON    = 1;//Set this to add HP's equal to the Constitution Ability Score * CON Bonus (0 is Off)
  int nRESTHP     = 1;//Set this to how many HP's per HD you wish to Heal

  AssignCommand(oMod,SetLocalInt(oMod,"RESTGLOBAL", nRESTGLOBAL));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTPHB", nRESTPHB));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTLEVEL", nRESTLEVEL));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTHOURS", nRESTHOURS));
  AssignCommand(oMod,SetLocalInt(oMod,"NATREGEN", nNATREGEN));
  AssignCommand(oMod,SetLocalInt(oMod,"WISCOOK", nWISCOOK));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTHEAL", nRESTHEAL));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTCON", nRESTCON));
  AssignCommand(oMod,SetLocalInt(oMod,"RESTHP", nRESTHP));

//:****************************************************************************/
//: OLANDER'S CRAFTING (DR System Requires ORS Addon Hak)

//: GENERAL SYSTEM CONFIGURATION SECTION

    int nCRAFTGLOBAL  = 1;//Set this to globally turn on or off the Crafting System (0 is OFF)
    int nCRAFTLICENSE = 0;//Set this to require the use of a Crafting License to Craft (0 is OFF)
    int nCRAFTSKILL   = 10;//Set this to require the MINIMUM Skill required to Craft Without a License.
                          //License will Disallow this Requirement. Either Armor or Weapon will Satisfy.
                          //This ONLY Affects Armor and Weapon Crafting as Wand, Potion, and Traps are
                          //Pretty much self regulated.

    AssignCommand(oMod,SetLocalInt(oMod,"CRAFTGLOBAL", nCRAFTGLOBAL));
    AssignCommand(oMod,SetLocalInt(oMod,"CRAFTLICENSE", nCRAFTLICENSE));
    AssignCommand(oMod,SetLocalInt(oMod,"CRAFTSKILL", nCRAFTSKILL));

//: OCR CONFIGURATION SECTION

    //I have also given the ability to Damage Reduction to Armor + AC
    //Diamonds for AC
    //Alexandrite for Damage Reduction
    //Set to 0 to give AC ONLY to Armor....No Damage Reduction
    int nDRSYS      = 0;
    AssignCommand(oMod,SetLocalInt(oMod,"DRSYS",nDRSYS));

    //Reality Armor rules to apply speed penalties while wearing armors Set to 0 to turn off
    int nARMORDAMAGE   = 1;//When the Armor, Helm, or Shield are used in Combat they will take damage (0 is Off)
    int nARMORDESTROY  = 0;//When the Armor, Helm, or Shield HP's are used up they will be destroyed (0 is Off)
    int nWEAPONDAMAGE  = 1;//When the Weapon/Gloves is used in Combat they will take damage (0 is Off)
    int nWEAPONDESTROY = 0;//When the Weapon/Glove HP's are used up it will be destroyed (0 is Off)
    int nCLOAKDAMAGE   = 1;//When the Cloak is used in Combat they will take damage (0 is Off)
    int nCLOAKDESTROY  = 0;//When the Cloak HP's are used up it will be destroyed (0 is Off)
    int nBOOTSDAMAGE   = 1;//When the Boots are used they will ALWAYS take damage (0 is Off)
    int nBOOTSDESTROY  = 0;//When the Boots HP's are used up it will be destroyed (0 is Off)
    int nBELTDAMAGE    = 1;//When the Belt is used in Combat they will take damage (0 is Off)
    int nBELTDESTROY   = 0;//When the Belt HP's are used up it will be destroyed (0 is Off)

    AssignCommand(oMod,SetLocalInt(oMod,"ARMORDAMAGE",nARMORDAMAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMORDESTROY",nARMORDESTROY));
    AssignCommand(oMod,SetLocalInt(oMod,"WEAPONDAMAGE",nWEAPONDAMAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"WEAPONDESTROY",nWEAPONDESTROY));
    AssignCommand(oMod,SetLocalInt(oMod,"CLOAKDAMAGE",nCLOAKDAMAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"CLOAKDESTROY",nCLOAKDESTROY));
    AssignCommand(oMod,SetLocalInt(oMod,"BOOTSDAMAGE",nBOOTSDAMAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"BOOTSDESTROY",nBOOTSDESTROY));
    AssignCommand(oMod,SetLocalInt(oMod,"BELTDAMAGE",nBELTDAMAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"BELTDESTROY",nBELTDESTROY));


    int nDEFLECTMESSAGE = 1;//Shows the Deflection Messages (0 is Off)
    int nROLLMESSAGE    = 0;//Shows the Weapon Roll Message (0 is Off)

    AssignCommand(oMod,SetLocalInt(oMod,"DEFLECTMESSAGE",nDEFLECTMESSAGE));
    AssignCommand(oMod,SetLocalInt(oMod,"ROLLMESSAGE",nROLLMESSAGE));

//: ARMOR CONFIGURATION SECTION

    //Number of rounds required to equip armor fully
    int nARMORRULES = 0;//Set to Turn Armor Rules On (0 is OFF)
    int nARMORLIGHT = 2;
    int nARMORMED   = 4;
    int nARMORHEAVY = 6;

    AssignCommand(oMod,SetLocalInt(oMod,"ARMORRULES",nARMORRULES));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMORLIGHT",nARMORLIGHT));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMORMED",nARMORMED));
    AssignCommand(oMod,SetLocalInt(oMod,"ARMORHEAVY",nARMORHEAVY));

//: CRAFTING CONFIGURATION SECTION

    //Prospecting Reources
    /*
      This is will make useable any placeables within 10 Meters that have the
      OCR_RESOURCE Variable Set to 1
      The Resource will Set Itself back to Non-Usable after sometime via a
      Psuedo HB (30 Secs)

      Herbal Natural Bonuses
      - Elf +2
      - Halfling +2
      - Half Elf +1
      - Druid +5
      - Ranger +5

      Ore Natural Bonues
      - Dwarf +5
      - Human +2
    */
    int nOCR_LORE = 5;//Set this for Minimum Lore Needed to Spot Resources (Range 0 to 43)
    AssignCommand(oMod,SetLocalInt(oMod,"OCR_LORE",nOCR_LORE));

    //These are all the configuration settings that are used throughout this
    //crafting system. Try to Remember that a Player can wear multiple items
    //that can stack bonuses.....so don't jack the numbers to high for each
    //enchantment or you WILL have SEVERE difficulties balancing your Module.
    //Then again....maybe you like that =)

    //ENCHANTING BONUSES
    int nABMAX      =  4;//This is Max Attack and Damage Bonus (# of Diamonds)
    int nDRMAX      =  5;//This is Max Damage Reduction (+1/5 Soak) for each Armor
                         //NOTE: Number of Items...ie  +2/5 Soak - 2 Dusty Rose Ioun Stones
                         //      Set at 5 would allow a TOTAL of +5/5 Soak DR
    int nACMAX      =  4;//This is Max AC for Shields/Helms/Amulets and Armors(When DRSYS is Off)
    int nDBEMAX     =  5;//This is Max Damage Bonus For Each Type of Item
    int nDREMAX     =  1;//This is Max Damage Resistance (5/-) Elemental For Each Type of Item
                         //NOTE: Number of Items...ie  10/- 2 of Something
                         //      5/- is 1 Item of Any Elemental Type
                         //      Set at 5 would allow a TOTAL of 25/- DR
    int nTMAX       =  1;//This is Max Damage/Elemental Bonus Combinations (Max is 6)
    int nPMAX       =  4;//This is Max Personal Bonus Items (+4 something)
    int nMMAX       =  3;//This is Max Mass Critical that can be Added to a Weapon (Max is 10)
                         /*
                            1 up to 1d4
                            2 up to 1d6
                            3 up to 1d8
                            4 up to 2d4
                            5 up to 1d10
                            6 up to 1d12
                            7 up to 2d6
                            8 up to 2d8
                            9 up to 2d10
                            10 up to 2d12
                         */

    int nENCDC      = 30;//This is the DC to use the Enchanting Table D20 + Lore/Spellcraft (Recommend 30)
    int nGEMDC      = 25;//This is the DC to use the Gem Cutting Table D20 + Lore(Recommend 30)

    int nHWALLOW    =  1;//Set this to Allow Large Weapon Overbonuses (0 is OFF)
    int nHWEBMAX    =  1;//This is the Overage of EB for Large Weapons...
                         //ie. nABMax is +4  setting this to 2 will allow +6

    //INTELLIGENCE/WISDOM REQUIREMENT
    int nIWREQ      =  1;//Set to 1 to Require to have 14(+2) INT or WIS to use the Enchanting Forge

    //Experience Cost to Enchant
    int nXPREQ      =  0;//Set to 1 to Require XP Loss for Enchanting Something
    int nXPCOST     = 100;//Set to a value that a Successful Enchant will Cost in XP (This CAN lose a Level)

    //Set the Stolen Flag So That Enchanted Items Can Not Be Sold At Normal Merchants
    int nStolen     =  1;//Set to 1 to have the Stolen Flag Set

    AssignCommand(oMod,SetLocalInt(oMod,"ABMAX", nABMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"DRMAX", nDRMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"ACMAX", nACMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"DBEMAX", nDBEMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"DREMAX", nDREMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"TMAX", nTMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"PMAX", nPMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"MMAX", nMMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"ENCDC", nENCDC));
    AssignCommand(oMod,SetLocalInt(oMod,"GEMDC", nGEMDC));
    AssignCommand(oMod,SetLocalInt(oMod,"HWALLOW", nHWALLOW));
    AssignCommand(oMod,SetLocalInt(oMod,"HWEBMAX", nHWEBMAX));
    AssignCommand(oMod,SetLocalInt(oMod,"IWREQ", nIWREQ));
    AssignCommand(oMod,SetLocalInt(oMod,"XPREQ", nXPREQ));
    AssignCommand(oMod,SetLocalInt(oMod,"XPCOST", nXPCOST));
    AssignCommand(oMod,SetLocalInt(oMod,"STOLEN", nStolen));


    //ORE SMELTING
    int nADAMDC     = 25;//The DC to Smelt Adamantine Ore
    int nADAMQTY    =  5;//The Quantity of Adamantine Ore Required to smelt a bar
    int nMITHDC     = 20;//The DC to Smelt Mithril Ore
    int nMITHQTY    =  5;//The Quantity of Mithril Ore Required to smelt a bar
    int nSTEELDC    = 15;//The DC to Smelt Steel Ore
    int nSTEELQTY   =  5;//The Quantity of Steel Ore Required to smelt a bar
    int nIRONDC     = 10;//The DC to Smelt Iron Ore
    int nIRONQTY    =  5;//The Quantity of Iron Ore Required to smelt a bar
    int nSILDC     = 20;//The DC to Smelt Iron Ore
    int nSILQTY    =  5;//The Quantity of Iron Ore Required to smelt a bar

    AssignCommand(oMod,SetLocalInt(oMod,"ADAMDC", nADAMDC));
    AssignCommand(oMod,SetLocalInt(oMod,"ADAMQTY", nADAMQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"MITHDC", nMITHDC));
    AssignCommand(oMod,SetLocalInt(oMod,"MITHQTY", nMITHQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"STEELDC", nSTEELDC));
    AssignCommand(oMod,SetLocalInt(oMod,"STEELQTY", nSTEELQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"IRONDC", nIRONDC));
    AssignCommand(oMod,SetLocalInt(oMod,"IRONQTY", nIRONQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"SILDC", nIRONDC));
    AssignCommand(oMod,SetLocalInt(oMod,"SILQTY", nIRONQTY));

    //MILLING
    int nIWOODDC    = 25;//The DC to Mill Ironwood Planks
    int nIWOODQTY   =  5;//The Quantity of Raw Ironwood Required to Mill Planks
    int nOAKDC      = 20;//The DC to Mill Oak Planks
    int nOAKQTY     =  5;//The Quantity of Raw Oak Required to Mill Planks
    int nELMDC      = 15;//The DC to Mill Elm Planks
    int nELMQTY     =  5;//The Quantity of Raw Elm Required to Mill Planks

    AssignCommand(oMod,SetLocalInt(oMod,"IWOODDC", nIWOODDC));
    AssignCommand(oMod,SetLocalInt(oMod,"IWOODQTY", nIWOODQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"OAKDC", nOAKDC));
    AssignCommand(oMod,SetLocalInt(oMod,"OAKQTY", nOAKQTY));
    AssignCommand(oMod,SetLocalInt(oMod,"ELMDC", nELMDC));
    AssignCommand(oMod,SetLocalInt(oMod,"ELMQTY", nELMQTY));


//:****************************************************************************/
//: OLANDER'S REALISTIC WEATHER

    int nWEATHERGLOBAL = 1;//Set this to globally turn on or off the Weather System (0 is OFF)

    //Debug Messages (Temperature and Humidity will always be seen)
    int nRWDebug = 0;//Debug Meesages (0 is OFF)

    int nSKYBOX = 1;//New Feature to diable Sky Box changes Dynamically
                    //Note:
                    /*
                      There are some 'Hiccups' encountered with the Aurora Engine
                      thay may cause the computer to go to 100% and cause the Server
                      to diconnect (very much like a never ending loop!!). If you
                      have this issue turn this off first then check to see if the
                      issue went away. Should.

                      This has not been an issue in the later releases of NWN.
                    */

    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERGLOBAL", nWEATHERGLOBAL));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERCYCLE",nMPH));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERDUBUG",nRWDebug));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERSKYBOX", nSKYBOX));

//:****************************************************************************/
//: OLANDER'S PHB/CUSTOM SPELLS

    //For Details See  ors_spellhook
  //  DelayCommand(0.1,AssignCommand(oMod,SetModuleOverrideSpellscript("vamp_spells")));//LEAVE THIS ALONE!!
    //DelayCommand(0.1,AssignCommand(oMod,SetModuleOverrideSpellscript("ors_spellhook")));//LEAVE THIS ALONE!!

    //Timestop Configs
    int nTimeStop   = 1;//Area Specific PW Friendly Time Stop (0 is OFF)
                        //At 0 This will enable Default Bioware TimeStop
    int nTSAOE      = 1;//Time Stop is an AOE Spell. (0 is Area Wide)
    int nTSRAD      =20;//Radius in Meters of AOE Time Stop.

    /*
      If set to zero, the duration will default to 1 + 1d4 rounds. Otherwise, the
      duration will be the number of seconds the variable is changed to.
      nTSDuration = 0;  Timestop lasts 9 seconds.
    */
    int nTSDuration = 9;

    /*
      Number of seconds before Timestop can be recast after being cast. Countdown
      messages are sent based on this time. Set to 0.0 if you dont want there to
      be any Casting Delay.
    */
    int nTSCasting = 60;

    AssignCommand(oMod,SetLocalInt(oMod,"TIMESTOP",nTimeStop));
    AssignCommand(oMod,SetLocalInt(oMod,"TSAOE",nTSAOE));
    AssignCommand(oMod,SetLocalInt(oMod,"TSRAD",nTSRAD));
    AssignCommand(oMod,SetLocalInt(oMod,"TIMESTOP_DUR",nTSDuration));
    AssignCommand(oMod,SetLocalInt(oMod,"TIMESTOP_DEL",nTSCasting));


    //Greater Sanctuary Configs
    int nGS = 1;//Greater Sanctuary Fix (0 is OFF)
                //At 0 This will enable Default Bioware
                /*
                  Issue with Greater Sanctuary. It lasts a LONG time and it also
                  Does not trigger Perceive Tables. The ONLY fix for this is to give
                  True Seeing to everyone or Ban the Spell. So this is a very nice
                  compromise to still allow this spell to be cast but not abused.
                  Greater Sanctuary is NOT a PHB Spell. It is for NWN only.
                */

    /*
      If set to zero, the duration will default to 1d8 rounds with a Minimum of 4 Rounds
      Otherwise, the duration will be the number of seconds the variable is changed to.
      nGSDuration = 12;  Greater Sanctuary lasts 12 Rounds. Always a Minimum of 4
     */
    int nGSDuration = 10;

    /*
      Number of seconds before Greater Sanctuary can be recast after being cast.
      Countdown messages are sent based on this time. Set to 0 if you dont want there to
      be any Casting Delay.
    */
    int nGSCasting = 60;

    AssignCommand(oMod,SetLocalInt(oMod,"GSANCTUARY",nGS));
    AssignCommand(oMod,SetLocalInt(oMod,"GSANCTUARY_DUR",nGSDuration));
    AssignCommand(oMod,SetLocalInt(oMod,"GSANCTUARY_DEL",nGSCasting));


    int nPHBHarm    = 1;//PHB Harm Spell (0 is OFF)
    int nPHBHeal    = 1;//PHB Heal Spell (0 is OFF)
    int nBlessW     = 1;//CEP fix for Bless Weapon (0 is OFF)
    int nDarkfire   = 1;//CEP fix for Darkfire (0 is OFF)
    int nFlameW     = 1;//CEP fix for Flame Weapon (0 is OFF)
    int nGMagicW    = 1;//CEP fix for Greater Magic Weapon (0 is OFF)
    int nMagicW     = 1;//CEP fix for Magic Weapon (0 is OFF)
    int nHolySword  = 1;//CEP fix for Holy Sword (0 is OFF)
    int nKeenEdge   = 1;//CEP fix for Keen Edge (0 is OFF)
    int nCFlame     = 1;//Continual Flame Exploit Fix (0 is OFF)
    int nGATE       = 0;//Improved Gate Spell (0 is OFF)
    int nEDK        = 0;//Improved Dragon Knight (0 is OFF)
    int nEMD        = 0;//Improved Mummy Dust (0 is OFF)
    int nISUM       = 0;//Improved Summoning (0 is OFF)
    int nIPSUM      = 0;//Improved Planar Summoning (0 is OFF)

    AssignCommand(oMod,SetLocalInt(oMod,"PHBHARM",nPHBHarm));
    AssignCommand(oMod,SetLocalInt(oMod,"PHBHEAL",nPHBHeal));
    AssignCommand(oMod,SetLocalInt(oMod,"BLESSW",nBlessW));
    AssignCommand(oMod,SetLocalInt(oMod,"DARKFIRE",nDarkfire));
    AssignCommand(oMod,SetLocalInt(oMod,"FLAMEW",nFlameW));
    AssignCommand(oMod,SetLocalInt(oMod,"GMAGICW",nGMagicW));
    AssignCommand(oMod,SetLocalInt(oMod,"MAGICW",nMagicW));
    AssignCommand(oMod,SetLocalInt(oMod,"HOLYSWORD",nHolySword));
    AssignCommand(oMod,SetLocalInt(oMod,"KEENEDGE",nKeenEdge));
    AssignCommand(oMod,SetLocalInt(oMod,"CFLAME",nCFlame));
    AssignCommand(oMod,SetLocalInt(oMod,"GATE",nGATE));
    AssignCommand(oMod,SetLocalInt(oMod,"EDK",nEDK));
    AssignCommand(oMod,SetLocalInt(oMod,"EMD",nEMD));
    AssignCommand(oMod,SetLocalInt(oMod,"ISUM",nISUM));
    AssignCommand(oMod,SetLocalInt(oMod,"IPSUM",nIPSUM));

//:****************************************************************************/
//: OLANDER'S REALISTIC TORCHES

    //This is the Torch/Lantern Cycle Time
    float fCycle = 30.0;
    AssignCommand(oMod,SetLocalFloat(oMod,"TORCHCYCLE",fCycle));

    //This is the Torch Number of HP's (Set to Multiples of 4)
    int nTHP = 20;//12This is Equivalent to 3 Hours
    AssignCommand(oMod,SetLocalInt(oMod,"TORCHHP",nTHP));

    //This is the Open Lantern Number of HP's  (Set to Multiples of 4)
    int nOLHP = 32;//24This is Equivalent to 6 Hours
    AssignCommand(oMod,SetLocalInt(oMod,"OLANTERNHP",nOLHP));

    //This is the Lantern Number of HP's  (Set to Multiples of 4)
    int nLHP = 60;//40This is Equivalent to 10 Hours
    AssignCommand(oMod,SetLocalInt(oMod,"LANTERNHP",nLHP));

//:****************************************************************************/
//: OLANDER'S GLOBAL AUTO SHUT DOOR DELAY

    float fASD = 15.0;//Set this to the Amount of Delay to Close the Door
    AssignCommand(oMod,SetLocalFloat(oMod,"ASD",fASD));


//:****************************************************************************/
//: OLANDER'S PACK ANIMALS

    //Animal GP Cost and Pack - Rough Info
    /*
      Pack Penguin CR4 (20 Items Max)
      Pack Badger CR4 (20 Items Max)
      Pack Boar CR5 (25 Items Max)
      Pack Beetle CR6 (30 Items Max)
      Pack Ox CR10 (50 Items Max)
      Pack Bear CR12 (60 Items Max)
      Pack Pony CR8 (35 Items Max)
      Pack Horse CR10 (40 Items Max)
    */

    //Pack Animal GP Cost
    int nPA = 2500;//Set this to Gold per CR Rating of the Pack Animal.
                  //Set to 0 to turn off Pack Animal Purchasing

    AssignCommand(oMod,SetLocalInt(oMod,"PACKPRICE",nPA));

//:****************************************************************************/
//: OLANDER'S HORSES

    //Horses
    int nHORSEPRICE = 100;//Price Per CR of the Horse

    AssignCommand(oMod,SetLocalInt(oMod,"HORSEPRICE",nHORSEPRICE));

    //Horse Riding Minimum Level
    /*
      Need to have Players not be able to Ride Horses until a
      Certain level? Set that here.
      If you set this to level 41 or more it will basically disable
      purchasing or riding horses.
    */
    int nRIDEHORSE = 5;
    AssignCommand(oMod,SetLocalInt(oMod,"RIDEHORSE",nRIDEHORSE));

    //Saddle Bags
    int nSBMAX = 50;
    AssignCommand(oMod,SetLocalInt(oMod,"SBMAX",nSBMAX));

//:****************************************************************************/
//: BIOWARE'S v1.69 HORSES  (For OHO.....DO NOT CONFIG BELOW DIFFENTLY)

   // Area Control
   SetLocalInt(GetModule(), "X3_MOUNTS_EXTERNAL_ONLY", TRUE);          // Horses not allowed in indoor areas
   SetLocalInt(GetModule(), "X3_MOUNTS_NO_UNDERGROUND", TRUE);         // Horses not allowed underground
// SetLocalInt(GetObjectByTag("AreaTag"), "X3_ABORT_WHEN_STUCK", TRUE);         // Abort mount if unable to run to horse in this area

   // Abilities & Combat
//   SetLocalInt(GetModule(), "X3_HORSE_DISABLE_SPEED", FALSE);          // No speed increase on mounting
//   SetLocalInt(GetModule(), "X3_HORSE_DISABLE_SKILL", FALSE);          // No skill penalties to Hide etc on mounting
   SetLocalInt(GetModule(), "X3_MOUNT_NO_REST_DISMOUNT", FALSE);       // Allow rest when mounted
   SetLocalInt(GetModule(), "X3_HORSE_ENABLE_ACBOOST", TRUE);          // Increase rider AC to match horse on mounting
   SetLocalInt(GetModule(), "X3_NO_MOUNTED_COMBAT_FEAT", FALSE);       // Disable Mounted Combat feat
   SetLocalInt(GetModule(), "X3_HORSE_ENABLE_HPBOOST", TRUE);          // Give rider temporary hit points on mounting
   SetLocalInt(GetModule(), "X3_ENABLE_MOUNT_DAMAGE", TRUE);           // Horse shares damage on dismounting
// SetLocalInt(GetModule(), "X3_HORSE_NO_CORPSES", TRUE);              // Mounted horses leave no corpses
// SetLocalInt(GetModule(), "X3_NO_SHAPESHIFT_SPELL_CHECK", TRUE);     // Allow mounted creatures to be shapeshifted by spells

   // Henchman Control
// SetLocalInt(GetModule(), "X3_RESTORE_HENCHMEN_LOCATIONS", TRUE);    // Henchmen's horses respawn near henchmen on loading saved game
// SetLocalInt(GetModule(), "X3_HORSE_NO_HENCHMAN_INCREASE", TRUE);    // No increase in maximum henchmen to accommodate horses
   SetLocalInt(GetModule(), "X3_HORSE_MAX_HENCHMEN ", 0);              // Upper limit on maximum henchmen to accommodate horses

   // Saddlebags
   SetLocalInt(GetModule(), "X3_HORSE_ENABLE_SADDLEBAGS", FALSE);       // Enable saddlebags
   SetLocalString(GetModule(), "X3_SADDLEBAG_DATABASE", "X3SADDLEBAG"); // Name of saddlebag database

   // Paladin Mounts
   SetLocalInt(GetModule(), "X3_HORSE_PALADIN_USE_PHB", TRUE);         // Paladin mount summoning duration as Player's Handbook
   SetLocalInt(GetModule(), "X3_MOUNT_NO_REST_DESPAWN", TRUE);         // Paladin mount does not despawn on rest
// SetLocalString(GetModule(), "X3_PALMOUNT_SUMMONOVR", "MyScript");   // Custom summoning script
// SetLocalString(GetModule(), "X3_EXTEND_PALMOUNT", "MyScript");      // Custom post-mount script
// SetLocalString(GetModule(), "X3_EXTEND_PALDMOUNT", "MyScript");     // Custom post-dismount script

   // Mounting System
// SetLocalInt(GetModule(), "X3_NO_MOUNT_COMMANDABLE", TRUE);          // Allow horse and rider to be commandable during mount / dismount
// SetLocalInt(GetModule(), "X3_HORSE_ACT_VS_DELAY", TRUE);            // Use actions rather than delays when mounting/dismounting
// SetLocalFloat(GetModule(), "fX3_MOUNT_DELAY", 2.0);                 // Mount animation additional time in seconds
// SetLocalFloat(GetModule(), "fX3_TIMEOUT_TO_MOUNT", 6.0);            // Maximum time allowed to run to horse in seconds
   SetLocalInt(GetModule(), "bX3_MOUNT_NO_ZAXIS", TRUE);               // Enabled in official Bioware script
// SetLocalFloat(GetModule(), "fX3_FREQUENCY", 2.0);                   // Frequency of pathfinding during run to horse in seconds

   // Database
   SetLocalInt(GetModule(), "X3_ENABLE_MOUNT_DB", FALSE);              // Enable data base functions

//:****************************************************************************/
//: OLANDER'S PETS (Requires NWNv1.69 - CEP2 - ANIMALS PROVIDED AS TEMPLATE PETS)

    //Pet GP Cost
    int nPet = 1000;//Set this to Gold per CR Rating of the Pet.
                   //Set to 0 to turn off Pet Purchasing

    AssignCommand(oMod,SetLocalInt(oMod,"PETPRICE",nPet));

//:****************************************************************************/
//: OLANDER'S BANKING

    //Safe Maximum Items
    /*
      Careful here. The Safe has a maximum Page Total for placing Items
      into it. This is due to the limitation of the Safe and the Transfer
      of items to the Storage Creature.

      Armor and Large Weapons are Counted as 2 Items.
    */
    int nOBKMAXITEMS = 100;
    AssignCommand(oMod,SetLocalInt(oMod,"OBKMAXITEMS",nOBKMAXITEMS));

    //Bank Account Maximum Gold
    /*
      Maximum amount of Gold per Bank Account
    */
    int nOBKMAXGOLD = 1000000;
    AssignCommand(oMod,SetLocalInt(oMod,"OBKMAXGOLD",nOBKMAXGOLD));

}
