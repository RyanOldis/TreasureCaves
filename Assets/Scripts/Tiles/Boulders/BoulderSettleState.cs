using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoulderSettleState : BoulderBaseState
{
    private float _localWaitTimer;

    public BoulderSettleState(ActiveBoulder currentContext, BoulderStateFactory stateFactory) : base(currentContext, stateFactory)
    {
        _localWaitTimer = _context.settleTime;
    }

    public override void CheckSwitchState()
    {
        if (_localWaitTimer <= 0f)
        {
            Vector3Int tilePos = _context.Map.WorldToCell(_context.transform.position);
            if (MapManager.instance.CheckForTile(tilePos + Vector3Int.down))
            {
                if (_context.Map.GetTile(tilePos + Vector3Int.down) as BoulderTile && !_context.checkNeighborTiles(tilePos))
                {
                    if (determinePushBoulder(tilePos))
                    {
                        ExitState();
                        return;
                    }
                }
                ExitState();
                _context.DeActivate();
                return;
            }/*
            else if (_context.CheckOtherObject(Vector3.down, 2.5f))
            {
                if (!_context.CheckOtherObject(Vector3.left, 0.5f))
                {
                    _context.pushDirection = -1;
                    SwitchStates(_factory.Push());
                    //Debug.Log("This boulder should push left");
                } else if (_context.CheckOtherObject(Vector3.right, 0.5f))
                {
                    _context.pushDirection = 1;
                    SwitchStates(_factory.Push());
                }
                //pushBoulder(tilePos);
                SwitchStates(_factory.Yield());
                return;
            }*/
            SwitchStates(_factory.Fall());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("boulder settling");
        _context.StateIndicator = Color.red;
        _context.hasYielded = false;
    }

    public override void ExitState()
    {
        
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();
        _context.MotionX = 0f;
        _context.MotionY = 0f;
        _localWaitTimer -= Time.deltaTime;
    }

    bool determinePushBoulder(Vector3Int tilePos)
    {
        bool leftTile = MapManager.instance.CheckForTile(tilePos + Vector3Int.down + Vector3Int.left);
        bool rightTile = MapManager.instance.CheckForTile(tilePos + Vector3Int.down + Vector3Int.right);
        bool val = false;

        if (!leftTile && !rightTile)
        {
            // move left
            _context.pushDirection = -1;
            SwitchStates(_factory.Push());
            val = true;
        }
        else if (!leftTile && rightTile)
        {
            // move left
            _context.pushDirection = -1;
            SwitchStates(_factory.Push());
            val = true;
        }
        else if (leftTile && !rightTile)
        {
            // move right
            _context.pushDirection = 1;
            SwitchStates(_factory.Push());
            val = true;
        }

        return val;
    }
}
