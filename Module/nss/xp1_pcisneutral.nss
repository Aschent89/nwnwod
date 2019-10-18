// the PC is Neutral
int StartingConditional()
{
    int iResult = GetAlignmentGoodEvil(GetPCSpeaker());
    if (iResult == ALIGNMENT_NEUTRAL) return TRUE;
    else return FALSE;
}
