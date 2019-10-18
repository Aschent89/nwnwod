////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_bank_dep1000
//  By Don Anderson
//  dandersonru@msn.com
//
//  Deposits Gold Amount
//
////////////////////////////////////////////////////////////////////////////////

#include "obk_inc"

void main()
{
  //Deposit Amount
  int nDeposit = 1000;

  object oPC = GetPCSpeaker();
  object oBank = OBJECT_SELF;
  string sDB = OBK_GetBankGoldDBString(oPC,oBank);

  //Gold Amounts
  int nPIGold = GetGold(oPC);
  int nPWGold = GetCampaignInt("OBK_BANKING",sDB,oPC);

  if(nPIGold < nDeposit)
  {
    SpeakString("You do have that much gold on you!");
    return;
  }

  //Now Deposit Gold
  TakeGoldFromCreature(nDeposit,oPC,TRUE);
  int nGold = nPWGold + nDeposit;
  SetCampaignInt("OBK_BANKING", sDB,nGold,oPC);
}
