////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_rest_exit
//  by Don Anderson
//  dandersonru@msn.com
//
//  This is to allow resting in specific areas
//  Script By : Deva Bryson Winblood
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
   object oPC=GetExitingObject();

   if (GetIsPC(oPC)==TRUE)
   {
     SetLocalInt(oPC,"REST_ALLOWED",FALSE);
     SetLocalInt(oPC, "TENT", FALSE);
   }
}
