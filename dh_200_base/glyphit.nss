void main()
{
object oGlyph = GetNearestObjectByTag("glyphofward");
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING)),oGlyph);
}
