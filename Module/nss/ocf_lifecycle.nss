////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_lifecycle
//  by Don Anderson
//  dandersonru@msn.com
//
//  Place on the Module On Activate Item Event
//
////////////////////////////////////////////////////////////////////////////////

void CampfireLifeCycle(object oCampfire)
{
  object oScorch = GetNearestObjectByTag("WeatheringScorchMark",oCampfire);

  int nLC = GetLocalInt(oCampfire,"LIFECYCLE");
  if(nLC == 0)
  {
    DestroyObject(oCampfire);
    AssignCommand(oScorch,DestroyObject(oScorch,10.0));
    return;
  }

  if(nLC == 2) AssignCommand(oCampfire,SpeakString("The flames begin to sputter, this Campfire needs more Dry Wood"));
  if(nLC == 10) AssignCommand(oCampfire,SpeakString("The flames arise from the added Dry Wood"));

  nLC--;
  SetLocalInt(oCampfire,"LIFECYCLE",nLC);

  DelayCommand(60.0,CampfireLifeCycle(oCampfire));
}

void main()
{
  object oCampfire = OBJECT_SELF;
  CampfireLifeCycle(oCampfire);
}
