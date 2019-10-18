////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Resouce Pseudo HB
//  ocr_hb_resource
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is called when the Resource is Discovered and continues until the
//  Resource is used up or a Player Character is outside of 20 Meters
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;

    //Player within 20 Meters
    object oPC  = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSelf, 1);
    float fDist = GetDistanceBetween(oSelf,oPC);
    if(fDist > 20.0)
    {
      SetUseableFlag(oSelf,FALSE);
      return;
    }
    else
    {
      DelayCommand(30.0, ExecuteScript("ocr_hb_resource", oSelf));
    }
}

