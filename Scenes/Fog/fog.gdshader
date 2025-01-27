shader_type canvas_item;

//noise 
uniform sampler2D noise_texture: repeat_enable,filter_nearest;
//fog density 
uniform float density: hint_range(0.0, 2.0) = 0.75;
//fog speed
uniform vec2 speed = vec2(0.02,0.01);

void fragment() {
	//moving fog
	vec2 uv = UV + speed * TIME;
	//sample noise texture
	float noise = texture(noise_texture,uv).r;
	//clamping the fog to 0.0 - 1.0
	float fog = clamp(noise * 2.0 - 1.0, 0.0 ,1.0);
	//applying effect 
	COLOR.a *= fog * density;
}

