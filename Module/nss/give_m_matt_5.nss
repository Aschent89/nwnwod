void main()
{

object oPC = GetPCSpeaker();
 object oItem;
 int nCheck;
 string sResRef;



//object oItem;
oItem = GetItemPossessedBy(oPC, "magepoint");
int iQpoint = GetItemStackSize (oItem);
if (iQpoint == 10)
{
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
}
if (iQpoint > 10)
{
SetItemStackSize (oItem, iQpoint-10);
}
CreateItemOnObject("mage_matt_5", oPC);
SendMessageToPC(oPC, "You have just furthered your magical knowledge");

}
