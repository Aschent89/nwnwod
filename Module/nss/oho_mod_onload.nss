////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_mod_onload
//  By Don Anderson
//  dandersonru@msn.com
//
//  OHO Module Setup
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oMod   = GetModule();

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
// SetLocalInt(GetModule(), "X3_MOUNTS_EXTERNAL_ONLY", TRUE);          // Horses not allowed in indoor areas
// SetLocalInt(GetModule(), "X3_MOUNTS_NO_UNDERGROUND", TRUE);         // Horses not allowed underground
// SetLocalInt(GetObjectByTag("AreaTag"), "X3_ABORT_WHEN_STUCK", TRUE);         // Abort mount if unable to run to horse in this area

   // Abilities & Combat
// SetLocalInt(GetModule(), "X3_HORSE_DISABLE_SPEED", TRUE);           // No speed increase on mounting
// SetLocalInt(GetModule(), "X3_HORSE_DISABLE_SKILL", TRUE);           // No skill penalties to Hide etc on mounting
// SetLocalInt(GetModule(), "X3_MOUNT_NO_REST_DISMOUNT", TRUE);        // Allow rest when mounted
   SetLocalInt(GetModule(), "X3_HORSE_ENABLE_ACBOOST", TRUE);          // Increase rider AC to match horse on mounting
// SetLocalInt(GetModule(), "X3_NO_MOUNTED_COMBAT_FEAT", TRUE);        // Disable Mounted Combat feat
   SetLocalInt(GetModule(), "X3_HORSE_ENABLE_HPBOOST", TRUE);          // Give rider temporary hit points on mounting
   SetLocalInt(GetModule(), "X3_ENABLE_MOUNT_DAMAGE", TRUE);           // Horse shares damage on dismounting
// SetLocalInt(GetModule(), "X3_HORSE_NO_CORPSES", TRUE);              // Mounted horses leave no corpses
// SetLocalInt(GetModule(), "X3_NO_SHAPESHIFT_SPELL_CHECK", TRUE);     // Allow mounted creatures to be shapeshifted by spells

   // Henchman Control
// SetLocalInt(GetModule(), "X3_RESTORE_HENCHMEN_LOCATIONS", TRUE);      // Henchmen's horses respawn near henchmen on loading saved game
// SetLocalInt(GetModule(), "X3_HORSE_NO_HENCHMAN_INCREASE", TRUE);    // No increase in maximum henchmen to accommodate horses
   SetLocalInt(GetModule(), "X3_HORSE_MAX_HENCHMEN ", 0);              // Upper limit on maximum henchmen to accommodate horses

   // Saddlebags
// SetLocalInt(GetModule(), "X3_HORSE_ENABLE_SADDLEBAGS", TRUE);       // Enable saddlebags
// SetLocalString(GetModule(), "X3_SADDLEBAG_DATABASE", "X3SADDLEBAG"); // Name of saddlebag database

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
// SetLocalInt(GetModule(), "X3_ENABLE_MOUNT_DB", TRUE);               // Enable data base functions

}
