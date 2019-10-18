object oItem;

void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

if (GetItemPossessedBy(oPC, "rank3")!= OBJECT_INVALID)
   {
   oPC = GetItemActivatedTarget();

//   oItem = GetItemPossessedBy(oPC, "rank2");

//   if (GetIsObjectValid(oItem))
//      DestroyObject(oItem);

//   CreateItemOnObject("rank3", oPC);

   }
else if (GetItemPossessedBy(oPC, "rank2")!= OBJECT_INVALID)
   {
   oPC = GetItemActivatedTarget();
   CreateItemOnObject("rank2", oPC);

   oItem = GetItemPossessedBy(oPC, "rank1");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   }
else if (GetItemPossessedBy(oPC, "rank1")!= OBJECT_INVALID)
   {

   oPC = GetItemActivatedTarget();
   CreateItemOnObject("rank2", oPC);

   oItem = GetItemPossessedBy(oPC, "rank1");

   if (GetIsObjectValid(oItem))
      DestroyObject(oItem);

   }
else
   {
   oPC = GetItemActivatedTarget();
   CreateItemOnObject("rank1", oPC);

   }

}
