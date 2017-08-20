Texture2D<float4> StereoParams : register(t125);
Texture1D<float4> IniParams : register(t120);

Texture2D<float4> cursor_mask : register(t100);
Texture2D<float4> cursor_color : register(t101);

void main(
		out float4 pos : SV_Position0,
		out float2 texcoord : TEXCOORD0,
		uint vertex : SV_VertexID)
{
	uint mask_width, mask_height;
	uint color_width, color_height;
	float2 resolution;
	float2 cursor_size;
	float2 mouse_pos;

	// For easy bailing:
	pos = 0;

	// Cursor hidden?
	if (!IniParams[7].y)
		return;

	cursor_color.GetDimensions(color_width, color_height);
	cursor_mask.GetDimensions(mask_width, mask_height);

	if (color_width) {
		// Colour cursor, bail if we are in the black and white / inverted cursor pass:
		if (IniParams[7].z == 2)
			return;
		cursor_size = float2(color_width, color_height);
	} else {
		// Black and white / inverted cursor, bail if we are in the colour cursor pass:
		if (IniParams[7].z == 1)
			return;
		cursor_size = float2(mask_width, mask_height / 2);
	}

	// Cursor position - hotspot position:
	pos.xy = mouse_pos.xy = IniParams[6].xy - IniParams[6].zw;

	// Not using vertex buffers so manufacture our own coordinates.
	switch(vertex) {
		case 0:
			texcoord = float2(0, cursor_size.y);
			break;
		case 1:
			texcoord = float2(0, 0);
			pos.y += cursor_size.y;
			break;
		case 2:
			texcoord = float2(cursor_size.x, cursor_size.y);
			pos.x += cursor_size.x;
			break;
		case 3:
			texcoord = float2(cursor_size.x, 0);
			pos.xy += cursor_size;
			break;
		default:
			pos.xy = 0;
			break;
	};

	// Scale from pixels to clip space:
	resolution = StereoParams.Load(int3(2, 0, 0)).xy;
	pos.xy = (pos.xy / resolution * 2 - 1) * float2(1, -1);
	pos.zw = float2(0, 1);

	// Adjust stereo depth of pos here using whatever means you feel is
	// suitable for this game, e.g. with a suitable crosshair.hlsl you
	// could automatically adjust it from the depth buffer:
	//mouse_pos.xy = (mouse_pos.xy / resolution * 2 - 1);
	//pos.x += adjust_from_depth_buffer(mouse_pos.x, mouse_pos.y);
}