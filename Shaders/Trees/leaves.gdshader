shader_type spatial;
render_mode cull_back, world_vertex_coords, unshaded;

group_uniforms Basic;
uniform float roughness = 1.0;
uniform float distance_fade_min : hint_range(0.0, 4096.0, 0.01);
uniform float distance_fade_max : hint_range(0.0, 4096.0, 0.01);

group_uniforms Leaves;
uniform sampler2D alpha_mask : filter_nearest, hint_default_white;
uniform vec4 leave_color : source_color = vec4(0.331, 0.547, 0.383, 1.0);
uniform vec4 under_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float normal_offset = 0.0;
uniform float normal_softness = 0.0;
uniform vec4 ss_tint : source_color = vec4(0.386, 0.865, 0.353, 1.0);
uniform float ss_radius = 0.0;
uniform float ss_power = 0.0;

group_uniforms Wind;
uniform sampler2D noise;
uniform float aabb_size;
uniform vec3 wind_direction = vec3(0.0, 0.0, -1.0);
uniform float wind_speed = 1.0;
uniform float wind_power = 1.0;

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void vertex() {
	float wind = texture(noise, (VERTEX.xz + TIME * wind_speed) / aabb_size).r;
	VERTEX += wind * wind_direction * wind_power * (1.0 - UV.y);
}

void fragment() {
	if (texture(alpha_mask, UV).r < 0.99) {
		discard;
	}
	
	float fade_distance = length(VERTEX);
	const vec3 magic = vec3(0.06711056, 0.00583715, 52.9829189);
	float fade = clamp(smoothstep(distance_fade_min, distance_fade_max, fade_distance), 0.0, 1.0);
	if (fade < 0.001 || fade < fract(magic.z * fract(dot(FRAGCOORD.xy, magic.xy)))) {
		discard;
	}
	
	ROUGHNESS = roughness;
	
	vec3 world_space_normals = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
	float vertical_normal = (world_space_normals.y + normal_offset) * 0.5;
	float mix_factor = 1.0 - clamp(pow(vertical_normal, normal_softness), 0.0, 1.0);
	ALBEDO = mix(leave_color, under_color, mix_factor).rgb;
	
	float ss_base = clamp(fresnel(ss_radius, NORMAL, VIEW), 0.0, 1.0);
	vec3 ss_color = ss_base * ss_tint.rgb * ss_power;
	EMISSION = ss_color;
	
	NORMAL = vec3(0.0, 1.0, 0.0);
}
