shader_type spatial;

uniform vec3 impact_pos;      // The global position where the hit happened
uniform float impact_radius = 1.0; 
uniform float impact_strength = 0.5; // How deep the dent goes

void vertex() {
    // 1. Get the world position of this vertex
    vec3 world_vertex = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    
    // 2. Calculate distance from the impact point
    float dist = distance(world_vertex, impact_pos);
    
    // 3. Create a mask: 1.0 at the center, 0.0 at the edge of the radius
    float mask = smoothstep(impact_radius, 0.0, dist);
    
    // 4. Move vertex downward based on the mask
    // We modify VERTEX in local space
    VERTEX.y -= mask * impact_strength;
}
