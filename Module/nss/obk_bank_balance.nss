////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_bank_balance
//  By Don Anderson
//  dandersonru@msn.com
//
//  Gets Gold Deposited Amount
//
////////////////////////////////////////////////////////////////////////////////

#include "obk_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBank = OBJECT_SELF;
    string sDB = OBK_GetBankGoldDBString(oPC,oBank);

    int nGold = GetCampaignInt("OBK_BANKING",sDB,oPC);
    SetCustomToken(1500, IntToString(nGold));
    return TRUE;
}
