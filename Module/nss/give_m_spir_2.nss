void main()
{

object oPC = GetPCSpeaker();
 object oItem;
 int nCheck;
 string sResRef;



//object oItem;
oItem = GetItemPossessedBy(oPC, "magepoint");
int iQpoint = GetItemStackSize (oItem);
if (iQpoint == 2)
{
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
}
if (iQpoint > 2)
{
SetItemStackSize (oItem, iQpoint-2);
}

CreateItemOnObject("mage_spir_2", oPC);
CreateItemOnObject("hlslang_10", oPC);
SendMessageToPC(oPC, "You have just furthered your magical knowledge");

}
