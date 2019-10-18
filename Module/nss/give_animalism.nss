object oItem;

void main()
{

object oPC = GetPCSpeaker();
 //Max out of this level can go no farther
if (GetItemPossessedBy(oPC, "vamp_anim_5")!= OBJECT_INVALID)
   {
   SendMessageToPC(oPC, "far enough");

   }
   //Processing for level 5
else if (GetItemPossessedBy(oPC, "vamp_anim_4")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
      {
      oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

      if (GetIsObjectValid(oItem))
         DestroyObject(oItem);

      if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
         {
         oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

         if (GetIsObjectValid(oItem))
            DestroyObject(oItem);

         if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
            {
            oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

            if (GetIsObjectValid(oItem))
               DestroyObject(oItem);

            if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
               {
               oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

               if (GetIsObjectValid(oItem))
                  DestroyObject(oItem);

               if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
                  {
                  oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

                  if (GetIsObjectValid(oItem))
                     DestroyObject(oItem);

                  CreateItemOnObject("vamp_anim_5", oPC);

                  }
               else
                  {
                  SendMessageToPC(oPC, "stop");

                  }

               }
            else
               {
               SendMessageToPC(oPC, "stop");

               }

            }
         else
            {
            SendMessageToPC(oPC, "stop");

            }

         }
      else
         {
         SendMessageToPC(oPC, "stop");

         }

      }
//   else
  //    {
  //    SendMessageToPC(oPC, "stop");

  //    }

   //Processing for level 4
else if (GetItemPossessedBy(oPC, "vamp_anim_3")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
      {
      oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

      if (GetIsObjectValid(oItem))
         DestroyObject(oItem);

      if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
         {
         oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

         if (GetIsObjectValid(oItem))
            DestroyObject(oItem);

         if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
            {
            oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

            if (GetIsObjectValid(oItem))
               DestroyObject(oItem);

            if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
               {
               oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

               if (GetIsObjectValid(oItem))
                  DestroyObject(oItem);

                  CreateItemOnObject("vamp_anim_4", oPC);

               }
            else
               {
               SendMessageToPC(oPC, "stop");

               }

            }
         else
            {
            SendMessageToPC(oPC, "stop");

            }

         }
      else
         {
         SendMessageToPC(oPC, "stop");

         }

      }
//   else
//      {
//      SendMessageToPC(oPC, "stop");

//      }

   //Processing for level 3
else if (GetItemPossessedBy(oPC, "vamp_anim_2")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
      {
      oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

      if (GetIsObjectValid(oItem))
         DestroyObject(oItem);

      if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
         {
         oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

         if (GetIsObjectValid(oItem))
            DestroyObject(oItem);

         if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
            {
            oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

            if (GetIsObjectValid(oItem))
               DestroyObject(oItem);

                  CreateItemOnObject("vamp_anim_3", oPC);

            }
         else
            {
            SendMessageToPC(oPC, "stop");

            }

         }
      else
         {
         SendMessageToPC(oPC, "stop");

         }

      }
//   else
//      {
//      SendMessageToPC(oPC, "stop");

//      }

   //Processing for level 2
else if (GetItemPossessedBy(oPC, "vamp_anim_1")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
      {
      oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

      if (GetIsObjectValid(oItem))
         DestroyObject(oItem);

      if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
         {
         oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

         if (GetIsObjectValid(oItem))
            DestroyObject(oItem);

                  CreateItemOnObject("vamp_anim_2", oPC);

         }
      else
         {
         SendMessageToPC(oPC, "stop");

         }

      }
//   else
//      {
//      SendMessageToPC(oPC, "stop");

//      }
      //Process for learning level 1 from clan mentor
else
   {
   if (GetItemPossessedBy(oPC, "vamp_bloodpoint")!= OBJECT_INVALID)
      {
      oItem = GetItemPossessedBy(oPC, "vamp_bloodpoint");

      if (GetIsObjectValid(oItem))
         DestroyObject(oItem);
                  CreateItemOnObject("vamp_anim_2", oPC);
      }
   else
      {
      SendMessageToPC(oPC, "stop");

      }
   }
 }
}
}
}
}
