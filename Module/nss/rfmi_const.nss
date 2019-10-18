//::///////////////////////////////////////////////
//:: RFMI_CONST
//:: RFMI_CONST.nss
//:://////////////////////////////////////////////
/*
- The Constants used by RFMI for easy modification.

- You may need to recompile after changing these.
*/
//:://////////////////////////////////////////////
//:: Scripting and variable naming: Moon.
//:: Kodus to Ian Hurst for making it userfriendly
//:: and understandable.
//:://////////////////////////////////////////////

//:: Give all RMFI variables a prefix. Disable Value: ""
      const string RFMI_VARIABLE_PREFIX = "RMFI_DP_";

//:: Store assigned variables persistently (across resets)
      const int RFMI_DEFAULT_BOOLEAN_VAR_PERSIST = FALSE;

//:: Database name for when storing variables persistently (used by the SetVar_*,
//:: GetVar_*, ChangeVar_*, RewardForMultipleItems, and RP_INT commands)
      const string RFMI_DEFAULT_STRING_CAMPAIGNNAME = "RFMI";

//----------------------------------------------------------------------------//
//::                    RFMI SCRIPT DEFAULTS BELOW.
//::     If you want to change a setting, this is the place to do it.
//----------------------------------------------------------------------------//

//:: The maximum number of quest items to accept
      const int RFMI_DEFAULT_INT_CAP = 20;

//:: Affect all party members
//:: Reduntant - Replaced was replaced by the PARTY_RESTRICT_* consts in v1.31
      const int RFMI_DEFAULT_BOOLEAN_ALL_PARTY = TRUE;

//:: If affect all party members is TRUE, give XP to all party members
      const int RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_XP = TRUE;

//:: If affect all party members is TRUE, give gold to all party members
      const int RFMI_DEFAULT_BOOLEAN_REWARD_PARTY_GP = TRUE;

//:: Party members in other areas receive rewards
//:: Reduntant - Replaced was replaced by the PARTY_RESTRICT_* consts in v1.31
      const int RFMI_DEFAULT_BOOLEAN_SERVERWIDE = FALSE;

//:: Do not remove excess quest items
      const int RFMI_DEFAULT_BOOLEAN_SOFT_CAP = TRUE;

//:: Notify DMs
      const int RFMI_DEFAULT_BOOLEAN_DIS_2_DMS = FALSE;

//:: If assigning a variable to an item in inventory, and if the item is not present,
//:: create the item (TRUE), or assign the variable to the character instead (FALSE).
//:: Note: If the PC turning in the quest does not have the item, this is always
//:: FALSE for the entire party (even if other party members have the item).
      const int RFMI_DEFAULT_BOOLEAN_MAKE_ITEM_ON_FAILURE = FALSE;

//:: The maximum level difference between party members before XP/Gold rewards
//:: are reduced.
//:: Disable = -1.
      const int RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE = -1;

//:: The maximum party size allowed before XP/Gold rewards are reduced.
//:: Disable = -1.
      const int RFMI_DEFAULT_INT_MAX_PARTY_SIZE = -1;

//:: Do not reduce XP/Gold rewards, regardless of party level difference, when the
//:: lowest level party member is greater than or equal to this number.
//:: Disable = -1.
      const int RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE_BYPASS = -1;

//:: The percent to reduce XP/Gold rewards for each level exceeding
//:: RFMI_DEFAULT_INT_MAX_LEVEL_DIFFERENCE, and for each party member exceeding
//:: RFMI_DEFAULT_INT_MAX_PARTY_SIZE.
//:: 0.0 = no reduction/disable
//:: 100.0 = complete elimination
      const float RFMI_DEFAULT_FLOAT_REWARD_DECREASEMENT_FACTOR = 0.0;


//::  Setup the "Default" value for RFMI Party Restrictions.
//::  the number after each const is the number to give PARTY_RESTRICT_DEFAULT
//::  if you want the given restriction as the default.
//::  NB: Currently only ONE restriction may apply at the time.
//::
//::  PARTY_RESTRICT_NO_PARTY means that only oPC is valid (works similar
//::  to setting RFMI_DEFAULT_BOOLEAN_ALL_PARTY to FALSE in previous versions)
//::  Value for PARTY_RESTRICT_NO_PARTY     = 0x00000000;
//::
//::  PARTY_RESTRICT_SAME_AREA means that only PartyMembers in the same area as
//::  as oPC are valid. (works similar to setting RFMI_DEFAULT_BOOLEAN_SERVERWIDE
//::   to FALSE in previous versions)
//::  Value for PARTY_RESTRICT_SAME_AREA    = 0x00000001;
//::
//::  PARTY_RESTRICT_DIS_X_METER means that only PartyMembers with X meters from
//::  oPC are valid. This is a new option
//::  Value for PARTY_RESTRICT_DIS_25_METER = 0x00000002;
//::  Value for PARTY_RESTRICT_DIS_50_METER = 0x00000004;
//::
//::  PARTY_RESTRICT_ALL_MEMBERS means that all PartyMembers regardless of
//::  location are valid. (works similar to setting RFMI_DEFAULT_BOOLEAN_SERVERWIDE
//::  to TRUE in previous versions)
//::  Value for PARTY_RESTRICT_ALL_MEMBERS  = 0x00000008;
//::
//::  Disable = N\A
      const int PARTY_RESTRICT_DEFAULT      = 0x00000001;

//End of User Constants.
//----------------------------------------------------------------------------//
