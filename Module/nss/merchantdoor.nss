//Put this script OnOpen
//This script locks merchant doors between the hours of 18 and 8.
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt = GetTimeHour();

if (nInt <= 23 || nInt >= 7)
   {
   SetLocked(OBJECT_SELF, TRUE);

   ActionCloseDoor(OBJECT_SELF);

   FloatingTextStringOnCreature("The merchant is closed.  Come back during business hours.", oPC);

   }
DelayCommand(10.0, ActionCloseDoor(OBJECT_SELF));
}
