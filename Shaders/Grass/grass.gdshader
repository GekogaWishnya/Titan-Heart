shader_type spatial;
render_mode cull_disabled, unshaded;

uniform sampler2D alpha;
uniform vec4 grass_base_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);
uniform vec4 grass_tip_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);

void fragment() {
	ALPHA = texture(alpha, UV).r;
	ALBEDO = mix(grass_tip_color.rgb, grass_base_color.rgb, UV.y);
}
