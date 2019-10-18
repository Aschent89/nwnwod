////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Jumping and Climbing
//  ors_jump_enter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Allows Jumping and Climbing from a specially placed trigger
//
//  Place this script in the Trigger On Enter Event
//  Will Automatically Jump to Another Trigger if
//  Less than 10 Meters Plus Dex Bonus
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC      = GetEnteringObject();
  object oTrigger = OBJECT_SELF;
  string sTrigger = GetTag(oTrigger);

  if(!GetIsPC(oPC)) return;

  //Closest Trigger With Same Tag
  object oJPoint1 = GetNearestObjectByTag("JumpPoint",oPC,1);
  object oJPoint2 = GetNearestObjectByTag("JumpPoint",oPC,2);
  object oRope = GetItemPossessedBy(oPC,"ClimbingRope");
  if(GetIsObjectValid(oJPoint1) && GetIsObjectValid(oJPoint2))
  {
    //Are we already Jumping?
    int nJumping = GetLocalInt(oPC,"JUMPING");
    if(nJumping == 1) return;

    location lPC = GetLocation(oPC);
    location lJPoint1 = GetLocation(oJPoint1);
    location lJPoint2 = GetLocation(oJPoint2);
    float fDist = GetDistanceBetweenLocations(lJPoint1,lJPoint2);
    int nDex = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
    float fJump = 10.0 + IntToFloat(nDex);

    SendMessageToPC(oPC,"Distance between Triggers : "+IntToString(FloatToInt(fDist))+" Meters");
    SendMessageToPC(oPC,"Possible Jump Distance : "+IntToString(FloatToInt(fJump))+" Meters");

    //Too Great of a Jump without a Climbing Rope
    if(fDist > fJump && !GetIsObjectValid(oRope))
    {
      SendMessageToPC(oPC,"This jump is too great for you without a Climbing Rope!");
      return;
    }

    //Jump to Trigger Automatically if Close
    effect eFly = EffectDisappearAppear(lJPoint2);
    effect eFlyWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);

    AssignCommand(oPC,ClearAllActions(TRUE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 0.1);
    SetCommandable(FALSE, oPC);

    //Duration MUST be 3.0 or higher. Higher for busy areas.
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFly, oPC, 4.0));
    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlyWind, lPC));
    SetLocalInt(oPC,"JUMPING",1);
    DelayCommand(8.0,SetCommandable(TRUE, oPC));
    DelayCommand(15.0,SetLocalInt(oPC,"JUMPING",0));

    //Jump all the Extra Creatures
    JumpAssociates(oPC);
  }
  else
  {
    SendMessageToPC(oPC,"You can jump accross here with a Climbing Rope.");
  }
}
