using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderController : MonoBehaviour {

    [SerializeField]
    private Color _baseColor;

	void Start ()
    {
        GetComponent<Renderer>().material.SetColor("_BaseColor", _baseColor);	
	}
	
}
