shader_type spatial;
render_mode cull_disabled, world_vertex_coords;

uniform sampler2D alpha : filter_nearest, hint_default_white;
uniform vec4 grass_base_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);
uniform vec4 grass_tip_color : source_color = vec4(0.409, 0.906, 0.373, 1.0);
uniform float render_distance = 0.0;

group_uniforms Wind;
uniform sampler2D noise;
uniform float aabb_size;
uniform vec3 wind_direction = vec3(0.0, 0.0, -1.0);
uniform float wind_speed = 1.0;
uniform float wind_power = 1.0;

void vertex() {
	float wind = texture(noise, (VERTEX.xz + TIME * wind_speed) / aabb_size).r;
	VERTEX += wind * wind_direction * wind_power * (1.0 - UV.y);
}

void fragment() {
	if (texture(alpha, UV).r < 0.99) {
		discard;
	}
	
	ALBEDO = mix(grass_tip_color.rgb, grass_base_color.rgb, UV.y);
	NORMAL = vec3(0.0, 1.0, 0.0);
}
