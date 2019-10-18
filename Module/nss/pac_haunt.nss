float DISTANCE_TO_HAUNT = 5.0; // in meters

void ToggleLight(int iState = OBJECT_TYPE_INVALID, object oObject = OBJECT_SELF)
{

        switch (iState)
        {
            case 1 : // HAUNT_ON
                AssignCommand(oObject, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
                DelayCommand(0.4,SetPlaceableIllumination(oObject, TRUE));
                SetLocalInt(oObject,"NW_L_AMION",1);
                DelayCommand(0.5,RecomputeStaticLighting(GetArea(oObject)));
                break;
            case -1 : //HAUNT_OFF
                AssignCommand(oObject, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                DelayCommand(0.4,SetPlaceableIllumination(oObject, FALSE));;
                SetLocalInt(oObject,"NW_L_AMION",0);
                DelayCommand(0.9,RecomputeStaticLighting(GetArea(oObject)));
                break;
            default :
                // Execute "nw_02_onoff" as the toggle
                // Calls RecomputeStaticLighting each time, so no...
                ExecuteScript("nw_02_onoff", oObject);
                break;
        }
}

void main()
{

    if (!GetLocalInt(OBJECT_SELF,"haunt_once"))
    {
      SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
      ToggleLight();
      SetLocalInt(OBJECT_SELF,"haunt_once",1);
    }

   int iHaunt = FALSE;

   object oPC = GetFirstPC();
   while (GetIsObjectValid(oPC) == TRUE)
   {
      float fNewDist = GetDistanceToObject(oPC);
      if (fNewDist>-1.0 && fNewDist<=DISTANCE_TO_HAUNT)
        iHaunt=1;
      oPC = GetNextPC();
   }

    if (iHaunt != GetLocalInt(OBJECT_SELF,"haunting") || GetLocalInt(OBJECT_SELF,"haunting")!=GetLocalInt(OBJECT_SELF,"NW_L_AMION") )
    {
        SetLocalInt(OBJECT_SELF,"NW_L_AMION",!iHaunt);

        ToggleLight();
        SetLocalInt(OBJECT_SELF,"haunting",iHaunt);
    }

}

