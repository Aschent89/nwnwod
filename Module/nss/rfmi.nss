//::///////////////////////////////////////////////
//:: Include File
//:: RFMI - Reward For Multiple Items v. 1.25
//::
//:: RFMI.nss
//::
//:://////////////////////////////////////////////
/*
   The Reward For Multiple Items Package contains:

   - Reward script for multiple items that handles
   items, xp reward and gp reward.
   - Variable handler.
   - RFMI_const file to easier update your defaults.
*/
//:://////////////////////////////////////////////
//:: Created By: Moon
//:: Created On: June 16, 2005
//:: Updated By: Moon
//:: Updated On: November 10, 2005
//:://////////////////////////////////////////////


// USER INFORMATION! - (Aid to the Builder)
//To Change default values/constants please see "RFMI_const"
//:: Variable Explanation:
/*
    bVars - boolean (TRUE/FALSE)
    iVars - integer {... -3, -2, -1, 0, 1, 2, 3 ...}
    oVars - objects (Player Character, NPCs, Items, Placeables)
    sVars - strings - Words/letters (e.g. "mn12of" or "JoHnNy")
*/
//:: Remember that strings are case senitive.
//:: Installion and modifications.
// Do a FULL Build Module - Compile Scripts. When importing this
// OR/AND if you change ANY none-comment within this script!
//End of User Information.


//Listing Include Files:

//RFMI_const - all the Default values
#include "RFMI_const"




//::///////////////////////////////////////////////
/*                ENGINE CONST                   */
//::///////////////////////////////////////////////


const int RFMI_SUCCESS = 0;
const int RFMI_FAILURE_SANITY = 1;
const int RFMI_FAILURE_CAP_REACHED = 2;
const int RFMI_FAILURE_NO_REWARD = 3;

const int PARTY_RESTRICT_NO_PARTY     = 0x00000000;
const int PARTY_RESTRICT_SAME_AREA    = 0x00000001;
const int PARTY_RESTRICT_DIS_25_METER = 0x00000002;
const int PARTY_RESTRICT_DIS_50_METER = 0x00000004;
const int PARTY_RESTRICT_ALL_MEMBERS  = 0x00000008;


//::///////////////////////////////////////////////
//:: HEADER FOR THE RFMI-SCRIPTS
//:://////////////////////////////////////////////


//returns RFMI_SUCCESS on Success,
//returns RFMI_FAILURE_SANITY if oPC or the Item with the tag sTag was Invalid
//returns RFMI_FAILURE_CAP_REACHED if the Cap was reached
//returns RFMI_FAILURE_NO_REWARD if No Reward would be given. (Due to Party Size or level differences)
//
//oPC - The Player Character.
//oStorage. The Object the Variables are stored on (The Module, PC, NPC, placable etc.)
//sTag - The Tag of the Item to be Delievered. e.g. "mor_Ni_092" (Case Senitive)
//iXP/iGP - XP/GP per Item. (Negative INTs resolve LOSES!)
//:: NOTE -  ALL VARIABLES BELOW THIS POINT ARE OPTIONAL! :://
//iCap - Max Items per Reset, if set to 0, then there is NO Cap. (Negative Ints are converted to Positive)
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//bRewardPartyXP. If FALSE, Party will NOT get any XP, if TRUE Party will get the same as oPC.
//bRewardPartyGP. If FALSE, Party will NOT get any Gold, if TRUE Party will get the same as oPC.
//iNotUsed - Name says it all.
//bSoftCap
//      - If TRUE, once the cap is reached, no more items are lost.
//      - If FALSE, ALL items are lost EVEN if cap is passed.
//      This does NOT affect the Reward in anyway, only how many items are lost if cap is passed.
//bDis2DMs (Uses the SendMessageToAllDMs()-Command)
//        - If TRUE, DMs will get notified each time a player activates this Script (Turns in items).
//        - If FALSE, DMs will NOT get notified.
//bVarPersist - If TRUE, this is Stored Persistantly (using SetCampaignInt()) rather than SetLocalInt()
//sCampaignName - The CampaignName used in SetCampaignInt. Only used if bVarPersist = TRUE
//It uses the SetVar_INT to set Variables. See this Command for more info on the Variable.
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
//Counter Abuse Measures:
//  - Cannot be cheated by "Drop Bug", Makes sure no party member exceeds the Cap.
int RewardForMultipleItems(object oPC, object oStorage, string sTag, int iXP, int iGP, int iCap=RFMI_DEFAULT_INT_CAP, int iRestrictions=PARTY_RESTRICT_DEFAULT, int bRewardPartyXP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_XP, int bRewardPartyGP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_GP, int iNotUsed=0, int bSoftCap=RFMI_DEFAULT_BOOLEAN_SOFT_CAP,int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, float fDecreasement=RFMI_DEFAULT_FLOAT_REWARD_DECREASEMENT_FACTOR, int iMaxPartySize=RFMI_DEFAULT_INT_MAX_PARTY_SIZE, int iMaxLevelDifference=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE, int iUnaffectLevel=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE_BYPASS);

//The Short Version of RewardForMultipleItems. It uses the default values from RFMI_const.nss
// No Return Value
//oPC - The Player Character.
//oStorage. The Object the Variables are stored on (The Module, PC, NPC, placable etc.)
//sTag - The Tag of the Item to be Delievered. e.g. "mor_Ni_092" (Case Senitive)
//iXP/iGP - XP/GP per Item. (Negative INTs resolve LOSES!)
//iCap - Max Items per Reset, if set to 0, then there is NO Cap. (Negative Ints are converted to Positive)
void RFMI(object oPC, object oStorage, string sTag, int iXP, int iGP, int iCap=RFMI_DEFAULT_INT_CAP, int iRestrictions=PARTY_RESTRICT_DEFAULT);

//Cycle through Selected part of the party and sets a Variable.
//oPC - Member of Party.
//oStorage - The Object the Variables are be stored on (The Module, PC, NPC, placable etc.)
//sVarname - Part of the Variable Name for the Local INT (see below)
//iAmount - The Number the Local INT should be set to (e.g. TRUE, 20, FALSE or 4)
//           iAmount = 0 is the same as deleting the variable.
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//iNotUsed - Name says it all
//bMakeItemOnFailure (ONLY Triggered/Used if oStorage is an object in oPC's Possesion)
//      - TRUE and a PartyMember does NOT have an item with same Tag, it gives the PartyMember
//            a item with the same resref of oStorage and sets the variable on it.
//      - FALSE, if Item cannot be found on the PartyMember, the variable is stored on the PartyMember
//----------------------------------------------------------------------------//
//Misc Info:
//if oStorage is a Player Character, it will store a unique Variable on EACH of the AFFECTED PartyMembers
//Current PC - The PartyMember Getting set its Variable.
//Prefix refers to the const string RFMI_VARIABLE_PREFIX.
//The Variable Name is determined like this:
//      - If oStorage is oPC (or just any PC)
//      Varible name = Prefix + sVarname + CD-Key of Current PC + Name of Current PC
//      - If oStorage is the Module
//        Varible name = Prefix + sVarname + Name of Module (Defaults to "ModuleName" in case of faulure) + Name of current PC
//      - If oStorage is any other object (NPCs, Items, Placeables)
//      Varible Name = Prefix + sVarname + Tag of oStorage + Name of Current PC
//NB: Varibles on Items (that the PC keeps) are stored PERSISTANTLY. (Yes, Also remembered through RESETS)
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
void SetVariables_INT(object oPC, object oStorage, string sVarname, int nAmount, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=FALSE, string sCampaignName="", int bMakeItemOnFailure=FALSE);

//Cycle through Selected part of the party and modifies a Variable.
//oPC - Member of Party.
//oStorage - The Object the Variables are be stored on (The Module, PC, NPC, placable etc.)
//sVarname - Part of the Variable Name for the Local INT (see below)
//iAmount - The Number the Local INT should be changed with. (e.g. 20, -25 or 10);
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//iNotUsed - Name says it all
//bMakeItemOnFailure (ONLY Triggered/Used if oStorage is an object in oPC's Possesion)
//      - TRUE and a PartyMember does NOT have an item with same Tag, it gives the PartyMember
//            a item with the same resref of oStorage and sets the variable on it.
//      - FALSE, if Item cannot be found on the PartyMember, the variable is stored on the PartyMember
//----------------------------------------------------------------------------//
//Misc Info:
//if oStorage is a Player Character, it will store a unique Variable on EACH of the AFFECTED PartyMembers
//Current PC - The PartyMember Getting set its Variable.
//Prefix refers to the const string RFMI_VARIABLE_PREFIX.
//The Variable Name is determined like this:
//      - If oStorage is oPC (or just any PC)
//      Varible name = Prefix + sVarname + CD-Key of Current PC + Name of Current PC
//      - If oStorage is the Module
//        Varible name = Prefix + sVarname + Name of Module (Defaults to "ModuleName" in case of failure) + Name of current PC
//      - If oStorage is any other object (NPCs, Items, Placeables)
//      Varible Name = Prefix + sVarname + Tag of oStorage + Name of Current PC
//NB: Varibles on Items (that the PC keeps) are stored PERSISTANTLY. (Yes, Also remembered through RESETS)
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
void ChangeVariables_INT(object oPC, object oStorage, string sVarname, int iAmount, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=FALSE, string sCampaignName="", int bMakeItemOnFailure=FALSE);

//Changes a INT Variable for a single player character on oStorage.
//oPC - Player Character.
//oStorage - The Object the Variables are be stored on (The Module, PC, NPC, placable etc.)
//sVarname - Part of the Variable Name for the Local INT (see below)
//iAmount - The Number the Local INT should be changed with. (e.g. 20, -25 or 10);
//bMakeItemOnFailure (ONLY Triggered/Used if oStorage is an object in oPC's Possesion)
//      - TRUE and a PartyMember does NOT have an item with same Tag, it gives the PartyMember
//            a item with the same resref of oStorage and sets the variable on it.
//      - FALSE, if Item cannot be found on the PartyMember, the variable is stored on the PartyMember
//----------------------------------------------------------------------------//
//Misc Info:
//if oStorage is a Player Character, it will store a unique Variable on EACH of the AFFECTED PartyMembers
//Current PC - The PartyMember Getting set its Variable.
//Prefix refers to the const string RFMI_VARIABLE_PREFIX.
//The Variable Name is determined like this:
//      - If oStorage is oPC (or just any PC)
//      Varible name = Prefix + sVarname + CD-Key of Current PC + Name of Current PC
//      - If oStorage is the Module
//        Varible name = Prefix + sVarname + Name of Module (Defaults to "ModuleName" in case of faulure) + Name of current PC
//      - If oStorage is any other object (NPCs, Items, Placeables)
//      Varible Name = Prefix + sVarname + Tag of oStorage + Name of Current PC
//NB: Varibles on Items (that the PC keeps) are stored PERSISTANTLY. (Yes, Also remembered through RESETS)
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
void ChangeVariables_INT_SG(object oPC, object oStorage, string sVarname, int iAmount, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, int bItem=FALSE, string sTag="", string sResRef="");

//Works like RewardPartyXP from nw_i0_tool, although this script allows you
//to localize the distrubuation to the area it is triggered from (Area of oPC)
//XP - XP to be distribuated amoung the Party. (Negative INT resolve LOSS!)
//oTarget - Member of Party
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//iNotUsed - Name says it all
void RP_XP(int iXP, object oPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0);


//Works like RewardPartyGP from nw_i0_tool, although this script allows you
//to localize the distrubuation to the area it is triggered from (Area of oPC)
//GP - GP to be distribuated amoung the Party. (Negative INT resolve LOSS!)
//oTarget - Member of Party
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//iNotUsed - Name says it all
void RP_GP(int iGP, object oPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0);


//Return the Local/Campaign INT set by SetVariables_INT.
//Returns 0 on error
//oPC - The Player this is all about.
//oStorage - The Object the Variable is stored on (The Module, PC, NPC, placable etc.)
//sVarname - Part of the Variable Name for the Local INT (see below)
int GetVar_INT(object oPC, object oStorage, string sVarname, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME);

//Used to retrieve the names of the Variables Set by the RFMI Scripts,
// since they are long and may be difficult to find again otherwise.
//
//Returns the Variable Name Set by SetVariables_*/ChangeVariables_*
//NOTE:
//This ONLY returns the name of the Variable set by the SetVariables_*
//It does NOT return the Value nor the Type of the Variable. (e.g. Campaign/Local)
//If you want the Value use the GetVar_* Commands.
string GetVar_Name(object oPC, object oStorage, string sVarname);

//Return Value: The amount of items taken from the player. (It takes iCap into consideration)
//Returns 0 on error. (e.g. Cap was reached before the script was triggered)
//oPC - The Player to take from.
//oStorage. The Object the Variables are stored on (The Module, PC, NPC, placable etc.)
//sTag - The Tag of the Item to be Delievered. e.g. "mor_Ni_092" (Case Senitive)
//iCap - Max Items per Reset, if set to 0, then there is NO Cap. (Negative Ints are converted to Positive)
//bSoftCap
//      - If TRUE, once the cap is reached, no more items are lost.
//      - If FALSE, ALL items are lost EVEN if cap is passed.
//      This does NOT affect the Reward in anyway, only how many items are lost if cap is passed.
//bDis2DMs (Uses the SendMessageToAllDMs()-Command)
//        - If TRUE, DMs will get notified each time a player activates this Script (Turns in items).
//        - If FALSE, DMs will NOT get notified.
//bVarPersist - If TRUE, this was Stored Persistantly (using GetCampaignInt()) rather than GetLocalInt()
//sCampaignName - The CampaignName used in GetCampaignInt. Only used if bVarPersist = TRUE
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
//Counter Abuse Measures:
//  - Cannot be cheated by "Drop Bug".
int TakeAllItems(object oPC, object oStorage, string sTag, int iCap=RFMI_DEFAULT_INT_CAP, int bSoftCap=RFMI_DEFAULT_BOOLEAN_SOFT_CAP, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME);

//Used by the RewardForMultipleItems() script to give the current reward to each partymember.
// - NB THIS FUNCTION DOES NOT TAKE THE ITEMS!
//oPC - The Player Character.
//oStorage. The Object the Variables are stored on (The Module, PC, NPC, placable etc.)
//sTag - The Tag of the Item to be Delievered. e.g. "mor_Ni_092" (Case Senitive)
//iXP/iGP - XP/GP per Item. (Negative INTs resolve LOSES!)
//:: NOTE -  ALL VARIABLES BELOW THIS POINT ARE OPTIONAL! :://
//iCap - Max Items per Reset, if set to 0, then there is NO Cap. (Negative Ints are converted to Positive)
//iRestrictions. Use PARTY_RESTRICT_* (is subject to bRewardPartyXP/bRewardPartyGP)
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//bRewardPartyXP. If FALSE, Party will NOT get any XP, if TRUE Party will get the same as oPC.
//bRewardPartyGP. If FALSE, Party will NOT get any Gold, if TRUE Party will get the same as oPC.
//iNotUsed - Name says it all
//bSoftCap
//      - If TRUE, once the cap is reached, no more items are lost.
//      - If FALSE, ALL items are lost EVEN if cap is passed.
//      This does NOT affect the Reward in anyway, only how many items are lost if cap is passed.
//bDis2DMs (Uses the SendMessageToAllDMs()-Command)
//        - If TRUE, DMs will get notified each time a player activates this Script (Turns in items).
//        - If FALSE, DMs will NOT get notified.
//bVarPersist - If TRUE, this is Stored Persistantly (using SetCampaignInt()) rather than SetLocalInt()
//sCampaignName - The CampaignName used in SetCampaignInt. Only used if bVarPersist = TRUE
//It uses the SetVar_INT to set Variables. See this Command for more info on the Variable.
//NB: if oStorage cannot be found the scripts defaults to the PC (and PartyMembers)
//Counter Abuse Measures:
//  - Makes sure no party member exceeds the Cap.
void RP_INT(object oPC, object oStorage, string sTag, int iXP, int iGP, int iAmount, int iCap=RFMI_DEFAULT_INT_CAP, int bRewardPartyXP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_XP, int bRewardPartyGP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_GP, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, float fProcentageDecrease=0.0);


//Returns value between 0.0 and 1.0
// * returns 1.0 on error.
float RFMI_RewardProcentage(object oPC, string sTag, float fDecreasement=RFMI_DEFAULT_FLOAT_REWARD_DECREASEMENT_FACTOR, int iMaxPartySize=RFMI_DEFAULT_INT_MAX_PARTY_SIZE, int iMaxLevelDifference=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE, int iUnaffectLevel=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE_BYPASS, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS);

//Works as GetFirstFactionMember / GetNextFactionMember (PC only)
//returns the first valid object choice following iRestrictions, or OBJECT_INVALID
//if no more "Valid PartyMembers" could be found.
//
//  Use PARTY_RESTRICT_*
//     - PARTY_RESTRICT_DIS_X_METER means that only PartyMembers within X meters
//       from oMainPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_SAME_AREA means that only PartyMembers within the same area
//       as oMainPC is considered a "Valid PartyMember"
//     - PARTY_RESTRICT_NO_PARTY means no Party
//       (returns oMainPC first time and OBJECT_INVALID after that)
//     - PARTY_RESTRICT_ALL_MEMBERS means PartyMembers are Valid
//
//iFirst toggles whether it acts like GetFirstFactionMember or GetNextFactionMember
object GetValidPartyMember(object oMainPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iFirst=FALSE);

//::///////////////////////////////////////////////
/*               IMPLEMENTATION                  */
//::///////////////////////////////////////////////


//::///////////////////////////////////////////////
//:: GetPlayerLevel
//::
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon (snatched from SSE)
//:: Created On: September 30, 2005
//:://////////////////////////////////////////////
int GetPlayerLevel(object oPC)
{
   int XP = GetXP(oPC);
   return FloatToInt(0.02 * (sqrt(5.0f) * sqrt(XP + 125.0f) + 25.0f));
}
//::///////////////////////////////////////////////
//:: RFMI_DM_String
//:: Private Function for RP_INT
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:: Created On: September 30, 2005
//:://////////////////////////////////////////////
string RFMI_DM_String(object oPlayer, int iRT)
{
string sReturn;
int iHD = GetPlayerLevel(oPlayer);
sReturn = GetName(oPlayer) +
" ( HD: " + IntToString(iHD) + " Affected by: " + IntToString(iRT)+")\n";


return sReturn;
}
//::///////////////////////////////////////////////
//:: RP_INT
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void RP_INT(object oPC, object oStorage, string sTag, int iXP, int iGP, int iAmount, int iCap=RFMI_DEFAULT_INT_CAP, int bRewardPartyXP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_XP, int bRewardPartyGP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_GP, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, float fProcentageDecrease=0.0)
{
//Check if any reward is given.
if( (!iAmount) || ( (!iXP)  && (!iGP) ) ){/*No Reward, End script*/ return;}

//If no CampaignName is given the Default to the standard.
if( (sCampaignName == "") && bVarPersist){sCampaignName = RFMI_DEFAULT_STRING_CAMPAIGNNAME;}

//Define Variables.
int bItem, iRT, iSetXP, iGiveGP;
string sDM;
string sItemTag = GetTag(oStorage);
string sResRef = GetResRef(oStorage);

//IF the DMs need to be told of this event, then create the first part of the message.
/*if(bDis2DMs == TRUE)*/{sDM = "The Party of " + GetName(oPC) + "\n turned in " + IntToString(iAmount) + " of " + sTag + "\n The (affected) Party Members are: \n";}

//If oStorage (the object we are supposed to store the information on) does not
//exist, then use oPC (the player) instead.
if(! GetIsObjectValid(oStorage) ) {oStorage = oPC;}
else if ( (GetObjectType(oStorage) == OBJECT_TYPE_ITEM) && GetItemPossessor(oStorage) == oPC){bItem = TRUE;}
    else {bItem = FALSE;}

//Right All PartyMembers it is.
//Define PartyMembers and begin the Loop
object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);
while (GetIsObjectValid(oPartyMember)) {

    //All PartyMembers (Save oPC) uses this part.
    if(oPartyMember != oPC)
      {
      //Was oStorage an Item in oPC's Inventory?
        if(bItem)
            {
            oStorage = GetItemPossessedBy(oPC, sTag);
            if(!GetIsObjectValid(oStorage) )
                {
                oStorage = bMakeItemOnFailure ? CreateItemOnObject(sResRef, oPC) : oPC ;
                }
            }
        //Calculate the Reward for this Member.
        //Find out how many oPartyMember turned into previously
        int iPD = GetVar_INT(oPartyMember, oStorage, sTag, bVarPersist, sCampaignName);
        //IF this exceeds the Cap, make sure oPartyMember does not get reward for any
        //item beyond the Cap.
        if(iPD + iAmount > iCap && iCap != 0){iRT = iCap - iPD; if(iCap < iPD) {iRT = 0;}}
        else {iRT = iAmount;}
        //Are we to Change oPartyMember's XP?
        if(bRewardPartyXP)
            {
            //Find out how much oPartyMember earned and give the reward/penalty
            iSetXP = GetXP(oPartyMember) + FloatToInt( (iRT * iXP * fProcentageDecrease) );
            SetXP(oPartyMember, iSetXP);
            }
        //Are we to Change oPartyMember's Gold?
        if(bRewardPartyGP)
            {
            //Find out how much oPartyMember earned.
            iGiveGP = FloatToInt(iRT * iGP * fProcentageDecrease);
            //Give in case iGiveGP is above 0, take if below
            if(iGiveGP >= 0){ GiveGoldToCreature(oPartyMember, iGiveGP);}
            else if(iGiveGP < 0) { TakeGoldFromCreature(abs(iGiveGP), oPartyMember, TRUE);}
            }
            ChangeVariables_INT_SG(oPartyMember, oStorage, sTag, iRT, bVarPersist, sCampaignName, bMakeItemOnFailure, bItem, sItemTag, sResRef);
        //Add oPartyMember to the DM Message if required.
        /*if(bDis2DMs == TRUE)*/{sDM = sDM + RFMI_DM_String(oPartyMember, iRT);}
      }

      //IF oPartyMember is the Player triggering this script.
      else if(oPartyMember == oPC)
      {
      //Was oStorage an Item in oPC's Inventory?
      if (bItem)
            {
            //Yes, Redefine oStorage for this PartyMember. (In case it was changed)
            oStorage = GetItemPossessedBy(oPC, sItemTag);
            //No Test to see to see if oPC has oStorage
            //If oPC never had it, then bItem would have been false.
            }
        //Add oPartyMember to the DM Message if required.
        /*if(bDis2DMs == TRUE){sDM = sDM + GetName(oPC) + " (" + IntToString(GetHitDice(oPC))+")\n";}*/

        //Calculate the Reward for this Member.
        //Find out how many oPartyMember turned into previously
        int iPD = GetVar_INT(oPC, oStorage, sTag, bVarPersist, sCampaignName);
        //IF this exceeds the Cap, make sure oPartyMember does not get reward for any
        //item beyond the Cap.
        if(iPD + iAmount > iCap && iCap != 0){iRT = iCap - iPD; if(iCap < iPD) {iRT = 0;}}
        else {iRT = iAmount;}

            //Determine oPCs earnings and give/take the correct amount.
            iSetXP = GetXP(oPC) + FloatToInt( (iRT * iXP * fProcentageDecrease)  );
            SetXP(oPC, iSetXP);
            iGiveGP = FloatToInt(iRT * iGP * fProcentageDecrease);
            if(iGiveGP >= 0){ GiveGoldToCreature(oPC, iGiveGP);}
            else if(iGiveGP < 0) { TakeGoldFromCreature(abs(iGiveGP), oPC, TRUE);}
            ChangeVariables_INT_SG(oPC, oStorage, sTag, iRT, bVarPersist, sCampaignName, bMakeItemOnFailure, bItem, sItemTag, sResRef);
        //Add oPartyMember to the DM Message if required.
        /*if(bDis2DMs == TRUE)*/{sDM = sDM + RFMI_DM_String(oPC, iRT);}
      }
     //Continue Loop with Next PartyMember
     oPartyMember = GetValidPartyMember(oPC, iRestrictions);

    }//End While

if(bDis2DMs){SendMessageToAllDMs(sDM);}
}

//::///////////////////////////////////////////////
//:: RP_XP (RewardParty_XP)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void RP_XP(int iXP, object oPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=FALSE)
{
//If nothing is given, then why bother?
if(!iXP){return;}

    // * for each party member
    // * cycle through them and
    // * and give them the appropriate reward
    // * HACK FOR NOW

    object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);
    while (GetIsObjectValid(oPartyMember))
    {

       SetXP(oPartyMember, GetXP(oPartyMember) + iXP );

    oPartyMember = GetValidPartyMember(oPC, iRestrictions);
    }



}

//::///////////////////////////////////////////////
//:: RP_GP (RewardParty_Gold)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void RP_GP(int iGP, object oPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=FALSE)
{
//If nothing is given, then why bother?
if(!iGP) {return;}
    // * for each party member
    // * cycle through them and
    // * and give them the appropriate reward
    // * HACK FOR NOW


    object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);
    while (GetIsObjectValid(oPartyMember))
    {

      if(iGP >= 0){GiveGoldToCreature(oPartyMember, iGP);}
      else if (iGP < 0){TakeGoldFromCreature(abs(iGP), oPartyMember, TRUE);}

    oPartyMember = GetValidPartyMember(oPC, iRestrictions);
    }



}

//::///////////////////////////////////////////////
//:: SetVariables_INT
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void SetVariables_INT(object oPC, object oStorage, string sVarname, int iAmount, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=FALSE, string sCampaignName="", int bMakeItemOnFailure=FALSE)
{
//If oStorage does not exist, default to oPC
int bItem;
string sTag = GetTag(oStorage);
string sResRef = GetResRef(oStorage);
string sVar;
//In case oStorage is an item in oPCs possesion, then the Variables for
//the PartyMembers should be stored on their item as well.
if( !GetIsObjectValid(oStorage) ) {oStorage = oPC;}
else if ( (GetObjectType(oStorage) == OBJECT_TYPE_ITEM) && (GetItemPossessor(oStorage) == oPC) ){bItem = TRUE;}
    else {bItem = FALSE;}
//If no CampaignName is given the Default to the standard.
if( (sCampaignName == "") && bVarPersist){sCampaignName = RFMI_DEFAULT_STRING_CAMPAIGNNAME;}

object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);

while ( GetIsObjectValid(oPartyMember) ) {
    if (bItem) {
        oStorage = GetItemPossessedBy(oPartyMember, sTag);
        if(! GetIsObjectValid(oStorage) ) {
            oStorage = bMakeItemOnFailure ? CreateItemOnObject(sResRef, oPartyMember) : oPartyMember ;
            }
        }

    switch(bVarPersist) {
            case FALSE:
                sVar = GetVar_Name(oPartyMember, oStorage, sVarname);
                if(iAmount)
                SetLocalInt(oStorage, sVar, iAmount);
                else
                DeleteLocalInt(oStorage, sVar);
                break;
            default:
                sVar = GetVar_Name(oPartyMember, oPartyMember, sVarname);
                if(iAmount)
                SetCampaignInt(sCampaignName, sVar, iAmount, oPartyMember);
                else
                DeleteCampaignVariable(sCampaignName, sVar, oPartyMember);
                break;
        }
    oPartyMember = GetValidPartyMember(oPC, iRestrictions);
    }
}

//::///////////////////////////////////////////////
//:: ChangeVariables_INT
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void ChangeVariables_INT(object oPC, object oStorage, string sVarname, int iAmount, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bVarPersist=FALSE, string sCampaignName="", int bMakeItemOnFailure=FALSE)
{
int bItem;
int iSet;
string sTag = GetTag(oStorage);
string sResRef = GetResRef(oStorage);
string sVar;
//In case oStorage is an item in oPCs possesion, then the Variables for
//the PartyMembers should be stored on their item as well.
if( !GetIsObjectValid(oStorage) ) {oStorage = oPC;}
else if ( (GetObjectType(oStorage) == OBJECT_TYPE_ITEM) && GetItemPossessor(oStorage) == oPC){bItem = TRUE;}
    else {bItem = FALSE;}
//If no CampaignName is given the Default to the standard.
if( (sCampaignName == "") && bVarPersist){sCampaignName = RFMI_DEFAULT_STRING_CAMPAIGNNAME;}

object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);
while ( GetIsObjectValid(oPartyMember) )   {
    if (bItem)
        {
        oStorage = GetItemPossessedBy(oPartyMember, sTag);
        if(! GetIsObjectValid(oStorage) )
            {
            oStorage = bMakeItemOnFailure ? CreateItemOnObject(sResRef, oPartyMember) : oPartyMember ;
            }
        }
        switch(bVarPersist)
            {
            case FALSE:
                sVar = GetVar_Name(oPartyMember, oStorage, sVarname);
                iSet = iAmount + GetVar_INT(oPartyMember, oPartyMember, sVarname, bVarPersist, sCampaignName);
                if(iSet)
                SetLocalInt(oStorage, sVar, iSet);
                else
                DeleteLocalInt(oStorage, sVar);
                break;
            default:
                sVar = GetVar_Name(oPartyMember, oPartyMember, sVarname);
                iSet = iAmount + GetVar_INT(oPartyMember, oPartyMember, sVarname, bVarPersist, sCampaignName);
                if(iSet)
                SetCampaignInt(sCampaignName, sVar, iSet, oPartyMember);
                else
                DeleteCampaignVariable(sCampaignName, sVar, oPartyMember);
                break;
            }
    oPartyMember = GetValidPartyMember(oPC, iRestrictions);
    }
}

//::///////////////////////////////////////////////
//:: GetVar_INT
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
int GetVar_INT(object oPC, object oStorage, string sVarname, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME)
{

//If oStorage does not exist, default to oPC
if( !GetIsObjectValid(oStorage) ) {oStorage = oPC;}

if(sCampaignName == ""){sCampaignName = RFMI_DEFAULT_STRING_CAMPAIGNNAME;}

string sVar = GetVar_Name(oPC, oStorage, sVarname);
int iReturn;
if(bVarPersist)
        iReturn = GetCampaignInt(sCampaignName, sVar, oPC);
  else
        iReturn = GetLocalInt(oStorage, sVar);

return iReturn;
}

//::///////////////////////////////////////////////
//:: GetVar_Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
string GetVar_Name(object oPC, object oStorage, string sVarname)
{
string sVar;
switch (GetObjectType(oStorage))
   {
   case OBJECT_TYPE_CREATURE:
        if(GetIsPC(oStorage))
            {
            sVar = RFMI_VARIABLE_PREFIX + sVarname + GetPCPublicCDKey(oPC) + GetName(oPC);
            }
        else
            {
            sVar = RFMI_VARIABLE_PREFIX + sVarname + GetTag(oStorage) + GetName(oPC);
            }
       break;
   case OBJECT_TYPE_DOOR:
   case OBJECT_TYPE_PLACEABLE:
   case OBJECT_TYPE_TRIGGER:
   case OBJECT_TYPE_ENCOUNTER:
   case OBJECT_TYPE_AREA_OF_EFFECT:
   case OBJECT_TYPE_STORE:
   case OBJECT_TYPE_WAYPOINT:
   case OBJECT_TYPE_ITEM:
            sVar = RFMI_VARIABLE_PREFIX + sVarname + GetTag(oStorage) + GetName(oPC);
            break;
   default:
       if (GetModule() == oStorage)
            {
            string sModuleName = GetModuleName();
                    if(sModuleName == "")
                        {
                        sModuleName = "ModuleName";
                        }
            sVar = RFMI_VARIABLE_PREFIX + sVarname + sModuleName + GetName(oPC);
            }
       else
            {
            oStorage = oPC;
            sVar = RFMI_VARIABLE_PREFIX + sVarname + GetPCPublicCDKey(oPC) + GetName(oPC);
            }
       break;
   }

return sVar;
}

//::///////////////////////////////////////////////
//:: ChangeVar_INT_SG
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void ChangeVariables_INT_SG(object oPC, object oStorage, string sVarname, int iAmount, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, int bItem=FALSE, string sTag="", string sResRef="")
{
if(bItem)
    {
    oStorage = GetItemPossessedBy(oPC, sTag);
    if(!GetIsObjectValid(oStorage) )
        {
        oStorage = bMakeItemOnFailure ? CreateItemOnObject(sResRef, oPC) : oPC ;
        }
    }
string sVar;
int iSet;
switch(bVarPersist)
    {
    case FALSE:
        sVar = GetVar_Name(oPC, oStorage, sVarname);
        iSet = iAmount + GetVar_INT(oPC, oStorage, sVarname, bVarPersist, sCampaignName);
        if(iSet)
        SetLocalInt(oStorage, sVar, iSet);
        else
        DeleteLocalInt(oStorage, sVar);
        break;
    default:
        sVar = GetVar_Name(oPC, oPC, sVarname);
        iSet = iAmount + GetVar_INT(oPC, oPC, sVarname, bVarPersist, sCampaignName);
        if(iSet)
        SetCampaignInt(sCampaignName, sVar, iSet, oPC);
        else
        DeleteCampaignVariable(sCampaignName, sVar, oPC);
        break;
    }

}
//::///////////////////////////////////////////////
//:: TakeAllItems
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
int TakeAllItems(object oPC, object oStorage, string sTag, int iCap=RFMI_DEFAULT_INT_CAP, int bSoftCap=RFMI_DEFAULT_BOOLEAN_SOFT_CAP, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME)
{
//If the player does not have the item, lets not waste energy on him.
if(GetItemPossessedBy(oPC, sTag) == OBJECT_INVALID) {SendMessageToPC(oPC, "You hold none of the desired items"); return 0;}
iCap = abs(iCap);
if( !GetIsObjectValid(oStorage) ) {oStorage = oPC;}

int iDelieverySoFar = GetVar_INT(oPC, oStorage, sTag, bVarPersist, sCampaignName);
if(iCap != 0 && iDelieverySoFar >= iCap){SendMessageToPC(oPC, "Cap reached, no further items can be turned in"); return 0;}
object oItem = GetFirstItemInInventory(oPC);
int iRT = 0;
{
if (iCap)
    {
    if(!bSoftCap)
        {
        while ( GetIsObjectValid(oItem) )
            {
            if (GetTag(oItem) == sTag)
                {
                iRT += GetNumStackedItems(oItem);
                DestroyObject(oItem);
                }
            oItem = GetNextItemInInventory(oPC);
            }
        if(iRT + iDelieverySoFar> iCap)
            {
            iRT = iCap - iDelieverySoFar;
            }
        DelayCommand(0.09, SendMessageToPC(oPC, "You have delievered " +IntToString(iDelieverySoFar + iRT) + " out of your max on " + IntToString(iCap)));
        }
    else if(bSoftCap)
        {
        while (GetIsObjectValid(oItem)  && (iRT + iDelieverySoFar < iCap))
            {
            if ((GetTag(oItem) == sTag))
                {

                if(iRT + iDelieverySoFar + GetNumStackedItems(oItem) > iCap)
                    {
                    SetItemStackSize(oItem, iCap - iRT);
                    iRT = iCap - iDelieverySoFar;
                    DelayCommand(0.10, SendMessageToPC(oPC, "Cap reached, no further items can be turned in"));
                    break;
                    }
                else
                    {
                    iRT += GetNumStackedItems(oItem);
                    DestroyObject(oItem);
                    }
                }
            if (iRT + iDelieverySoFar >= iCap)
                {
                DelayCommand(0.10, SendMessageToPC(oPC, "Cap reached, no further items can be turned in"));
                break;
                }
            oItem = GetNextItemInInventory(oPC);
            }
        }
    if(iRT < 0)
       {
       iRT = 0;
       }
    DelayCommand(0.09, SendMessageToPC(oPC, "You have delievered " +IntToString(iDelieverySoFar + iRT) + " out of your max on " + IntToString(iCap)));

    }
else if(!iCap)
    {
        while (GetIsObjectValid(oItem))
            {
            if (GetTag(oItem) == sTag)
                {
                iRT += GetNumStackedItems(oItem);
                DestroyObject(oItem);
                }
            oItem = GetNextItemInInventory(oPC);
            }
    SendMessageToPC(oPC, "You have delievered " + IntToString(iDelieverySoFar + iRT) + " so far.");
    }
 }
    //if Required, tell DMs of this.
    string sDM = "PC: " + GetName(oPC) + ", Login: " + GetPCPlayerName(oPC) + " turned in " + IntToString(iRT) + " of the item with the Tag: " + sTag + ". \n";
    switch(iCap)
        {
        case 0:
            sDM = sDM + " There is no Cap.";
            break;
        default:
            switch(bSoftCap)
                {
                case TRUE:
                    sDM = sDM + " The Cap is " + IntToString(iCap) + " and is Soft.";
                    break;
                default:
                    sDM = sDM + " The Cap is " + IntToString(iCap) + " and is Hard.";
                    break;
                }
            break;
        }
    if(bDis2DMs){SendMessageToAllDMs(sDM);}
return iRT;
}

//::///////////////////////////////////////////////
//:: RewardForMultipleItemsDefault
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
void RFMI(object oPC, object oStorage, string sTag, int iXP, int iGP, int iCap=RFMI_DEFAULT_INT_CAP, int iRestrictions=PARTY_RESTRICT_DEFAULT)
{
//Yes, This is it.
RewardForMultipleItems(oPC, oStorage, sTag, iXP, iGP, iCap, iRestrictions);
}
//::///////////////////////////////////////////////
//:: RewardForMultipleItems
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
int RewardForMultipleItems(object oPC, object oStorage, string sTag, int iXP, int iGP, int iCap=RFMI_DEFAULT_INT_CAP, int iRestrictions=PARTY_RESTRICT_DEFAULT, int bRewardPartyXP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_XP, int bRewardPartyGP=RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_GP, int iNotUsed=0, int bSoftCap=RFMI_DEFAULT_BOOLEAN_SOFT_CAP,int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS, int bVarPersist=RFMI_DEFAULT_BOOLEAN_VAR_PERSIST, string sCampaignName=RFMI_DEFAULT_STRING_CAMPAIGNNAME, int bMakeItemOnFailure=RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE, float fDecreasement=RFMI_DEFAULT_FLOAT_REWARD_DECREASEMENT_FACTOR, int iMaxPartySize=RFMI_DEFAULT_INT_MAX_PARTY_SIZE, int iMaxLevelDifference=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE, int iUnaffectLevel=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE_BYPASS)
{
//Sanity Test.
if(! GetIsObjectValid( GetItemPossessedBy(oPC, sTag) ) ) {SendMessageToPC(oPC, "You hold none of the desired items"); return RFMI_FAILURE_SANITY; }

//Check if the Cap was reached before.
if(GetVar_INT(oPC, oStorage, sTag, bVarPersist, sCampaignName) >= iCap) {SendMessageToPC(oPC, "Cap reached, no further items can be turned in"); return RFMI_FAILURE_CAP_REACHED;}

//Calculate the decreasement in reward for large parties or level differences
float fDecrease = RFMI_RewardProcentage(oPC, sTag, fDecreasement, iMaxPartySize, iMaxLevelDifference, iUnaffectLevel, iRestrictions, 0, bDis2DMs);

    if(fDecrease == 0.0) //Cancel if no reward would be given due to Party size or Level differences
        { SendMessageToPC(oPC, "No Reward would be given due to Party Level Range and Party Size."); return RFMI_FAILURE_NO_REWARD; }

int iRT = TakeAllItems(oPC, oStorage, sTag, iCap, bSoftCap, bDis2DMs, bVarPersist, sCampaignName);

//In case TakeAllItems returns FALSE
if(!iRT) {return RFMI_FAILURE_CAP_REACHED;}

    //Give Reward
    RP_INT(oPC, oStorage, sTag, iXP, iGP, iRT, iCap, bRewardPartyXP, bRewardPartyGP, iRestrictions, 0, bVarPersist, sCampaignName, bDis2DMs, bMakeItemOnFailure, fDecrease);

//Return Success
return RFMI_SUCCESS;
}
//::///////////////////////////////////////////////
//:: RFMI_RewardProcentage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
float RFMI_RewardProcentage(object oPC, string sTag, float fDecreasement=RFMI_DEFAULT_FLOAT_REWARD_DECREASEMENT_FACTOR, int iMaxPartySize=RFMI_DEFAULT_INT_MAX_PARTY_SIZE, int iMaxLevelDifference=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE, int iUnaffectLevel=RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE_BYPASS, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iNotUsed=0, int bDis2DMs=RFMI_DEFAULT_BOOLEAN_DIS_2_DMS)
{
//Check if it is worth wasting time on!
if( (iRestrictions==PARTY_RESTRICT_NO_PARTY) || (fDecreasement == 0.0) || ( (iMaxPartySize == -1) && (iMaxLevelDifference == -1) ) ) {return 1.0;}

//Calculation Time!
float fReturn = 100.0;
string sDM;
int iCurrent = 0, iSize = 0, iMaxL = GetPlayerLevel(oPC), iMinL = GetPlayerLevel(oPC), iRange=0;

object oPartyMember = GetValidPartyMember(oPC, iRestrictions, TRUE);
while(GetIsObjectValid(oPartyMember))
    {
            {
            iSize += 1;
            iCurrent = GetPlayerLevel(oPartyMember);

            if (iMaxL < iCurrent)
               {
                 iMaxL = iCurrent;
               }
            else if (iMinL > iCurrent)
               {
                 iMinL = iCurrent;
               }
            }
    oPartyMember = GetValidPartyMember(oPC, iRestrictions);
    }

iRange = iMaxL - iMinL;
if(iUnaffectLevel <= iMinL && iUnaffectLevel != -1)
    {
    iRange = 0;
    }
if(iRange > iMaxLevelDifference && iMaxLevelDifference != -1)
    {
    fReturn = fReturn - (fDecreasement * (iRange - iMaxLevelDifference));
    }
if(iSize > iMaxPartySize && iMaxPartySize != -1)
    {
    fReturn = fReturn - (fDecreasement * (iSize - iMaxPartySize));
    }
if(fReturn < 0.0)
    {
    fReturn = 0.0;
    }
if(fReturn > 100.0)
    {
    fReturn = 100.0;
    }


sDM = "The Party of " + GetName(oPC) + " received " + FloatToString(fReturn, 6, 2) + "% of the original reward for turning in " + sTag + "\n The Party Size was " + IntToString(iSize) + " out of the allowed on " + IntToString(iMaxPartySize) + ". \n The Level Range was " + IntToString(iRange) + " out of the allowed on " + IntToString(iMaxLevelDifference);
if(bDis2DMs){SendMessageToAllDMs(sDM);}

return fReturn/100;
}

//::///////////////////////////////////////////////
//:: GetValidPartyMember
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Moon
//:://////////////////////////////////////////////
object GetValidPartyMember(object oMainPC, int iRestrictions=PARTY_RESTRICT_DEFAULT, int iFirst=FALSE) {
//Define Major Variables
object oReturn = iFirst?GetFirstFactionMember(oMainPC):GetNextFactionMember(oMainPC);
//Kill process if we cannot find a valid party-member or if we hit oMainPC (who will always be accepted)
if( !GetIsObjectValid(oReturn) || (oReturn == oMainPC) ) return oReturn;

switch(iRestrictions) {
    case PARTY_RESTRICT_NO_PARTY:
        oReturn = iFirst?oMainPC:OBJECT_INVALID;
        break;
    case PARTY_RESTRICT_DIS_25_METER:
    case PARTY_RESTRICT_DIS_50_METER:
        if( (GetDistanceBetween(oMainPC, oReturn) > (12.5*iRestrictions)) ) {
            oReturn = GetValidPartyMember(oMainPC, iRestrictions);
            }
        break;
    case PARTY_RESTRICT_SAME_AREA:
        if( GetArea(oMainPC) != GetArea(oReturn) ) {
            oReturn = GetValidPartyMember(oMainPC, iRestrictions);
            }
        break;
    }
return oReturn;
}//End Function
