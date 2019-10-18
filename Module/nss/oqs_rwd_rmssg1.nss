////////////////////////////////////////////////////////////////////////////////
//  Olander's Questing System
//  oqs_rwd_rmssg1
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from the Conversation of the Receiver
//
//  This is Good for Checking a Message to Them. Can be Many Messages. Simply
//  use/copy this and set the Quantity to which Message this is.
//
//  Format:  OQS_REWARD_GP# (Variable in Int)
//           Quantity of Reward in Gold
//
//           OQS_REWARD_XP# (Variable in Int)
//           Quantity of Reward in Experience
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  object oMod = GetModule();

  int nRNum = 101;
  string sGPReward = "OQS_REWARD_GP" + IntToString(nRNum);
  int nGPReward = GetLocalInt(oNPC,sGPReward);
  string sXPReward = "OQS_REWARD_XP" + IntToString(nRNum);
  int nXPReward = GetLocalInt(oNPC,sXPReward);

  if(nGPReward > 0) GiveGoldToCreature(oPC,nGPReward);
  if(nGPReward > 0) GiveXPToCreature(oPC,nXPReward);
}
