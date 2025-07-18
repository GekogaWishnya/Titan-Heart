shader_type spatial;
render_mode cull_back, shadows_disabled;

uniform vec4 water_color : source_color = vec4(0.467, 0.812, 0.949, 1.0);
uniform float roughness = 0.0;
uniform float specular = 1.0;
uniform float tone_distance : hint_range(1.0, 10000.0, 1) = 1000.0;
uniform float tone_factor : hint_range(0.0, 10.0, 0.01) = 1.0;

float expStep(float x, float n)
{
    return exp2(-exp2(n)*pow(x,n));
}

void fragment() {
	ROUGHNESS = roughness;
	SPECULAR = specular;

	vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float water_factor = expStep(distance(world_pos, CAMERA_POSITION_WORLD) / tone_distance, tone_factor);

	ALBEDO = water_color.rgb;
	METALLIC = water_factor;
}
