/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Tell us who's bag it is.
void main()
{
    string sOwner = GetLocalString(OBJECT_SELF,"Name");
    string sFeedback = sOwner+"'s belongings";
    SpeakString(sFeedback);
}
