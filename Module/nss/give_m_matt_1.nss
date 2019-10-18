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


/*  nCheck = GetItemStackSize(oItem);
   sResRef = GetResRef(oItem);//get resref of item
   nCheck = nCheck-1;//reduce the stack size int by one
   DestroyObject(oItem);//destroy the stack/single item
    if(nCheck > 0)//if there should be anymore in the stack left
    {
     CreateItemOnObject(sResRef, OBJECT_SELF, nCheck);
    }
 */



CreateItemOnObject("mage_matt_1", oPC);
SendMessageToPC(oPC, "You have just furthered your magical knowledge");

}
