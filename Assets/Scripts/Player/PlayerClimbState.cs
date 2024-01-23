using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerClimbState : PlayerBaseState
{
    public PlayerClimbState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = false;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        if (!_context.MovePerformed)
        {
            SwitchState(_factory.IdleClimb());
        }
    }

    public override void EnterState()
    {
        
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
        CheckSwitchState();
        _context.MotionY = _context.MoveDir.y * _context.climbSpeed;
        _context.MotionX = _context.MoveDir.x * _context.shimmySpeed;
    }
}
