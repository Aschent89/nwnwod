void main()
{

object oPC = GetPCSpeaker();
 object oItem;
 int nCheck;
 string sResRef;



//object oItem;
oItem = GetItemPossessedBy(oPC, "magepoint");
int iQpoint = GetItemStackSize (oItem);
if (iQpoint == 4)
{
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
}
if (iQpoint > 4)
{
SetItemStackSize (oItem, iQpoint-4);
}

CreateItemOnObject("mage_entr_3", oPC);
SendMessageToPC(oPC, "You have just furthered your magical knowledge");

}
