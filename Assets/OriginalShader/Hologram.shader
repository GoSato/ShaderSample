Shader "Custom/Hologram" {
	
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Outline("Outline", Range(0, 10.0)) = 1.5
	}

	SubShader {
		Tags { "Queue"="Transparent" }
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard alpha:fade
		#pragma target 3.0

		struct Input {
			float3 worldNormal;
			float3 viewDir;
		};

		fixed4 _Color;
		float _Outline;

		void surf (Input IN, inout SurfaceOutputStandard o) {
		
			o.Albedo = _Color.rgb;
			float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
			o.Alpha = alpha * _Outline;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
