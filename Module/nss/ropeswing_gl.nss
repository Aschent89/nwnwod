// Swing swing from the tangles of..

void delayFade(object oPC, float fSpeed)
{
    DelayCommand(1.5f, FadeFromBlack(oPC, fSpeed));
}

void main()
{
    //fade to black
    object oPC = GetLastUsedBy();
    float fSpeed = FADE_SPEED_FASTEST;
    FadeToBlack(oPC, fSpeed);


    //six different screaming sounds to play
    switch(Random(6))
    {
        case 0:   PlaySound("as_pl_screamm1"); break;
        case 1:   PlaySound("as_pl_screamm2"); break;
        case 2:   PlaySound("as_pl_screamm3"); break;
        case 3:   PlaySound("as_pl_screamm4"); break;
        case 4:   PlaySound("as_pl_screamm5"); break;
        case 5:   PlaySound("as_pl_screamm6"); break;
    }

    //play wind sound
    PlaySound("as_wt_gustchasm1");

    //move player to waypoint on other side of chasm
    AssignCommand(GetLastUsedBy(),ActionJumpToLocation(GetLocation(GetObjectByTag("ROPE_LAND"))));

    //fade from black
    delayFade(oPC, fSpeed);
}
