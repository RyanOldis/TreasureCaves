using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerCoyoteState : PlayerBaseState
{
    private float _coyoteTimer;

    public PlayerCoyoteState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();

        _coyoteTimer = _context.coyoteTime;
    }

    public override void CheckSwitchState()
    {
        if (_context.JumpPressed && !_context.RequireNewJumpPress)
        {
            SwitchState(_factory.Jump());
        }
        if (_coyoteTimer <= 0f)
        {
            SwitchState(_factory.Fall());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("coyote time");
        _context.MotionY = 0f;
    }

    public override void ExitState()
    {
        //Debug.Log("and we're falling...");
    }

    public override void InitializeSubstate()
    {
        if (_context.MovePerformed)
        {
            SetSubState(_factory.Move());
        }
        else
        {
            SetSubState(_factory.Idle());
        }
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
        _context.MotionY = 0f;
        CheckSwitchState();
        _coyoteTimer -= Time.deltaTime;

    }
}
