shader_type spatial;
render_mode cull_back, shadows_disabled, unshaded;

uniform vec4 albedo : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	ALBEDO = albedo.rgb;
}
