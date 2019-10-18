object oDeny;

void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "mage_matt_5")== OBJECT_INVALID)
   {
   oDeny = GetWaypointByTag("wp_enchant");

   AssignCommand(oPC, JumpToObject(oDeny));

   return;
   }

}
