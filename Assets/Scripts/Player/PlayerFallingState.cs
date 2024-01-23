using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerFallingState : PlayerBaseState
{
    private bool _jumpBuffer;
    private float _jumpBufferTimer;

    private float _localGravity = 1f;

    public PlayerFallingState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        //Debug.Log("switch to grounded?");
        if (_context.Grounded)
        {
            if (_jumpBuffer)
            {
                SwitchState(_factory.Jump());
                return;
            }
            SwitchState(_factory.Ground());
        }
        if (LadderCheck())
        {
            SwitchState(_factory.Ladder());
        }
    }

    public override void EnterState()
    {
        //Debug.Log("falling");
    }

    public override void ExitState()
    {
        
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
        //Debug.Log("hit from fall");
        _context.Grounded = _context.IsGrounded();
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

        SetJumpBuffer();
        UpdateBufferTimer();

        _context.MotionY = Mathf.Min(_context.MotionY + Physics2D.gravity.y * _localGravity * Time.deltaTime, _context.terminalVelocity);
        _localGravity = Mathf.Lerp(_localGravity, _context.fallGravity, _context.jumpFallDuration * Time.deltaTime);
    }

    void SetJumpBuffer()
    {
        if (_context.JumpPressed && !_context.RequireNewJumpPress)
        {
            _jumpBuffer = true;
            _jumpBufferTimer = _context.jumpBufferTime;
        }
    }
    void UpdateBufferTimer()
    {
        _jumpBufferTimer -= Time.deltaTime;
        if (_jumpBufferTimer <= 0f)
        {
            _jumpBuffer = false;
        }
    }

    private bool LadderCheck()
    {
        return (bool)Physics2D.BoxCast(_context.GetTransform().position + (Vector3)_context.ladderOffset, _context.ladderBoxSize, 0, -_context.GetTransform().up, _context.ladderDistance, _context.ladderMask);
    }
}
