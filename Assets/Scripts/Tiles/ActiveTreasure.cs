using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveTreasure : ActiveObject
{
    protected override void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            Debug.Log("collected an active treasure");
            BreakThis();
            return;
        }
        base.OnCollisionEnter2D(collision);
    }
}
