////////////////////////////////////////////////////////////////////////////////
//
//  Realistic Torches - Activation Script
//  torch_mod_onact
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the Module OnActivate Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetItemActivator();
    object oMod     = GetModule();

    object oOil     = GetItemActivated();
    string sOil     = GetTag(oOil);

    object oTorch   = GetItemActivatedTarget();
    string sTorch   = GetTag(oTorch);

    int nOLHP       = GetLocalInt(oMod,"OLANTERNHP");
    int nLHP        = GetLocalInt(oMod,"LANTERNHP");

    //If not Lantern Oil then don't go further
    if(sOil != "LanternOil") return;

    //Check if Oil was used on an Open Lantern
    if(sTorch == "OpenLantern")
    {
      SetLocalInt(oTorch,"OLANTERNHP",nOLHP);
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
      SendMessageToPC(oPC,"Your Lantern has been filled with Oil.");
    }

    //Check if Oil was used on a Lantern
    if(sTorch == "Lantern")
    {
      SetLocalInt(oTorch,"LANTERNHP",nLHP);
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
      SendMessageToPC(oPC,"Your Lantern has been filled with Oil.");
    }
}
