////////////////////////////////////////////////////////////////////////////////
//  Capture the Flag - Start Game Switch
//  ors_ctf_switch
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Switch OnUsed Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc_ctf"

void ActivateSwitch()
{
   DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(2.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void main()
{
    object oDM = GetLastUsedBy();
    object oSwitch = OBJECT_SELF;

    int nCTFStart = GetLocalInt(oSwitch,"CTF_START");
    if(nCTFStart == 0)
    {
      SetLocalInt(oSwitch,"CTF_START",1);
      ActivateSwitch();
      SpeakString("CTF is Prepared. Use this switch again within 10 Seconds to Start the CTF Game.");
      DelayCommand(10.0,DeleteLocalInt(oSwitch,"CTF_START"));//So it does not stay Prepared
    }
    if(nCTFStart == 1)
    {
      ActivateSwitch();
      CTF_BeginGame();
    }
}
