void main()
{

     object oPC = GetPCLevellingUp();
  object oMod = GetModule();
//   object oPC = GetPCLevellingUp();

     if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_FANGS")!= OBJECT_INVALID)
   {

         /*object ovamppoint =*/ CreateItemOnObject("vamppoint", oPC,1);
      SendMessageToPC(oPC,"You have gained more blood to work with.");

   }

 if (GetItemPossessedBy(oPC, "mage_pouch")!= OBJECT_INVALID)
   {

        /* object omagepoint =*/ CreateItemOnObject("magepoint", oPC,1);
      SendMessageToPC(oPC,"Your magic has grown up");

   }

 if (GetItemPossessedBy(oPC, "gar_litany")!= OBJECT_INVALID)
   {

       /*  object ogarougnoisepoint = */CreateItemOnObject("garougnoisepoint", oPC,1);
      SendMessageToPC(oPC,"The spirits notice your power.");

   }

    if (GetItemPossessedBy(oPC, "gar_litanydark")!= OBJECT_INVALID)
   {

       /*  object ogarougnoisepoint = */CreateItemOnObject("garougnoisepoint", oPC,1);
      SendMessageToPC(oPC,"The spirits notice your power.");
   }

       if (GetItemPossessedBy(oPC, "hunter_faith")!= OBJECT_INVALID)
   {

      /*   object ohunterpoint = */ CreateItemOnObject("hunterspoint", oPC,1);
      SendMessageToPC(oPC,"Your faith grows stronger");
   }
       if (GetItemPossessedBy(oPC, "vamp_ghoul")!= OBJECT_INVALID)
   {

      /*   object ohunterpoint = */ CreateItemOnObject("vamppoint", oPC,1);
      SendMessageToPC(oPC,"Your bond of blood grows stronger.");
   }
 }
