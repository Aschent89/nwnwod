void main()
{
object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("ssss");

DestroyObject(oTarget, 0.0);

    // Destroy old animalism give new
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_anim_1")))
       {
         oTarget = GetObjectByTag("vamp_anim_1");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_anim_1",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_anim_2")))
       {
         oTarget = GetObjectByTag("vamp_anim_2");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_anim_2",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_anim_3")))
       {
         oTarget = GetObjectByTag("vamp_anim_3");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_anim_3",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_anim_4")))
       {
         oTarget = GetObjectByTag("vamp_anim_4");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_anim_4",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_anim_5")))
       {
         oTarget = GetObjectByTag("vamp_anim_5");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_anim_5",GetEnteringObject());

        }
    // Destroy old Auspex give new
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_ausp_1")))
       {
         oTarget = GetObjectByTag("vamp_ausp_1");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_ausp_1",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_ausp_2")))
       {
         oTarget = GetObjectByTag("vamp_ausp_2");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_ausp_2",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_ausp_3")))
       {
         oTarget = GetObjectByTag("vamp_ausp_3");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_ausp_3",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_ausp_4")))
       {
         oTarget = GetObjectByTag("vamp_ausp_4");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_ausp_4",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_ausp_5")))
       {
         oTarget = GetObjectByTag("vamp_ausp_5");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_ausp_5",GetEnteringObject());

        }
    // Destroy old Celerity give new
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_cele_1")))
       {
         oTarget = GetObjectByTag("vamp_cele_1");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_cele_1",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_cele_2")))
       {
         oTarget = GetObjectByTag("vamp_cele_2");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_cele_2",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_cele_3")))
       {
         oTarget = GetObjectByTag("vamp_cele_3");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_cele_3",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_cele_4")))
       {
         oTarget = GetObjectByTag("vamp_cele_4");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_cele_4",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_cele_5")))
       {
         oTarget = GetObjectByTag("vamp_cele_5");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_cele_5",GetEnteringObject());

        }
    // Destroy old Dominate give new
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_dom_1")))
       {
         oTarget = GetObjectByTag("vamp_dom_1");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_domi_1",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_dom_2")))
       {
         oTarget = GetObjectByTag("vamp_dom_2");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_domi_2",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_dom_3")))
       {
         oTarget = GetObjectByTag("vamp_dom_3");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_domi_3",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_dom_4")))
       {
         oTarget = GetObjectByTag("vamp_dom_4");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_domi_4",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_dom_5")))
       {
         oTarget = GetObjectByTag("vamp_dom_5");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_domi_5",GetEnteringObject());

        }
    // Destroy old Obfuscate give new
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_obfu_1")))
       {
         oTarget = GetObjectByTag("vamp_obfu_1");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_obfu_1",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_obfu_2")))
       {
         oTarget = GetObjectByTag("vamp_obfu_2");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_obfu_2",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_obfu_3")))
       {
         oTarget = GetObjectByTag("vamp_obfu_3");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_obfu_3",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_obfu_4")))
       {
         oTarget = GetObjectByTag("vamp_obfu_4");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_obfu_4",GetEnteringObject());

        }
     if(GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"vamp_obfu_5")))
       {
         oTarget = GetObjectByTag("vamp_obfu_5");

        DestroyObject(oTarget, 0.0);

       CreateItemOnObject("vamp_g_obfu_5",GetEnteringObject());

        }

}
