////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Banking
//  obk_bank_wdw100k
//  By Don Anderson
//  dandersonru@msn.com
//
//  Withdraws Gold Amount
//
////////////////////////////////////////////////////////////////////////////////

#include "obk_inc"

void main()
{
  //Withdraw Gold Amount
  int nWithdraw = 100000;

  object oPC = GetPCSpeaker();
  object oBank = OBJECT_SELF;
  string sDB = OBK_GetBankGoldDBString(oPC,oBank);

  //Gold Amounts
  int nPWGold = GetCampaignInt("OBK_BANKING",sDB,oPC);

  if(nPWGold < nWithdraw)
  {
    SpeakString("You do have that much gold in this Bank!");
    return;
  }

  //Now Withdraw Gold
  GiveGoldToCreature(oPC,nWithdraw);
  int nGold = nPWGold - nWithdraw;
  SetCampaignInt("OBK_BANKING", sDB,nGold,oPC);
}
