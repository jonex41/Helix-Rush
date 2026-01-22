shader_type canvas_item;
uniform float radius : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec2 center_dist = abs(UV - 0.5) - (0.5 - radius);
    if (length(max(center_dist, 0.0)) > radius) {
        discard;
    }
}
