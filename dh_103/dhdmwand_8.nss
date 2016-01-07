void main()
{
SendMessageToPC(GetPCSpeaker(), "The spawner has been deleted.");
DestroyObject(GetObjectByTag("dm_spawner_sira"));
DestroyObject(GetObjectByTag("dmwp_spawner_sira"));
}
