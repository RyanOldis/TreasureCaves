using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerIdleLadderState : PlayerBaseState
{
    public PlayerIdleLadderState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = false;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        if (_context.MovePerformed)
        {
            SwitchState(_factory.Climb());
        }
    }

    public override void EnterState()
    {
        _context.MotionX = 0f;
        _context.MotionY = 0f;
    }

    public override void ExitState()
    {
        
    }

    public override void InitializeSubstate()
    {
        
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        
    }

    public override void OnCollisionExit(Collision2D collision)
    {
        
    }

    public override void OnTriggerEnter(Collider2D collision)
    {
        
    }

    public override void OnTriggerExit(Collider2D collision)
    {
        
    }

    public override void UpdateState()
    {
        _context.MotionX = 0f;
        _context.MotionY = 0f;
        CheckSwitchState();
    }
}
