

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

if (GetStringLowerCase(GetSubRace(oPC))=="mage")
   {
   if (GetItemPossessedBy(oPC, "mage_vis")== OBJECT_INVALID)
      {
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      }
   }
}
