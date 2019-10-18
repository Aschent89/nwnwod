/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Remove the bag if empty.
void main()
{
    if(GetIsObjectValid(GetFirstItemInInventory(OBJECT_SELF))==FALSE)
       DestroyObject(OBJECT_SELF);
}

