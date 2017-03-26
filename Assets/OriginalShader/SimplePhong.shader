Shader "Custom/SimplePhong" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Spec("Specular", Range(2.0, 30.0)) = 10.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf SimplePhong

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		float _Spec;

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color;
		}

		half4 LightingSimplePhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half NdotL = max(0, dot(s.Normal, lightDir));
			float3 R = normalize(- lightDir + 2.0 * s.Normal * NdotL);
			float3 spec = pow(max(0, dot(R, viewDir)), _Spec);

			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * NdotL + NdotL + spec + fixed4(0.1f, 0.1f, 0.1f, 1);
			c.a = s.Alpha;
			return c;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
