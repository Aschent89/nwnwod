int StartingConditional()
{
	int nShow = OBJECT_INVALID != GetItemPossessedBy(GetPCSpeaker(), "ChickenHead");
	return nShow;
}
