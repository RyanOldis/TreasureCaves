using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class ArrowBox
{
    //public int rotation { get; set; }

    public static void LaunchArrow(GameObject obj, int rotation, Vector2 pos)
    {
        GameObject.Instantiate(obj, pos, Quaternion.Euler(0, 0, rotation * 90));
    }
}
