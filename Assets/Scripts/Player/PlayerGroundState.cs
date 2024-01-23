using UnityEngine;

public class PlayerGroundState : PlayerBaseState
{

    public PlayerGroundState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        if (_context.JumpPressed && !_context.RequireNewJumpPress)
        {
            SwitchState(_factory.Jump());
        }
        if (!_context.IsGrounded())
        {
            SwitchState(_factory.Coyote());
        }
        
    }

    public override void EnterState()
    {
        //Debug.Log("In ground state");
        _context.MotionY = -8f;
        _context.Grounded = true;
    }

    public override void ExitState()
    {
        _context.Grounded = false;
    }

    public override void InitializeSubstate()
    {
        if (_context.MovePerformed)
        {
            SetSubState(_factory.Move());
        } else
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
        _currentSubState.OnTriggerEnter(collision);
        if (collision.CompareTag("Ladders"))
        {
            SwitchState(_factory.Ladder());
        }
    }

    public override void OnTriggerExit(Collider2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();
    }
}
