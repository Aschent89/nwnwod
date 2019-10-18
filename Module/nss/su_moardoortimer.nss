void main()
{
    int iTime = GetTimeHour();
    object oPC = GetLastUsedBy();
    //Error checking
    if(oPC == OBJECT_INVALID)
    {
        SpeakString("PC was invalid!");
        return 0;
    }
    if(iTime >=9 && iTime <= 16)
    {
    }
    else
    {
    }
}
