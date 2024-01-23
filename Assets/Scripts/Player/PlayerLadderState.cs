using UnityEngine;

public class PlayerLadderState : PlayerBaseState
{
    public PlayerLadderState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        if (_context.JumpPressed && !_context.RequireNewJumpPress)
        {
            SwitchState(_factory.Jump());
            _currentSubState.ExitState();
            _currentSubState = null;
        }
        
        if (!LadderCheck() && !_context.Grounded)
        {
            SwitchState(_factory.Fall());
        }
        
    }

    public override void EnterState()
    {
        //Debug.Log("In ladder state");
    }

    public override void ExitState()
    {
        //Debug.Log("exit ladder");
    }

    public override void InitializeSubstate()
    {
        if (_context.MovePerformed)
        {
            SetSubState(_factory.Climb());
        }
        else
        {
            SetSubState(_factory.IdleClimb());
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
        if (collision.CompareTag("Ladders"))
        {
            // go back to the other root states
            if (_context.Grounded)
            {
                SwitchState(_factory.Ground());
            }
            //if (!_context.Grounded && !LadderCheck())
            else
            {
                SwitchState(_factory.Fall());
            }
        }
    }

    public override void UpdateState()
    {
        CheckSwitchState();
        //_context.MotionY = _context.MoveDir.y;
    }

    private bool LadderCheck()
    {
        return (bool)Physics2D.BoxCast(_context.GetTransform().position + (Vector3)_context.ladderOffset, _context.ladderBoxSize, 0, -_context.GetTransform().up, _context.ladderDistance, _context.ladderMask);
    }
}
