shader_type spatial;
render_mode cull_back, unshaded, shadows_disabled;

uniform sampler2D reflection : hint_default_transparent;

void fragment() {
	vec4 texel = texture(reflection, UV);
	
	if (texel.a < 0.20) {
		discard;
	}
	
	ALBEDO = texel.rgb;
}
