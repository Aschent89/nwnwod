void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

if (GetItemPossessedBy(oPC, "mage_pouch")!= OBJECT_INVALID)
   {
   SetSubRace(oPC, "Mage");

}
}
