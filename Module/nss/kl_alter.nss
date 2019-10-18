void main()
{
       object oPC = GetLastAttacker();
       if (GetLocalInt(oPC,"KL_ALTAR") != 0)
    {
       return;
    }

       FloatingTextStringOnCreature("A hundred souls cry out in freedom....", oPC);
       AdjustAlignment( oPC, ALIGNMENT_GOOD, 5 );
       SetLocalInt(oPC,"KL_ALTAR",1);
}

