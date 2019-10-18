void main()
{
    object oPC = GetLastUsedBy();
    DelayCommand(120.0, ActionCloseDoor(OBJECT_SELF));
int iStealth = GetStealthMode(oPC);
  if (iStealth == STEALTH_MODE_ACTIVATED)
    {
    SetActionMode(oPC,ACTION_MODE_STEALTH, FALSE) ;
    }

}
