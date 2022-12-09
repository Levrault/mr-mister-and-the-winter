shader_type canvas_item;

uniform vec2 target = vec2(0.5);
uniform vec2 offset = vec2(-0.01, -0.05);
uniform float circle_size: hint_range(0f, 1f);
uniform float ring_size: hint_range(0f, 0.1f);
uniform vec4 ring_color: hint_color;

void fragment() {

	// keep current texture
	COLOR = texture(TEXTURE, UV);
	
	// Convert to match aspect ratio
	vec2 resolution = 1f / SCREEN_PIXEL_SIZE;
	vec2 current_pixel = SCREEN_UV * resolution;
	vec2 offset_target = target + offset;
	vec2 target_pixel = vec2(offset_target.x, 1f - offset_target.y) * resolution;
	float dist = distance(current_pixel, target_pixel);
	float radius = circle_size * length(resolution);
	float radius_ring = (ring_size + circle_size) * length(resolution);
	
	COLOR.a = clamp(1f + dist - radius_ring, 0f, 1f);
}