void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_FANGS")!= OBJECT_INVALID)
   {
//   if (GetItemPossessedBy(oPC, "FALLEN_VAMPIRE_COFFIN")== OBJECT_INVALID)
//      {
//      CreateItemOnObject("yourcoffin2", oPC);

//      }
   if (GetItemPossessedBy(oPC, "hlslang_12")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_12", oPC);

      }
   }
else if (GetItemPossessedBy(oPC, "vamp_anim_1")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_8")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_8", oPC);

      }
   }
else if (GetItemPossessedBy(oPC, "gar_litanydark")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_11")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_11", oPC);

      }
   }
else if (GetItemPossessedBy(oPC, "gar_litany")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_11")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_11", oPC);

      }
   }
else if (GetItemPossessedBy(oPC, "gar_thrlvl1")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_10")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_10", oPC);

      }
    }
else if (GetItemPossessedBy(oPC, "garou_lupis_1")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_8")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_8", oPC);

      }
    }
else if (GetItemPossessedBy(oPC, "mage_pouch")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_7")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_7", oPC);

      }
   }
else if (GetItemPossessedBy(oPC, "mage_pouch")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "mage_vis")== OBJECT_INVALID)
      {
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      CreateItemOnObject("mage_vis", oPC);
      }
   }
else if (GetItemPossessedBy(oPC, "mage_pouch")!= OBJECT_INVALID)
   {
//   if (GetSubRace(oPC, "Mage")== OBJECT_INVALID)
  //    {

//SetSubRace(oPC, "Human");
  //    }
   }
else if (GetItemPossessedBy(oPC, "mage_spir_2")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "hlslang_10")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_10", oPC);

      }
    }
else if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0))
   {
   if (GetItemPossessedBy(oPC, "hlslang_8")== OBJECT_INVALID)
      {
      CreateItemOnObject("hlslang_8", oPC);
      }
    }

}
