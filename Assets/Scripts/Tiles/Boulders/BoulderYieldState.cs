using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoulderYieldState : BoulderBaseState
{
    float waitDistance;
    public BoulderYieldState(ActiveBoulder currentContext, BoulderStateFactory stateFactory) : base(currentContext, stateFactory)
    {
        
    }

    public override void CheckSwitchState()
    {
        //if (localTimer > 0f)
        //Debug.Log(_context.SideBoulder.transform.position.y - _context.transform.position.y);
        if (_context.OtherBoulder)
        {
            if (_context.transform.position.y - _context.OtherBoulder?.transform.position.y < waitDistance)
                return;
        }
        /*
        Vector3Int tileCheck = _context._map.WorldToCell(_context.transform.position) + Vector3Int.right * _context.pushDirection;
        switch (_context.pushDirection)
        {
            case -1:
                if (_context.checkOtherBoulder(Vector3.left, 1f))
                {
                    return;
                }
                break;
            case 0:
                if (_context.checkOtherBoulder(Vector3.down, 1f))
                {
                    return;
                }
                break;
            case 1:
                if (_context.checkOtherBoulder(Vector3.right, 1f))
                {
                    return;
                }
                break;
            default:
                break;
        }
        */
        //RewindState();
        if (_context.pushDirection != 0)
        {
            SwitchStates(_factory.Push());
        } else {
            SwitchStates(_factory.Fall());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("Now Yielding. yielding time: " + Time.unscaledTime);
        _context.StateIndicator = Color.yellow;
        waitDistance = _context.yieldDistance;
        //_context.ThisCollider.enabled = false;
    }

    public override void ExitState()
    {
        //Debug.Log("Resuming time: " + Time.unscaledTime);
        //_context.ThisCollider.enabled = true;
        _context.OtherBoulder = null;
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();

        _context.MotionX = 0f;
        _context.MotionY = 0f;
    }

    public override void SetYieldDistance(float f)
    {
        waitDistance = f;
    }
}
