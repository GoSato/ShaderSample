Shader "Custom/CircleDraw" {

	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Radius("Radius", Range(1, 1000)) = 10.0
		_Speed("Speed", Range(1, 200)) = 100.0
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float3 worldPos;
		};

		fixed4 _Color;
		float _Radius;
		float _Speed;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float dist = distance(fixed3(0, 0, 0), IN.worldPos);
			float val = abs(sin(dist * _Radius + _Time * _Speed));
			if (val > 0.98)
			{
				o.Albedo = fixed4(1, 1, 1, 1);
			}
			else
			{
				o.Albedo = _Color;
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}
