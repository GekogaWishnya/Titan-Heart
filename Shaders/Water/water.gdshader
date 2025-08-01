shader_type spatial;
render_mode cull_back, shadows_disabled, world_vertex_coords, unshaded;

uniform sampler2D sky;
uniform float sky_factor : hint_range(0.0, 10.0, 0.05) = 1.0;
uniform vec4 water_color : source_color = vec4(0.467, 0.812, 0.949, 1.0);
uniform float tone_factor : hint_range(0.0, 10.0, 0.01) = 1.0;

float expStep(float x, float n)
{
    return exp2(-exp2(n)*pow(x,n));
}

void fragment() {
	vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 camera_dir = normalize(world_pos - CAMERA_POSITION_WORLD);
	float camera_y_half_angle = asin(camera_dir.y) / PI;
	vec2 sphere_uv = vec2(
		atan(camera_dir.x, -camera_dir.z) / (2.0 * PI),
		(0.5 + camera_y_half_angle) * 2.0
	);
	
	float water_factor = 1.0 - expStep(-camera_y_half_angle * 2.0, tone_factor);
	vec3 color = (textureLod(sky, sphere_uv, 0.0).rgb * sky_factor + water_color.rgb * water_factor);
	ALBEDO = color / max(max(color.r, color.g), color.b);
}
