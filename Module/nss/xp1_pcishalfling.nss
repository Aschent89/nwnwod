// check if the PC is Halfling
int StartingConditional()
{
    int iResult;

    iResult = GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFLING;
    return iResult;
}
