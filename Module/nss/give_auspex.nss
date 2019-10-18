void main()
{

object oPC = GetPCSpeaker();
int nNumItems = 0;
object oItem = GetFirstItemInInventory(oPC);
string sItem = "vamppoint";
while (GetIsObjectValid(oItem) == TRUE)

//if (GetItemPossessedBy(oPC, "vamppoint")!= OBJECT_INVALID)
//     {

          if (GetTag(oItem) == sItem)
          {
          nNumItems = nNumItems + GetNumStackedItems(oItem);
           }
          oItem = GetNextItemInInventory(oPC);
           }
          oItem = GetItemPossessedBy(oPC, "vamppoint");
         int iPower = GetItemStackSize (oItem);
         if (iPower <= 5)
          {
           if (GetIsObjectValid(oItem))
            DestroyObject(oItem);
                 if (GetIsObjectValid(oItem))
             DestroyObject(oItem);
                 if (GetIsObjectValid(oItem))
         DestroyObject(oItem);
                 if (GetIsObjectValid(oItem))
         DestroyObject(oItem);
                          if (GetIsObjectValid(oItem))
         DestroyObject(oItem);
         CreateItemOnObject("vamp_ausp_5", oPC);
       }
   //   if (nNumItems >= 4)
    //  {
//       oItem = GetItemPossessedBy (oPC,"vampirepoint");
   //   SendMessageToPC(oPC, "You do not have the knowledge to learn this skill.");


   //   }



   }


