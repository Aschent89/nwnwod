////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_putoutfire
//  by Don Anderson
//  dandersonru@msn.com
//
//  Puts Out Campfire (PC Speaker is the OBJECT_SELF here!!)
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oCF = GetNearestObjectByTag("Campfire",oPC,1);
  object oSM = GetNearestObjectByTag("WeatheringScorchMark",oPC,1);

  if(GetDistanceToObject(oCF) > 6.0) return;

  //Destroy the Campfire
  DestroyObject(oCF);

  //Now Destroy the Scorch Mark
  DestroyObject(oSM,2.0);

  DelayCommand(2.5,RecomputeStaticLighting(GetArea(oPC)));
}
