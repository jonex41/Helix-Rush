shader_type canvas_item;

void fragment() {
	vec2 uv = UV - vec2(0.5);
	float dist = length(uv);

	if (dist > 0.5) {
		discard;
	}

	// Light blue color
	vec3 light_blue = vec3(0.4, 0.75, 1.0);

	COLOR = vec4(light_blue, 1.0);
}
