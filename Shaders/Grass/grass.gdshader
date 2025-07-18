shader_type spatial;
render_mode cull_disabled, unshaded, world_vertex_coords;

uniform sampler2D alpha;
uniform vec4 grass_base_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);
uniform vec4 grass_tip_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);

group_uniforms Wind;
uniform sampler2D noise;
uniform float noise_texture_size;
uniform vec3 wind_direction = vec3(0.0, 0.0, -1.0);
uniform float wind_speed = 1.0;
uniform float wind_power = 1.0;

void vertex() {
	float wind = texture(noise, (VERTEX.xz + TIME * wind_speed) / noise_texture_size).r;
	VERTEX += wind * wind_direction * wind_power * (1.0 - UV.y);
}

void fragment() {
	ALPHA = texture(alpha, UV).r;
	ALBEDO = mix(grass_tip_color.rgb, grass_base_color.rgb, UV.y);
}
