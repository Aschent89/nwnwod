void main()
{

object oPC = GetPCSpeaker();
 object oItem;
 int nCheck;
 string sResRef;



//object oItem;
oItem = GetItemPossessedBy(oPC, "magepoint");
int iQpoint = GetItemStackSize (oItem);
if (iQpoint == 6)
{
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
}
if (iQpoint > 6)
{
SetItemStackSize (oItem, iQpoint-6);
}
CreateItemOnObject("mage_mind_4", oPC);
SendMessageToPC(oPC, "You have just furthered your magical knowledge");

}
