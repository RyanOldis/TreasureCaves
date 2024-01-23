using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveSteelBox : ActiveObject
{
    protected override void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            //BreakThis();
            return;
        }
        base.OnCollisionEnter2D(collision);
        //Debug.Log("Steel box");
    }
}
